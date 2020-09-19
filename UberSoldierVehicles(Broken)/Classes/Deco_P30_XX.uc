class Deco_P30_XX extends DKKarma;

function PostBeginPlay()
{
	super.PostBeginPlay();

                 Spawn( class'FX_DecoTireFire',self,,Location + (vect(0,0,0) << Rotation));  

}

simulated function Destroyed()
{
	super.Destroyed();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.P30.P30_XX'
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
     KParams=KarmaParams'UberSoldierVehicles.Deco_P30_XX.KParams0'

}
