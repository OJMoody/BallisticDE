class M99WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XRandFactor=0.300000
		YRandFactor=0.300000
		DeclineTime=1.000000
		DeclineDelay=1.2
		HipMultiplier=3
		CrouchMultiplier=0.95
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=256,Max=1768)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=-8000)
		ADSMultiplier=0.15
		AimAdjustTime=0.500000
		ChaosDeclineTime=1.500000
		ChaosSpeedThreshold=400.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.85
		PlayerJumpFactor=0.85
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.50000		
		DisplaceDurationMult=1.25
		MagAmmo=1
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}