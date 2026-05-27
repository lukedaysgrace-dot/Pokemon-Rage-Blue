; Evos+moves data structure:
; - Evolution methods:
;    * db EVOLVE_LEVEL, level, species
;    * db EVOLVE_ITEM, used item, min level (1), species
;    * db EVOLVE_TRADE, min level (1), species
; - db 0 ; no more evolutions
; - Learnset (in increasing level order):
;    * db level, move
; - db 0 ; no more level-up moves

MACRO blue_evolve_level
IF DEF(_BLUE)
	db EVOLVE_LEVEL, \1, \2
ENDC
ENDM

MACRO blue_evolve_item
IF DEF(_BLUE)
	db EVOLVE_ITEM, \1, \2, \3
ENDC
ENDM

EvosMovesPointerTable:
	table_width 2
	dw RhydonEvosMoves
	dw KangaskhanEvosMoves
	dw NidoranMEvosMoves
	dw ClefairyEvosMoves
	dw SpearowEvosMoves
	dw VoltorbEvosMoves
	dw NidokingEvosMoves
	dw SlowbroEvosMoves
	dw IvysaurEvosMoves
	dw ExeggutorEvosMoves
	dw LickitungEvosMoves
	dw ExeggcuteEvosMoves
	dw GrimerEvosMoves
	dw GengarEvosMoves
	dw NidoranFEvosMoves
	dw NidoqueenEvosMoves
	dw CuboneEvosMoves
	dw RhyhornEvosMoves
	dw LaprasEvosMoves
	dw ArcanineEvosMoves
	dw MewEvosMoves
	dw GyaradosEvosMoves
	dw ShellderEvosMoves
	dw TentacoolEvosMoves
	dw GastlyEvosMoves
	dw ScytherEvosMoves
	dw StaryuEvosMoves
	dw BlastoiseEvosMoves
	dw PinsirEvosMoves
	dw TangelaEvosMoves
	dw CranidosEvosMoves
	dw RampardosEvosMoves
	dw GrowlitheEvosMoves
	dw OnixEvosMoves
	dw FearowEvosMoves
	dw PidgeyEvosMoves
	dw SlowpokeEvosMoves
	dw KadabraEvosMoves
	dw GravelerEvosMoves
	dw ChanseyEvosMoves
	dw MachokeEvosMoves
	dw MrMimeEvosMoves
	dw HitmonleeEvosMoves
	dw HitmonchanEvosMoves
	dw ArbokEvosMoves
	dw ParasectEvosMoves
	dw PsyduckEvosMoves
	dw DrowzeeEvosMoves
	dw GolemEvosMoves
	dw CufantEvosMoves
	dw MagmarEvosMoves
	dw CopperajahEvosMoves
	dw ElectabuzzEvosMoves
	dw MagnetonEvosMoves
	dw KoffingEvosMoves
	dw ToxelEvosMoves
	dw MankeyEvosMoves
	dw SeelEvosMoves
	dw DiglettEvosMoves
	dw TaurosEvosMoves
	dw ToxtricityEvosMoves
	dw MissingNo3EEvosMoves
	dw MissingNo3FEvosMoves
	dw FarfetchdEvosMoves
	dw VenonatEvosMoves
	dw DragoniteEvosMoves
	dw ShieldonEvosMoves
	dw BastiodonEvosMoves
	dw MissingNo45EvosMoves
	dw DoduoEvosMoves
	dw PoliwagEvosMoves
	dw JynxEvosMoves
	dw MoltresEvosMoves
	dw ArticunoEvosMoves
	dw ZapdosEvosMoves
	dw DittoEvosMoves
	dw MeowthEvosMoves
	dw KrabbyEvosMoves
	dw BunearyEvosMoves
	dw LopunnyEvosMoves
	dw MissingNo51EvosMoves
	dw VulpixEvosMoves
	dw NinetalesEvosMoves
	dw PikachuEvosMoves
	dw RaichuEvosMoves
	dw WimpodEvosMoves
	dw GolisopodEvosMoves
	dw DratiniEvosMoves
	dw DragonairEvosMoves
	dw KabutoEvosMoves
	dw KabutopsEvosMoves
	dw HorseaEvosMoves
	dw SeadraEvosMoves
	dw MissingNo5EEvosMoves
	dw MissingNo5FEvosMoves
	dw SandshrewEvosMoves
	dw SandslashEvosMoves
	dw OmanyteEvosMoves
	dw OmastarEvosMoves
	dw JigglypuffEvosMoves
	dw WigglytuffEvosMoves
	dw EeveeEvosMoves
	dw FlareonEvosMoves
	dw JolteonEvosMoves
	dw VaporeonEvosMoves
	dw MachopEvosMoves
	dw ZubatEvosMoves
	dw EkansEvosMoves
	dw ParasEvosMoves
	dw PoliwhirlEvosMoves
	dw PoliwrathEvosMoves
	dw WeedleEvosMoves
	dw KakunaEvosMoves
	dw BeedrillEvosMoves
	dw MissingNo73EvosMoves
	dw DodrioEvosMoves
	dw PrimeapeEvosMoves
	dw DugtrioEvosMoves
	dw VenomothEvosMoves
	dw DewgongEvosMoves
	dw MissingNo79EvosMoves
	dw MissingNo7AEvosMoves
	dw CaterpieEvosMoves
	dw MetapodEvosMoves
	dw ButterfreeEvosMoves
	dw MachampEvosMoves
	dw MissingNo7FEvosMoves
	dw GolduckEvosMoves
	dw HypnoEvosMoves
	dw GolbatEvosMoves
	dw MewtwoEvosMoves
	dw SnorlaxEvosMoves
	dw MagikarpEvosMoves
	dw MissingNo86EvosMoves
	dw MissingNo87EvosMoves
	dw MukEvosMoves
	dw MissingNo8AEvosMoves
	dw KinglerEvosMoves
	dw CloysterEvosMoves
	dw MissingNo8CEvosMoves
	dw ElectrodeEvosMoves
	dw ClefableEvosMoves
	dw WeezingEvosMoves
	dw PersianEvosMoves
	dw MarowakEvosMoves
	dw MissingNo92EvosMoves
	dw HaunterEvosMoves
	dw AbraEvosMoves
	dw AlakazamEvosMoves
	dw PidgeottoEvosMoves
	dw PidgeotEvosMoves
	dw StarmieEvosMoves
	dw BulbasaurEvosMoves
	dw VenusaurEvosMoves
	dw TentacruelEvosMoves
	dw MissingNo9CEvosMoves
	dw GoldeenEvosMoves
	dw SeakingEvosMoves
	dw LileepEvosMoves
	dw CradilyEvosMoves
	dw AnorithEvosMoves
	dw ArmaldoEvosMoves
	dw PonytaEvosMoves
	dw RapidashEvosMoves
	dw RattataEvosMoves
	dw RaticateEvosMoves
	dw NidorinoEvosMoves
	dw NidorinaEvosMoves
	dw GeodudeEvosMoves
	dw PorygonEvosMoves
	dw AerodactylEvosMoves
	dw MissingNoACEvosMoves
	dw MagnemiteEvosMoves
	dw MissingNoAEEvosMoves
	dw MissingNoAFEvosMoves
	dw CharmanderEvosMoves
	dw SquirtleEvosMoves
	dw CharmeleonEvosMoves
	dw WartortleEvosMoves
	dw CharizardEvosMoves
	dw MissingNoB5EvosMoves
	dw FossilKabutopsEvosMoves
	dw FossilAerodactylEvosMoves
	dw MonGhostEvosMoves
	dw OddishEvosMoves
	dw GloomEvosMoves
	dw VileplumeEvosMoves
	dw BellsproutEvosMoves
	dw WeepinbellEvosMoves
	dw VictreebelEvosMoves
	dw ChikoritaEvosMoves
	dw BayleefEvosMoves
	dw MeganiumEvosMoves
	dw CyndaquilEvosMoves
	dw QuilavaEvosMoves
	dw TyphlosionEvosMoves
	dw TotodileEvosMoves
	dw CroconawEvosMoves
	dw FeraligatrEvosMoves
	dw MurkrowEvosMoves
	dw HonchkrowEvosMoves
	dw MisdreavusEvosMoves
	dw MismagiusEvosMoves
	dw GuardiaEvosMoves
	dw MasquawkEvosMoves
	dw GorochuEvosMoves
	dw LarvitarEvosMoves
	dw PupitarEvosMoves
	dw TyranitarEvosMoves
	dw RaltsEvosMoves
	dw KirliaEvosMoves
	dw GardevoirEvosMoves
	dw RioluEvosMoves
	dw LucarioEvosMoves
	dw BagonEvosMoves
	dw ShelgonEvosMoves
	dw SalamenceEvosMoves
	dw DuskullEvosMoves
	dw DusclopsEvosMoves
	dw DusknoirEvosMoves
	dw GolettEvosMoves
	dw GolurkEvosMoves
	dw HeracrossEvosMoves
	dw EspeonEvosMoves
	dw UmbreonEvosMoves
	dw GlaceonEvosMoves
	dw LeafeonEvosMoves
	dw AnnihilapeEvosMoves
	dw BlisseyEvosMoves
	dw CrobatEvosMoves
	dw ElectivireEvosMoves
	dw KingdraEvosMoves
	dw LickilickyEvosMoves
	dw MagmortarEvosMoves
	dw MagnezoneEvosMoves
	dw Porygon2EvosMoves
	dw PorygonZEvosMoves
	dw RhyperiorEvosMoves
	dw ScizorEvosMoves
	dw SteelixEvosMoves
	dw TangrowthEvosMoves
	dw VenipedeEvosMoves
	dw WhirlipedeEvosMoves
	dw ScolipedeEvosMoves
	dw SneaselEvosMoves
	dw WeavileEvosMoves
	dw MesmeriaEvosMoves
	dw CroagunkEvosMoves
	dw ToxicroakEvosMoves
	dw PhanpyEvosMoves
	dw DonphanEvosMoves
	dw HoundourEvosMoves
	dw HoundoomEvosMoves
	assert_table_length NUM_POKEMON_INDEXES

RhydonEvosMoves:
; Evolutions
	blue_evolve_level 38, RHYPERIOR
	db 0
; Learnset
	db 8, SAND_ATTACK
	db 18, ROCK_THROW
	db 21, LEER
	db 31, DIG
	db 39, TAKE_DOWN
	db 42, ROCK_SLIDE
	db 46, EARTHQUAKE
	db 50, HYPER_BEAM
	db 0
KangaskhanEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, GROWL
	db 6, TAIL_WHIP
	db 9, QUICK_ATTACK
	db 21, BITE
	db 25, HEADBUTT
	db 31, BODY_SLAM
	db 33, CRUNCH
	db 44, DOUBLE_EDGE
	db 0
NidoranMEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, NIDORINO
	db 0
; Learnset
	db 8, PECK
	db 9, POISON_STING
	db 15, FOCUS_ENERGY
	db 25, ACID
	db 27, HORN_ATTACK
	db 36, TOXIC
	db 38, SLUDGE_BOMB
	db 0
ClefairyEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, CLEFABLE
	db 0
; Learnset
	db 10, DOUBLESLAP
	db 18, SING
	db 19, MINIMIZE
	db 25, HEADBUTT
	db 29, BODY_SLAM
	db 35, PSYCHIC_M
	db 45, DOUBLE_EDGE
	db 0
SpearowEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, FEAROW
	db 0
; Learnset
	db 6, LEER
	db 10, FURY_ATTACK
	db 22, FOCUS_ENERGY
	db 23, WING_ATTACK
	db 25, HEADBUTT
	db 31, BODY_SLAM
	db 33, DRILL_PECK
	db 44, DOUBLE_EDGE
	db 0
VoltorbEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, ELECTRODE
	db 0
; Learnset
	db 7, THUNDERSHOCK
	db 14, SONICBOOM
	db 16, THUNDER_WAVE
	db 23, SWIFT
	db 28, LIGHT_SCREEN
	db 36, THUNDERBOLT
	db 44, THUNDER
	db 0
NidokingEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, LEER
	db 9, DOUBLE_KICK
	db 12, PECK
	db 18, FOCUS_ENERGY
	db 25, ACID
	db 38, SLUDGE
	db 41, SLUDGE_BOMB
	db 0
SlowbroEvosMoves:
; Evolutions
	db 0
; Learnset
	db 25, BUBBLEBEAM
	db 35, SURF
	db 37, PSYCHIC_M
	db 40, AMNESIA
	db 44, HYDRO_PUMP
	db 48, RECOVER
	db 0
IvysaurEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 32, VENUSAUR
	db 0
; Learnset
	db 9, VINE_WHIP
	db 10, GROWTH
	db 15, RAZOR_LEAF
	db 16, POISONPOWDER
	db 22, SLEEP_POWDER
	db 34, TAKE_DOWN
	db 42, SOLARBEAM
	db 44, DOUBLE_EDGE
	db 0
ExeggutorEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, ABSORB
	db 12, LEECH_SEED
	db 16, STUN_SPORE
	db 17, CONFUSION
	db 25, MEGA_DRAIN
	db 28, STOMP
	db 31, REFLECT
	db 38, SOLARBEAM
	db 0
LickitungEvosMoves:
; Evolutions
	blue_evolve_level 33, LICKILICKY
	db 0
; Learnset
	db 9, TACKLE
	db 17, DISABLE
	db 20, ACID
	db 27, STOMP
	db 31, SCREECH
	db 34, BODY_SLAM
	db 37, SLAM
	db 38, DOUBLE_EDGE
	db 0
ExeggcuteEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, EXEGGUTOR
	db 0
; Learnset
	db 9, ABSORB
	db 11, LEECH_SEED
	db 16, STUN_SPORE
	db 17, POISONPOWDER
	db 18, CONFUSION
	db 22, MEGA_DRAIN
	db 26, PSYBEAM
	db 36, PSYCHIC_M
	db 42, SOLARBEAM
	db 0
GrimerEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 38, MUK
	db 0
; Learnset
	db 7, HARDEN
	db 9, POISON_STING
	db 12, SMOG
	db 23, MINIMIZE
	db 25, ACID
	db 30, SLUDGE
	db 35, SLUDGE_BOMB
	db 0
GengarEvosMoves:
; Evolutions
	db 0
; Learnset
	db 14, LICK
	db 18, HYPNOSIS
	db 22, CONFUSE_RAY
	db 28, NIGHT_SHADE
	db 36, HAZE
	db 40, SHADOW_BALL
	db 46, DREAM_EATER
	db 0
NidoranFEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, NIDORINA
	db 0
; Learnset
	db 7, TAIL_WHIP
	db 9, POISON_STING
	db 25, ACID
	db 27, BITE
	db 36, TOXIC
	db 37, CRUNCH
	db 38, SLUDGE_BOMB
	db 0
NidoqueenEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, GROWL
	db 9, POISON_STING
	db 18, SUPERSONIC
	db 25, BITE
	db 28, ACID
	db 31, CRUNCH
	db 38, SLUDGE_BOMB
	db 0
CuboneEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, MAROWAK
	db 0
; Learnset
	db 5, TAIL_WHIP
	db 7, LEER
	db 21, HEADBUTT
	db 23, RAGE
	db 30, BONEMERANG
	db 31, DIG
	db 38, EARTHQUAKE
	db 0
RhyhornEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, RHYDON
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 18, ROCK_THROW
	db 21, LEER
	db 25, STOMP
	db 29, ROCK_SLIDE
	db 31, DIG
	db 39, TAKE_DOWN
	db 40, EARTHQUAKE
	db 0
LaprasEvosMoves:
; Evolutions
	db 0
; Learnset
	db 14, SING
	db 18, ICE_SHARD
	db 23, CONFUSE_RAY
	db 25, BUBBLEBEAM
	db 34, BODY_SLAM
	db 40, SURF
	db 43, ICE_BEAM
	db 46, HYDRO_PUMP
	db 0
ArcanineEvosMoves:
; Evolutions
	db 0
; Learnset
	db 25, FLAME_WHEEL
	db 27, FLAMETHROWER
	db 31, EXTREME_SPEED
	db 34, CRUNCH
	db 37, AGILITY
	db 44, FIRE_BLAST
	db 0
MewEvosMoves:
; Evolutions
	db 0
; Learnset
	db 17, CONFUSION
	db 23, PSYWAVE
	db 29, TRANSFORM
	db 32, METRONOME
	db 33, BARRIER
	db 37, MEGA_PUNCH
	db 38, DREAM_EATER
	db 42, PSYCHIC_M
	db 0
GyaradosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, WATER_GUN
	db 17, FOCUS_ENERGY
	db 24, RAGE
	db 27, WATERFALL
	db 30, BUBBLEBEAM
	db 33, CRUNCH
	db 38, SURF
	db 0
ShellderEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, CLOYSTER
	db 0
; Learnset
	db 9, LEER
	db 12, WATER_GUN
	db 19, SUPERSONIC
	db 25, BUBBLEBEAM
	db 28, AURORA_BEAM
	db 38, SURF
	db 39, ICE_BEAM
	db 45, HYDRO_PUMP
	db 0
TentacoolEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, TENTACRUEL
	db 0
; Learnset
	db 7, CONSTRICT
	db 9, POISON_STING
	db 12, WATER_GUN
	db 16, SUPERSONIC
	db 24, SCREECH
	db 25, BUBBLEBEAM
	db 39, SURF
	db 45, HYDRO_PUMP
	db 0
GastlyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 25, HAUNTER
	db 0
; Learnset
	db 12, LICK
	db 18, HYPNOSIS
	db 22, CONFUSE_RAY
	db 28, NIGHT_SHADE
	db 38, SHADOW_BALL
	db 42, DREAM_EATER
	db 0
ScytherEvosMoves:
; Evolutions
	blue_evolve_item METAL_COAT, 1, SCIZOR
	db 0
; Learnset
	db 7, LEER
	db 9, PIN_MISSILE
	db 17, BUG_BITE
	db 21, FOCUS_ENERGY
	db 24, WING_ATTACK
	db 25, SLASH
	db 31, RAZOR_WIND
	db 34, X_SCISSOR
	db 0
StaryuEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, STARMIE
	db 0
; Learnset
	db 7, WATER_GUN
	db 9, HARDEN
	db 17, CONFUSE_RAY
	db 23, SWIFT
	db 25, PSYBEAM
	db 26, BUBBLEBEAM
	db 40, SURF
	db 46, HYDRO_PUMP
	db 0
BlastoiseEvosMoves:
; Evolutions
	db 0
; Learnset
	db 21, BITE
	db 28, BUBBLEBEAM
	db 36, SURF
	db 40, SKULL_BASH
	db 44, HYDRO_PUMP
	db 50, HYDRO_CANNON
	db 0
PinsirEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, HARDEN
	db 12, PIN_MISSILE
	db 13, FOCUS_ENERGY
	db 17, BUG_BITE
	db 31, X_SCISSOR
	db 33, STRENGTH
	db 35, SUBMISSION
	db 0
TangelaEvosMoves:
; Evolutions
	blue_evolve_level 36, TANGROWTH
	db 0
; Learnset
	db 9, GROWTH
	db 12, ABSORB
	db 14, POISONPOWDER
	db 15, CONFUSION
	db 21, LEECH_SEED
	db 24, MEGA_DRAIN
	db 34, SLAM
	db 38, SOLARBEAM
	db 0
CranidosEvosMoves:
; Evolutions
	blue_evolve_level 30, RAMPARDOS
	db 0
; Learnset
	db 7, LEER
	db 14, FOCUS_ENERGY
	db 17, ROCK_THROW
	db 25, HEADBUTT
	db 26, ROCK_SLIDE
	db 30, SLAM
	db 0
RampardosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, LEER
	db 17, ROCK_THROW
	db 25, HEADBUTT
	db 30, ROCK_SLIDE
	db 34, FOCUS_ENERGY
	db 38, TAKE_DOWN
	db 42, SLAM
	db 48, HYPER_BEAM
	db 0
GrowlitheEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, ARCANINE
	db 0
; Learnset
	db 7, LEER
	db 9, EMBER
	db 21, FLAME_WHEEL
	db 28, AGILITY
	db 31, CRUNCH
	db 37, TAKE_DOWN
	db 39, FLAMETHROWER
	db 44, FIRE_BLAST
	db 0
OnixEvosMoves:
; Evolutions
	blue_evolve_item METAL_COAT, 1, STEELIX
	db 0
; Learnset
	db 9, HARDEN
	db 17, ROCK_THROW
	db 20, RAGE
	db 27, ROCK_SLIDE
	db 33, SLAM
	db 35, DIG
	db 37, EARTHQUAKE
	db 0
FearowEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, QUICK_ATTACK
	db 18, MIRROR_MOVE
	db 23, FOCUS_ENERGY
	db 26, WING_ATTACK
	db 29, HEADBUTT
	db 31, BODY_SLAM
	db 34, DRILL_PECK
	db 44, DOUBLE_EDGE
	db 0
PidgeyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, PIDGEOTTO
	db 0
; Learnset
	db 7, SAND_ATTACK
	db 9, TACKLE
	db 15, MIRROR_MOVE
	db 25, HEADBUTT
	db 28, WING_ATTACK
	db 30, RAZOR_WIND
	db 31, BODY_SLAM
	db 44, DOUBLE_EDGE
	db 0
SlowpokeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 37, SLOWBRO
	db 0
; Learnset
	db 5, GROWL
	db 8, WATER_GUN
	db 14, DISABLE
	db 24, HEADBUTT
	db 25, BUBBLEBEAM
	db 35, SURF
	db 37, PSYCHIC_M
	db 44, HYDRO_PUMP
	db 0
KadabraEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, ALAKAZAM
	db 0
; Learnset
	db 15, HYPNOSIS
	db 18, KINESIS
	db 21, PSYBEAM
	db 22, REFLECT
	db 23, NIGHT_SHADE
	db 38, DREAM_EATER
	db 40, PSYCHIC_M
	db 0
GravelerEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, GOLEM
	db 0
; Learnset
	db 8, SAND_ATTACK
	db 10, HARDEN
	db 17, ROCK_THROW
	db 28, ROCK_SLIDE
	db 30, TAKE_DOWN
	db 39, EARTHQUAKE
	db 46, DOUBLE_EDGE
	db 0
ChanseyEvosMoves:
; Evolutions
	blue_evolve_level 28, BLISSEY
	db 0
; Learnset
	db 5, TAIL_WHIP
	db 6, GROWL
	db 9, QUICK_ATTACK
	db 17, SING
	db 25, HEADBUTT
	db 31, BODY_SLAM
	db 37, EGG_BOMB
	db 43, DOUBLE_EDGE
	db 0
MachokeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, MACHAMP
	db 0
; Learnset
	db 9, TACKLE
	db 18, FOCUS_ENERGY
	db 21, BIDE
	db 24, MACH_PUNCH
	db 28, SEISMIC_TOSS
	db 37, CROSS_CHOP
	db 41, DOUBLE_EDGE
	db 44, HI_JUMP_KICK
	db 0
MrMimeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, HYPNOSIS
	db 19, PSYWAVE
	db 25, SUCKER_PUNCH
	db 26, PSYBEAM
	db 31, LIGHT_SCREEN
	db 34, REFLECT
	db 37, PSYCHIC_M
	db 38, DREAM_EATER
	db 0
HitmonleeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, TACKLE
	db 14, LOW_KICK
	db 17, SUCKER_PUNCH
	db 18, FOCUS_ENERGY
	db 25, ROLLING_KICK
	db 31, SUBMISSION
	db 44, HI_JUMP_KICK
	db 0
HitmonchanEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, LEER
	db 13, MACH_PUNCH
	db 18, FOCUS_ENERGY
	db 25, COUNTER
	db 29, FIRE_PUNCH
	db 32, ICE_PUNCH
	db 35, SUBMISSION
	db 44, HI_JUMP_KICK
	db 0
ArbokEvosMoves:
; Evolutions
	db 0
; Learnset
	db 16, GLARE
	db 23, SCREECH
	db 26, ACID
	db 31, CRUNCH
	db 33, SLAM
	db 38, SLUDGE
	db 41, SLUDGE_BOMB
	db 0
ParasectEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, PIN_MISSILE
	db 12, ABSORB
	db 15, FURY_SWIPES
	db 18, LEECH_SEED
	db 21, BUG_BITE
	db 24, GROWTH
	db 27, SLASH
	db 33, X_SCISSOR
	db 0
PsyduckEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, GOLDUCK
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 9, BUBBLE
	db 13, CONFUSION
	db 14, DISABLE
	db 25, BUBBLEBEAM
	db 26, PSYBEAM
	db 37, SURF
	db 44, HYDRO_PUMP
	db 0
DrowzeeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, HYPNO
	db 0
; Learnset
	db 11, DISABLE
	db 14, CONFUSION
	db 18, MEDITATE
	db 21, HEADBUTT
	db 24, PSYBEAM
	db 38, PSYCHIC_M
	db 39, DREAM_EATER
	db 0
GolemEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, HARDEN
	db 17, ROCK_THROW
	db 28, ROCK_SLIDE
	db 36, TAKE_DOWN
	db 40, EARTHQUAKE
	db 44, SELFDESTRUCT
	db 50, EXPLOSION
	db 0
CufantEvosMoves:
; Evolutions
	blue_evolve_level 34, COPPERAJAH
	db 0
; Learnset
	db 6, GROWL
	db 12, ROCK_THROW
	db 16, STOMP
	db 24, METAL_CLAW
	db 29, IRON_TAIL
	db 34, ROCK_SLIDE
	db 0
MagmarEvosMoves:
; Evolutions
	blue_evolve_level 38, MAGMORTAR
	db 0
; Learnset
	db 7, LEER
	db 9, SMOG
	db 12, SMOKESCREEN
	db 15, FIRE_SPIN
	db 22, FLAME_WHEEL
	db 25, LOW_KICK
	db 41, FLAMETHROWER
	db 46, FIRE_BLAST
	db 0
CopperajahEvosMoves:
; Evolutions
	db 0
; Learnset
	db 17, ROCK_THROW
	db 25, STOMP
	db 34, ROCK_SLIDE
	db 38, IRON_TAIL
	db 44, EARTHQUAKE
	db 50, HYPER_BEAM
	db 0
ElectabuzzEvosMoves:
; Evolutions
	blue_evolve_level 38, ELECTIVIRE
	db 0
; Learnset
	db 9, THUNDERSHOCK
	db 17, THUNDER_WAVE
	db 21, SWIFT
	db 25, SCREECH
	db 28, LOW_KICK
	db 41, THUNDERBOLT
	db 46, THUNDER
	db 0
MagnetonEvosMoves:
; Evolutions
	blue_evolve_level 35, MAGNEZONE
	db 0
; Learnset
	db 16, THUNDER_WAVE
	db 18, SUPERSONIC
	db 28, SWIFT
	db 31, TRI_ATTACK
	db 37, THUNDERBOLT
	db 44, THUNDER
	db 0
KoffingEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 35, WEEZING
	db 0
; Learnset
	db 9, POISON_STING
	db 11, SMOKESCREEN
	db 20, HAZE
	db 25, ACID
	db 32, SLUDGE
	db 41, SELFDESTRUCT
	db 47, EXPLOSION
	db 0
ToxelEvosMoves:
; Evolutions
	blue_evolve_level 30, TOXTRICITY
	db 0
; Learnset
	db 6, GROWL
	db 9, THUNDERSHOCK
	db 15, ACID
	db 20, THUNDER_WAVE
	db 25, SCREECH
	db 29, SLUDGE
	db 30, THUNDERBOLT
	db 0
MankeyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, PRIMEAPE
	db 0
; Learnset
	db 16, SEISMIC_TOSS
	db 19, KARATE_CHOP
	db 22, FOCUS_ENERGY
	db 29, SCREECH
	db 31, SUBMISSION
	db 35, SKULL_BASH
	db 39, THRASH
	db 44, HI_JUMP_KICK
	db 0
SeelEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 34, DEWGONG
	db 0
; Learnset
	db 5, GROWL
	db 8, WATER_GUN
	db 26, AURORA_BEAM
	db 27, WATERFALL
	db 34, REST
	db 38, SURF
	db 41, TAKE_DOWN
	db 44, HYDRO_PUMP
	db 0
DiglettEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, DUGTRIO
	db 0
; Learnset
	db 5, GROWL
	db 8, SAND_ATTACK
	db 18, SUCKER_PUNCH
	db 25, SLASH
	db 27, FISSURE
	db 31, DIG
	db 39, EARTHQUAKE
	db 0
TaurosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 9, QUICK_ATTACK
	db 13, LEER
	db 24, STOMP
	db 31, BODY_SLAM
	db 46, DOUBLE_EDGE
	db 49, OUTRAGE
	db 0
ToxtricityEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, THUNDERSHOCK
	db 17, ACID
	db 25, SCREECH
	db 30, THUNDERBOLT
	db 34, SLUDGE
	db 39, SLUDGE_BOMB
	db 45, THUNDER
	db 50, HYPER_BEAM
	db 0
MissingNo3EEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
MissingNo3FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
FarfetchdEvosMoves:
; Evolutions
	blue_evolve_level 36, MASQUAWK
	db 0
; Learnset
	db 6, LEER
	db 9, QUICK_ATTACK
	db 13, FOCUS_ENERGY
	db 16, RAZOR_LEAF
	db 30, SLASH
	db 31, BODY_SLAM
	db 43, SKY_ATTACK
	db 44, DOUBLE_EDGE
	db 0
VenonatEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, VENOMOTH
	db 0
; Learnset
	db 9, PIN_MISSILE
	db 15, POISONPOWDER
	db 18, STUN_SPORE
	db 22, PSYBEAM
	db 23, LEECH_LIFE
	db 25, MEGA_DRAIN
	db 31, X_SCISSOR
	db 0
DragoniteEvosMoves:
; Evolutions
	db 0
; Learnset
	db 18, DRAGON_RAGE
	db 29, SLAM
	db 43, OUTRAGE
	db 45, WING_ATTACK
	db 49, FIRE_PUNCH
	db 53, THUNDERPUNCH
	db 60, HYPER_BEAM
	db 0
ShieldonEvosMoves:
; Evolutions
	blue_evolve_level 30, BASTIODON
	db 0
; Learnset
	db 9, TACKLE
	db 17, ROCK_THROW
	db 26, ROCK_SLIDE
	db 30, TAKE_DOWN
	db 0
BastiodonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, TACKLE
	db 17, ROCK_THROW
	db 26, ROCK_SLIDE
	db 30, METAL_CLAW
	db 34, TAKE_DOWN
	db 40, IRON_TAIL
	db 46, DOUBLE_EDGE
	db 0
MissingNo45EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
DoduoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, DODRIO
	db 0
; Learnset
	db 6, GROWL
	db 7, LEER
	db 9, FURY_ATTACK
	db 20, RAGE
	db 22, WING_ATTACK
	db 31, BODY_SLAM
	db 33, DRILL_PECK
	db 44, DOUBLE_EDGE
	db 0
PoliwagEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, POLIWHIRL
	db 0
; Learnset
	db 9, WATER_GUN
	db 20, HYPNOSIS
	db 22, LOW_KICK
	db 26, BUBBLEBEAM
	db 31, BODY_SLAM
	db 37, AMNESIA
	db 38, SURF
	db 43, HYDRO_PUMP
	db 0
JynxEvosMoves:
; Evolutions
	blue_evolve_level 36, MESMERIA
	db 0
; Learnset
	db 9, POWDER_SNOW
	db 15, CONFUSION
	db 17, ICE_SHARD
	db 19, SING
	db 23, SCREECH
	db 26, AURORA_BEAM
	db 37, PSYCHIC_M
	db 38, ICE_BEAM
	db 46, BLIZZARD
	db 0
MoltresEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, LEER
	db 8, EMBER
	db 9, GUST
	db 22, WING_ATTACK
	db 25, FLAME_WHEEL
	db 28, AGILITY
	db 36, FLAMETHROWER
	db 44, FIRE_BLAST
	db 0
ArticunoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 8, POWDER_SNOW
	db 9, GUST
	db 10, LEER
	db 16, ICE_SHARD
	db 24, MIST
	db 46, BLIZZARD
	db 49, SKY_ATTACK
	db 0
ZapdosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, PECK
	db 10, LEER
	db 16, THUNDER_WAVE
	db 36, THUNDERBOLT
	db 46, THUNDER
	db 49, SKY_ATTACK
	db 0
DittoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, QUICK_ATTACK
	db 25, HEADBUTT
	db 28, SLASH
	db 31, BODY_SLAM
	db 44, DOUBLE_EDGE
	db 0
MeowthEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, PERSIAN
	db 0
; Learnset
	db 9, QUICK_ATTACK
	db 16, FURY_SWIPES
	db 21, PAY_DAY
	db 22, BITE
	db 28, SCREECH
	db 31, BODY_SLAM
	db 44, DOUBLE_EDGE
	db 0
KrabbyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, KINGLER
	db 0
; Learnset
	db 7, HARDEN
	db 9, WATER_GUN
	db 16, VICEGRIP
	db 23, BUBBLEBEAM
	db 29, STOMP
	db 34, SLAM
	db 40, CRABHAMMER
	db 0
BunearyEvosMoves:
; Evolutions
	blue_evolve_level 22, LOPUNNY
	db 0
; Learnset
	db 9, QUICK_ATTACK
	db 13, DEFENSE_CURL
	db 16, DOUBLE_KICK
	db 27, HEADBUTT
	db 31, BODY_SLAM
	db 33, AGILITY
	db 36, HI_JUMP_KICK
	db 43, DOUBLE_EDGE
	db 0
LopunnyEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, QUICK_ATTACK
	db 17, MACH_PUNCH
	db 18, DEFENSE_CURL
	db 27, HEADBUTT
	db 31, BODY_SLAM
	db 33, AGILITY
	db 36, HI_JUMP_KICK
	db 43, DOUBLE_EDGE
	db 0
MissingNo51EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
VulpixEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, NINETALES
	db 0
; Learnset
	db 9, TACKLE
	db 12, QUICK_ATTACK
	db 15, DISABLE
	db 19, FIRE_SPIN
	db 21, CONFUSE_RAY
	db 22, FLAME_WHEEL
	db 36, FLAMETHROWER
	db 46, FIRE_BLAST
	db 0
NinetalesEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, FIRE_SPIN
	db 12, TACKLE
	db 14, DISABLE
	db 20, HYPNOSIS
	db 22, FLAME_WHEEL
	db 26, CONFUSE_RAY
	db 32, FLAMETHROWER
	db 40, FIRE_BLAST
	db 0
PikachuEvosMoves:
; Evolutions
	db EVOLVE_ITEM, THUNDER_STONE, 1, RAICHU
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 12, THUNDER_WAVE
	db 22, SWIFT
	db 30, SLAM
	db 37, THUNDERBOLT
	db 44, THUNDER
	db 0
RaichuEvosMoves:
; Evolutions
	blue_evolve_level 45, GOROCHU
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 22, SWIFT
	db 25, BODY_SLAM
	db 27, THUNDERBOLT
	db 28, LIGHT_SCREEN
	db 31, SLAM
	db 44, THUNDER
	db 0
WimpodEvosMoves:
; Evolutions
	blue_evolve_level 30, GOLISOPOD
	db 0
; Learnset
	db 8, SAND_ATTACK
	db 9, PIN_MISSILE
	db 14, BUG_BITE
	db 17, BUBBLEBEAM
	db 18, DEFENSE_CURL
	db 24, WATERFALL
	db 28, LEECH_LIFE
	db 31, X_SCISSOR
	db 0
GolisopodEvosMoves:
; Evolutions
	db 0
; Learnset
	db 17, BUG_BITE
	db 21, PIN_MISSILE
	db 24, SUCKER_PUNCH
	db 30, WATERFALL
	db 34, SLASH
	db 38, X_SCISSOR
	db 44, SWORDS_DANCE
	db 0
DratiniEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 25, DRAGONAIR
	db 0
; Learnset
	db 14, THUNDER_WAVE
	db 17, DRAGON_RAGE
	db 24, SLAM
	db 0
DragonairEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 45, DRAGONITE
	db 0
; Learnset
	db 18, DRAGON_RAGE
	db 25, SLAM
	db 32, AGILITY
	db 38, THUNDER_WAVE
	db 44, OUTRAGE
	db 0
KabutoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, KABUTOPS
	db 0
; Learnset
	db 9, SAND_ATTACK
	db 11, LEER
	db 21, ROCK_THROW
	db 29, MEGA_DRAIN
	db 30, SLASH
	db 0
KabutopsEvosMoves:
; Evolutions
	db 0
; Learnset
	db 11, LEER
	db 21, ROCK_THROW
	db 25, SLASH
	db 30, ROCK_SLIDE
	db 35, WATERFALL
	db 40, MEGA_DRAIN
	db 46, HYDRO_PUMP
	db 50, X_SCISSOR
	db 0
HorseaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, SEADRA
	db 0
; Learnset
	db 7, LEER
	db 9, WATER_GUN
	db 10, SMOKESCREEN
	db 25, BUBBLEBEAM
	db 26, WATERFALL
	db 38, SURF
	db 44, HYDRO_PUMP
	db 0
SeadraEvosMoves:
; Evolutions
	blue_evolve_level 36, KINGDRA
	db 0
; Learnset
	db 7, LEER
	db 9, WATER_GUN
	db 14, DISABLE
	db 25, BUBBLEBEAM
	db 26, WATERFALL
	db 38, SURF
	db 46, HYDRO_PUMP
	db 0
MissingNo5EEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
MissingNo5FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
SandshrewEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, SANDSLASH
	db 0
; Learnset
	db 7, SAND_ATTACK
	db 18, DEFENSE_CURL
	db 24, SWIFT
	db 27, SLASH
	db 32, DIG
	db 40, EARTHQUAKE
	db 0
SandslashEvosMoves:
; Evolutions
	db 0
; Learnset
	db 18, DEFENSE_CURL
	db 24, SWIFT
	db 29, SLASH
	db 32, AGILITY
	db 34, DIG
	db 42, EARTHQUAKE
	db 0
OmanyteEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, OMASTAR
	db 0
; Learnset
	db 9, SAND_ATTACK
	db 11, LEER
	db 20, ROCK_THROW
	db 24, BITE
	db 28, HORN_ATTACK
	db 30, ROCK_SLIDE
	db 0
OmastarEvosMoves:
; Evolutions
	db 0
; Learnset
	db 20, ROCK_THROW
	db 30, ROCK_SLIDE
	db 35, WATERFALL
	db 40, SURF
	db 46, HYDRO_PUMP
	db 50, BLIZZARD
	db 0
JigglypuffEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, WIGGLYTUFF
	db 0
; Learnset
	db 9, QUICK_ATTACK
	db 10, DOUBLESLAP
	db 14, DISABLE
	db 18, DEFENSE_CURL
	db 25, HEADBUTT
	db 29, BODY_SLAM
	db 44, DOUBLE_EDGE
	db 0
WigglytuffEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, QUICK_ATTACK
	db 18, BIDE
	db 24, MINIMIZE
	db 25, HEADBUTT
	db 28, SLASH
	db 31, BODY_SLAM
	db 44, DOUBLE_EDGE
	db 0
EeveeEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, FLAREON
	db EVOLVE_ITEM, THUNDER_STONE, 1, JOLTEON
	db EVOLVE_ITEM, WATER_STONE, 1, VAPOREON
	blue_evolve_item ICE_STONE, 1, GLACEON
	blue_evolve_item LEAF_STONE, 1, LEAFEON
	blue_evolve_item MOON_STONE, 1, UMBREON
	blue_evolve_level 26, ESPEON
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 9, GROWL
	db 12, DOUBLE_KICK
	db 15, QUICK_ATTACK
	db 23, SWIFT
	db 25, BITE
	db 31, BODY_SLAM
	db 46, DOUBLE_EDGE
	db 0
FlareonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 9, GROWL
	db 18, FIRE_SPIN
	db 25, SWIFT
	db 28, BITE
	db 31, FLAME_WHEEL
	db 34, FLAMETHROWER
	db 44, FIRE_BLAST
	db 0
JolteonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 9, GROWL
	db 17, THUNDER_WAVE
	db 25, BITE
	db 28, SWIFT
	db 34, THUNDERBOLT
	db 46, THUNDER
	db 0
VaporeonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 9, GROWL
	db 12, BUBBLE
	db 25, BITE
	db 28, BUBBLEBEAM
	db 31, AURORA_BEAM
	db 38, SURF
	db 46, HYDRO_PUMP
	db 0
MachopEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, MACHOKE
	db 0
; Learnset
	db 7, LEER
	db 9, TACKLE
	db 13, FOCUS_ENERGY
	db 17, LOW_KICK
	db 25, SEISMIC_TOSS
	db 37, CROSS_CHOP
	db 41, DOUBLE_EDGE
	db 44, HI_JUMP_KICK
	db 0
ZubatEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, GOLBAT
	db 0
; Learnset
	db 9, POISON_STING
	db 12, GUST
	db 15, HYPNOSIS
	db 18, SUPERSONIC
	db 21, WING_ATTACK
	db 24, BITE
	db 25, ACID
	db 38, SLUDGE_BOMB
	db 0
EkansEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, ARBOK
	db 0
; Learnset
	db 7, POISON_STING
	db 16, GLARE
	db 20, BITE
	db 23, SCREECH
	db 26, ACID
	db 30, SLAM
	db 38, SLUDGE
	db 0
ParasEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 24, PARASECT
	db 0
; Learnset
	db 9, PIN_MISSILE
	db 12, ABSORB
	db 15, FURY_SWIPES
	db 18, STUN_SPORE
	db 21, GROWTH
	db 24, LEECH_LIFE
	db 27, SLASH
	db 33, X_SCISSOR
	db 0
PoliwhirlEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, POLIWRATH
	db 0
; Learnset
	db 21, LOW_KICK
	db 23, BUBBLEBEAM
	db 25, WATERFALL
	db 31, BODY_SLAM
	db 38, AMNESIA
	db 41, SURF
	db 45, HYDRO_PUMP
	db 0
PoliwrathEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, BUBBLE
	db 18, HAZE
	db 24, MIST
	db 25, BUBBLEBEAM
	db 31, SUBMISSION
	db 38, SURF
	db 44, HYDRO_PUMP
	db 47, DOUBLE_EDGE
	db 0
WeedleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 7, KAKUNA
	db 0
; Learnset
	db 9, PIN_MISSILE
	db 12, TWINEEDLE
	db 14, BUG_BITE
	db 31, X_SCISSOR
	db 0
KakunaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, BEEDRILL
	db 0
; Learnset
	db 9, PIN_MISSILE
	db 12, TWINEEDLE
	db 17, BUG_BITE
	db 31, X_SCISSOR
	db 0
BeedrillEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, STRING_SHOT
	db 9, HARDEN
	db 12, POISON_STING
	db 15, TWINEEDLE
	db 18, PECK
	db 21, BUG_BITE
	db 24, RAGE
	db 31, X_SCISSOR
	db 0
MissingNo73EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
DodrioEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, LEER
	db 9, QUICK_ATTACK
	db 18, SUPERSONIC
	db 22, WING_ATTACK
	db 25, RAGE
	db 31, BODY_SLAM
	db 33, DRILL_PECK
	db 44, DOUBLE_EDGE
	db 0
PrimeapeEvosMoves:
; Evolutions
	blue_evolve_level 36, ANNIHILAPE
	db 0
; Learnset
	db 14, LOW_KICK
	db 18, FOCUS_ENERGY
	db 21, COUNTER
	db 25, RAGE
	db 31, SUBMISSION
	db 32, SCREECH
	db 44, HI_JUMP_KICK
	db 0
DugtrioEvosMoves:
; Evolutions
	db 0
; Learnset
	db 8, SAND_ATTACK
	db 25, SLASH
	db 26, SCREECH
	db 29, FISSURE
	db 31, TRI_ATTACK
	db 41, EARTHQUAKE
	db 0
VenomothEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, PIN_MISSILE
	db 18, STUN_SPORE
	db 22, PSYBEAM
	db 25, MEGA_DRAIN
	db 31, BUG_BITE
	db 36, SLEEP_POWDER
	db 41, X_SCISSOR
	db 46, PSYCHIC_M
	db 0
DewgongEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, WATER_GUN
	db 17, ICE_SHARD
	db 25, BUBBLEBEAM
	db 34, REST
	db 38, SURF
	db 41, TAKE_DOWN
	db 42, ICE_BEAM
	db 44, HYDRO_PUMP
	db 0
MissingNo79EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
MissingNo7AEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
CaterpieEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 7, METAPOD
	db 0
; Learnset
	db 9, PIN_MISSILE
	db 12, TWINEEDLE
	db 14, BUG_BITE
	db 31, X_SCISSOR
	db 0
MetapodEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 18, BUTTERFREE
	db 0
; Learnset
	db 9, PIN_MISSILE
	db 12, TWINEEDLE
	db 17, BUG_BITE
	db 31, X_SCISSOR
	db 0
ButterfreeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, STRING_SHOT
	db 9, HARDEN
	db 12, PIN_MISSILE
	db 15, GUST
	db 18, TACKLE
	db 21, BUG_BITE
	db 22, PSYBEAM
	db 31, X_SCISSOR
	db 0
MachampEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, TACKLE
	db 18, FOCUS_ENERGY
	db 21, BIDE
	db 24, COUNTER
	db 27, MACH_PUNCH
	db 37, CROSS_CHOP
	db 41, DOUBLE_EDGE
	db 44, HI_JUMP_KICK
	db 0
MissingNo7FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
GolduckEvosMoves:
; Evolutions
	db 0
; Learnset
	db 17, CONFUSION
	db 25, BUBBLEBEAM
	db 33, PSYBEAM
	db 38, SURF
	db 43, HYDRO_PUMP
	db 48, AMNESIA
	db 0
HypnoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 18, MEDITATE
	db 21, HEADBUTT
	db 24, PSYBEAM
	db 28, BARRIER
	db 39, PSYCHIC_M
	db 42, DREAM_EATER
	db 0
GolbatEvosMoves:
; Evolutions
	blue_evolve_level 36, CROBAT
	db 0
; Learnset
	db 9, POISON_STING
	db 12, GUST
	db 15, HYPNOSIS
	db 18, SUPERSONIC
	db 25, WING_ATTACK
	db 28, ACID
	db 31, CRUNCH
	db 38, SLUDGE_BOMB
	db 0
MewtwoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 18, PSYWAVE
	db 22, CONFUSE_RAY
	db 24, PSYBEAM
	db 33, MIST
	db 35, BARRIER
	db 38, DREAM_EATER
	db 0
SnorlaxEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, TACKLE
	db 20, HARDEN
	db 22, BITE
	db 25, SLASH
	db 26, SCREECH
	db 29, CRUNCH
	db 30, BODY_SLAM
	db 49, HYPER_BEAM
	db 0
MagikarpEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, GYARADOS
	db 0
; Learnset
	db 9, WATER_GUN
	db 11, TACKLE
	db 25, BUBBLEBEAM
	db 28, WATERFALL
	db 38, SURF
	db 44, HYDRO_PUMP
	db 0
MissingNo86EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
MissingNo87EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
MukEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, POISON_STING
	db 15, SMOG
	db 25, ACID
	db 38, MINIMIZE
	db 42, SLUDGE
	db 46, SLUDGE_BOMB
	db 50, ACID_ARMOR
	db 0
MissingNo8AEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
KinglerEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, HARDEN
	db 12, WATER_GUN
	db 17, VICEGRIP
	db 23, BUBBLEBEAM
	db 30, STOMP
	db 36, SLAM
	db 42, CRABHAMMER
	db 0
CloysterEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, LEER
	db 9, SPIKE_CANNON
	db 12, WATER_GUN
	db 17, ICE_SHARD
	db 25, BUBBLEBEAM
	db 28, BARRIER
	db 38, SURF
	db 44, HYDRO_PUMP
	db 0
MissingNo8CEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
ElectrodeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, THUNDERSHOCK
	db 16, THUNDER_WAVE
	db 23, SWIFT
	db 28, LIGHT_SCREEN
	db 37, THUNDERBOLT
	db 41, SELFDESTRUCT
	db 44, THUNDER
	db 0
ClefableEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, GROWL
	db 9, TACKLE
	db 18, DEFENSE_CURL
	db 25, HEADBUTT
	db 31, BODY_SLAM
	db 35, PSYCHIC_M
	db 45, DOUBLE_EDGE
	db 0
WeezingEvosMoves:
; Evolutions
	db 0
; Learnset
	db 12, SMOKESCREEN
	db 25, ACID
	db 31, SCREECH
	db 35, SLUDGE
	db 39, SLUDGE_BOMB
	db 43, SELFDESTRUCT
	db 48, EXPLOSION
	db 0
PersianEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, QUICK_ATTACK
	db 16, FURY_SWIPES
	db 20, HYPNOSIS
	db 25, SWIFT
	db 31, BODY_SLAM
	db 36, AMNESIA
	db 44, DOUBLE_EDGE
	db 0
MarowakEvosMoves:
; Evolutions
	blue_evolve_level 42, GUARDIA
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 21, HEADBUTT
	db 23, RAGE
	db 24, FOCUS_ENERGY
	db 31, DIG
	db 33, BONEMERANG
	db 38, EARTHQUAKE
	db 0
MissingNo92EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
HaunterEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, GENGAR
	db 0
; Learnset
	db 12, LICK
	db 20, HYPNOSIS
	db 24, CONFUSE_RAY
	db 30, NIGHT_SHADE
	db 40, SHADOW_BALL
	db 44, DREAM_EATER
	db 0
AbraEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, KADABRA
	db 0
; Learnset
	db 17, CONFUSION
	db 25, PSYBEAM
	db 38, PSYCHIC_M
	db 41, DREAM_EATER
	db 0
AlakazamEvosMoves:
; Evolutions
	db 0
; Learnset
	db 18, PSYBEAM
	db 22, REFLECT
	db 28, BARRIER
	db 36, RECOVER
	db 40, PSYCHIC_M
	db 46, DREAM_EATER
	db 0
PidgeottoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, PIDGEOT
	db 0
; Learnset
	db 9, TACKLE
	db 16, MIRROR_MOVE
	db 25, HEADBUTT
	db 29, WING_ATTACK
	db 31, BODY_SLAM
	db 32, AGILITY
	db 36, RAZOR_WIND
	db 44, DOUBLE_EDGE
	db 0
PidgeotEvosMoves:
; Evolutions
	db 0
; Learnset
	db 16, MIRROR_MOVE
	db 25, HEADBUTT
	db 29, WING_ATTACK
	db 36, AGILITY
	db 40, RAZOR_WIND
	db 45, DOUBLE_EDGE
	db 50, SKY_ATTACK
	db 0
StarmieEvosMoves:
; Evolutions
	db 0
; Learnset
	db 18, PSYWAVE
	db 22, CONFUSE_RAY
	db 24, MINIMIZE
	db 25, SWIFT
	db 28, BUBBLEBEAM
	db 31, PSYBEAM
	db 38, SURF
	db 44, HYDRO_PUMP
	db 0
BulbasaurEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, IVYSAUR
	db 0
; Learnset
	db 7, VINE_WHIP
	db 9, GROWTH
	db 11, LEECH_SEED
	db 15, RAZOR_LEAF
	db 16, POISONPOWDER
	db 32, TAKE_DOWN
	db 37, SOLARBEAM
	db 40, DOUBLE_EDGE
	db 0
VenusaurEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, GROWTH
	db 15, RAZOR_LEAF
	db 16, POISONPOWDER
	db 22, SLEEP_POWDER
	db 34, TAKE_DOWN
	db 42, SOLARBEAM
	db 46, DOUBLE_EDGE
	db 0
TentacruelEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, POISON_STING
	db 12, WATER_GUN
	db 15, CONSTRICT
	db 24, SCREECH
	db 25, BUBBLEBEAM
	db 31, BARRIER
	db 41, SURF
	db 46, HYDRO_PUMP
	db 0
MissingNo9CEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
GoldeenEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, SEAKING
	db 0
; Learnset
	db 9, WATER_GUN
	db 12, QUICK_ATTACK
	db 14, SUPERSONIC
	db 22, HORN_ATTACK
	db 28, AGILITY
	db 31, WATERFALL
	db 38, SURF
	db 44, HYDRO_PUMP
	db 0
SeakingEvosMoves:
; Evolutions
	db 0
; Learnset
	db 22, HORN_ATTACK
	db 29, WATERFALL
	db 33, AGILITY
	db 38, SURF
	db 44, HYDRO_PUMP
	db 48, DOUBLE_EDGE
	db 0
MissingNo9FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
MissingNoA0EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
MissingNoA1EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
MissingNoA2EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
PonytaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, RAPIDASH
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 9, GROWL
	db 18, FIRE_SPIN
	db 22, FLAME_WHEEL
	db 27, STOMP
	db 38, FLAMETHROWER
	db 39, TAKE_DOWN
	db 42, FIRE_BLAST
	db 0
RapidashEvosMoves:
; Evolutions
	db 0
; Learnset
	db 18, FIRE_SPIN
	db 22, FLAME_WHEEL
	db 28, AGILITY
	db 40, TAKE_DOWN
	db 42, FLAMETHROWER
	db 46, FIRE_BLAST
	db 50, DOUBLE_EDGE
	db 0
RattataEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, RATICATE
	db 0
; Learnset
	db 7, QUICK_ATTACK
	db 14, FOCUS_ENERGY
	db 20, BITE
	db 25, HEADBUTT
	db 28, CRUNCH
	db 31, BODY_SLAM
	db 40, DOUBLE_EDGE
	db 0
RaticateEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, FURY_SWIPES
	db 18, FOCUS_ENERGY
	db 20, BITE
	db 25, HEADBUTT
	db 29, CRUNCH
	db 31, BODY_SLAM
	db 34, SWORDS_DANCE
	db 42, DOUBLE_EDGE
	db 0
NidorinoEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, NIDOKING
	db 0
; Learnset
	db 9, POISON_STING
	db 12, PECK
	db 16, DOUBLE_KICK
	db 18, FOCUS_ENERGY
	db 25, ACID
	db 38, SLUDGE_BOMB
	db 39, TOXIC
	db 0
NidorinaEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, NIDOQUEEN
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 9, POISON_STING
	db 25, ACID
	db 29, BITE
	db 37, CRUNCH
	db 38, SLUDGE_BOMB
	db 39, TOXIC
	db 0
GeodudeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 25, GRAVELER
	db 0
; Learnset
	db 6, SAND_ATTACK
	db 10, HARDEN
	db 17, ROCK_THROW
	db 28, ROCK_SLIDE
	db 30, TAKE_DOWN
	db 37, EARTHQUAKE
	db 43, DOUBLE_EDGE
	db 0
PorygonEvosMoves:
; Evolutions
	blue_evolve_level 30, PORYGON2
	db 0
; Learnset
	db 9, QUICK_ATTACK
	db 14, THUNDER_WAVE
	db 23, PSYBEAM
	db 25, BARRIER
	db 28, HEADBUTT
	db 31, BODY_SLAM
	db 35, THUNDERBOLT
	db 46, DOUBLE_EDGE
	db 0
AerodactylEvosMoves:
; Evolutions
	db 0
; Learnset
	db 14, SUPERSONIC
	db 18, ROCK_THROW
	db 25, BITE
	db 27, ROCK_SLIDE
	db 31, CRUNCH
	db 33, FLY
	db 0
MissingNoACEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
MagnemiteEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, MAGNETON
	db 0
; Learnset
	db 9, THUNDERSHOCK
	db 13, THUNDER_WAVE
	db 16, SUPERSONIC
	db 17, SONICBOOM
	db 29, SWIFT
	db 37, THUNDERBOLT
	db 44, THUNDER
	db 0
MissingNoAEEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
MissingNoAFEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
CharmanderEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, CHARMELEON
	db 0
; Learnset
	db 7, EMBER
	db 10, LEER
	db 11, SMOKESCREEN
	db 23, RAGE
	db 26, SLASH
	db 29, FLAME_WHEEL
	db 33, STONE_EDGE
	db 44, ACCELEROCK
	db 0
SquirtleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, WARTORTLE
	db 0
; Learnset
	db 9, WITHDRAW
	db 12, BUBBLE
	db 21, BITE
	db 26, BUBBLEBEAM
	db 29, HEADBUTT
	db 38, SURF
	db 40, HYDRO_PUMP
	db 0
CharmeleonEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, CHARIZARD
	db 0
; Learnset
	db 10, LEER
	db 12, SMOKESCREEN
	db 20, FIRE_SPIN
	db 23, RAGE
	db 25, FLAME_WHEEL
	db 28, SLASH
	db 35, FLAMETHROWER
	db 44, FIRE_BLAST
	db 0
WartortleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, BLASTOISE
	db 0
; Learnset
	db 9, WATER_GUN
	db 10, WITHDRAW
	db 21, BITE
	db 28, BUBBLEBEAM
	db 32, HEADBUTT
	db 38, SURF
	db 42, SKULL_BASH
	db 0
CharizardEvosMoves:
; Evolutions
	db 0
; Learnset
	db 12, SMOKESCREEN
	db 25, WING_ATTACK
	db 31, SLASH
	db 36, FLAME_WHEEL
	db 40, FLAMETHROWER
	db 44, FIRE_BLAST
	db 50, SKY_ATTACK
	db 55, BLAST_BURN
	db 0
MissingNoB5EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
FossilKabutopsEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
FossilAerodactylEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
MonGhostEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
OddishEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, GLOOM
	db 0
; Learnset
	db 9, VINE_WHIP
	db 10, GROWTH
	db 15, POISONPOWDER
	db 16, STUN_SPORE
	db 17, RAZOR_LEAF
	db 18, ACID
	db 41, SOLARBEAM
	db 0
GloomEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, VILEPLUME
	db 0
; Learnset
	db 9, VINE_WHIP
	db 10, GROWTH
	db 17, RAZOR_LEAF
	db 23, SLEEP_POWDER
	db 25, ACID
	db 31, TOXIC
	db 42, SOLARBEAM
	db 0
VileplumeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, ABSORB
	db 12, VINE_WHIP
	db 15, GROWTH
	db 16, POISONPOWDER
	db 25, MEGA_DRAIN
	db 34, TOXIC
	db 38, SOLARBEAM
	db 0
BellsproutEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 21, WEEPINBELL
	db 0
; Learnset
	db 10, WRAP
	db 16, POISONPOWDER
	db 19, STUN_SPORE
	db 22, SLEEP_POWDER
	db 24, RAZOR_LEAF
	db 27, ACID
	db 36, SLAM
	db 38, SOLARBEAM
	db 0
WeepinbellEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, VICTREEBEL
	db 0
; Learnset
	db 16, POISONPOWDER
	db 19, STUN_SPORE
	db 22, SLEEP_POWDER
	db 25, ACID
	db 26, RAZOR_LEAF
	db 37, SLAM
	db 38, SOLARBEAM
	db 0
VictreebelEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, VINE_WHIP
	db 10, GROWTH
	db 16, POISONPOWDER
	db 17, LEECH_LIFE
	db 25, MEGA_DRAIN
	db 31, SLAM
	db 34, SWORDS_DANCE
	db 38, SOLARBEAM
	db 0
ChikoritaEvosMoves:
	blue_evolve_level 16, BAYLEEF
	db 0
; Learnset
	db 9, VINE_WHIP
	db 13, RAZOR_LEAF
	db 14, POISONPOWDER
	db 16, LEECH_SEED
	db 24, REFLECT
	db 32, BODY_SLAM
	db 40, SOLARBEAM
	db 0
BayleefEvosMoves:
	blue_evolve_level 32, MEGANIUM
	db 0
; Learnset
	db 6, GROWL
	db 9, VINE_WHIP
	db 12, TACKLE
	db 16, POISONPOWDER
	db 17, LEECH_SEED
	db 20, RAZOR_LEAF
	db 34, BODY_SLAM
	db 42, SOLARBEAM
	db 0
MeganiumEvosMoves:
	db 0
; Learnset
	db 9, VINE_WHIP
	db 16, POISONPOWDER
	db 20, RAZOR_LEAF
	db 32, LIGHT_SCREEN
	db 36, BODY_SLAM
	db 42, SOLARBEAM
	db 48, FRENZY_PLANT
	db 0
CyndaquilEvosMoves:
	blue_evolve_level 14, QUILAVA
	db 0
; Learnset
	db 7, LEER
	db 9, EMBER
	db 12, TACKLE
	db 15, SMOKESCREEN
	db 23, FLAME_WHEEL
	db 27, SWIFT
	db 39, FLAMETHROWER
	db 44, FIRE_BLAST
	db 0
QuilavaEvosMoves:
	blue_evolve_level 36, TYPHLOSION
	db 0
; Learnset
	db 7, LEER
	db 9, EMBER
	db 12, TACKLE
	db 15, SMOKESCREEN
	db 23, FLAME_WHEEL
	db 27, SWIFT
	db 41, FLAMETHROWER
	db 44, FIRE_BLAST
	db 0
TyphlosionEvosMoves:
	db 0
; Learnset
	db 15, SMOKESCREEN
	db 23, FLAME_WHEEL
	db 36, SWIFT
	db 40, FLAMETHROWER
	db 44, FIRE_BLAST
	db 50, DOUBLE_EDGE
	db 0
TotodileEvosMoves:
	blue_evolve_level 18, CROCONAW
	db 0
; Learnset
	db 7, LEER
	db 8, WATER_GUN
	db 25, BUBBLEBEAM
	db 27, SLASH
	db 28, SCREECH
	db 30, CRUNCH
	db 38, SURF
	db 46, HYDRO_PUMP
	db 0
CroconawEvosMoves:
	blue_evolve_level 30, FERALIGATR
	db 0
; Learnset
	db 7, LEER
	db 9, WATER_GUN
	db 25, BUBBLEBEAM
	db 28, SLASH
	db 30, SCREECH
	db 31, CRUNCH
	db 38, SURF
	db 46, HYDRO_PUMP
	db 0
FeraligatrEvosMoves:
	db 0
; Learnset
	db 7, LEER
	db 9, WATER_GUN
	db 21, BITE
	db 25, BUBBLEBEAM
	db 31, CRUNCH
	db 32, SCREECH
	db 38, SURF
	db 46, HYDRO_PUMP
	db 0
MurkrowEvosMoves:
	blue_evolve_level 36, HONCHKROW
	db 0
; Learnset
	db 8, BITE
	db 9, PECK
	db 16, HAZE
	db 22, WING_ATTACK
	db 24, NIGHT_SHADE
	db 25, BITE
	db 28, SUCKER_PUNCH
	db 31, CRUNCH
	db 0
HonchkrowEvosMoves:
	db 0
; Learnset
	db 12, PECK
	db 25, BITE
	db 36, CRUNCH
	db 38, SUCKER_PUNCH
	db 40, DRILL_PECK
	db 44, NIGHT_SHADE
	db 48, SKY_ATTACK
	db 0
MisdreavusEvosMoves:
	blue_evolve_item MOON_STONE, 1, MISMAGIUS
	db 0
; Learnset
	db 6, GROWL
	db 9, LICK
	db 17, HYPNOSIS
	db 20, CONFUSION
	db 23, CONFUSE_RAY
	db 25, NIGHT_SHADE
	db 26, PSYBEAM
	db 39, SHADOW_BALL
	db 0
MismagiusEvosMoves:
	db 0
; Learnset
	db 6, GROWL
	db 9, LICK
	db 13, CONFUSION
	db 17, HYPNOSIS
	db 22, CONFUSE_RAY
	db 25, NIGHT_SHADE
	db 28, PSYBEAM
	db 40, SHADOW_BALL
	db 0
GuardiaEvosMoves:
	db 0
; Learnset
	db 7, LEER
	db 18, LOW_KICK
	db 24, FOCUS_ENERGY
	db 31, BONEMERANG
	db 38, EARTHQUAKE
	db 44, CROSS_CHOP
	db 50, ROCK_SLIDE
	db 0
MasquawkEvosMoves:
	db 0
; Learnset
	db 6, LEER
	db 13, FOCUS_ENERGY
	db 20, WING_ATTACK
	db 30, SLASH
	db 36, CROSS_CHOP
	db 43, SKY_ATTACK
	db 48, SWORDS_DANCE
	db 0
GorochuEvosMoves:
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 22, SWIFT
	db 27, THUNDERBOLT
	db 34, FIRE_PUNCH
	db 38, THUNDERPUNCH
	db 45, THUNDER
	db 50, LIGHT_SCREEN
	db 0
LarvitarEvosMoves:
	blue_evolve_level 25, PUPITAR
	db 0
; Learnset
	db 7, LEER
	db 12, ROCK_THROW
	db 20, BITE
	db 24, SCREECH
	db 0
PupitarEvosMoves:
	blue_evolve_level 45, TYRANITAR
	db 0
; Learnset
	db 17, ROCK_THROW
	db 20, BITE
	db 24, SCREECH
	db 30, ROCK_SLIDE
	db 36, CRUNCH
	db 42, EARTHQUAKE
	db 0
TyranitarEvosMoves:
	db 0
; Learnset
	db 17, ROCK_THROW
	db 24, SCREECH
	db 36, EARTHQUAKE
	db 45, ROCK_SLIDE
	db 49, CRUNCH
	db 55, THRASH
	db 60, HYPER_BEAM
	db 0
RaltsEvosMoves:
	blue_evolve_level 20, KIRLIA
	db 0
; Learnset
	db 6, GROWL
	db 13, DOUBLE_TEAM
	db 16, CONFUSION
	db 19, HYPNOSIS
	db 23, PSYBEAM
	db 35, PSYCHIC_M
	db 37, DREAM_EATER
	db 0
KirliaEvosMoves:
	blue_evolve_level 30, GARDEVOIR
	db 0
; Learnset
	db 6, GROWL
	db 16, HYPNOSIS
	db 17, TELEPORT
	db 20, CONFUSION
	db 23, PSYBEAM
	db 38, PSYCHIC_M
	db 41, DREAM_EATER
	db 0
GardevoirEvosMoves:
	db 0
; Learnset
	db 16, HYPNOSIS
	db 20, CONFUSION
	db 23, PSYBEAM
	db 30, LIGHT_SCREEN
	db 36, REFLECT
	db 40, PSYCHIC_M
	db 46, DREAM_EATER
	db 0
RioluEvosMoves:
	blue_evolve_level 28, LUCARIO
	db 0
; Learnset
	db 14, KARATE_CHOP
	db 17, LOW_KICK
	db 20, BITE
	db 24, METAL_CLAW
	db 27, SCREECH
	db 30, CRUNCH
	db 31, SUBMISSION
	db 36, SWORDS_DANCE
	db 44, HI_JUMP_KICK
	db 0
LucarioEvosMoves:
	db 0
; Learnset
	db 16, KARATE_CHOP
	db 17, METAL_CLAW
	db 18, MACH_PUNCH
	db 26, SCREECH
	db 30, CRUNCH
	db 31, SUBMISSION
	db 36, SWORDS_DANCE
	db 40, IRON_TAIL
	db 44, HI_JUMP_KICK
	db 0
BagonEvosMoves:
	blue_evolve_level 25, SHELGON
	db 0
; Learnset
	db 7, LEER
	db 18, DRAGON_RAGE
	db 22, HEADBUTT
	db 25, FOCUS_ENERGY
	db 0
ShelgonEvosMoves:
	blue_evolve_level 45, SALAMENCE
	db 0
; Learnset
	db 18, DRAGON_RAGE
	db 22, HEADBUTT
	db 30, SLAM
	db 36, CRUNCH
	db 42, OUTRAGE
	db 0
SalamenceEvosMoves:
	db 0
; Learnset
	db 18, DRAGON_RAGE
	db 25, FLY
	db 31, SLAM
	db 42, OUTRAGE
	db 45, WING_ATTACK
	db 49, CRUNCH
	db 55, SKY_ATTACK
	db 60, HYPER_BEAM
	db 0
DuskullEvosMoves:
	blue_evolve_level 28, DUSCLOPS
	db 0
; Learnset
	db 7, LEER
	db 9, LICK
	db 11, DISABLE
	db 19, CONFUSE_RAY
	db 22, NIGHT_SHADE
	db 39, SHADOW_BALL
	db 40, PSYCHIC_M
	db 0
DusclopsEvosMoves:
	blue_evolve_level 38, DUSKNOIR
	db 0
; Learnset
	db 9, LICK
	db 19, CONFUSE_RAY
	db 31, NIGHT_SHADE
	db 34, SHADOW_BALL
	db 40, FIRE_PUNCH
	db 44, ICE_PUNCH
	db 48, DREAM_EATER
	db 0
DusknoirEvosMoves:
db 0
; Learnset
	db 14, DISABLE
	db 19, CONFUSE_RAY
	db 28, NIGHT_SHADE
	db 34, FIRE_PUNCH
	db 42, ICE_PUNCH
	db 45, SHADOW_BALL
	db 50, HYPER_BEAM
	db 0
GolettEvosMoves:
	blue_evolve_level 32, GOLURK
	db 0
; Learnset
	db 13, DEFENSE_CURL
	db 23, NIGHT_SHADE
	db 31, DIG
	db 34, MEGA_PUNCH
	db 37, SHADOW_BALL
	db 42, EARTHQUAKE
	db 0
GolurkEvosMoves:
	db 0
; Learnset
	db 18, DEFENSE_CURL
	db 23, NIGHT_SHADE
	db 31, DIG
	db 37, SHADOW_BALL
	db 43, MEGA_PUNCH
	db 47, EARTHQUAKE
	db 51, HYPER_BEAM
	db 0
HeracrossEvosMoves:
	db 0
; Learnset
	db 7, LEER
	db 17, BUG_BITE
	db 18, PIN_MISSILE
	db 20, COUNTER
	db 23, HORN_ATTACK
	db 24, SLASH
	db 31, X_SCISSOR
	db 39, SWORDS_DANCE
	db 0
AnnihilapeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 14, LOW_KICK
	db 18, FOCUS_ENERGY
	db 21, COUNTER
	db 31, SUBMISSION
	db 32, SCREECH
	db 36, SHADOW_BALL
	db 39, THRASH
	db 44, HI_JUMP_KICK
	db 46, OUTRAGE
	db 0
BlisseyEvosMoves:
; Evolutions
	db 0
; Learnset
	db 5, TAIL_WHIP
	db 6, GROWL
	db 10, DOUBLESLAP
	db 17, SING
	db 25, HEADBUTT
	db 31, BODY_SLAM
	db 40, EGG_BOMB
	db 43, DOUBLE_EDGE
	db 0
CrobatEvosMoves:
; Evolutions
	db 0
; Learnset
	db 12, GUST
	db 18, SUPERSONIC
	db 25, WING_ATTACK
	db 36, CONFUSE_RAY
	db 40, SLUDGE_BOMB
	db 44, HAZE
	db 48, TOXIC
	db 0
ElectivireEvosMoves:
; Evolutions
	db 0
; Learnset
	db 17, THUNDER_WAVE
	db 25, SCREECH
	db 31, FIRE_PUNCH
	db 38, THUNDERPUNCH
	db 42, THUNDERBOLT
	db 48, THUNDER
	db 0
EspeonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 17, CONFUSION
	db 23, SWIFT
	db 26, PSYBEAM
	db 32, LIGHT_SCREEN
	db 38, PSYCHIC_M
	db 44, DREAM_EATER
	db 0
GlaceonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, GROWL
	db 9, POWDER_SNOW
	db 18, ICE_SHARD
	db 25, SWIFT
	db 28, BITE
	db 31, BARRIER
	db 34, ICE_BEAM
	db 46, BLIZZARD
	db 0
KingdraEvosMoves:
; Evolutions
	db 0
; Learnset
	db 25, BUBBLEBEAM
	db 31, AGILITY
	db 38, SURF
	db 42, SLAM
	db 46, HYDRO_PUMP
	db 50, DRAGON_RAGE
	db 0
LeafeonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, TAIL_WHIP
	db 9, GROWL
	db 12, VINE_WHIP
	db 15, LEECH_SEED
	db 25, BITE
	db 28, SWIFT
	db 31, MEGA_DRAIN
	db 38, SOLARBEAM
	db 0
LickilickyEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, TACKLE
	db 17, DISABLE
	db 27, STOMP
	db 31, SCREECH
	db 34, BODY_SLAM
	db 37, SLAM
	db 38, DOUBLE_EDGE
	db 0
MagmortarEvosMoves:
; Evolutions
	db 0
; Learnset
	db 21, CONFUSE_RAY
	db 22, FLAME_WHEEL
	db 31, THUNDERPUNCH
	db 38, FIRE_PUNCH
	db 42, FLAMETHROWER
	db 48, FIRE_BLAST
	db 0
MagnezoneEvosMoves:
; Evolutions
	db 0
; Learnset
	db 16, THUNDER_WAVE
	db 31, TRI_ATTACK
	db 35, SWIFT
	db 38, THUNDERBOLT
	db 44, THUNDER
	db 48, LIGHT_SCREEN
	db 0
PorygonZEvosMoves:
; Evolutions
	db 0
; Learnset
	db 14, THUNDER_WAVE
	db 23, PSYBEAM
	db 31, TRI_ATTACK
	db 38, AGILITY
	db 42, THUNDERBOLT
	db 46, DOUBLE_EDGE
	db 50, HYPER_BEAM
	db 0
Porygon2EvosMoves:
; Evolutions
	blue_evolve_level 38, PORYGON_Z
	db 0
; Learnset
	db 9, QUICK_ATTACK
	db 11, THUNDERSHOCK
	db 18, DEFENSE_CURL
	db 23, PSYBEAM
	db 25, HEADBUTT
	db 31, AGILITY
	db 34, BODY_SLAM
	db 44, DOUBLE_EDGE
	db 0
RhyperiorEvosMoves:
; Evolutions
	db 0
; Learnset
	db 18, ROCK_THROW
	db 29, ROCK_SLIDE
	db 31, DIG
	db 38, TAKE_DOWN
	db 42, EARTHQUAKE
	db 46, HYPER_BEAM
	db 0
ScizorEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, LEER
	db 9, PIN_MISSILE
	db 15, METAL_CLAW
	db 17, BUG_BITE
	db 21, FOCUS_ENERGY
	db 25, SLASH
	db 32, RAZOR_WIND
	db 34, X_SCISSOR
	db 0
ScolipedeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, PIN_MISSILE
	db 18, DEFENSE_CURL
	db 21, BUG_BITE
	db 23, SCREECH
	db 31, X_SCISSOR
	db 37, TAKE_DOWN
	db 46, DOUBLE_EDGE
	db 0
SneaselEvosMoves:
; Evolutions
	blue_evolve_level 34, WEAVILE
	db 0
; Learnset
	db 13, ICE_SHARD
	db 17, SUCKER_PUNCH
	db 20, SWIFT
	db 31, CRUNCH
	db 33, SLASH
	db 34, SCREECH
	db 37, AGILITY
	db 44, BLIZZARD
	db 0
SteelixEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, HARDEN
	db 17, METAL_CLAW
	db 25, STEEL_WING
	db 27, ROCK_SLIDE
	db 31, CRUNCH
	db 35, DIG
	db 40, IRON_TAIL
	db 0
TangrowthEvosMoves:
; Evolutions
	db 0
; Learnset
	db 13, STUN_SPORE
	db 21, MEGA_DRAIN
	db 34, SLAM
	db 36, GROWTH
	db 40, SOLARBEAM
	db 46, SLEEP_POWDER
	db 0
UmbreonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 6, GROWL
	db 17, SUCKER_PUNCH
	db 21, CONFUSE_RAY
	db 25, BITE
	db 28, SWIFT
	db 31, CRUNCH
	db 38, TAKE_DOWN
	db 0
VenipedeEvosMoves:
; Evolutions
	blue_evolve_level 22, WHIRLIPEDE
	db 0
; Learnset
	db 9, PIN_MISSILE
	db 18, DEFENSE_CURL
	db 21, BUG_BITE
	db 23, SCREECH
	db 31, X_SCISSOR
	db 35, TAKE_DOWN
	db 44, DOUBLE_EDGE
	db 0
WeavileEvosMoves:
; Evolutions
	db 0
; Learnset
	db 17, SUCKER_PUNCH
	db 20, ICE_SHARD
	db 25, SLASH
	db 31, CRUNCH
	db 38, AGILITY
	db 42, SCREECH
	db 46, BLIZZARD
	db 50, X_SCISSOR
	db 0
WhirlipedeEvosMoves:
; Evolutions
	blue_evolve_level 30, SCOLIPEDE
	db 0
; Learnset
	db 9, PIN_MISSILE
	db 18, DEFENSE_CURL
	db 21, BUG_BITE
	db 23, SCREECH
	db 31, X_SCISSOR
	db 36, TAKE_DOWN
	db 46, DOUBLE_EDGE
	db 0
MesmeriaEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, POWDER_SNOW
	db 15, CONFUSION
	db 17, ICE_SHARD
	db 19, SING
	db 23, SCREECH
	db 37, PSYCHIC_M
	db 38, ICE_BEAM
	db 46, BLIZZARD
	db 0
CroagunkEvosMoves:
; Evolutions
	blue_evolve_level 34, TOXICROAK
	db 0
; Learnset
	db 17, LOW_KICK
	db 19, SUCKER_PUNCH
	db 25, ACID
	db 35, TOXIC
	db 38, SLUDGE
	db 40, SLUDGE_BOMB
	db 0
ToxicroakEvosMoves:
; Evolutions
	db 0
; Learnset
	db 17, LOW_KICK
	db 19, SUCKER_PUNCH
	db 25, ACID
	db 37, SLUDGE
	db 41, SLUDGE_BOMB
	db 45, SUBMISSION
	db 49, CROSS_CHOP
	db 0
PhanpyEvosMoves:
	blue_evolve_level 25, DONPHAN
	db 0
; Learnset
	db 6, GROWL
	db 18, DEFENSE_CURL
	db 29, SLAM
	db 31, DIG
	db 35, TAKE_DOWN
	db 38, EARTHQUAKE
	db 0
DonphanEvosMoves:
	db 0
; Learnset
	db 6, GROWL
	db 18, DEFENSE_CURL
	db 25, HORN_ATTACK
	db 29, SLAM
	db 31, DIG
	db 40, EARTHQUAKE
	db 0
HoundourEvosMoves:
	blue_evolve_level 24, HOUNDOOM
	db 0
; Learnset
	db 7, LEER
	db 9, EMBER
	db 12, SMOG
	db 17, SUCKER_PUNCH
	db 22, BITE
	db 37, CRUNCH
	db 40, FLAMETHROWER
	db 0
HoundoomEvosMoves:
	db 0
; Learnset
	db 9, EMBER
	db 22, BITE
	db 24, FLAME_WHEEL
	db 32, SMOG
	db 37, CRUNCH
	db 42, FLAMETHROWER
	db 48, FIRE_BLAST
	db 0
LileepEvosMoves:
	blue_evolve_level 30, CRADILY
	db 0
; Learnset
	db 9, CONSTRICT
	db 17, CONFUSE_RAY
	db 20, ROCK_THROW
	db 23, ACID
	db 26, MEGA_DRAIN
	db 30, ROCK_SLIDE
	db 0
CradilyEvosMoves:
	db 0
; Learnset
	db 9, CONSTRICT
	db 17, ROCK_THROW
	db 22, CONFUSE_RAY
	db 28, MEGA_DRAIN
	db 30, ROCK_SLIDE
	db 36, ACID
	db 42, BARRIER
	db 48, SOLARBEAM
	db 0
AnorithEvosMoves:
	blue_evolve_level 30, ARMALDO
	db 0
; Learnset
	db 9, HARDEN
	db 15, METAL_CLAW
	db 17, ROCK_THROW
	db 18, BUG_BITE
	db 26, SLASH
	db 30, ROCK_SLIDE
	db 0
ArmaldoEvosMoves:
	db 0
; Learnset
	db 9, HARDEN
	db 17, ROCK_THROW
	db 18, BUG_BITE
	db 26, SLASH
	db 30, ROCK_SLIDE
	db 36, METAL_CLAW
	db 42, X_SCISSOR
	db 48, SWORDS_DANCE
	db 0
