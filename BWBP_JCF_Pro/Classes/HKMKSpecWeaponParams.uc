class HKMKSpecWeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		RangeAtten=0.3
		Damage=35
		HeadMult=1.5f
		LimbMult=0.5f
		DamageType=Class'BWBP_JCF_Pro.DTHKMKSpecPistol'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTHKMKSpecPistolHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTHKMKSpecPistol'
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		Recoil=220.000000
		Chaos=0.280000
		BotRefireRate=0.750000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.DE.MkFire_1',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.210000
		FireEndAnim=
		AimedFireAnim='SightFire'
		FireAnimRate=1.8	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		CrouchMultiplier=0.800000
		ViewBindFactor=0.63
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=0.50000
		DeclineDelay=0.250000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=0.4
		ADSMultiplier=2
		AimAdjustTime=0.350000
		ChaosDeclineTime=0.4500000
		ChaosSpeedThreshold=1400.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		SightOffset=(X=-5.000000,Y=-4.300000,Z=11.600000)
		DisplaceDurationMult=0.33
		PlayerSpeedFactor=1.05
		SightingTime=0.200000
		MagAmmo=8
        InventorySize=3
		SightPivot=(Pitch=-70)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}