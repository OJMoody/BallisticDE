class HKMK23PistolWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Max=6000.000000)
		WaterTraceRange=3600.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=40.0
		HeadMult=1.5
		LimbMult=0.55
		DamageType=Class'BWBP_JCF_Pro.DTHKMK23Pistol'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTHKMK23PistolHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTHKMK23Pistol'
		PenetrationEnergy=24.000000
		PenetrateForce=135
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.DE.MkFire_1',Volume=1.300000)
		Recoil=2048.000000
		Chaos=0.015000
		Inaccuracy=(X=4,Y=4)
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.25
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
	End Object
		
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
	FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=2048.000000
		DeclineTime=0.400000
		DeclineDelay=0.050000
		ViewBindFactor=0.400000
		ADSViewBindFactor=0.400000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=128,Max=1024)
		AimAdjustTime=0.350000
		ADSMultiplier=0.700000
		ViewBindFactor=0.400000
		SprintChaos=0.400000
		ChaosDeclineTime=0.300000
		ChaosSpeedThreshold=1400.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=1.100000
		InventorySize=20
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		MagAmmo=12
		SightOffset=(X=-60.000000,Y=32.700000,Z=31.500000)
		SightPivot=(Pitch=-70,Roll=-1024)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}