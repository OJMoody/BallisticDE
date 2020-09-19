class TunguskaT2 extends DKWeapons;

var name Barrel[8];
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
       NextFireTime = Level.TimeSeconds + 0.25; 
       Spawn(class'FX_IFBFireInEffect',,,GetBoneCoords(Barrel[i]).Origin, GetBoneRotation(Barrel[i])); 
       Spawn(class'FX_IFBFireOffEffect',,,GetBoneCoords(Barrel[i]).Origin, GetBoneRotation(Barrel[i])); 
       Spawn(class'PROJ_IFBMain',,,GetBoneCoords(Barrel[i]).Origin, GetBoneRotation(Barrel[i])); 
  
       PlayOwnedSound(FireSoundClass, SLOT_None, 1.0,, 1000,, False);    
       if (i < 7)    
         i = i + 1;     
       else 
         {    
           i = 0;    
           IsOnFire = false; 
           NextFireTime = Level.TimeSeconds + 10; 
                        
         } 
     }    
    Super.Tick(dt); 
}     

function AltFire(Controller C) 
     {    
       if ( (IsOnFire == false) && (NextFireTime < Level.TimeSeconds) );
         IsOnFire = false; 
     }    
}

defaultproperties
{
     Barrel(0)="FireR1"
     Barrel(1)="FireL1"
     Barrel(2)="FireR2"
     Barrel(3)="FireL2"
     Barrel(4)="FireR3"
     Barrel(5)="FireL3"
     Barrel(6)="FireR4"
     Barrel(7)="FireL4"
     YawBone="Turret"
     PitchBone="Barrel"
     PitchUpLimit=9000
     PitchDownLimit=63000
     WeaponFireAttachmentBone="Barrel"
     RotationsPerSecond=0.080000
     Spread=0.020000
     RedSkin=Shader'DKVehiclesTex.Tunguska.Tunguska'
     BlueSkin=Shader'DKVehiclesTex.Tunguska.Tunguska'
     FireInterval=10.000000
     FireSoundClass=Sound'DKoppIISound.Fire.Rocket_FireB'
     FireSoundVolume=255.000000
     FireSoundRadius=500.000000
     RotateSound=None
     ProjectileClass=Class'UberSoldierVehicles.PROJ_IFBMain'
     AIInfo(0)=(RefireRate=0.850000)
     Mesh=SkeletalMesh'DKVehiclesAnim.TunguskaT2'
     Skins(0)=Shader'DKVehiclesTex.Tunguska.Tunguska'
}
