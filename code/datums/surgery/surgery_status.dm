/datum/surgery_status
	/// List of zones where surgery steps are currently performed.
	var/list/ongoing_steps = list()
	/**
	 * Associative list of string -> type, where string is zone name and
	 * type is a reference to an operated organ.
	 *
	 * Exists 'cause of integrated crcuits.
	 */
	var/list/operated_organs = list()

	var/list/surgery_stages = list()
	/*
	 *	List of Affected Organs associated with lists of (current surgery -> surgery stage), 
	 *  where Affected Organs is obj/item/organ/, Surgery is /datum/surgery_step/ and
	 *	Stage is a number of current stage done.
	 */

/datum/surgery_status/proc/start_surgery(obj/item/organ/target_organ, target_zone)
	LAZYADD(ongoing_steps, target_zone)
	operated_organs[target_zone] = target_organ

/datum/surgery_status/proc/stop_surgery(target_zone)
	LAZYREMOVE(ongoing_steps, target_zone)
	operated_organs[target_zone] = null

/datum/surgery_status/proc/set_stage(obj/item/organ/target_organ, datum/surgery_step/surgery, stage)
	if(stage)
		LAZYDISTINCTADD(surgery_stages, target_organ)
		LAZYSET(surgery_stages[target_organ], surgery, stage)
	else
		LAZYREMOVEASSOC(surgery_stages, target_organ, surgery)

/datum/surgery_status/proc/get_stage(obj/item/organ/target_organ, datum/surgery_step/surgery)
	return LAZYACCESS(surgery_stages[target_organ], surgery)
