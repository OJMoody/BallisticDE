class AY90WeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
			ProjectileClass=Class'BWBP_SKCExp_Pro.AY90BoltProjectile'
			SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
			Speed=2000.000000
			MaxSpeed=35000.000000
			AccelSpeed=35000.000000
			DamageRadius=30.000000
			MomentumTransfer=30000.000000
			HeadMult=2.000000
			LimbMult=0.500000
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BWBP_SKCExp_Pro.A73BFlashEmitter'
			FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltShot',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=256.000000
			Chaos=-1.0
			Inaccuracy=(X=9,Y=6)
			WarnTargetPct=0.200000	
		End Object

		Begin Object Class=FireParams Name=ArenaPrimaryFireParams
			FireInterval=1.000000
			AmmoPerFire=5
			BurstFireRateFactor=1.00
			AimedFireAnim="SightFire"
			FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
			ProjectileClass=Class'AY90Projectile'
			SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
			Speed=85.000000
			MaxSpeed=4500.000000
			AccelSpeed=70000.000000
			Damage=40
			DamageRadius=96.000000
			MomentumTransfer=150.000000
			HeadMult=2.5
			LimbMult=0.5
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.SkirthBow.SkrithBow-WaveFire',Volume=1.700000)
			Recoil=0.0
			Chaos=-1.0
			Inaccuracy=(X=2000,Y=10)
			WarnTargetPct=0.500000	
		End Object

		Begin Object Class=FireParams Name=ArenaSecondaryFireParams
			FireInterval=1.000000
			AmmoPerFire=5
			BurstFireRateFactor=1.00
			AimedFireAnim="SightFire"
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.150000,OutVal=0.100000),(InVal=0.250000,OutVal=0.200000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=-0.250000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.090000),(InVal=0.150000,OutVal=0.150000),(InVal=0.250000,OutVal=0.120000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.050000),(InVal=500000.000000,OutVal=0.500000)))
		PitchFactor=0.800000
		YawFactor=0.800000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=1024.000000
		DeclineTime=1.500000
		ViewBindFactor=0.450000
		HipMultiplier=1.000000
		CrouchMultiplier=0.600000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=1740)
		CrouchMultiplier=0.600000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		AimDamageThreshold=75.000000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightOffset=(Y=4.700000,Z=7.050000)
		SightPivot=(Pitch=768)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}