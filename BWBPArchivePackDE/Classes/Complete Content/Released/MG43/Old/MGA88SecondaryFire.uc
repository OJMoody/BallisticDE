class MGA88SecondaryFire extends BallisticFire;

function PlayFiring()
{
    if (BallisticTurret(Instigator) != None)
    {
        super.PlayFiring();
    }
}

function ServerPlayFiring()
{
    if (BallisticTurret(Instigator) != None)
        BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
}

function DoFireEffect()
{
    if (BallisticTurret(Instigator) == None)
        MGA88Machinegun(Weapon).Notify_Deploy();
}
simulated function bool AllowFire()
{
    if (BallisticTurret(Instigator) == None && Instigator.HeadVolume.bWaterVolume)
        return false;
    return super.AllowFire();
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireAnim="Undeploy"
     FireRate=0.700000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_792mmBelt'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
