class Deco_P30_X extends DKKarma;

var FX_DecoTankFire Effect;
var PROJ_TankExp Decal;

function PostBeginPlay()
{
	super.PostBeginPlay();

                 Effect = spawn( class'FX_DecoTankFire',self,,Location + (vect(0,0,0) << Rotation));  
	   Spawn(class'FX_HelecopterDestroy',,, Location - 100 * Normal(Velocity), Rot(0,16384,0));

}

simulated function Destroyed()
{
                Effect.Destroy();

	super.Destroyed();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.P30.P30_X'
     bUseDynamicLights=True
     AmbientGlow=100
     Begin Object Class=KarmaParams Name=KParams0
         KMass=18.000000
         KLinearDamping=0.100000
         KAngularDamping=0.100000
         KBuoyancy=1.000000
         KStartEnabled=True
         KVelDropBelowThreshold=-1.000000
         KMaxSpeed=10000.000000
         KMaxAngularSpeed=10000.000000
         bHighDetailOnly=False
         bDoSafetime=True
         StayUprightStiffness=0.000000
         KFriction=1.000000
         KRestitution=0.100000
         KImpactThreshold=100000.000000
     End Object
     KParams=KarmaParams'UberSoldierVehicles.Deco_P30_X.KParams0'

}
