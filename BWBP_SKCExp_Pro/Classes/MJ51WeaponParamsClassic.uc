class MJ51WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=10000.000000,Max=13000.000000)
		WaterTraceRange=10400.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=24
		HeadMult=3.125
		LimbMult=0.5
		DamageType=Class'BWBP_SKCExp_Pro.DTMJ51Assault'
		DamageTypeHead=Class'BWBP_SKCExp_Pro.DTMJ51AssaultHead'
		DamageTypeArm=Class'BWBP_SKCExp_Pro.DTMJ51AssaultLimb'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKCExp_Pro.MJ51FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.MJ51.MJ51Carbine-Fire')
		Recoil=128.000000
		Chaos=-1.0
		Inaccuracy=(X=8,Y=8)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.075000
		AimedFireAnim="SightFire"
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKCExp_Pro.MJ51ChaffRifleGrenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3750.000000
		MaxSpeed=4500.000000
		Damage=65.000000
		DamageRadius=192.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'MJ51AltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		Recoil=0.0
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.600000
		BurstFireRateFactor=1.00
		FireAnim="FireGrenade"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=1.500000
		YawFactor=0.400000
		XRandFactor=1.000000
		YRandFactor=0.200000
		MaxRecoil=2048.000000
		DeclineTime=1.5
		DeclineDelay=0.100000
		ViewBindFactor=0.600000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2050)
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		ChaosDeclineTime=1.0
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		SightOffset=(X=0.000000,Y=-6.450000,Z=24.000000)
		WeaponBoneScales(0)=(BoneName="CarryHandle",Slot=54,Scale=1f)
		WeaponBoneScales(1)=(BoneName="HoloSightLower",Slot=55,Scale=1f)
		WeaponBoneScales(2)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}