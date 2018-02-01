#define HOLOMAP_WALKABLE_TILE "#ffffff"
#define HOLOMAP_CONCRETE_TILE "#999999"

var/datum/holomap_updater/holomap_updater

/datum/holomap_updater
	var/image/holomap = null
	var/last_update = 0
	var/last_update_without_users = 0
	var/list/users = list()

/datum/holomap_updater/New()
	holomap_updater = src
	activate()
	..()

/datum/holomap_updater/Destroy()
	holomap_updater = null
	return ..()

/datum/holomap_updater/proc/activate()
	holomap = image(generateHoloMap())
	holomap.layer = HUD_LAYER
	holomap.plane = HUD_PLANE
	START_PROCESSING(SSobj, src)

/datum/holomap_updater/process()
	if(last_update < world.time)
		for(var/mob/M in users)
			M.hud_used.holomap_obj.overlays -= holomap
		qdel(holomap)
		holomap = image(generateHoloMap())
		holomap.layer = HUD_LAYER
		holomap.plane = HUD_PLANE
		for(var/mob/M in users)
			M.hud_used.holomap_obj.overlays += holomap

/datum/holomap_updater/proc/generateHoloMap()
	var/icon/holomap = icon('icons/canvas.dmi', "blank")
	for(var/i = 1 to ((2 * world.view + 1) * 32))
		for(var/r = 1 to ((2 * world.view + 1) * 32))
			var/turf/tile = locate(i, r, 1)
			if(tile)
				if (istype(tile, /turf/simulated/floor) || istype(tile, /turf/unsimulated/floor) || istype(tile, /turf/simulated/shuttle/floor))
					holomap.DrawBox(HOLOMAP_WALKABLE_TILE, i, r)
				if(istype(tile, /turf/simulated/wall) || istype(tile, /turf/unsimulated/wall) || locate(/obj/structure/grille) in tile || locate(/obj/structure/window) in tile)
					holomap.DrawBox(HOLOMAP_CONCRETE_TILE, i, r)
	return holomap

#undef HOLOMAP_WALKABLE_TILE
#undef HOLOMAP_CONCRETE_TILE