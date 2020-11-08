class ZX98WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.1,OutVal=0.09),(InVal=0.2,OutVal=0.12),(InVal=0.25,OutVal=0.13),(InVal=0.3,OutVal=0.11),(InVal=0.35,OutVal=0.08),(InVal=0.40000,OutVal=0.050000),(InVal=0.50000,OutVal=-0.020000),(InVal=0.600000,OutVal=-0.040000),(InVal=0.700000,OutVal=0.04),(InVal=0.800000,OutVal=0.070000),(InVal=1.000000,OutVal=0.13)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.07),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.2600000),(InVal=0.400000,OutVal=0.4000),(InVal=0.500000,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
		XRandFactor=0.15000
		YRandFactor=0.15000
		DeclineTime=0.160000
		DeclineDelay=0.400000
		MaxRecoil=512
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=768)
		SprintOffset=(Pitch=-3000,Yaw=-5000)
		AimAdjustTime=0.400000
		ChaosDeclineTime=0.50000
		ChaosSpeedThreshold=7000.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.95
		PlayerJumpFactor=0.95
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.450000		
		DisplaceDurationMult=1
		MagAmmo=40
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}