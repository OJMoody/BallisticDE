class MJ51WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1400.000000,Max=5200.000000) //5.56mm Short Barrel
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=43.0
		HeadMult=2.139534
		LimbMult=0.651162
		DamageType=Class'BWBP_SKCExp_Pro.DTMJ51Assault'
		DamageTypeHead=Class'BWBP_SKCExp_Pro.DTMJ51AssaultHead'
		DamageTypeArm=Class'BWBP_SKCExp_Pro.DTMJ51AssaultLimb'
		PenetrationEnergy=18.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.MJ51.MJ55A3Carbine-Fire',Pitch=1.150000,Volume=1.10000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=700.000000
		Chaos=0.050000
		Inaccuracy=(X=12,Y=12)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.063000
		AimedFireAnim="SightFire"
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKCExp_Pro.MJ51HeGrenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3600.000000
		Damage=200.000000
		DamageRadius=400.000000
		MomentumTransfer=30000.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'MJ51AltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		Recoil=600.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=1.250000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireAnim="FireGrenade"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.400000,OutVal=0.250000),(InVal=0.600000,OutVal=0.300000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.700000,OutVal=0.350000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.150000
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=2800
		DeclineTime=0.625000
		DeclineDelay=0.075000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=12,Max=1400)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		ChaosDeclineTime=1.450000
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightOffset=(X=10.000000,Y=-6.450000,Z=20.900000)
		ViewOffset=(X=-9.000000,Y=8.000000,Z=-15.000000)
		WeaponBoneScales(0)=(BoneName="IronsLower",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="CarryHandle",Slot=54,Scale=-1)
		WeaponBoneScales(2)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(3)=(BoneName="HoloSightLower",Slot=56,Scale=1f)
		//WeaponMaterialSwaps(0)=(Material=Shader'BWBP_SKC_Tex.LK05.LK05-EOTechGlow2',Index=4)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		WeaponName="G51 5.56mm Carbine"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}