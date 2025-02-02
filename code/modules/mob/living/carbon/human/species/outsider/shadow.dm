/datum/species/shadow
	name = "Shadow"
	name_plural = "shadows"

	icobase = 'icons/mob/human_races/r_shadow.dmi'
	deform = 'icons/mob/human_races/r_shadow.dmi'

	language = "Sol Common" //todo?
	unarmed_types = list(/datum/unarmed_attack/claws/strong, /datum/unarmed_attack/bite/sharp)
	darksight_range = 8
	darksight_tint = DARKTINT_GOOD
	has_organ = list()
	siemens_coefficient = 0

	blood_color = "#cccccc"
	flesh_color = "#aaaaaa"

	remains_type = /obj/effect/decal/cleanable/ash
	death_message = "dissolves into ash..."

	species_flags = SPECIES_FLAG_NO_SCAN | SPECIES_FLAG_NO_SLIP | SPECIES_FLAG_NO_POISON | SPECIES_FLAG_NO_EMBED | SPECIES_FLAG_NO_ANTAG_TARGET
	spawn_flags = SPECIES_IS_RESTRICTED

	genders = list(NEUTER)

/datum/species/shadow/handle_death(mob/living/carbon/human/H)
	H.dust()

/datum/species/shadow/handle_environment_special(mob/living/carbon/human/H)
	if(H.InStasis() || H.is_ic_dead() || H.isSynthetic())
		return
	var/light_amount = 0
	if(isturf(H.loc))
		var/turf/T = H.loc
		light_amount = T.get_lumcount() * 10
	if(light_amount > 2) //if there's enough light, start dying
		H.take_overall_damage(1,1)
	else //heal in the dark
		H.heal_overall_damage(1,1)

/datum/species/shadow/is_eligible_for_antag_spawn(antag_id)
	return FALSE // No need to be more antagous than we already are
