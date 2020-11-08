class PUGWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.05000),(InVal=0.200000,OutVal=0.060000),(InVal=0.300000,OutVal=0.10000),(InVal=0.400000,OutVal=0.150000),(InVal=0.500000,OutVal=0.170000),(InVal=0.65000000,OutVal=0.100000),(InVal=0.75.000000,OutVal=0.05000),(InVal=1.000000,OutVal=0.080000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.300000,OutVal=0.40000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.20000
		YRandFactor=0.30000
		DeclineDelay=0.5
		DeclineTime=0.7	
		MaxRecoil=2096
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=0.3
		AimSpread=(Min=256,Max=1024)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=2000.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.900000
		PlayerJumpFactor=0.900000
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.500000
		DisplaceDurationMult=1
		MagAmmo=15
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}