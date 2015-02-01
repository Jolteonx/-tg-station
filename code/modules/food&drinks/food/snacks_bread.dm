
/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread
	name = "bread"
	desc = "Some plain old Earthen bread."
	icon_state = "bread"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/breadslice
	slices_num = 5
	bitesize = 2


/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/New()
	..()
	reagents.add_reagent("nutriment", 6)

/obj/item/weapon/reagent_containers/food/snacks/breadslice
	name = "bread slice"
	desc = "A slice of home."
	icon_state = "breadslice"
	trash = /obj/item/trash/plate
	bitesize = 2
	custom_food_type = /obj/item/weapon/reagent_containers/food/snacks/customizable/sandwich


/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/plain
	custom_food_type = /obj/item/weapon/reagent_containers/food/snacks/customizable/bread



/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/meat
	name = "meatbread loaf"
	desc = "The culinary base of every self-respecting eloquen/tg/entleman."
	icon_state = "meatbread"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/breadslice/meat

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/meatbread/New()
	..()
	reagents.add_reagent("nutriment", 24)
	reagents.add_reagent("vitamin", 5)

/obj/item/weapon/reagent_containers/food/snacks/breadslice/meat
	name = "meatbread slice"
	desc = "A slice of delicious meatbread."
	icon_state = "meatbreadslice"






/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/xenomeat
	name = "xenomeatbread loaf"
	desc = "The culinary base of every self-respecting eloquen/tg/entleman. Extra Heretical."
	icon_state = "xenomeatbread"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/breadslice/xenomeat

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/xenomeat/New()
	..()
	reagents.add_reagent("nutriment", 24)
	reagents.add_reagent("vitamin", 5)

/obj/item/weapon/reagent_containers/food/snacks/breadslice/xenomeat
	name = "xenomeatbread slice"
	desc = "A slice of delicious meatbread. Extra Heretical."
	icon_state = "xenobreadslice"






/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/spidermeat
	name = "spider meat loaf"
	desc = "Reassuringly green meatloaf made from spider meat."
	icon_state = "spidermeatbread"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/breadslice/spidermeat


/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/spidermeat/New()
	..()
	reagents.add_reagent("nutriment", 24)
	reagents.add_reagent("toxin", 15)
	reagents.add_reagent("vitamin", 5)

/obj/item/weapon/reagent_containers/food/snacks/breadslice/spidermeat
	name = "spider meat bread slice"
	desc = "A slice of meatloaf made from an animal that most likely still wants you dead."
	icon_state = "xenobreadslice"


/obj/item/weapon/reagent_containers/food/snacks/breadslice/spidermeat/New()
	..()
	reagents.add_reagent("toxin", 2)







/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/banana
	name = "banana-nut bread"
	desc = "A heavenly and filling treat."
	icon_state = "bananabread"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/breadslice/banana

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/banana/New()
	..()
	reagents.add_reagent("banana", 20)
	reagents.add_reagent("nutriment", 14)


/obj/item/weapon/reagent_containers/food/snacks/breadslice/banana
	name = "banana-nut bread slice"
	desc = "A slice of delicious banana bread."
	icon_state = "bananabreadslice"








/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/tofu
	name = "Tofubread"
	desc = "Like meatbread but for vegetarians. Not guaranteed to give superpowers."
	icon_state = "tofubread"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/breadslice/tofu

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/tofu/New()
	..()
	reagents.add_reagent("nutriment", 24)
	reagents.add_reagent("vitamin", 5)


/obj/item/weapon/reagent_containers/food/snacks/breadslice/tofu
	name = "tofubread slice"
	desc = "A slice of delicious tofubread."
	icon_state = "tofubreadslice"






/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/creamcheese
	name = "cream cheese bread"
	desc = "Yum yum yum!"
	icon_state = "creamcheesebread"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/breadslice/creamcheese

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/bread/creamcheese/New()
	..()
	reagents.add_reagent("nutriment", 14)
	reagents.add_reagent("vitamin", 5)

/obj/item/weapon/reagent_containers/food/snacks/breadslice/creamcheese
	name = "cream cheese bread slice"
	desc = "A slice of yum!"
	icon_state = "creamcheesebreadslice"









/obj/item/weapon/reagent_containers/food/snacks/baguette
	name = "baguette"
	desc = "Bon appetit!"
	icon_state = "baguette"

/obj/item/weapon/reagent_containers/food/snacks/baguette/New()
	..()
	reagents.add_reagent("nutriment", 6)
	reagents.add_reagent("blackpepper", 1)
	reagents.add_reagent("sodiumchloride", 1)
	reagents.add_reagent("vitamin", 1)
	bitesize = 3
