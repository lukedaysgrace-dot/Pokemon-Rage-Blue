#!/usr/bin/env python3
"""Report direct calls/jumps between different switchable ROM banks.

Game Boy addresses $4000-$7fff are backed by the currently selected ROM bank.
A plain CALL/JP between two different ROMX banks therefore executes unrelated
bytes.  Cross-bank transfers must use a farcall/predef/bankswitch mechanism.

The audit is intentionally conservative: it only reports transfers where both
the caller and target resolve through an RGBDS .sym file.  ROM0 destinations
are always safe and are omitted.  Transfers from ROM0 into ROMX are checked
against the game's reviewed bank-dispatch entry points.
"""

from __future__ import annotations

import argparse
import re
from dataclasses import dataclass
from pathlib import Path


SYMBOL_RE = re.compile(r"^([0-9A-Fa-f]+):([0-9A-Fa-f]+)\s+(\S+)")
GLOBAL_LABEL_RE = re.compile(r"^([A-Za-z_][A-Za-z0-9_#@]*)(?:::?)\s*(?:;.*)?$")
TRANSFER_RE = re.compile(
    r"^\s*(call|jp)\s+(?:(?:nz|z|nc|c),\s*)?([A-Za-z_][A-Za-z0-9_#@]*)\b",
    re.IGNORECASE,
)

# These fixed-bank entry points are reached only after their callers select the
# destination bank (or are bank-specific audio/VBlank dispatches). Keep this
# list narrow: an unreviewed ROM0 -> ROMX transfer fails the audit.
KNOWN_ROM0_TRANSFERS = {
    ("PlaySound", "Audio1_PlaySound"),
    ("PlaySound", "Audio2_PlaySound"),
    ("PlaySound", "Audio3_PlaySound"),
    ("_LoadMapVramAndColors", "LoadMapVramAndColors"),
    ("CheckForHiddenEventOrBookshelfOrCardKeyDoor", "CheckForHiddenEvent"),
    ("Init", "WriteDMACodeToHRAM"),
    ("Init", "PrepareTitleScreen"),
    ("TossItem", "TossItem_"),
    ("GetItemPrice", "GetMachinePrice"),
    ("WaitForTextScrollButtonPress", "TownMapSpriteBlinkingAnimation"),
    ("DisplayListMenuIDLoop", "HandleItemListSwapping"),
    ("OverworldLoopLessDelay", "PrepareForSpecialWarp"),
    ("HandleBlackOut", "ResetStatusAndHalveMoneyOnBlackout"),
    ("HandleBlackOut", "PrepareForSpecialWarp"),
    ("HandleBlackOut", "SpecialEnterMap"),
    ("HandleFlyWarpOrDungeonWarp", "PrepareForSpecialWarp"),
    ("HandleFlyWarpOrDungeonWarp", "SpecialEnterMap"),
    ("LoadFrontSpriteByMonIndex", "CopyUncompressedPicToHL"),
    ("Predef", "GetPredefPointer"),
    ("RedisplayStartMenu", "StartMenu_Pokedex"),
    ("RedisplayStartMenu", "StartMenu_Pokemon"),
    ("RedisplayStartMenu", "StartMenu_Item"),
    ("RedisplayStartMenu", "StartMenu_TrainerInfo"),
    ("RedisplayStartMenu", "StartMenu_SaveReset"),
    ("RedisplayStartMenu", "StartMenu_Option"),
    ("CloseTextDisplay", "InitMapSprites"),
    ("VBlank", "Audio1_UpdateMusic"),
    ("VBlank", "Music_DoLowHealthAlarm"),
    ("VBlank", "Audio2_UpdateMusic"),
    ("VBlank", "Audio3_UpdateMusic"),
    ("AutoBgMapTransfer", "RefreshWindow"),
    ("TransferBgRows", "WindowTransferBgRowsAndColors"),
    ("_ColorOverworldSprite", "ColorOverworldSprite"),
}


@dataclass(frozen=True)
class Symbol:
    bank: int
    address: int


@dataclass(frozen=True)
class Transfer:
    path: Path
    line: int
    opcode: str
    caller: str
    caller_bank: int
    target: str
    target_bank: int


def load_symbols(path: Path) -> dict[str, Symbol]:
    symbols: dict[str, Symbol] = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        match = SYMBOL_RE.match(line)
        if not match:
            continue
        bank, address, name = match.groups()
        symbols[name] = Symbol(int(bank, 16), int(address, 16))
    return symbols


def scan(root: Path, symbols: dict[str, Symbol]) -> list[Transfer]:
    findings: list[Transfer] = []
    for path in sorted(root.rglob("*.asm")):
        if ".git" in path.parts or "_to_delete" in path.parts:
            continue
        caller: str | None = None
        caller_symbol: Symbol | None = None
        for number, line in enumerate(
            path.read_text(encoding="utf-8", errors="replace").splitlines(), 1
        ):
            label = GLOBAL_LABEL_RE.match(line)
            if label:
                candidate = label.group(1)
                if candidate in symbols:
                    caller = candidate
                    caller_symbol = symbols[candidate]
                continue

            transfer = TRANSFER_RE.match(line)
            if not transfer or caller is None or caller_symbol is None:
                continue
            opcode, target = transfer.groups()
            target_symbol = symbols.get(target)
            if target_symbol is None:
                continue
            if caller_symbol.address >= 0x8000 or target_symbol.address >= 0x8000:
                continue
            if target_symbol.bank == 0 or caller_symbol.bank == target_symbol.bank:
                continue
            findings.append(
                Transfer(
                    path.relative_to(root),
                    number,
                    opcode.lower(),
                    caller,
                    caller_symbol.bank,
                    target,
                    target_symbol.bank,
                )
            )
    return findings


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("sym", nargs="?", default="pokeblue.sym")
    parser.add_argument("--root", default=Path(__file__).resolve().parents[1], type=Path)
    args = parser.parse_args()

    root = args.root.resolve()
    sym_path = Path(args.sym)
    if not sym_path.is_absolute():
        sym_path = root / sym_path
    symbols = load_symbols(sym_path)
    findings = scan(root, symbols)

    romx = [item for item in findings if item.caller_bank != 0]
    rom0 = [item for item in findings if item.caller_bank == 0]
    unexpected_rom0 = [
        item
        for item in rom0
        if (item.caller, item.target) not in KNOWN_ROM0_TRANSFERS
    ]

    print(f"reviewed ROM0 bank dispatches: {len(rom0) - len(unexpected_rom0)}")
    for heading, items in (
        ("unsafe ROMX-to-ROMX candidates", romx),
        ("unreviewed ROM0-to-ROMX candidates", unexpected_rom0),
    ):
        print(f"{heading}: {len(items)}")
        for item in items:
            print(
                f"  {item.path}:{item.line}: {item.opcode} {item.target} "
                f"({item.caller} bank ${item.caller_bank:02x} -> "
                f"bank ${item.target_bank:02x})"
            )

    return 1 if romx or unexpected_rom0 else 0


if __name__ == "__main__":
    raise SystemExit(main())
