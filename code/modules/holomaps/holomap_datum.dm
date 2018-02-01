


/datum/holomap_interface
	var/mob/activator = null
	var/obj/item/holder = null
	var/list/holomap_images = list()

/datum/holomap_interface/New(obj/item/holder)
	src.holder = holder
	..()

/datum/holomap_interface/Destroy()
	QDEL_NULL(holder)
	return ..()

/datum/holomap_interface/process()
	update_holomap()

/datum/holomap_interface/proc/draw_special()
	return

/datum/holomap_interface/proc/draw_special_icon(var/filter, var/obj/holomap_holder)
	var/image/mob_indicator = image('icons/holomap_markers.dmi', "error")
	mob_indicator.plane = ABOVE_HUD_PLANE
	mob_indicator.layer = ABOVE_HUD_LAYER
	mob_indicator.loc = activator.hud_used.holomap_obj
	var/turf/mob_location = get_turf(holomap_holder)
	if(!mob_location.z == 1 && !isturf(holomap_holder.loc))
		return
	if(ishuman(holomap_holder.loc))
		var/mob/living/carbon/human/H = holomap_holder.loc
		if(H.head == holomap_holder)
			if(H.stat == DEAD)
				mob_indicator.icon_state = (filter+"_3")
			else if(H.stat == UNCONSCIOUS || H.restrained())
				mob_indicator.icon_state = (filter+"_2")
			else
				mob_indicator.icon_state = (filter+"_1")
	if(isrobot(holomap_holder.loc))
		var/mob/living/silicon/robot/M = holomap_holder.loc
		if(M.health > 0)
			mob_indicator.icon_state = (filter+"_1")
		if(M.health <= 0)
			mob_indicator.icon_state = (filter+"_0")
	if(istype(holomap_holder.loc, /obj/mecha))
		var/obj/mecha/M = holomap_holder.loc
		if(M.health > 0)
			mob_indicator.icon_state = (filter+"_1")
		if(M.health <= 0)
			mob_indicator.icon_state = (filter+"_0")
	if(holomap_holder == holder)
		mob_indicator.icon_state = "you"
	if(mob_indicator.icon_state == "error")
		mob_indicator.pixel_x = (rand(6,9)) * PIXEL_MULTIPLIER
		mob_indicator.pixel_y = (rand(6,9)) * PIXEL_MULTIPLIER
	mob_indicator.pixel_x = (mob_location.x - 6) * PIXEL_MULTIPLIER
	mob_indicator.pixel_y = (mob_location.y - 6) * PIXEL_MULTIPLIER
	holomap_images += mob_indicator

/datum/holomap_interface/proc/activate(mob/user, var/color_filter)
	if(activator)
		return
	activator = user
	if(!holomap_updater)
		holomap_updater = new
	holomap_updater.users += user
	activator.hud_used.holomap_obj.overlays += holomap_updater.holomap
	activator.hud_used.holomap_obj.color = color_filter
	START_PROCESSING(SSobj, src)

/datum/holomap_interface/proc/deactivate_holomap()
	STOP_PROCESSING(SSobj, src)
	if(!activator)
		return
	activator.hud_used.holomap_obj.overlays -= holomap_updater.holomap
	holomap_updater.users -= activator
	if(activator.client)
		activator.client.images -= holomap_images
	for(var/i in holomap_images)
		qdel(i)
	holomap_images.Cut()
	activator = null

/datum/holomap_interface/proc/update_holomap()
	if(!activator || !activator.client)
		deactivate_holomap()
		return

	if(length(holomap_images))
		activator.client.images -= holomap_images
		for(var/i in holomap_images)
			qdel(i)
		holomap_images.Cut()

	draw_special()

	activator.client.images |= holomap_images

/datum/holomap_interface/deathsquad/draw_special()
	for(var/obj/item/clothing/head/helmet/space/deathsquad/D in deathsquad_helmets)
		draw_special_icon("deathsquad", D)

/datum/holomap_interface/nuclear/draw_special()
	for(var/obj/item/clothing/head/helmet/space/rig/syndi/S in nuclear_holo)
		draw_special_icon("nuclear", S)
	for(var/mob/living/silicon/robot/syndicate/R in nuclear_holo)
		draw_special_icon("syborg", R)
	for(var/obj/mecha/combat/gygax/dark/D in mechas_list)
		draw_special_icon("dgyx", D)
	for(var/obj/mecha/combat/marauder/mauler/M in mechas_list)
		draw_special_icon("mau", M)

/datum/holomap_interface/vox/draw_special()
	for(var/obj/item/clothing/head/helmet/space/vox/pressure/P in vox_helmets)
		draw_special_icon("voxp", P)
	for(var/obj/item/clothing/head/helmet/space/vox/carapace/C in vox_helmets)
		draw_special_icon("voxc", C)
	for(var/obj/item/clothing/head/helmet/space/vox/stealth/S in vox_helmets)
		draw_special_icon("voxs", S)
	for(var/obj/item/clothing/head/helmet/space/vox/medic/M in vox_helmets)
		draw_special_icon("voxm", M)

/datum/holomap_interface/ert/draw_special()
	for(var/obj/item/clothing/head/helmet/space/rig/ert/commander/C in ert_helmets)
		draw_special_icon("ertc", C)
	for(var/obj/item/clothing/head/helmet/space/rig/ert/security/S in ert_helmets)
		draw_special_icon("erts", S)
	for(var/obj/item/clothing/head/helmet/space/rig/ert/engineer/E in ert_helmets)
		draw_special_icon("erte", E)
	for(var/obj/item/clothing/head/helmet/space/rig/ert/medical/M in ert_helmets)
		draw_special_icon("ertm", M)
