class P90SubMachinegunWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		RangeAtten=0.35
		Damage=21
		DamageType=Class'BWBP_JCF_Pro.DTP90SMG'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTP90SMGHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTP90SMG'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_JCF_Pro.P90FlashEmitter'
		FlashScaleFactor=0.050000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.P90.P90Fire',Volume=1.300000)
		Recoil=80.000000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.08000
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.06000
		YRandFactor=0.06000
		DeclineDelay=0.1000000
		MaxRecoil=8000
		DeclineTime=0.65
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=0.05
		ADSMultiplier=1
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.550000
		AimSpread=(Min=32,Max=768)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=850.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		SightingTime=0.25
        MagAmmo=50
        InventorySize=12
		SightOffset=(X=-12.000000,Y=-0.420000,Z=12.700000)
		SightPivot=(Pitch=-100)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}