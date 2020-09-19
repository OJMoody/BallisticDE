class IFBT extends DKWeapons;

var name Barrel[12];
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
       if (i < 11)    
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
         IsOnFire = true; 
     }    
}

defaultproperties
{
     Barrel(0)="01"
     Barrel(1)="02"
     Barrel(2)="03"
     Barrel(3)="04"
     Barrel(4)="05"
     Barrel(5)="06"
     Barrel(6)="07"
     Barrel(7)="08"
     Barrel(8)="09"
     Barrel(9)="10"
     Barrel(10)="11"
     Barrel(11)="12"
     YawBone="Turret"
     PitchBone="Barrel"
     PitchUpLimit=5500
     PitchDownLimit=65000
     RotationsPerSecond=0.080000
     Spread=0.020000
     RedSkin=Shader'DKVehiclesTex.IFV.IFVB'
     BlueSkin=Shader'DKVehiclesTex.IFV.IFVB'
     FireInterval=15.000000
     FireSoundClass=Sound'DKoppIISound.Fire.Rocket_FireB'
     FireSoundVolume=255.000000
     FireSoundRadius=500.000000
     FireForce="PRVSideAltFire"
     AIInfo(0)=(aimerror=400.000000,RefireRate=0.500000)
     Mesh=SkeletalMesh'DKVehiclesAnim.IFBT'
     DrawScale=0.650000
     Skins(0)=Shader'DKVehiclesTex.IFV.IFVB'
     Skins(1)=Shader'DKVehiclesTex.Effects.RocketShell'
}
