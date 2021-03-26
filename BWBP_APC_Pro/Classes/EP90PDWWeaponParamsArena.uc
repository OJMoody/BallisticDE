class EP90PDWWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		DamageType=Class'BWBP_APC_Pro.DTEP90PDW'
		DamageTypeHead=Class'BWBP_APC_Pro.DTEP90PDWHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTEP90PDW'
		DecayRange=(Min=1800,Max=3600)
		TraceRange=(Max=6000.000000)
		Damage=26.000000
		RangeAtten=0.30000
		Inaccuracy=(X=32,Y=32)
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_APC_Pro.EP90PDWFlashEmitter'
		FlashScaleFactor=0.050000
		Recoil=150.000000
		Chaos=0.150000
		FireSound=(Sound=Sound'BWBP_CC_Sounds.EP110.EP110-Fire',Volume=9.500000,Slot=SLOT_Interact,bNoOverride=False)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.125000
		AimedFireAnim="SightFire"
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		FlashScaleFactor=0.100000
		BotRefireRate=0.250000
		WarnTargetPct=0.500000
		TraceRange=(Max=6000.000000)
		DamageType=Class'BWBP_APC_Pro.DTEP90PDW'
		DamageTypeHead=Class'BWBP_APC_Pro.DTEP90PDWHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTEP90PDW'
		Damage=50
		Recoil=960.000000
		Chaos=0.320000
		FireSound=(Sound=Sound'BWBP_CC_Sounds.EP110.EP110-Overblast',Volume=7.800000)
		Inaccuracy=(X=32,Y=32)
		SplashDamage=True
		MuzzleFlashClass=Class'BWBP_APC_Pro.EP90PDWFlashEmitter'
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		MaxHoldTime=2.50000
		AimedFireAnim="SightFire"
		FireInterval=1.200000
		AmmoPerFire=5
		FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.45
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.16)))
        YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.25),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.15000
		YRandFactor=0.15000
		DeclineTime=0.9
		DeclineDelay=0.4000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=32,Max=512)
		ADSMultiplier=0.200000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.90000
		ChaosSpeedThreshold=15000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		SightingTime=0.250000
		SightOffset=(X=-4.000000,Y=-0.250000,Z=13.600000)
		SightPivot=(Pitch=1024)
		ZoomType=ZT_Fixed
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		DisplaceDurationMult=1
		MagAmmo=25
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}