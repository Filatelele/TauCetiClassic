/obj/item/weapon/reagent_containers/hypospray/combat
	name = "combat stimulant injector"
	desc = "A modified air-needle autoinjector, used by operatives trained in medical practices to quickly heal injuries in the field."
	amount_per_transfer_from_this = 10
	icon = 'icons/obj/items.dmi'
	icon_state = "combat_hypo"
	volume = 60

/obj/item/weapon/reagent_containers/hypospray/combat/atom_init()
	. = ..()
	if (!possible_transfer_amounts)
		src.verbs -= /obj/item/weapon/reagent_containers/verb/set_APTFT
	reagents.add_reagent("synaptizine", 5)
	reagents.add_reagent("hyperzine", 15)
	reagents.add_reagent("oxycodone", 15)
	reagents.add_reagent("anti_toxin", 25)

//FIRST-AID KIT
/obj/item/weapon/storage/firstaid/tactical
	name = "first-aid kit"
	icon_state = "bezerk"
	desc = "I hope you've got insurance."
	max_w_class = 3

/obj/item/weapon/storage/firstaid/tactical/atom_init()
	. = ..()
	if (empty)
		return
	new /obj/item/weapon/reagent_containers/hypospray/combat(src)
	new /obj/item/weapon/storage/pill_bottle/bicaridine(src)
	new /obj/item/weapon/storage/pill_bottle/dermaline(src)
	new /obj/item/weapon/storage/pill_bottle/dylovene(src)
	new /obj/item/weapon/storage/pill_bottle/tramadol(src)
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector(src)
	new /obj/item/device/healthanalyzer(src)

/obj/item/weapon/storage/firstaid/small_firstaid_kit/combat
	name = "Combat first-aid small kit"
	icon_state = "first_aid_kit_com"
	desc = "A small kit of auto injectors with drugs placed in his pocket. It`s combat version"
	max_w_class = 2
	w_class = 2

/obj/item/weapon/storage/firstaid/small_firstaid_kit/combat/atom_init()
	. = ..()

	if (empty)
		return

	new /obj/item/weapon/reagent_containers/hypospray/autoinjector/combat(src)
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector/bicaridine(src)
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector/dermaline(src)
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector/antitox(src)
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector/tramadol(src)
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector(src)
	new /obj/item/device/healthanalyzer(src)

/obj/item/weapon/storage/firstaid/small_firstaid_kit/space
	name = "Space first-aid small kit"
	icon_state = "first_aid_kit_sp"
	desc = "A small kit of auto injectors with drugs placed in his pocket. It`s space version"
	max_w_class = 2
	w_class = 2

/obj/item/weapon/storage/firstaid/small_firstaid_kit/space/atom_init()
	. = ..()

	if (empty)
		return

	new /obj/item/weapon/patcher(src)
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector/bicaridine(src)
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector/dermaline(src)
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector/antitox(src)
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector/tramadol(src)
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector(src)
	new /obj/item/device/healthanalyzer(src)

/obj/item/weapon/storage/firstaid/small_firstaid_kit/civilian
	name = "Civilan first-aid small kit"
	icon_state = "first_aid_kit_civilan"
	desc = "A small cheap kit with medical items."
	max_w_class = 2
	w_class = 2

/obj/item/weapon/storage/firstaid/small_firstaid_kit/civilian/atom_init()
	. = ..()

	if (empty)
		return

	new /obj/item/stack/medical/ointment(src)
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/weapon/reagent_containers/pill/dylovene(src)
	new /obj/item/weapon/reagent_containers/pill/dexalin(src)
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector(src)
	new /obj/item/device/healthanalyzer(src)
