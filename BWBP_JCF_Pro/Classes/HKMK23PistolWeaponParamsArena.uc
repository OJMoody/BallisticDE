class HKMK23PistolWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Max=6000.000000)
		Damage=26
		DamageType=Class'BWBP_JCF_Pro.DTHKMK23Pistol'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTHKMK23PistolHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTHKMK23Pistol'
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.950000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.DE.MkFire_1',Volume=1.300000)
		Recoil=220.000000
		Chaos=0.280000
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.210000
		FireAnim="SightFire"
		AimedFireAnim="SightFire"
		FireAnimRate=1.400000	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================
        Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
            FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
            Recoil=0.0
            Chaos=-1.0
            BotRefireRate=0.300000
        End Object

        Begin Object Class=FireParams Name=ArenaSecondaryFireParams
            FireInterval=0.200000
            AmmoPerFire=0
            BurstFireRateFactor=1.00
            FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
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
		PlayerSpeedFactor=1.1
		SightingTime=0.200000
		MagAmmo=8
        InventorySize=3
		SightOffset=(X=-25.000000,Y=9.750000,Z=7.700000)
		SightPivot=(Pitch=-70)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}