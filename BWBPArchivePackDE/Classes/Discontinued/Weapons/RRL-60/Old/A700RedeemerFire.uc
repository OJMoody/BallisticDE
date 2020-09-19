class A700RedeemerFire extends A700ProjectileFire;

function Projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local Projectile p;

    p = Super.SpawnProjectile(Start,Dir);
    if ( p == None )
        p = Super.SpawnProjectile(Instigator.Location,Dir);
    if ( p == None )
    {
	 	Weapon.Spawn(class'IE_A700RocketExplodeR');
		//Weapon.HurtRadius(500, 400, class'DamTypeRedeemer', 100000, Instigator.Location);
	}
    return p;
}

function float MaxRange()
{
	return 20000;
}

defaultproperties
{
     ProjSpawnOffset=(X=100.000000,Z=0.000000)
     BallisticFireSound=(Sound=Sound'BallisticSounds3.G5.G5-Fire1')
     bSplashDamage=True
     bRecommendSplashDamage=True
     FireForce="redeemer_shoot"
     FireRate=1.000000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_A700Rockets'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBPArchivePackDE.A700Rocket'
     BotRefireRate=0.500000
}
