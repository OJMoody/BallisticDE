class AH64Missile extends DKWeapons;

var name Barrel[2];
var float NextFireTime; 
var int    i; 
var bool IsOnFire; 

state ProjectileFireMode    
{    
       simulated event SetInitialState() 
       { 
                      Super.SetInitialState(); 

     Enable('Tick'); 
} 

function Tick(float dt) 
{ 
     if ( (IsOnFire == true) && (NextFireTime < Level.TimeSeconds) ) 
     {    
       NextFireTime = Level.TimeSeconds + 0.00; 
       Spawn(class'PROJ_AH64Missile',,,GetBoneCoords(Barrel[i]).Origin, GetBoneRotation(Barrel[i]));    
       PlayOwnedSound(FireSoundClass, SLOT_None, 1.0,, 1000,, False);    
       if (i < 1)    
         i = i + 1;     
       else 
         {    
           i = 0;    
           IsOnFire = false; 
           NextFireTime = Level.TimeSeconds + 1; 
         } 
     }    
    Super.Tick(dt); 
}     

function AltFire(Controller C)    
     {    
       if ( (IsOnFire == false) && (NextFireTime < Level.TimeSeconds) ); 
         IsOnFire = true; 
     }    
}

defaultproperties
{
     Barrel(0)="FireL"
     Barrel(1)="FireR"
     YawBone="Turret"
     YawStartConstraint=1.000000
     YawEndConstraint=1.000000
     PitchBone="Turret"
     PitchDownLimit=50000
     RotationsPerSecond=0.200000
     AltFireInterval=3.000000
     FireSoundClass=Sound'CicadaSnds.Missile.MissileEject'
     FireSoundVolume=200.000000
     RotateSound=None
     Mesh=SkeletalMesh'DKVehiclesAnim.AH64T1'
     Skins(0)=Shader'DKVehiclesTex.AH64.AH64Missle'
     Skins(1)=Shader'DKVehiclesTex.AH64.AH64Rocket'
     Skins(2)=TexEnvMap'CH_Rocket_tex.REnvmap'
}
