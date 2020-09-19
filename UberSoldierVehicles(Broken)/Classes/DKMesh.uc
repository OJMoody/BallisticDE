//------------------------------------------------------//
// Basic class for all Mesh object                      //
//------------------------------------------------------//

class DKMesh extends StaticMeshActor;

var() bool bDamageable;
var()	int		Health;
var() vector ShadowDir;
var ShadowProjector Shadow;

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
			Shadow.MaxTraceDistance = 10000;
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
     bDamageable=True
     Health=1000
     bUseDynamicLights=False
     bDramaticLighting=True
     bStatic=False
     bWorldGeometry=False
     bAcceptsProjectors=False
     bAlwaysRelevant=True
     Physics=PHYS_Trailer
     RemoteRole=ROLE_SimulatedProxy
     AmbientGlow=1
     MaxLights=24
     bCollideWhenPlacing=True
     bHardAttach=True
     SoundVolume=255
     SoundRadius=256.000000
     bCollideWorld=True
     bBlockPlayers=True
     bBlockProjectiles=True
     bProjTarget=True
     bBlockKarma=False
     bBlocksTeleport=True
     bNetNotify=True
}
