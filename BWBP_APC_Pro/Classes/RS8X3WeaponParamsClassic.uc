class RS8X3WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Semi
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		WaterTraceRange=2250.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=30.0
		HeadMult=2.3
		LimbMult=0.3
		DamageType=Class'BWBP_APC_Pro.DTRS8X3Pistol'
		DamageTypeHead=Class'BWBP_APC_Pro.DTRS8X3PistolHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTRS8X3Pistol'
		PenetrationEnergy=20.000000
		PenetrateForce=135
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Pistol.RSP-Fire',Volume=1.100000)
		Recoil=2048.000000
		Chaos=0.015000
		Inaccuracy=(X=8,Y=8)
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.180000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object

	//Burst
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParamsBurst
		WaterTraceRange=2250.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=30.0
		HeadMult=2.3
		LimbMult=0.3
		DamageType=Class'BWBP_APC_Pro.DTRS8X3Pistol'
		DamageTypeHead=Class'BWBP_APC_Pro.DTRS8X3PistolHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTRS8X3Pistol'
		PenetrationEnergy=20.000000
		PenetrateForce=135
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Pistol.RSP-Fire',Volume=1.100000)
		Recoil=256.000000
		Chaos=0.200000
		Inaccuracy=(X=8,Y=8)
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParamsBurst
		FireInterval=0.070000
		BurstFireRateFactor=1.00
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParamsBurst'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
			SpreadMode=FSM_Rectangle
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
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=ClassicRecoilParamsBurst
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=1.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=48,Max=8192)
		AimAdjustTime=0.450000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=11200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=1.100000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=14
		SightOffset=(X=-15.000000,Y=-0.900000,Z=13.200000)
		SightPivot=(Pitch=768,Roll=-1024)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		RecoilParams(1)=RecoilParams'ClassicRecoilParamsBurst'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParamsBurst'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}