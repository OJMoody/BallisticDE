//=============================================================================
// AH104's flame projectile.
//
// by Azarael, copy and pasted by Sarge
// adapting code by Nolan "Dark Carnivour" Richert
// Aspects of which are copyright (c) 2006 RuneStorm. All rights reserved.
//=============================================================================
class AH104FlameProjectile extends RSDarkFlameProjectile;

event Tick(float DT)
{
	super(BallisticProjectile).Tick(DT);
	if (vector(Rotation) Dot Normal(EndPoint-Location) < 0.0)
	{
		if (bHitWall)
			HurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, EndPoint);
		Destroy();
	}
}

simulated function bool CanTouch (Actor Other)
{
    local int i;

    if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return false;
	if (Other.Base == Instigator)
		return false;
	for(i=0;i<AlreadyHit.length;i++)
		if (AlreadyHit[i] == Other)
			return false;

    return true;
}

simulated function ApplyImpactEffect(Actor Other, Vector HitLocation)
{
    local int i;
    local AH104ActorFire Burner;

    DoDamage(Other, HitLocation);

    if (Pawn(Other) != None && Pawn(Other).Health > 0 && Vehicle(Other) == None)
    {
        for (i=0;i<Other.Attached.length;i++)
        {
            if (AH104ActorFire(Other.Attached[i])!=None)
            {
                AH104ActorFire(Other.Attached[i]).AddFuel(0.15);
                break;
            }
        }
        if (i>=Other.Attached.length)
        {
            Burner = Spawn(class'AH104ActorFire',Other,,Other.Location);
            Burner.Initialize(Other);
            if (Instigator!=None)
            {
                Burner.Instigator = Instigator;
                Burner.InstigatorController = Instigator.Controller;
            }
        }
    }
}

simulated function Penetrate(Actor Other, Vector HitLocation)
{
    AlreadyHit[AlreadyHit.length] = Other;
}

defaultproperties
{
     MyRadiusDamageType=Class'BWBP_SKCExp_Pro.DT_AH104Burned'
     Damage=8.000000
     MyDamageType=Class'BWBP_SKCExp_Pro.DT_AH104Burned'
     LifeSpan=0.300000
     CollisionRadius=28.000000
     CollisionHeight=28.000000
}
