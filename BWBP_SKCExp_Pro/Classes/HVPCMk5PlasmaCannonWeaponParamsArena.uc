class HVPCMk5PlasmaCannonWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKCExp_Pro.HVPCMk5Projectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=50.000000
		MaxSpeed=8000.000000
		AccelSpeed=90000.000000
		Damage=75
		DamageRadius=265.000000
		MomentumTransfer=65000.000000
		MuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Fire',Volume=2.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=700.000000
		Chaos=0.400000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.700000
		AmmoPerFire=5
		FireAnim="Fire2"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKCExp_Pro.HVPCMk5ProjectileSmall'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=200.000000
		MaxSpeed=2000000.000000
		AccelSpeed=150000.000000
		Damage=30
		DamageRadius=122.000000
		MomentumTransfer=12500.000000
		MuzzleFlashClass=Class'BWBP_SKCExp_Pro.A48FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-FireAlt',Volume=2.000000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=200.000000
		Chaos=0.025000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.175000
		FireAnim="Fire2"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		YawFactor=0.100000
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.070000),(InVal=0.600000,OutVal=-0.060000),(InVal=0.700000,OutVal=-0.060000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.350000),(InVal=0.450000,OutVal=0.550000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		DeclineTime=0.750000
		DeclineDelay=0.900000
		MaxRecoil=512
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=32,Max=896)
		SprintOffset=(Pitch=-3000,Yaw=-5000)
		AimAdjustTime=0.400000
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=3000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000		
		DisplaceDurationMult=1
		MagAmmo=200
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.700000
		SightOffset=(X=-12.000000,Z=25.000000)
		SightPivot=(Pitch=768)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}