/obj/machinery/station_holomap
	name = "Station holomap"
	desc = "A virtual map of the surrounding station."
	icon = 'icons/obj/machines/station_holomap.dmi'
	anchored = 1
	density = 0
	use_power = 1
	idle_power_usage = 10
	active_power_usage = 20

	var/list/watching_mobs = list()
	var/on = FALSE
	var/datum/holomap_interface/holo = null

/obj/machinery/station_holomap/atom_init()
	holo = new (src)
	. = ..()

/obj/machinery/station_holomap/proc/toggle_holomap(mob/user)
	if(on)
		holo.deactivate_holomap()
	else
		holo.activate(user)