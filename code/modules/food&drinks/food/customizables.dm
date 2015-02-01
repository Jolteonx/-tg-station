
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
/*
/obj/item/weapon/reagent_containers/food/snacks/breadslice/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/A = new/obj/item/weapon/reagent_containers/food/snacks/customizable/sandwich(get_turf(src))
		create_custom_food(A, I, user)
	else . = ..()
	return

/obj/item/weapon/reagent_containers/food/snacks/bun/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/A = new/obj/item/weapon/reagent_containers/food/snacks/customizable/burger(get_turf(src))
		create_custom_food(S.custom_food_type, I, user)
	else . = ..()
	return

/obj/item/weapon/reagent_containers/food/snacks/sliceable/flatdough/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/A = new/obj/item/weapon/reagent_containers/food/snacks/customizable/pizza(get_turf(src))
		create_custom_food(A, I, user)
	else . = ..()
	return

/obj/item/weapon/reagent_containers/food/snacks/boiledspagetti/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/A = new/obj/item/weapon/reagent_containers/food/snacks/customizable/pasta(get_turf(src))
		create_custom_food(A, I, user)
	else . = ..()
	return

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/A = new/obj/item/weapon/reagent_containers/food/snacks/customizable/bread(get_turf(src))
		create_custom_food(A, I, user)
	else . = ..()
	return

/obj/item/weapon/reagent_containers/food/snacks/plainpie/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/A = new/obj/item/weapon/reagent_containers/food/snacks/customizable/pie(get_turf(src))
		create_custom_food(A, I, user)
	else . = ..()
	return

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/plaincake/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/A = new/obj/item/weapon/reagent_containers/food/snacks/customizable/cake(get_turf(src))
		create_custom_food(A, I, user)
	else . = ..()
	return

/obj/item/weapon/reagent_containers/food/snacks/wishsoup/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/A = new/obj/item/weapon/reagent_containers/food/snacks/customizable/soup(get_turf(src))
		create_custom_food(A, I, user)
	else . = ..()
	return
*/


/obj/item/weapon/reagent_containers/food/snacks/customizable/proc/create_custom_food(obj/item/weapon/reagent_containers/BASE, obj/item/I, mob/user)
	BASE.reagents.trans_to(src,reagents.total_volume)
	src.attackby(I, user)
	qdel(BASE)

/obj/item/weapon/reagent_containers/food/snacks/customizable/sandwich/create_custom_food(obj/item/weapon/reagent_containers/BASE, obj/item/I, mob/user)
	icon_state = BASE.icon_state
	..()

// Custom Meals ////////////////////////////////////////////////

/obj/item/weapon/reagent_containers/bowl
	name = "snack bowl"
	icon_state	= "snack_bowl"
	name = "bowl"
	desc = "An empty bowl. Put some food in it to start making a soup."
	icon = 'icons/obj/food.dmi'
	icon_state = "soup"

/obj/item/weapon/reagent_containers/bowl/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/weapon/reagent_containers/food/snacks/grown))
		var/obj/item/weapon/reagent_containers/food/snacks/grown/G = I
		var/obj/item/weapon/reagent_containers/food/snacks/customizable/A = new/obj/item/weapon/reagent_containers/food/snacks/customizable/salad(get_turf(src))
		A.create_custom_food(src, G, user)
	else . = ..()
	return

// Customizable Foods //////////////////////////////////////////

/obj/item/weapon/reagent_containers/food/snacks/customizable
	trash = /obj/item/trash/plate
	bitesize = 2

	var/ingMax = 12
	var/list/ingredients = list()
	var/stackIngredients = 0
	var/fullyCustom = 0
	var/addTop = 0

/obj/item/weapon/reagent_containers/food/snacks/customizable/attackby(obj/item/I,mob/user)
	if((src.contents.len >= src.ingMax) || (src.contents.len >= 20))
		user << "<span class='warning'>You can't add more ingredients to [src].</span>"
	else if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/food/snacks/S = I
		if(user)
			user.drop_item()
		src.ingredients += S
		S.reagents.trans_to(src,S.reagents.total_volume)
		src.update(S)
		if(user)
			user << "<span class='notice'>You add the [I.name] to the [src.name].</span>"
		qdel(I)
	else . = ..()
	return

/obj/item/weapon/reagent_containers/food/snacks/customizable/proc/update(obj/item/weapon/reagent_containers/food/snacks/S)
	var/i = 0

	if(addTop)
		overlays.Cut()
		var/image/T = new(src.icon, "[src.icon_state]")
		T.pixel_x = pick(list(-1,0,1))
		T.pixel_y = (ingredients.len * 2)+1
		overlays += T


		var/image/I = new(src.icon, "[src.icon_state]_filling")

		if(!S.filling_color == "#FFFFFF")
			I.color = S.filling_color
		else
			I.color = pick("#FF0000","#0000FF","#008000","#FFFF00")
		if(stackIngredients)
			I.pixel_x = pick(list(-1,0,1))
			I.pixel_y = (i*2)+1
		else
			I.pixel_x = pick(list(-2,0,2))
			I.pixel_y = pick(list(-2,0,1))
		overlays += I

	var/ingredients_list =""
	for(var/obj/item/weapon/reagent_containers/food/snacks/ING in ingredients)
		ingredients_list += "[ING.name], "
	desc += "It contains [ingredients_list]."
	w_class = n_ceil(Clamp((ingredients.len/2),1,3))
	//HERE WE MUST ADD THE CHECK FOR EXISTING
	//RECIPES TO TRANSFORM THE FOOD AND ITS SPRITE IF NECESSARY.
	//

/*
/obj/item/weapon/reagent_containers/food/snacks/customizable/Destroy()
	for(. in src.ingredients) qdel(.)
	return ..()
	*/

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

/obj/item/weapon/reagent_containers/food/snacks/customizable/bread
	name = "bread"
	icon_state = "breadcustom"

/obj/item/weapon/reagent_containers/food/snacks/customizable/pie
	name = "pie"
	icon_state = "piecustom"

/obj/item/weapon/reagent_containers/food/snacks/customizable/cake
	name = "cake"
	desc = "A popular band."
	icon_state = "cakecustom"

/obj/item/weapon/reagent_containers/food/snacks/customizable/salad
	name = "salad"
	desc = "Very tasty."
	icon_state = "saladcustom"
	trash = /obj/item/weapon/reagent_containers/bowl

/obj/item/weapon/reagent_containers/food/snacks/customizable/soup
	name = "soup"
	desc = "A bowl with liquid and... stuff in it."
	icon_state = "soup"
	trash = /obj/item/weapon/reagent_containers/bowl

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
	cooked_type = /obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/plain
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/dough/New()
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
	custom_food_type = /obj/item/weapon/reagent_containers/food/snacks/customizable/pizza

/obj/item/weapon/reagent_containers/food/snacks/sliceable/flatdough/New()
	..()
	reagents.add_reagent("nutriment", 3)


/obj/item/weapon/reagent_containers/food/snacks/doughslice
	name = "dough slice"
	desc = "A building block of an impressive dish."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "doughslice"
	cooked_type = /obj/item/weapon/reagent_containers/food/snacks/bun
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/doughslice/New()
	..()
	reagents.add_reagent("nutriment", 1)


/obj/item/weapon/reagent_containers/food/snacks/bun
	name = "bun"
	desc = "A base for any self-respecting burger."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "bun"
	bitesize = 2
	custom_food_type = /obj/item/weapon/reagent_containers/food/snacks/customizable/burger

/obj/item/weapon/reagent_containers/food/snacks/bun/New()
	..()
	reagents.add_reagent("nutriment", 4)


/obj/item/weapon/reagent_containers/food/snacks/rawcutlet
	name = "raw cutlet"
	desc = "A raw meat cutlet."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "bun"
	cooked_type = /obj/item/weapon/reagent_containers/food/snacks/cutlet
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/rawcutlet/New()
	..()
	reagents.add_reagent("nutriment", 4)


/obj/item/weapon/reagent_containers/food/snacks/cutlet
	name = "cutlet"
	desc = "A cooked meat cutlet."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "bun"
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/cutlet/New()
	..()
	reagents.add_reagent("nutriment", 4)