//=============================================================================
// Fender.
//
// A Car Fender used as a shield.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_sh_fender extends JunkShield;

defaultproperties
{
     DownDir=(Pitch=-4296,Yaw=-8592)
     UpDir=(Yaw=-3096)
     DownCoverage=0.800000
     BlockRate=0.700000
     rating=55.000000
     ShieldPropClass=Class'JWVanDE.JWVan_sh_fenderProp'
     AttachOffset=(X=1.000000,Y=0.000000,Z=1.000000)
     AttachPivot=(Pitch=1024,Yaw=-16000,Roll=14000)
     Health=525
     HurtThreshold=40
     MaxProtection=225
     PickupClass=Class'JWVanDE.JWVan_sh_fenderPickup'
     PlayerViewOffset=(X=-10.000000,Y=16.000000)
     AttachmentClass=Class'JWVanDE.JWVan_sh_fenderAttachment'
     ItemName="Bumper"
}
