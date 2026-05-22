SECTION "Pokemon Back HD", ROMX

RedPicBackHD::  INCBIN "gfx/pokemon/backhd/redb.pic"
MintPicBackHD:: INCBIN "gfx/pokemon/backhd/mintb.pic"

LoadMonBackPic:
; Reload header for the back pic. In battle, use the party slot's species (source of truth)
; unless transformed — then wBattleMonSpecies is the appearance. Out of battle (e.g. HoF),
; wBattleMonSpecies was set by the caller.
	ld a, [wIsInBattle]
	and a
	jr z, .speciesFromBattleMon
	ld a, [wPlayerBattleStatus3]
	bit TRANSFORMED, a
	jr nz, .speciesFromBattleMon
	ld hl, wPartyMon1Species
	ld a, [wPlayerMonNumber]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hl]
	jr .gotSpecies
.speciesFromBattleMon
	ld a, [wBattleMonSpecies]
.gotSpecies
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetMonHeader
	hlcoord 1, 5
	ld b, 7
	ld c, 8
	call ClearScreenArea
	ld a, [wOptions]
	bit BIT_BACK_SPRITES_HD, a
	jr z, .loadRegularBackPic
	call TryLoadMonBackPicHD
	ret c
.loadRegularBackPic
	ld hl, wMonHBackSprite - wMonHeader
	call UncompressMonSprite
	predef ScaleSpriteByTwo
	ld de, vBackPic
	call InterlaceMergeSpriteBuffers
	ld hl, vSprites
	ld de, vBackPic
	ld c, (2 * SPRITEBUFFERSIZE) / TILE_SIZE ; count of 16-byte chunks to be copied
	ldh a, [hLoadedROMBank]
	ld b, a
	call CopyVideoData
	ret

TryLoadMonBackPicHD::
	ld a, [wCurPartySpecies]
	and a
	jr z, .missing
	dec a
	ld hl, PokemonBackHDPicPointers
	ld b, 0
	ld c, a
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	and a
	jr z, .missing
	ld b, a
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	ld a, b
	call UncompressSpriteFromDE
	ld a, $66
	ld c, a
	ld de, vBackPic
	call LoadUncompressedSpriteData
	ld hl, vSprites
	ld de, vBackPic
	ld c, (2 * SPRITEBUFFERSIZE) / TILE_SIZE
	ldh a, [hLoadedROMBank]
	ld b, a
	call CopyVideoData
	scf
	ret
.missing
	and a
	ret

PokemonBackHDPicPointers::
	table_width 3
	dba RhydonBackHDPic
	dba KangaskhanBackHDPic
	dba NidoranMBackHDPic
	dba ClefairyBackHDPic
	dba SpearowBackHDPic
	dba VoltorbBackHDPic
	dba NidokingBackHDPic
	dba SlowbroBackHDPic
	dba IvysaurBackHDPic
	dba ExeggutorBackHDPic
	dba LickitungBackHDPic
	dba ExeggcuteBackHDPic
	dba GrimerBackHDPic
	dba GengarBackHDPic
	dba NidoranFBackHDPic
	dba NidoqueenBackHDPic
	dba CuboneBackHDPic
	dba RhyhornBackHDPic
	dba LaprasBackHDPic
	dba ArcanineBackHDPic
	dba MewBackHDPic
	dba GyaradosBackHDPic
	dba ShellderBackHDPic
	dba TentacoolBackHDPic
	dba GastlyBackHDPic
	dba ScytherBackHDPic
	dba StaryuBackHDPic
	dba BlastoiseBackHDPic
	dba PinsirBackHDPic
	dba TangelaBackHDPic
	dba CranidosBackHDPic
	dba RampardosBackHDPic
	dba GrowlitheBackHDPic
	dba OnixBackHDPic
	dba FearowBackHDPic
	dba PidgeyBackHDPic
	dba SlowpokeBackHDPic
	dba KadabraBackHDPic
	dba GravelerBackHDPic
	dba ChanseyBackHDPic
	dba MachokeBackHDPic
	dba MrMimeBackHDPic
	dba HitmonleeBackHDPic
	dba HitmonchanBackHDPic
	dba ArbokBackHDPic
	dba ParasectBackHDPic
	dba PsyduckBackHDPic
	dba DrowzeeBackHDPic
	dba GolemBackHDPic
	dba TyruntBackHDPic
	dba MagmarBackHDPic
	dba TyrantrumBackHDPic
	dba ElectabuzzBackHDPic
	dba MagnetonBackHDPic
	dba KoffingBackHDPic
	dba AmauraBackHDPic
	dba MankeyBackHDPic
	dba SeelBackHDPic
	dba DiglettBackHDPic
	dba TaurosBackHDPic
	dba AurorusBackHDPic
	db 0
	dw 0
	db 0
	dw 0
	dba FarfetchdBackHDPic
	dba VenonatBackHDPic
	dba DragoniteBackHDPic
	dba ShieldonBackHDPic
	dba BastiodonBackHDPic
	db 0
	dw 0
	dba DoduoBackHDPic
	dba PoliwagBackHDPic
	dba JynxBackHDPic
	dba MoltresBackHDPic
	dba ArticunoBackHDPic
	dba ZapdosBackHDPic
	dba DittoBackHDPic
	dba MeowthBackHDPic
	dba KrabbyBackHDPic
	dba BunearyBackHDPic
	dba LopunnyBackHDPic
	db 0
	dw 0
	dba VulpixBackHDPic
	dba NinetalesBackHDPic
	dba PikachuBackHDPic
	dba RaichuBackHDPic
	dba HippopotasBackHDPic
	dba HippowdonBackHDPic
	dba DratiniBackHDPic
	dba DragonairBackHDPic
	dba KabutoBackHDPic
	dba KabutopsBackHDPic
	dba HorseaBackHDPic
	dba SeadraBackHDPic
	db 0
	dw 0
	db 0
	dw 0
	dba SandshrewBackHDPic
	dba SandslashBackHDPic
	dba OmanyteBackHDPic
	dba OmastarBackHDPic
	dba JigglypuffBackHDPic
	dba WigglytuffBackHDPic
	dba EeveeBackHDPic
	dba FlareonBackHDPic
	dba JolteonBackHDPic
	dba VaporeonBackHDPic
	dba MachopBackHDPic
	dba ZubatBackHDPic
	dba EkansBackHDPic
	dba ParasBackHDPic
	dba PoliwhirlBackHDPic
	dba PoliwrathBackHDPic
	dba WeedleBackHDPic
	dba KakunaBackHDPic
	dba BeedrillBackHDPic
	db 0
	dw 0
	dba DodrioBackHDPic
	dba PrimeapeBackHDPic
	dba DugtrioBackHDPic
	dba VenomothBackHDPic
	dba DewgongBackHDPic
	db 0
	dw 0
	db 0
	dw 0
	dba CaterpieBackHDPic
	dba MetapodBackHDPic
	dba ButterfreeBackHDPic
	dba MachampBackHDPic
	db 0
	dw 0
	dba GolduckBackHDPic
	dba HypnoBackHDPic
	dba GolbatBackHDPic
	dba MewtwoBackHDPic
	dba SnorlaxBackHDPic
	dba MagikarpBackHDPic
	db 0
	dw 0
	db 0
	dw 0
	dba MukBackHDPic
	db 0
	dw 0
	dba KinglerBackHDPic
	dba CloysterBackHDPic
	db 0
	dw 0
	dba ElectrodeBackHDPic
	dba ClefableBackHDPic
	dba WeezingBackHDPic
	dba PersianBackHDPic
	dba MarowakBackHDPic
	db 0
	dw 0
	dba HaunterBackHDPic
	dba AbraBackHDPic
	dba AlakazamBackHDPic
	dba PidgeottoBackHDPic
	dba PidgeotBackHDPic
	dba StarmieBackHDPic
	dba BulbasaurBackHDPic
	dba VenusaurBackHDPic
	dba TentacruelBackHDPic
	db 0
	dw 0
	dba GoldeenBackHDPic
	dba SeakingBackHDPic
	dba LileepBackHDPic
	dba CradilyBackHDPic
	dba AnorithBackHDPic
	dba ArmaldoBackHDPic
	dba PonytaBackHDPic
	dba RapidashBackHDPic
	dba RattataBackHDPic
	dba RaticateBackHDPic
	dba NidorinoBackHDPic
	dba NidorinaBackHDPic
	dba GeodudeBackHDPic
	dba PorygonBackHDPic
	dba AerodactylBackHDPic
	db 0
	dw 0
	dba MagnemiteBackHDPic
	db 0
	dw 0
	db 0
	dw 0
	dba CharmanderBackHDPic
	dba SquirtleBackHDPic
	dba CharmeleonBackHDPic
	dba WartortleBackHDPic
	dba CharizardBackHDPic
	db 0
	dw 0
	db 0
	dw 0
	db 0
	dw 0
	db 0
	dw 0
	dba OddishBackHDPic
	dba GloomBackHDPic
	dba VileplumeBackHDPic
	dba BellsproutBackHDPic
	dba WeepinbellBackHDPic
	dba VictreebelBackHDPic
	dba ChikoritaBackHDPic
	dba BayleefBackHDPic
	dba MeganiumBackHDPic
	dba CyndaquilBackHDPic
	dba QuilavaBackHDPic
	dba TyphlosionBackHDPic
	dba TotodileBackHDPic
	dba CroconawBackHDPic
	dba FeraligatrBackHDPic
	dba MurkrowBackHDPic
	dba HonchkrowBackHDPic
	dba MisdreavusBackHDPic
	dba MismagiusBackHDPic
	dba SwinubBackHDPic
	dba PiloswineBackHDPic
	dba MamoswineBackHDPic
	dba LarvitarBackHDPic
	dba PupitarBackHDPic
	dba TyranitarBackHDPic
	dba RaltsBackHDPic
	dba KirliaBackHDPic
	dba GardevoirBackHDPic
	dba RioluBackHDPic
	dba LucarioBackHDPic
	dba BagonBackHDPic
	dba ShelgonBackHDPic
	dba SalamenceBackHDPic
	dba DuskullBackHDPic
	dba DusclopsBackHDPic
	dba DusknoirBackHDPic
	dba GolettBackHDPic
	dba GolurkBackHDPic
	dba HeracrossBackHDPic
	dba EspeonBackHDPic
	dba UmbreonBackHDPic
	dba GlaceonBackHDPic
	dba LeafeonBackHDPic
	dba AnnihilapeBackHDPic
	dba BlisseyBackHDPic
	dba CrobatBackHDPic
	dba ElectivireBackHDPic
	dba KingdraBackHDPic
	dba LickilickyBackHDPic
	dba MagmortarBackHDPic
	dba MagnezoneBackHDPic
	dba Porygon2BackHDPic
	dba PorygonZBackHDPic
	dba RhyperiorBackHDPic
	dba ScizorBackHDPic
	dba SteelixBackHDPic
	dba TangrowthBackHDPic
	dba VenipedeBackHDPic
	dba WhirlipedeBackHDPic
	dba ScolipedeBackHDPic
	dba SneaselBackHDPic
	dba WeavileBackHDPic
	dba MesmeriaBackHDPic
	dba CroagunkBackHDPic
	dba ToxicroakBackHDPic
	dba PhanpyBackHDPic
	dba DonphanBackHDPic
	dba HoundourBackHDPic
	dba HoundoomBackHDPic
	assert_table_length NUM_POKEMON_INDEXES

SECTION "Pokemon Back HD Pics 1", ROMX

RhydonBackHDPic:: INCBIN "gfx/pokemon/backhd/rhydonb.pic"
KangaskhanBackHDPic:: INCBIN "gfx/pokemon/backhd/kangaskhanb.pic"
NidoranMBackHDPic:: INCBIN "gfx/pokemon/backhd/nidoranmb.pic"
ClefairyBackHDPic:: INCBIN "gfx/pokemon/backhd/clefairyb.pic"
SpearowBackHDPic:: INCBIN "gfx/pokemon/backhd/spearowb.pic"
VoltorbBackHDPic:: INCBIN "gfx/pokemon/backhd/voltrobb.pic"
NidokingBackHDPic:: INCBIN "gfx/pokemon/backhd/nidokingb.pic"
SlowbroBackHDPic:: INCBIN "gfx/pokemon/backhd/slowbrob.pic"
IvysaurBackHDPic:: INCBIN "gfx/pokemon/backhd/ivysaurb.pic"
ExeggutorBackHDPic:: INCBIN "gfx/pokemon/backhd/exeggutorb.pic"
LickitungBackHDPic:: INCBIN "gfx/pokemon/backhd/lickitungb.pic"
ExeggcuteBackHDPic:: INCBIN "gfx/pokemon/backhd/exeggcuteb.pic"
GrimerBackHDPic:: INCBIN "gfx/pokemon/backhd/grimerb.pic"
GengarBackHDPic:: INCBIN "gfx/pokemon/backhd/gengarb.pic"
NidoranFBackHDPic:: INCBIN "gfx/pokemon/backhd/nidoranfb.pic"
NidoqueenBackHDPic:: INCBIN "gfx/pokemon/backhd/nidoqueenb.pic"

SECTION "Pokemon Back HD Pics 2", ROMX

CuboneBackHDPic:: INCBIN "gfx/pokemon/backhd/cuboneb.pic"
RhyhornBackHDPic:: INCBIN "gfx/pokemon/backhd/rhyhornb.pic"
LaprasBackHDPic:: INCBIN "gfx/pokemon/backhd/laprasb.pic"
ArcanineBackHDPic:: INCBIN "gfx/pokemon/backhd/arcanineb.pic"
MewBackHDPic:: INCBIN "gfx/pokemon/backhd/mewb.pic"
GyaradosBackHDPic:: INCBIN "gfx/pokemon/backhd/gyaradosb.pic"
ShellderBackHDPic:: INCBIN "gfx/pokemon/backhd/shellderb.pic"
TentacoolBackHDPic:: INCBIN "gfx/pokemon/backhd/tentacoolb.pic"
GastlyBackHDPic:: INCBIN "gfx/pokemon/backhd/gastlyb.pic"
ScytherBackHDPic:: INCBIN "gfx/pokemon/backhd/scytherb.pic"
StaryuBackHDPic:: INCBIN "gfx/pokemon/backhd/staryub.pic"
BlastoiseBackHDPic:: INCBIN "gfx/pokemon/backhd/blastoiseb.pic"
PinsirBackHDPic:: INCBIN "gfx/pokemon/backhd/pinisrb.pic"
TangelaBackHDPic:: INCBIN "gfx/pokemon/backhd/tangelab.pic"
GrowlitheBackHDPic:: INCBIN "gfx/pokemon/backhd/growlitheb.pic"
OnixBackHDPic:: INCBIN "gfx/pokemon/backhd/onixb.pic"

SECTION "Pokemon Back HD Pics 3", ROMX

FearowBackHDPic:: INCBIN "gfx/pokemon/backhd/fearowb.pic"
PidgeyBackHDPic:: INCBIN "gfx/pokemon/backhd/pidgeyb.pic"
SlowpokeBackHDPic:: INCBIN "gfx/pokemon/backhd/slowpokeb.pic"
KadabraBackHDPic:: INCBIN "gfx/pokemon/backhd/kadabrab.pic"
GravelerBackHDPic:: INCBIN "gfx/pokemon/backhd/gravelerb.pic"
ChanseyBackHDPic:: INCBIN "gfx/pokemon/backhd/chanseyb.pic"
MachokeBackHDPic:: INCBIN "gfx/pokemon/backhd/machokeb.pic"
MrMimeBackHDPic:: INCBIN "gfx/pokemon/backhd/mrmimeb.pic"
HitmonleeBackHDPic:: INCBIN "gfx/pokemon/backhd/hitmonleeb.pic"
HitmonchanBackHDPic:: INCBIN "gfx/pokemon/backhd/hitmonchanb.pic"
ArbokBackHDPic:: INCBIN "gfx/pokemon/backhd/arbokb.pic"
ParasectBackHDPic:: INCBIN "gfx/pokemon/backhd/parasectb.pic"
PsyduckBackHDPic:: INCBIN "gfx/pokemon/backhd/psyduckb.pic"
DrowzeeBackHDPic:: INCBIN "gfx/pokemon/backhd/drowzeeb.pic"
GolemBackHDPic:: INCBIN "gfx/pokemon/backhd/golemb.pic"
MagmarBackHDPic:: INCBIN "gfx/pokemon/backhd/magmarb.pic"

SECTION "Pokemon Back HD Pics 4", ROMX

ElectabuzzBackHDPic:: INCBIN "gfx/pokemon/backhd/electabuzzb.pic"
MagnetonBackHDPic:: INCBIN "gfx/pokemon/backhd/magnetonb.pic"
KoffingBackHDPic:: INCBIN "gfx/pokemon/backhd/koffingb.pic"
MankeyBackHDPic:: INCBIN "gfx/pokemon/backhd/mankeyb.pic"
SeelBackHDPic:: INCBIN "gfx/pokemon/backhd/seelb.pic"
DiglettBackHDPic:: INCBIN "gfx/pokemon/backhd/diglettb.pic"
TaurosBackHDPic:: INCBIN "gfx/pokemon/backhd/taurosb.pic"
FarfetchdBackHDPic:: INCBIN "gfx/pokemon/backhd/farfetchdb.pic"
VenonatBackHDPic:: INCBIN "gfx/pokemon/backhd/venonatb.pic"
DragoniteBackHDPic:: INCBIN "gfx/pokemon/backhd/dragoniteb.pic"
DoduoBackHDPic:: INCBIN "gfx/pokemon/backhd/doduob.pic"
PoliwagBackHDPic:: INCBIN "gfx/pokemon/backhd/poliwagb.pic"
JynxBackHDPic:: INCBIN "gfx/pokemon/backhd/jynxb.pic"
MoltresBackHDPic:: INCBIN "gfx/pokemon/backhd/moltresb.pic"
ArticunoBackHDPic:: INCBIN "gfx/pokemon/backhd/articunob.pic"
ZapdosBackHDPic:: INCBIN "gfx/pokemon/backhd/zapdosb.pic"

SECTION "Pokemon Back HD Pics 5", ROMX

DittoBackHDPic:: INCBIN "gfx/pokemon/backhd/dittob.pic"
MeowthBackHDPic:: INCBIN "gfx/pokemon/backhd/meowthb.pic"
KrabbyBackHDPic:: INCBIN "gfx/pokemon/backhd/krabbyb.pic"
VulpixBackHDPic:: INCBIN "gfx/pokemon/backhd/vulpixb.pic"
NinetalesBackHDPic:: INCBIN "gfx/pokemon/backhd/ninetalesb.pic"
PikachuBackHDPic:: INCBIN "gfx/pokemon/backhd/pikachub.pic"
RaichuBackHDPic:: INCBIN "gfx/pokemon/backhd/raichub.pic"
DratiniBackHDPic:: INCBIN "gfx/pokemon/backhd/dratinitb.pic"
DragonairBackHDPic:: INCBIN "gfx/pokemon/backhd/dragonairb.pic"
KabutoBackHDPic:: INCBIN "gfx/pokemon/backhd/kabutob.pic"
KabutopsBackHDPic:: INCBIN "gfx/pokemon/backhd/kabutopsb.pic"
HorseaBackHDPic:: INCBIN "gfx/pokemon/backhd/horseab.pic"
SeadraBackHDPic:: INCBIN "gfx/pokemon/backhd/seadrab.pic"
SandshrewBackHDPic:: INCBIN "gfx/pokemon/backhd/sandshrewb.pic"
SandslashBackHDPic:: INCBIN "gfx/pokemon/backhd/sandslashb.pic"
OmanyteBackHDPic:: INCBIN "gfx/pokemon/backhd/omanyteb.pic"

SECTION "Pokemon Back HD Pics 6", ROMX

OmastarBackHDPic:: INCBIN "gfx/pokemon/backhd/omastarb.pic"
JigglypuffBackHDPic:: INCBIN "gfx/pokemon/backhd/jigglypuffb.pic"
WigglytuffBackHDPic:: INCBIN "gfx/pokemon/backhd/wigglytuffb.pic"
EeveeBackHDPic:: INCBIN "gfx/pokemon/backhd/eeveeb.pic"
FlareonBackHDPic:: INCBIN "gfx/pokemon/backhd/flareonb.pic"
JolteonBackHDPic:: INCBIN "gfx/pokemon/backhd/jotleonb.pic"
VaporeonBackHDPic:: INCBIN "gfx/pokemon/backhd/vaporeonb.pic"
MachopBackHDPic:: INCBIN "gfx/pokemon/backhd/machopb.pic"
ZubatBackHDPic:: INCBIN "gfx/pokemon/backhd/zubatb.pic"
EkansBackHDPic:: INCBIN "gfx/pokemon/backhd/ekansb.pic"
ParasBackHDPic:: INCBIN "gfx/pokemon/backhd/parasb.pic"
PoliwhirlBackHDPic:: INCBIN "gfx/pokemon/backhd/poliwhirlb.pic"
PoliwrathBackHDPic:: INCBIN "gfx/pokemon/backhd/poliwrathb.pic"
WeedleBackHDPic:: INCBIN "gfx/pokemon/backhd/weedleb.pic"
KakunaBackHDPic:: INCBIN "gfx/pokemon/backhd/kakunab.pic"
BeedrillBackHDPic:: INCBIN "gfx/pokemon/backhd/beedrillb.pic"

SECTION "Pokemon Back HD Pics 7", ROMX

DodrioBackHDPic:: INCBIN "gfx/pokemon/backhd/dodriob.pic"
PrimeapeBackHDPic:: INCBIN "gfx/pokemon/backhd/primeapeb.pic"
DugtrioBackHDPic:: INCBIN "gfx/pokemon/backhd/dugtriob.pic"
VenomothBackHDPic:: INCBIN "gfx/pokemon/backhd/venomothb.pic"
DewgongBackHDPic:: INCBIN "gfx/pokemon/backhd/dewgongb.pic"
CaterpieBackHDPic:: INCBIN "gfx/pokemon/backhd/caterpieb.pic"
MetapodBackHDPic:: INCBIN "gfx/pokemon/backhd/metapodb.pic"
ButterfreeBackHDPic:: INCBIN "gfx/pokemon/backhd/butterfreeb.pic"
MachampBackHDPic:: INCBIN "gfx/pokemon/backhd/machampb.pic"
GolduckBackHDPic:: INCBIN "gfx/pokemon/backhd/golduckb.pic"
HypnoBackHDPic:: INCBIN "gfx/pokemon/backhd/hypnob.pic"
GolbatBackHDPic:: INCBIN "gfx/pokemon/backhd/golbatb.pic"
MewtwoBackHDPic:: INCBIN "gfx/pokemon/backhd/mewtwob.pic"
SnorlaxBackHDPic:: INCBIN "gfx/pokemon/backhd/snorlaxb.pic"
MagikarpBackHDPic:: INCBIN "gfx/pokemon/backhd/magikarpb.pic"
MukBackHDPic:: INCBIN "gfx/pokemon/backhd/mukb.pic"

SECTION "Pokemon Back HD Pics 8", ROMX

KinglerBackHDPic:: INCBIN "gfx/pokemon/backhd/kinglerb.pic"
CloysterBackHDPic:: INCBIN "gfx/pokemon/backhd/cloysterb.pic"
ElectrodeBackHDPic:: INCBIN "gfx/pokemon/backhd/electrodeb.pic"
ClefableBackHDPic:: INCBIN "gfx/pokemon/backhd/clefableb.pic"
WeezingBackHDPic:: INCBIN "gfx/pokemon/backhd/weezingb.pic"
PersianBackHDPic:: INCBIN "gfx/pokemon/backhd/persianb.pic"
MarowakBackHDPic:: INCBIN "gfx/pokemon/backhd/marowakb.pic"
HaunterBackHDPic:: INCBIN "gfx/pokemon/backhd/haunterb.pic"
AbraBackHDPic:: INCBIN "gfx/pokemon/backhd/abrab.pic"
AlakazamBackHDPic:: INCBIN "gfx/pokemon/backhd/alakazamb.pic"
PidgeottoBackHDPic:: INCBIN "gfx/pokemon/backhd/pidgeottob.pic"
PidgeotBackHDPic:: INCBIN "gfx/pokemon/backhd/pidgeotb.pic"
StarmieBackHDPic:: INCBIN "gfx/pokemon/backhd/starmieb.pic"
BulbasaurBackHDPic:: INCBIN "gfx/pokemon/backhd/bulbasaurb.pic"
VenusaurBackHDPic:: INCBIN "gfx/pokemon/backhd/venusaurb.pic"
TentacruelBackHDPic:: INCBIN "gfx/pokemon/backhd/tentacruelb.pic"

SECTION "Pokemon Back HD Pics 9", ROMX

GoldeenBackHDPic:: INCBIN "gfx/pokemon/backhd/goldeenb.pic"
SeakingBackHDPic:: INCBIN "gfx/pokemon/backhd/seakingb.pic"
PonytaBackHDPic:: INCBIN "gfx/pokemon/backhd/ponytab.pic"
RapidashBackHDPic:: INCBIN "gfx/pokemon/backhd/rapidashb.pic"
RattataBackHDPic:: INCBIN "gfx/pokemon/backhd/rattatab.pic"
RaticateBackHDPic:: INCBIN "gfx/pokemon/backhd/raticateb.pic"
NidorinoBackHDPic:: INCBIN "gfx/pokemon/backhd/nidorinob.pic"
NidorinaBackHDPic:: INCBIN "gfx/pokemon/backhd/nidorinab.pic"
GeodudeBackHDPic:: INCBIN "gfx/pokemon/backhd/geodudeb.pic"
PorygonBackHDPic:: INCBIN "gfx/pokemon/backhd/porygonb.pic"
AerodactylBackHDPic:: INCBIN "gfx/pokemon/backhd/aerodactylb.pic"
MagnemiteBackHDPic:: INCBIN "gfx/pokemon/backhd/magnemiteb.pic"
CharmanderBackHDPic:: INCBIN "gfx/pokemon/backhd/charmanderb.pic"
SquirtleBackHDPic:: INCBIN "gfx/pokemon/backhd/squirtleb.pic"
CharmeleonBackHDPic:: INCBIN "gfx/pokemon/backhd/charmeleonb.pic"
WartortleBackHDPic:: INCBIN "gfx/pokemon/backhd/wartortleb.pic"

SECTION "Pokemon Back HD Pics 10", ROMX

CharizardBackHDPic:: INCBIN "gfx/pokemon/backhd/charizardb.pic"
OddishBackHDPic:: INCBIN "gfx/pokemon/backhd/oddishb.pic"
GloomBackHDPic:: INCBIN "gfx/pokemon/backhd/gloomb.pic"
VileplumeBackHDPic:: INCBIN "gfx/pokemon/backhd/vileplumeb.pic"
BellsproutBackHDPic:: INCBIN "gfx/pokemon/backhd/bellsproutb.pic"
WeepinbellBackHDPic:: INCBIN "gfx/pokemon/backhd/weepinbellb.pic"
VictreebelBackHDPic:: INCBIN "gfx/pokemon/backhd/vicribelb.pic"

SECTION "Pokemon Back HD Pics 11", ROMX

CranidosBackHDPic:: INCBIN "gfx/pokemon/backhd/cranidosb.pic"
RampardosBackHDPic:: INCBIN "gfx/pokemon/backhd/rampardosb.pic"
TyruntBackHDPic:: INCBIN "gfx/pokemon/backhd/tyruntb.pic"
TyrantrumBackHDPic:: INCBIN "gfx/pokemon/backhd/tyrantrumb.pic"
AmauraBackHDPic:: INCBIN "gfx/pokemon/backhd/amaurab.pic"
AurorusBackHDPic:: INCBIN "gfx/pokemon/backhd/aurorusb.pic"
ShieldonBackHDPic:: INCBIN "gfx/pokemon/backhd/shieldonb.pic"
BastiodonBackHDPic:: INCBIN "gfx/pokemon/backhd/bastiodonb.pic"
BunearyBackHDPic:: INCBIN "gfx/pokemon/backhd/bunearyb.pic"
LopunnyBackHDPic:: INCBIN "gfx/pokemon/backhd/lopunnyb.pic"
HippopotasBackHDPic:: INCBIN "gfx/pokemon/backhd/hippopotasb.pic"
HippowdonBackHDPic:: INCBIN "gfx/pokemon/backhd/hippowdonb.pic"
LileepBackHDPic:: INCBIN "gfx/pokemon/backhd/lileepb.pic"
CradilyBackHDPic:: INCBIN "gfx/pokemon/backhd/cradilyb.pic"
AnorithBackHDPic:: INCBIN "gfx/pokemon/backhd/anorithb.pic"
ArmaldoBackHDPic:: INCBIN "gfx/pokemon/backhd/armaldob.pic"

SECTION "Pokemon Back HD Pics 12", ROMX

ChikoritaBackHDPic:: INCBIN "gfx/pokemon/backhd/chikoritab.pic"
BayleefBackHDPic:: INCBIN "gfx/pokemon/backhd/bayleefb.pic"
MeganiumBackHDPic:: INCBIN "gfx/pokemon/backhd/meganiumb.pic"
CyndaquilBackHDPic:: INCBIN "gfx/pokemon/backhd/cyndaquilb.pic"
QuilavaBackHDPic:: INCBIN "gfx/pokemon/backhd/quilavab.pic"
TyphlosionBackHDPic:: INCBIN "gfx/pokemon/backhd/typhlosionb.pic"
TotodileBackHDPic:: INCBIN "gfx/pokemon/backhd/totodileb.pic"
CroconawBackHDPic:: INCBIN "gfx/pokemon/backhd/croconawb.pic"
FeraligatrBackHDPic:: INCBIN "gfx/pokemon/backhd/feraligatrb.pic"
MurkrowBackHDPic:: INCBIN "gfx/pokemon/backhd/murkrowb.pic"
HonchkrowBackHDPic:: INCBIN "gfx/pokemon/backhd/honchkrowb.pic"
MisdreavusBackHDPic:: INCBIN "gfx/pokemon/backhd/misdreavusb.pic"
MismagiusBackHDPic:: INCBIN "gfx/pokemon/backhd/mismagiusb.pic"
SwinubBackHDPic:: INCBIN "gfx/pokemon/backhd/swinubb.pic"
PiloswineBackHDPic:: INCBIN "gfx/pokemon/backhd/piloswineb.pic"
MamoswineBackHDPic:: INCBIN "gfx/pokemon/backhd/mamoswineb.pic"

SECTION "Pokemon Back HD Pics 13", ROMX

LarvitarBackHDPic:: INCBIN "gfx/pokemon/backhd/larvitarb.pic"
PupitarBackHDPic:: INCBIN "gfx/pokemon/backhd/pupitarb.pic"
TyranitarBackHDPic:: INCBIN "gfx/pokemon/backhd/tyranitarb.pic"
RaltsBackHDPic:: INCBIN "gfx/pokemon/backhd/raltsb.pic"
KirliaBackHDPic:: INCBIN "gfx/pokemon/backhd/kirliab.pic"
GardevoirBackHDPic:: INCBIN "gfx/pokemon/backhd/gardevoirb.pic"
RioluBackHDPic:: INCBIN "gfx/pokemon/backhd/riolub.pic"
LucarioBackHDPic:: INCBIN "gfx/pokemon/backhd/lucariob.pic"
BagonBackHDPic:: INCBIN "gfx/pokemon/backhd/bagonb.pic"
ShelgonBackHDPic:: INCBIN "gfx/pokemon/backhd/shelgonb.pic"
SalamenceBackHDPic:: INCBIN "gfx/pokemon/backhd/salamenceb.pic"
DuskullBackHDPic:: INCBIN "gfx/pokemon/backhd/duskullb.pic"
DusclopsBackHDPic:: INCBIN "gfx/pokemon/backhd/dusclopsb.pic"
DusknoirBackHDPic:: INCBIN "gfx/pokemon/backhd/dusknoirb.pic"
GolettBackHDPic:: INCBIN "gfx/pokemon/backhd/golettb.pic"
GolurkBackHDPic:: INCBIN "gfx/pokemon/backhd/golurkb.pic"

SECTION "Pokemon Back HD Pics 14", ROMX

HeracrossBackHDPic:: INCBIN "gfx/pokemon/backhd/heracrossb.pic"
EspeonBackHDPic:: INCBIN "gfx/pokemon/backhd/espeonb.pic"
UmbreonBackHDPic:: INCBIN "gfx/pokemon/backhd/umbreonb.pic"
GlaceonBackHDPic:: INCBIN "gfx/pokemon/backhd/glaceonb.pic"
LeafeonBackHDPic:: INCBIN "gfx/pokemon/backhd/leafeonb.pic"
AnnihilapeBackHDPic:: INCBIN "gfx/pokemon/backhd/annihilapeb.pic"
BlisseyBackHDPic:: INCBIN "gfx/pokemon/backhd/blisseyb.pic"
CrobatBackHDPic:: INCBIN "gfx/pokemon/backhd/crobatb.pic"
ElectivireBackHDPic:: INCBIN "gfx/pokemon/backhd/electivireb.pic"
KingdraBackHDPic:: INCBIN "gfx/pokemon/backhd/kingdrab.pic"
LickilickyBackHDPic:: INCBIN "gfx/pokemon/backhd/lickilickyb.pic"
MagmortarBackHDPic:: INCBIN "gfx/pokemon/backhd/magmortarb.pic"
MagnezoneBackHDPic:: INCBIN "gfx/pokemon/backhd/magnezoneb.pic"
Porygon2BackHDPic:: INCBIN "gfx/pokemon/backhd/porygon2b.pic"
PorygonZBackHDPic:: INCBIN "gfx/pokemon/backhd/porygon_zb.pic"
RhyperiorBackHDPic:: INCBIN "gfx/pokemon/backhd/rhyperiorb.pic"

SECTION "Pokemon Back HD Pics 15", ROMX

ScizorBackHDPic:: INCBIN "gfx/pokemon/backhd/scizorb.pic"
SteelixBackHDPic:: INCBIN "gfx/pokemon/backhd/steelixb.pic"
TangrowthBackHDPic:: INCBIN "gfx/pokemon/backhd/tangrowthb.pic"
VenipedeBackHDPic:: INCBIN "gfx/pokemon/backhd/venipedeb.pic"
WhirlipedeBackHDPic:: INCBIN "gfx/pokemon/backhd/whirlipedeb.pic"
ScolipedeBackHDPic:: INCBIN "gfx/pokemon/backhd/scolipedeb.pic"
SneaselBackHDPic:: INCBIN "gfx/pokemon/backhd/sneaselb.pic"
WeavileBackHDPic:: INCBIN "gfx/pokemon/backhd/weavileb.pic"
MesmeriaBackHDPic:: INCBIN "gfx/pokemon/backhd/mesmeriab.pic"
CroagunkBackHDPic:: INCBIN "gfx/pokemon/backhd/croagunkb.pic"
ToxicroakBackHDPic:: INCBIN "gfx/pokemon/backhd/toxicroakb.pic"
PhanpyBackHDPic:: INCBIN "gfx/pokemon/backhd/phanpyb.pic"
DonphanBackHDPic:: INCBIN "gfx/pokemon/backhd/donphanb.pic"
HoundourBackHDPic:: INCBIN "gfx/pokemon/backhd/houndourb.pic"
HoundoomBackHDPic:: INCBIN "gfx/pokemon/backhd/houndoomb.pic"
