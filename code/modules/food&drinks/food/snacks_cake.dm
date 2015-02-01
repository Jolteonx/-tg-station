
/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake
	name = "vanilla cake"
	desc = "A plain cake, not a lie."
	icon_state = "plaincake"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/cakeslice/plain
	slices_num = 5
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/New()
	..()
	reagents.add_reagent("nutriment", 20)
	reagents.add_reagent("vitamin", 5)

/obj/item/weapon/reagent_containers/food/snacks/cakeslice
	name = "cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "plaincake_slice"
	trash = /obj/item/trash/plate
	bitesize = 2



/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/plain
	custom_food_type = /obj/item/weapon/reagent_containers/food/snacks/customizable/cake

/obj/item/weapon/reagent_containers/food/snacks/cakeslice/plain
	name = "vanilla cake slice"


/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/carrot
	name = "carrot cake"
	desc = "A favorite desert of a certain wascally wabbit. Not a lie."
	icon_state = "carrotcake"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/cakeslice/carrot
	slices_num = 5

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/carrot/New()
	..()
	reagents.add_reagent("imidazoline", 10)
	reagents.add_reagent("vitamin", 5)

/obj/item/weapon/reagent_containers/food/snacks/cakeslice/carrot
	name = "carrot cake slice"
	desc = "Carrotty slice of Carrot Cake, carrots are good for your eyes! Also not a lie."
	icon_state = "carrotcake_slice"



/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/brain
	name = "brain cake"
	desc = "A squishy cake-thing."
	icon_state = "braincake"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/cakeslice/brain
	slices_num = 5

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/brain/New()
	..()
	reagents.add_reagent("alkysine", 10)
	reagents.add_reagent("vitamin", 5)

/obj/item/weapon/reagent_containers/food/snacks/cakeslice/brain
	name = "brain cake slice"
	desc = "Lemme tell you something about prions. THEY'RE DELICIOUS."
	icon_state = "braincakeslice"


/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/cheese
	name = "cheese cake"
	desc = "DANGEROUSLY cheesy."
	icon_state = "cheesecake"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/cakeslice/cheese
	slices_num = 5

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/cheese/New()
	..()
	reagents.add_reagent("vitamin", 5)

/obj/item/weapon/reagent_containers/food/snacks/cakeslice/cheese
	name = "cheese cake slice"
	desc = "Slice of pure cheestisfaction."
	icon_state = "cheesecake_slice"


/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/orange
	name = "orange cake"
	desc = "A cake with added orange."
	icon_state = "orangecake"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/cakeslice/orange
	slices_num = 5

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/orange/New()
	..()
	reagents.add_reagent("vitamin", 5)

/obj/item/weapon/reagent_containers/food/snacks/cakeslice/orange
	name = "orange cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "orangecake_slice"

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/lime
	name = "lime cake"
	desc = "A cake with added lime."
	icon_state = "limecake"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/cakeslice/lime
	slices_num = 5

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/lime/New()
	..()
	reagents.add_reagent("vitamin", 5)

/obj/item/weapon/reagent_containers/food/snacks/cakeslice/lime
	name = "lime cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "limecake_slice"


/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/lemon
	name = "lemon cake"
	desc = "A cake with added lemon."
	icon_state = "lemoncake"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/cakeslice/lemon
	slices_num = 5

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/lemon/New()
	..()
	reagents.add_reagent("vitamin", 5)

/obj/item/weapon/reagent_containers/food/snacks/cakeslice/lemon
	name = "lemon cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "lemoncake_slice"


/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/chocolate
	name = "chocolate cake"
	desc = "A cake with added chocolate."
	icon_state = "chocolatecake"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/cakeslice/chocolate
	slices_num = 5

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/chocolate/New()
	..()
	reagents.add_reagent("vitamin", 5)

/obj/item/weapon/reagent_containers/food/snacks/cakeslice/chocolate
	name = "chocolate cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "chocolatecake_slice"


/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/birthday
	name = "birthday cake"
	desc = "Happy Birthday little clown..."
	icon_state = "birthdaycake"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/cakeslice/birthday
	slices_num = 5

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/birthday/New()
	..()
	reagents.add_reagent("sprinkles", 10)
	reagents.add_reagent("vitamin", 5)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/cakeslice/birthday
	name = "birthday cake slice"
	desc = "A slice of your birthday."
	icon_state = "birthdaycakeslice"


/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/apple
	name = "apple cake"
	desc = "A cake centred with Apple."
	icon_state = "applecake"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/cakeslice/apple
	slices_num = 5

/obj/item/weapon/reagent_containers/food/snacks/sliceable/store/cake/apple/New()
	..()
	reagents.add_reagent("vitamin", 5)

/obj/item/weapon/reagent_containers/food/snacks/cakeslice/apple
	name = "apple cake slice"
	desc = "A slice of heavenly cake."
	icon_state = "applecakeslice"

