//-----------------------------------------------------------//
// Basic class for all karma object                          //
//-----------------------------------------------------------//

class DKKarma extends KarmaThing;

var() bool bDamageable;
var()	int		Health;

var ShadowProjector Shadow;
var() vector ShadowDir;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

	if ( Level.NetMode != NM_DedicatedServer)
	{
			Shadow = Spawn(class'ShadowProjector',Self,'',Location);
			Shadow.ShadowActor = self;
			Shadow.bBlobShadow = false;
			Shadow.LightDirection = Normal(vect(0,0,5));
			Shadow.LightDistance = 1000;
			Shadow.MaxTraceDistance = 5000;
			Shadow.CullDistance = 0;
			Shadow.InitShadow();
	}
}

simulated function TakeDamage( int NDamage, Pawn instigatedBy, Vector hitlocation, 
					Vector momentum, class<DamageType> damageType)
{
	Instigator = InstigatedBy;
	if (!bDamageable || (Health<0) ) 
		Return;
	if ( Instigator != None )
		MakeNoise(1.0);
	Health -= NDamage;
	if (Health <0) 	
		Destroy();
}

simulated event Destroyed()
{
                Shadow.Destroy();

	Super.Destroyed();
}

defaultproperties
{
     Health=1000
     bDramaticLighting=True
     bNoDelete=False
     bAcceptsProjectors=False
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=50.000000
     AmbientGlow=1
     MaxLights=24
     SurfaceType=EST_Metal
     bShadowCast=True
     bCollideWhenPlacing=True
     SoundVolume=255
     SoundRadius=256.000000
     bCollideWorld=True
     bBlockPlayers=True
     bNetNotify=True
     Begin Object Class=KarmaParamsSkel Name=PawnKParams
         KMass=5.000000
         KLinearDamping=0.100000
         KAngularDamping=0.100000
         KBuoyancy=1.000000
         KStartEnabled=True
         KVelDropBelowThreshold=-1.000000
         KMaxSpeed=10000.000000
         KMaxAngularSpeed=10000.000000
         bHighDetailOnly=False
         bKAllowRotate=True
         bDoSafetime=True
         StayUprightStiffness=0.000000
         KFriction=1.500000
         KImpactThreshold=100000.000000
     End Object
     KParams=KarmaParamsSkel'UberSoldierVehicles.DKKarma.PawnKParams'

}
