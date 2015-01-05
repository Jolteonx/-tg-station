
//**************************************************************
//
// Customizable Food
// ---------------------------
// Did the best I could. Still tons of duplication.
// Part of it is due to shitty reagent system.
// Other part due to limitations of attackby().
//
//**************************************************************

// Various Snacks //////////////////////////////////////////////

/obj/item/weapon/reagent_containers/food/snacks/breadslice/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/A = new/obj/item/weapon/reagent_containers/food/snacks/customizable/sandwich(get_turf(src),I)
		A.attackby(I, user)
		qdel(src)
	else . = ..()
	return

/obj/item/weapon/reagent_containers/food/snacks/bun/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/A = new/obj/item/weapon/reagent_containers/food/snacks/customizable/burger(get_turf(src),I)
		A.attackby(I, user)
		qdel(src)
	else . = ..()
	return

/obj/item/weapon/reagent_containers/food/snacks/sliceable/flatdough/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/A = new/obj/item/weapon/reagent_containers/food/snacks/customizable/pizza(get_turf(src),I)
		A.attackby(I, user)
		qdel(src)
	else . = ..()
	return

/obj/item/weapon/reagent_containers/food/snacks/boiledspagetti/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/A = new/obj/item/weapon/reagent_containers/food/snacks/customizable/pasta(get_turf(src),I)
		A.attackby(I, user)
		qdel(src)
	else . = ..()
	return

// Custom Meals ////////////////////////////////////////////////

/obj/item/trash/bowl
	name = "bowl"
	desc = "An empty bowl. Put some food in it to start making a soup."
	icon = 'icons/obj/food.dmi'
	icon_state = "soup"

/obj/item/trash/bowl/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/weapon/shard) || istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		new/obj/item/weapon/reagent_containers/food/snacks/customizable/soup(get_turf(src),I)
		qdel(src)
	else . = ..()
	return

// Customizable Foods //////////////////////////////////////////

/obj/item/weapon/reagent_containers/food/snacks/customizable
	trash = /obj/item/trash/plate
	bitesize = 2

	var/ingMax = 600
	var/list/ingredients = list()
	var/stackIngredients = 0
	var/fullyCustom = 0
	var/addTop = 0

/obj/item/weapon/reagent_containers/food/snacks/customizable/New(loc,ingredient)
	. = ..()
	src.reagents.add_reagent("nutriment",8)
	src.update()
	return

/obj/item/weapon/reagent_containers/food/snacks/customizable/attackby(obj/item/I,mob/user)
	if((src.contents.len >= src.ingMax) || (src.contents.len >= 30))
		user << "<span class='warning'>How about no.</span>"
	else if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/food/snacks/S = I
		if(user)
			user.drop_item()
		S.loc = src
		src.ingredients += S
		S.reagents.trans_to(src,S.reagents.total_volume)
		src.update()
		if(user)
			user << "<span class='notice'>You add the [I.name] to the [src.name].</span>"
	else . = ..()
	return

/obj/item/weapon/reagent_containers/food/snacks/customizable/proc/update()
	var/fullname = "" //We need to build this from the contents of the var.
	var/i = 0

	overlays.Cut()

	for(var/obj/item/weapon/reagent_containers/food/snacks/O in ingredients)

		i++
		if(i == 1)
			fullname += "[O.name]"
		else if(i == ingredients.len)
			fullname += " and [O.name]"
		else
			fullname += ", [O.name]"

		if(!fullyCustom)
			var/image/I = new(src.icon, "[src.icon_state]_filling")
			if(istype(O, /obj/item/weapon/reagent_containers/food/snacks))
				var/obj/item/weapon/reagent_containers/food/snacks/food = O
				if(!food.filling_color == "#FFFFFF")
					I.color = food.filling_color
				else
					I.color = pick("#FF0000","#0000FF","#008000","#FFFF00")
			if(stackIngredients)
				I.pixel_x = pick(list(-1,0,1))
				I.pixel_y = (i*2)+1
			overlays += I
		else
			var/image/F = new(O.icon, O.icon_state)
			F.pixel_x = pick(list(-1,0,1))
			F.pixel_y = pick(list(-1,0,1))
			overlays += F
			overlays += O.overlays

	if(addTop)
		var/image/T = new(src.icon, "[src.icon_state]_top")
		T.pixel_x = pick(list(-1,0,1))
		T.pixel_y = (ingredients.len * 2)+1
		overlays += T

	name = lowertext("[fullname] [initial(src.name)]")
	if(length(name) > 80) name = "[pick(list("absurd","colossal","enormous","ridiculous","massive","oversized","cardiac-arresting","pipe-clogging","edible but sickening","sickening","gargantuan","mega","belly-burster","chest-burster"))] [initial(src.name)]"
	w_class = n_ceil(Clamp((ingredients.len/2),1,3))

/obj/item/weapon/reagent_containers/food/snacks/customizable/Destroy()
	for(. in src.ingredients) qdel(.)
	return ..()

// Sandwiches //////////////////////////////////////////////////

/obj/item/weapon/reagent_containers/food/snacks/customizable/sandwich
	name = "sandwich"
	desc = "A timeless classic."
	icon_state = "breadslice"
	stackIngredients = 1
	addTop = 1

// Misc Subtypes ///////////////////////////////////////////////

/obj/item/weapon/reagent_containers/food/snacks/customizable/pizza
	name = "personal pizza"
	desc = "A personalized pan pizza meant for only one person."
	icon_state = "personal_pizza"

/obj/item/weapon/reagent_containers/food/snacks/customizable/pasta
	name = "spagetti"
	desc = "Noodles. With stuff. Delicious."
	icon_state = "pasta_bot"

/obj/item/weapon/reagent_containers/food/snacks/customizable/cook/bread
	name = "bread"
	icon_state = "breadcustom"

/obj/item/weapon/reagent_containers/food/snacks/customizable/cook/pie
	name = "pie"
	icon_state = "piecustom"

/obj/item/weapon/reagent_containers/food/snacks/customizable/cook/cake
	name = "cake"
	desc = "A popular band."
	icon_state = "cakecustom"

/obj/item/weapon/reagent_containers/food/snacks/customizable/cook/jelly
	name = "jelly"
	desc = "Totally jelly."
	icon_state = "jellycustom"

/obj/item/weapon/reagent_containers/food/snacks/customizable/cook/donkpocket
	name = "donk pocket"
	desc = "You wanna put a bangin-Oh nevermind."
	icon_state = "donkcustom"

/obj/item/weapon/reagent_containers/food/snacks/customizable/cook/kebab
	name = "kebab"
	icon_state = "kababcustom"

/obj/item/weapon/reagent_containers/food/snacks/customizable/cook/salad
	name = "salad"
	desc = "Very tasty."
	icon_state = "saladcustom"

/obj/item/weapon/reagent_containers/food/snacks/customizable/cook/waffles
	name = "waffles"
	desc = "Made with love."
	icon_state = "wafflecustom"

/obj/item/weapon/reagent_containers/food/snacks/customizable/fullycustom
	name = "on a plate"
	desc = "A unique dish."
	icon_state = "fullycustom"

/obj/item/weapon/reagent_containers/food/snacks/customizable/soup
	name = "soup"
	desc = "A bowl with liquid and... stuff in it."
	icon_state = "soup"
	trash = /obj/item/trash/bowl

/obj/item/weapon/reagent_containers/food/snacks/customizable/burger
	name = "burger bun"
	desc = "A bun for a burger. Delicious."
	icon_state = "burger"
	stackIngredients = 1
	addTop = 1



///////////////////////////////////////////
// new old food stuff from bs12
///////////////////////////////////////////

// Flour + egg = dough
/obj/item/weapon/reagent_containers/food/snacks/flour/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/reagent_containers/food/snacks/egg))
		new /obj/item/weapon/reagent_containers/food/snacks/dough(src)
		user << "You make some dough."
		del(W)
		del(src)

// Egg + flour = dough
/obj/item/weapon/reagent_containers/food/snacks/egg/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/reagent_containers/food/snacks/flour))
		new /obj/item/weapon/reagent_containers/food/snacks/dough(src)
		user << "You make some dough."
		del(W)
		del(src)

/obj/item/weapon/reagent_containers/food/snacks/dough
	name = "dough"
	desc = "A piece of dough."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "dough"
	bitesize = 2
	New()
		..()
		reagents.add_reagent("nutriment", 3)

// Dough + rolling pin = flat dough
/obj/item/weapon/reagent_containers/food/snacks/dough/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/kitchen/rollingpin))
		if(isturf(loc))
			new /obj/item/weapon/reagent_containers/food/snacks/sliceable/flatdough(loc)
			user << "<span class='notice'>You flatten [src].</span>"
			qdel(src)
		else
			user << "<span class='notice'>You need to put [src] on a surface to roll it out!</span>"
	else
		..()

// slicable into 3xdoughslices
/obj/item/weapon/reagent_containers/food/snacks/sliceable/flatdough
	name = "flat dough"
	desc = "A flattened dough."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "flat dough"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/doughslice
	slices_num = 3
	New()
		..()
		reagents.add_reagent("nutriment", 3)

/obj/item/weapon/reagent_containers/food/snacks/doughslice
	name = "dough slice"
	desc = "A building block of an impressive dish."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "doughslice"
	bitesize = 2
	New()
		..()
		reagents.add_reagent("nutriment", 1)

/obj/item/weapon/reagent_containers/food/snacks/bun
	name = "bun"
	desc = "A base for any self-respecting burger."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "bun"
	bitesize = 2
	New()
		..()
		reagents.add_reagent("nutriment", 4)
