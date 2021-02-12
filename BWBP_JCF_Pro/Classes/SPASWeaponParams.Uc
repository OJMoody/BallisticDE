class SPASWeaponParams extends BallisticWeaponParams;

defaultproperties
{
    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.4
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.10000),(InVal=0.350000,OutVal=0.13000),(InVal=0.550000,OutVal=0.230000),(InVal=0.800000,OutVal=0.35000),(InVal=1.000000,OutVal=0.45)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.150000),(InVal=0.40000,OutVal=0.50000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
        YRandFactor=0.100000
        DeclineTime=0.500000
        DeclineDelay=0.750000
    End Object

    Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=0.15
        ADSMultiplier=0.350000
        SprintOffSet=(Pitch=-1000,Yaw=-2048)
        JumpChaos=1.000000
        ChaosDeclineTime=0.750000	
		ChaosSpeedThreshold=550.000000
    End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		MagAmmo=10
		SightingTime=0.35
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}