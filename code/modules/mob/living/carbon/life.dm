/mob/living/carbon/proc/get_breath_from_internal(volume_needed)
	if(internal)
		if (!contents.Find(internal))
			internal = null
		if (!wear_mask || !(wear_mask.flags & MASKINTERNALS) )
			internal = null
		if(internal)
			if (internals)
				internals.icon_state = "internal1"
			return internal.remove_air_volume(volume_needed)
		else
			if (internals)
				internals.icon_state = "internal0"
	return

/mob/living/carbon/Life()
	set invisibility = 0
	set background = BACKGROUND_ENABLED

	if (notransform)
		return
	if(!loc)
		return
	var/datum/gas_mixture/environment = loc.return_air()

	if(stat != DEAD)

		//Updates the number of stored chemicals for powers
		handle_changeling()

		//Mutations and radiation
		handle_mutations_and_radiation()

		//Chemicals in the body
		handle_chemicals_in_body()

		//Blud
		handle_blood()

		//Random events (vomiting etc)
		handle_random_events()

		. = 1


	//Handle temperature/pressure differences between body and environment
	handle_environment(environment)

	handle_fire()

	//stuff in the stomach
	handle_stomach()

	update_canmove()

	update_gravity(mob_has_gravity())

	for(var/obj/item/weapon/grab/G in src)
		G.process()

	handle_regular_status_updates() // Status updates, death etc.

	if(client)
		handle_regular_hud_updates()

	return .



/mob/living/carbon/proc/handle_changeling()
	return

/mob/living/carbon/proc/handle_mutations_and_radiation()
	if(radiation)

		switch(radiation)
			if(0 to 50)
				radiation--
				if(prob(25))
					adjustToxLoss(1)
					updatehealth()

			if(50 to 75)
				radiation -= 2
				adjustToxLoss(1)
				if(prob(5))
					radiation -= 5
				updatehealth()

			if(75 to 100)
				radiation -= 3
				adjustToxLoss(3)
				updatehealth()

		radiation = Clamp(radiation, 0, 100)


/mob/living/carbon/proc/handle_chemicals_in_body()
	if(reagents)
		reagents.metabolize(src)

	if(drowsyness)
		drowsyness--
		eye_blurry = max(2, eye_blurry)
		if(prob(5))
			sleeping += 1
			Paralyse(5)

	confused = max(0, confused - 1)
	// decrement dizziness counter, clamped to 0
	if(resting)
		dizziness = max(0, dizziness - 5)
		jitteriness = max(0, jitteriness - 5)
	else
		dizziness = max(0, dizziness - 1)
		jitteriness = max(0, jitteriness - 1)

	updatehealth()
	return

/mob/living/carbon/proc/handle_disabilities()
	return

/mob/living/carbon/proc/handle_blood()
	return

/mob/living/carbon/proc/handle_random_events()
	return

/mob/living/carbon/proc/handle_environment(var/datum/gas_mixture/environment)
	return

/mob/living/carbon/proc/handle_regular_status_updates()

	if(stat == DEAD)
		eye_blind = max(eye_blind, 1)
		silent = 0
	else
		updatehealth()
		if(health <= config.health_threshold_dead || !getorgan(/obj/item/organ/brain))
			death()
			eye_blind = max(eye_blind, 1)
			silent = 0
			return 1


		//UNCONSCIOUS. NO-ONE IS HOME
		if( (getOxyLoss() > 50) || (config.health_threshold_crit >= health) )
			Paralyse(3)

		if(paralysis)
			AdjustParalysis(-1)
			stat = UNCONSCIOUS
		else if(sleeping)
			handle_dreams()
			adjustStaminaLoss(-10)
			sleeping = max(sleeping-1, 0)
			stat = UNCONSCIOUS
			if( prob(10) && health && !hal_crit )
				spawn(0)
					emote("snore")
		//CONSCIOUS
		else
			stat = CONSCIOUS

		handle_disabilities()

		//Dizziness
		if(dizziness)
			var/client/C = client
			var/pixel_x_diff = 0
			var/pixel_y_diff = 0
			var/temp
			var/saved_dizz = dizziness
			dizziness = max(dizziness-1, 0)
			if(C)
				var/oldsrc = src
				var/amplitude = dizziness*(sin(dizziness * 0.044 * world.time) + 1) / 70 // This shit is annoying at high strength
				src = null
				spawn(0)
					if(C)
						temp = amplitude * sin(0.008 * saved_dizz * world.time)
						pixel_x_diff += temp
						C.pixel_x += temp
						temp = amplitude * cos(0.008 * saved_dizz * world.time)
						pixel_y_diff += temp
						C.pixel_y += temp
						sleep(3)
						if(C)
							temp = amplitude * sin(0.008 * saved_dizz * world.time)
							pixel_x_diff += temp
							C.pixel_x += temp
							temp = amplitude * cos(0.008 * saved_dizz * world.time)
							pixel_y_diff += temp
							C.pixel_y += temp
						sleep(3)
						if(C)
							C.pixel_x -= pixel_x_diff
							C.pixel_y -= pixel_y_diff
				src = oldsrc

		//Jitteryness
		if(jitteriness)
			do_jitter_animation(jitteriness)
			jitteriness = max(jitteriness-1, 0)

		//Other

		if(stuttering)
			stuttering = max(stuttering-1, 0)

		if(slurring)
			slurring = max(slurring-1,0)

		if(silent)
			silent = max(silent-1, 0)

		if(druggy)
			druggy = max(druggy-1, 0)

		if(stunned)
			AdjustStunned(-1)
			if(!stunned)
				update_icons()

		if(weakened)
			weakened = max(weakened-1,0)
			if(!weakened)
				update_icons()

		if(hallucination)
			spawn handle_hallucinations()

			if(hallucination<=2)
				hallucination = 0
			else
				hallucination -= 2

		else
			for(var/atom/a in hallucinations)
				qdel(a)

		CheckStamina()
	return 1


/mob/living/carbon/proc/handle_vision()

	client.screen.Remove(global_hud.blurry, global_hud.druggy, global_hud.vimpaired, global_hud.darkMask)

	if(stat == DEAD)
		sight |= SEE_TURFS
		sight |= SEE_MOBS
		sight |= SEE_OBJS
		see_in_dark = 8
		see_invisible = SEE_INVISIBLE_LEVEL_TWO
	else
		sight &= ~SEE_TURFS
		sight &= ~SEE_MOBS
		sight &= ~SEE_OBJS
		see_in_dark = 2
		see_invisible = SEE_INVISIBLE_LIVING
		if(see_override)
			see_invisible = see_override

	if ((blind && stat != DEAD))
		if (eye_blind)
			blind.layer = 18
		else
			blind.layer = 0

			if (disabilities & NEARSIGHT)
				client.screen += global_hud.vimpaired

			if (eye_blurry)
				client.screen += global_hud.blurry

			if (druggy)
				client.screen += global_hud.druggy

	if (stat != DEAD)
		if(machine)
			if (!( machine.check_eye(src) ))
				reset_view(null)
		else
			if(!client.adminobs)
				reset_view(null)

/mob/living/carbon/proc/handle_hud_icons()
	return

/mob/living/carbon/proc/handle_hud_icons_health()
	if(healths)
		if (stat != DEAD)
			switch(health)
				if(100 to INFINITY)
					healths.icon_state = "health0"
				if(80 to 100)
					healths.icon_state = "health1"
				if(60 to 80)
					healths.icon_state = "health2"
				if(40 to 60)
					healths.icon_state = "health3"
				if(20 to 40)
					healths.icon_state = "health4"
				if(0 to 20)
					healths.icon_state = "health5"
				else
					healths.icon_state = "health6"
		else
			healths.icon_state = "health7"

/mob/living/carbon/proc/handle_regular_hud_updates()
	if(!client)	return 0

	update_action_buttons()

	if(damageoverlay)
		if(damageoverlay.overlays)
			damageoverlay.overlays = list()

		if(stat == UNCONSCIOUS)
			//Critical damage passage overlay
			if(health <= config.health_threshold_crit)
				var/image/I = image("icon" = 'icons/mob/screen_full.dmi', "icon_state" = "passage0")
				I.blend_mode = BLEND_OVERLAY //damageoverlay is BLEND_MULTIPLY
				var/critstep = (config.health_threshold_crit + config.health_threshold_dead)/10
				switch(health)
					if(2*critstep to critstep)
						I.icon_state = "passage1"
					if(3*critstep to 2*critstep)
						I.icon_state = "passage2"
					if(4*critstep to 3*critstep)
						I.icon_state = "passage3"
					if(5*critstep to 4*critstep)
						I.icon_state = "passage4"
					if(6*critstep to 5*critstep)
						I.icon_state = "passage5"
					if(7*critstep to 6*critstep)
						I.icon_state = "passage6"
					if(8*critstep to 7*critstep)
						I.icon_state = "passage7"
					if(9*critstep to 8*critstep)
						I.icon_state = "passage8"
					if(9.5*critstep to 9*critstep)
						I.icon_state = "passage9"
					if(-INFINITY to 9.5*critstep)
						I.icon_state = "passage10"
				damageoverlay.overlays += I
		else
			//Oxygen damage overlay
			if(oxyloss)
				var/image/I = image("icon" = 'icons/mob/screen_full.dmi', "icon_state" = "oxydamageoverlay0")
				switch(oxyloss)
					if(10 to 20)
						I.icon_state = "oxydamageoverlay1"
					if(20 to 25)
						I.icon_state = "oxydamageoverlay2"
					if(25 to 30)
						I.icon_state = "oxydamageoverlay3"
					if(30 to 35)
						I.icon_state = "oxydamageoverlay4"
					if(35 to 40)
						I.icon_state = "oxydamageoverlay5"
					if(40 to 45)
						I.icon_state = "oxydamageoverlay6"
					if(45 to INFINITY)
						I.icon_state = "oxydamageoverlay7"
				damageoverlay.overlays += I

			//Fire and Brute damage overlay (BSSR)
			var/hurtdamage = src.getBruteLoss() + src.getFireLoss() + damageoverlaytemp
			damageoverlaytemp = 0 // We do this so we can detect if someone hits us or not.
			if(hurtdamage)
				var/image/I = image("icon" = 'icons/mob/screen_full.dmi', "icon_state" = "brutedamageoverlay0")
				I.blend_mode = BLEND_ADD
				switch(hurtdamage)
					if(5 to 15)
						I.icon_state = "brutedamageoverlay1"
					if(15 to 30)
						I.icon_state = "brutedamageoverlay2"
					if(30 to 45)
						I.icon_state = "brutedamageoverlay3"
					if(45 to 70)
						I.icon_state = "brutedamageoverlay4"
					if(70 to 85)
						I.icon_state = "brutedamageoverlay5"
					if(85 to INFINITY)
						I.icon_state = "brutedamageoverlay6"
				var/image/black = image(I.icon, I.icon_state) //BLEND_ADD doesn't let us darken, so this is just to blacken the edge of the screen
				black.color = "#170000"
				damageoverlay.overlays += I
				damageoverlay.overlays += black


	handle_vision()
	handle_hud_icons()

	return 1

/mob/living/carbon/proc/handle_stomach()
	spawn(0)
		for(var/mob/living/M in stomach_contents)
			if(M.loc != src)
				stomach_contents.Remove(M)
				continue
			if(istype(M, /mob/living/carbon) && stat != 2)
				if(M.stat == 2)
					M.death(1)
					stomach_contents.Remove(M)
					qdel(M)
					continue
				if(SSmob.times_fired%3==1)
					if(!(M.status_flags & GODMODE))
						M.adjustBruteLoss(5)
					nutrition += 10



