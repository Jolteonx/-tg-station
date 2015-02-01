
#define INGREDIENTS_FILL 1
#define INGREDIENTS_SCATTER 2
#define INGREDIENTS_STACK 3

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
		if(I.w_class > 2)
			user << "<span class='warning'>The ingredient is too big for [src].</span>"
		else
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
	var/Ingredientsplacement = INGREDIENTS_FILL

/obj/item/weapon/reagent_containers/food/snacks/customizable/examine(mob/user)
	..()
	var/ingredients_listed = ""
	for(var/obj/item/weapon/reagent_containers/food/snacks/ING in ingredients)
		ingredients_listed += "[ING.name], "
	user << "It contains [ingredients_listed]among other things."

/obj/item/weapon/reagent_containers/food/snacks/customizable/attackby(obj/item/I,mob/user)
	if((src.contents.len >= src.ingMax) || (src.contents.len >= 20))
		user << "<span class='warning'>You can't add more ingredients to [src].</span>"
	else if(istype(I,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/food/snacks/S = I
		if(I.w_class > 2)
			user << "<span class='warning'>The ingredient is too big for [src].</span>"
		else
			user.drop_item()
			src.ingredients += S
			S.loc = src
			S.reagents.trans_to(src,S.reagents.total_volume)
			AddIngredient(S)
			user << "<span class='notice'>You add the [I.name] to the [src.name].</span>"
	else . = ..()
	return

/obj/item/weapon/reagent_containers/food/snacks/customizable/proc/AddIngredient(obj/item/weapon/reagent_containers/food/snacks/S)

	var/image/I = new(src.icon, "[initial(icon_state)]_filling")

	if(!S.filling_color == "#FFFFFF")
		I.color = S.filling_color
	else
		I.color = pick("#FF0000","#0000FF","#008000","#FFFF00")

	switch(Ingredientsplacement)

		if(INGREDIENTS_STACK)
			I.pixel_x = pick(list(-1,0,1))
			I.pixel_y = ingredients.len
			overlays.Cut(ingredients.len)
			var/image/TOP = new(src.icon, "[src.icon_state]")
			TOP.pixel_x = pick(list(-1,0,1))
			TOP.pixel_y = ingredients.len
			overlays += I
			overlays += TOP
		if(INGREDIENTS_SCATTER)
			I.pixel_x = pick(list(-1,0,1))
			I.pixel_y = pick(list(-1,0,1))
			overlays += I
		if(INGREDIENTS_FILL)
			overlays += I

	w_class = n_ceil(Clamp((ingredients.len/2),1,3))
	check_matched_recipe()


/obj/item/weapon/reagent_containers/food/snacks/customizable/proc/check_matched_recipe()
	//HERE WE MUST ADD THE CHECK FOR EXISTING
	//RECIPES TO TRANSFORM THE FOOD AND ITS SPRITE IF NECESSARY.
	return

/obj/item/weapon/reagent_containers/food/snacks/customizable/Destroy()
	for(. in src.ingredients)
		qdel(.)
	return ..()


// Sandwiches //////////////////////////////////////////////////

/obj/item/weapon/reagent_containers/food/snacks/customizable/sandwich
	name = "sandwich"
	desc = "A timeless classic."
	icon_state = "breadslice"
	Ingredientsplacement = INGREDIENTS_STACK

// Misc Subtypes ///////////////////////////////////////////////

/obj/item/weapon/reagent_containers/food/snacks/customizable/pizza
	name = "personal pizza"
	desc = "A personalized pan pizza meant for only one person."
	icon_state = "personal_pizza"
	Ingredientsplacement = INGREDIENTS_SCATTER

/obj/item/weapon/reagent_containers/food/snacks/customizable/pasta
	name = "spagetti"
	desc = "Noodles. With stuff. Delicious."
	icon_state = "pasta_bot"
	Ingredientsplacement = INGREDIENTS_SCATTER

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
	icon_state = "soupcustom"
	trash = /obj/item/weapon/reagent_containers/bowl

/obj/item/weapon/reagent_containers/food/snacks/customizable/burger
	name = "burger bun"
	desc = "A bun for a burger. Delicious."
	icon_state = "bun"
	Ingredientsplacement = INGREDIENTS_STACK



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


#undef INGREDIENTS_FILL
#undef INGREDIENTS_SCATTER
#undef INGREDIENTS_STACK