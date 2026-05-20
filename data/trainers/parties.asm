TrainerDataPointers:
	table_width 2
	dw YoungsterData
	dw BugCatcherData
	dw LassData
	dw SailorData
	dw JrTrainerMData
	dw JrTrainerFData
	dw PokemaniacData
	dw SuperNerdData
	dw HikerData
	dw BikerData
	dw BurglarData
	dw EngineerData
	dw ArianaData
	dw FisherData
	dw SwimmerData
	dw SwimmerFData
	dw CueBallData
	dw GamblerData
	dw BeautyData
	dw PsychicData
	dw RockerData
	dw JugglerData
	dw TamerData
	dw BirdKeeperData
	dw BlackbeltData
	dw Rival1Data
	dw ProfOakData
	dw ChiefData
	dw ScientistData
	dw GiovanniData
	dw RocketData
	dw CooltrainerMData
	dw CooltrainerFData
	dw BrunoKarenData
	dw BrockData
	dw MistyData
	dw LtSurgeData
	dw ErikaData
	dw KogaData
	dw BlaineData
	dw SabrinaData
	dw GentlemanData
	dw Rival2Data
	dw Rival3Data
	dw LoreleiData
	dw ChannelerData
	dw AgathaData
	dw LanceData
	dw BlueCloakData
	dw GreenData
	dw GreenRocketData
	dw NinjaData
	dw JanineData
	dw PetrelData
	dw ProtonData
	dw ArcherData
	dw SoldierData
	dw RocketData ; ROCKET_F: same parties as TEAM ROCKET
	assert_table_length NUM_TRAINERS

; if first byte != $FF, then
	; first byte is level (of all pokemon on this team)
	; all the next bytes are pokemon species
	; null-terminated
; if first byte == $FF, then
	; first byte is $FF (obviously)
	; every next two bytes are a level and species
	; null-terminated


IF DEF(_RED)
INCLUDE "data/trainers/parties_red.asm"
ELSE
INCLUDE "data/trainers/parties_blue.asm"
ENDC

