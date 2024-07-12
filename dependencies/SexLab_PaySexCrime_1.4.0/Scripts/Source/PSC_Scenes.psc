Scriptname PSC_Scenes extends Quest  

SexLabFramework Property SexLab Auto

PaySexCrimeMCM Property PSC_MCM Auto



	Function Anal(Actor Actor1, Actor Actor2)
		if (SexLab.IsValidActor(Actor1) && SexLab.IsValidActor(Actor2))
			actor[] activeActors = new actor[2]
			activeActors[0] = Actor1
			activeActors[1] = Actor2
			sslBaseAnimation[] anims = SexLab.GetAnimationsBytags(2, "Anal")
			sslThreadModel th = SexLab.NewThread()
			th.AddActor(activeActors[0])
			th.AddActor(activeActors[1])
			th.SetAnimations(anims)
			th.DisableLeadIn(true)
			th.StartThread()
		endif
	EndFunction


	Function Multiple(Actor Actor1, Actor Actor2, Actor Actor3)
		if (SexLab.IsValidActor(Actor1) && SexLab.IsValidActor(Actor2) && SexLab.IsValidActor(Actor3))
			actor[] activeActors = new actor[3]
			activeActors[0] = Actor1
			activeActors[1] = Actor2
			activeActors[2] = Actor3
			sslBaseAnimation[] anims = SexLab.GetAnimationsBytags(3, "MMF")
			sslThreadModel th = SexLab.NewThread()
			th.AddActor(activeActors[0])
			th.AddActor(activeActors[1])
			th.AddActor(activeActors[2])
			th.SetAnimations(anims)
			th.DisableLeadIn(true)
			th.StartThread()
		endif
	EndFunction


	Function MultipleTW(Actor Actor1, Actor Actor2, Actor Actor3)
		if (SexLab.IsValidActor(Actor1) && SexLab.IsValidActor(Actor2) && SexLab.IsValidActor(Actor3))
			actor[] activeActors = new actor[3]
			activeActors[0] = Actor1
			activeActors[1] = Actor2
			activeActors[2] = Actor3
			sslBaseAnimation[] anims = SexLab.GetAnimationsBytags(3, "MFF")
			sslThreadModel th = SexLab.NewThread()
			th.AddActor(activeActors[0])
			th.AddActor(activeActors[1])
			th.AddActor(activeActors[2])
			th.SetAnimations(anims)
			th.DisableLeadIn(true)
			th.StartThread()
		endif
	EndFunction


	Function MultipleAny(Actor Actor1, Actor Actor2, Actor Actor3)
		if (SexLab.IsValidActor(Actor1) && SexLab.IsValidActor(Actor2) && SexLab.IsValidActor(Actor3))
			actor[] activeActors = new actor[3]
			activeActors[0] = Actor1
			activeActors[1] = Actor2
			activeActors[2] = Actor3
			sslBaseAnimation[] anims = SexLab.GetAnimationsBytags(3, "Sex")
			sslThreadModel th = SexLab.NewThread()
			th.AddActor(activeActors[0])
			th.AddActor(activeActors[1])
			th.AddActor(activeActors[2])
			th.SetAnimations(anims)
			th.DisableLeadIn(true)
			th.StartThread()
		endif
	EndFunction


	Function OralF(Actor Actor1, Actor Actor2)
		if (SexLab.IsValidActor(Actor1) && SexLab.IsValidActor(Actor2))
			actor[] activeActors = new actor[2]
			activeActors[1] = Actor1
			activeActors[0] = Actor2
			sslBaseAnimation[] anims = SexLab.GetAnimationsBytags(2, "Cunnilingus", "69")
			sslThreadModel th = SexLab.NewThread()
			th.AddActor(activeActors[0])
			th.AddActor(activeActors[1])
			th.SetAnimations(anims)
			th.DisableLeadIn(true)
			th.StartThread()
		endif
	EndFunction


	Function OralM(Actor Actor1, Actor Actor2)
		if (SexLab.IsValidActor(Actor1) && SexLab.IsValidActor(Actor2))
			actor[] activeActors = new actor[2]
			activeActors[0] = Actor1
			activeActors[1] = Actor2
			sslBaseAnimation[] anims = SexLab.GetAnimationsBytags(2, "Blowjob", "Cunnilingus,Anal,vaginal")
			sslThreadModel th = SexLab.NewThread()
			th.AddActor(activeActors[0])
			th.AddActor(activeActors[1])
			th.SetAnimations(anims)
			th.DisableLeadIn(true)
			th.StartThread()
		endif
	EndFunction


	Function Sex(Actor Actor1, Actor Actor2)
		if (SexLab.IsValidActor(Actor1) && SexLab.IsValidActor(Actor2))
			actor[] activeActors = new actor[2]
			activeActors[0] = Actor1
			activeActors[1] = Actor2
			sslBaseAnimation[] anims = SexLab.GetAnimationsBytags(2, "vaginal", "FF")
			sslThreadModel th = SexLab.NewThread()
			th.AddActor(activeActors[0])
			th.AddActor(activeActors[1])
			th.SetAnimations(anims)
			th.DisableLeadIn(true)
			th.StartThread()
		endif
	EndFunction


	Function SexAny(Actor Actor1, Actor Actor2)
		if (SexLab.IsValidActor(Actor1) && SexLab.IsValidActor(Actor2))
			actor[] activeActors = new actor[2]
			activeActors[0] = Actor1
			activeActors[1] = Actor2
			sslBaseAnimation[] anims = SexLab.GetAnimationsBytags(2, "Sex")
			sslThreadModel th = SexLab.NewThread()
			th.AddActor(activeActors[0])
			th.AddActor(activeActors[1])
			th.SetAnimations(anims)
			th.DisableLeadIn(true)
			th.StartThread()
		endif
	EndFunction