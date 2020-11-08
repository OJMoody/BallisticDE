class MG36WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.40000),(InVal=0.500000,OutVal=0.550000),(InVal=0.700000,OutVal=0.70000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.300000),(InVal=0.500000,OutVal=0.550000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1000
		YRandFactor=0.2000
		MaxRecoil=12288
		DeclineTime=1.3
		DeclineDelay=0.350000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=200,Max=1024)
		ADSMultiplier=0.200000
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimAdjustTime=0.400000
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=15000.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.850000
		DisplaceDurationMult=1.5
		MagAmmo=120
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'