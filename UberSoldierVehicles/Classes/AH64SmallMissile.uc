class AH64SmallMissile extends DKWeapons;

var name Barrel[19];
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
       NextFireTime = Level.TimeSeconds + 0.10; 
       Spawn(class'PROJ_AH64Rocket',,,GetBoneCoords(Barrel[i]).Origin, GetBoneRotation(Barrel[i]));    
       PlayOwnedSound(FireSoundClass, SLOT_None, 1.0,, 1000,, False);    
       if (i < 18)    
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

function Fire(Controller C)    
     {    
       if ( (IsOnFire == false) && (NextFireTime < Level.TimeSeconds) ); 
         IsOnFire = True; 
     }    

function AltFire(Controller C)    
     {    
       if ( (IsOnFire == false) && (NextFireTime < Level.TimeSeconds) ); 
         IsOnFire = false; 
     }    
}

defaultproperties
{
     Barrel(0)="FireL"
     Barrel(1)="FireR"
     Barrel(2)="FireR"
     Barrel(3)="FireL"
     Barrel(4)="FireR"
     Barrel(5)="FireL"
     Barrel(6)="FireR"
     Barrel(7)="FireL"
     Barrel(8)="FireR"
     Barrel(9)="FireL"
     Barrel(10)="FireR"
     Barrel(11)="FireL"
     Barrel(12)="FireR"
     Barrel(13)="FireL"
     Barrel(14)="FireR"
     Barrel(15)="FireL"
     Barrel(16)="FireR"
     Barrel(17)="FireL"
     Barrel(18)="FireR"
     YawBone="Turret"
     YawStartConstraint=1.000000
     YawEndConstraint=1.000000
     PitchBone="Turret"
     PitchDownLimit=50000
     RotationsPerSecond=0.200000
     FireInterval=5.000000
     FireSoundClass=Sound'A3.irpgweaa'
     FireSoundVolume=200.000000
     RotateSound=None
     Mesh=SkeletalMesh'DKVehiclesAnim.AH64T2'
     Skins(0)=Texture'DKVehiclesTex.Detail.invis'
     Skins(1)=Shader'DKVehiclesTex.AH64.AH64Rocket'
}
