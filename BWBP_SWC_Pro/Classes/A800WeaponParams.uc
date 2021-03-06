class A800WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.700000
		DeclineDelay=0.40000
		MaxRecoil=10000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=0.2
		ADSMultiplier=1
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		AimSpread=(Min=128,Max=768)
		AimDamageThreshold=75.000000
		ChaosDeclineTime=1.000000
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
	    SightingTime=0.600000	 
        MagAmmo=90
        InventorySize=12
        SightMoveSpeedFactor=0.75
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}