//=============================================================================
// JWVan_sh_round.
//
// A medieval round shield.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_sh_round extends JunkShield;

defaultproperties
{
     UpDir=(Yaw=-4096)
     UpCoverage=0.300000
     BlockRate=0.900000
     rating=65.000000
     ShieldPropClass=Class'JWVanDE.JWVan_sh_roundProp'
     AttachOffset=(Y=0.000000,Z=1.000000)
     AttachPivot=(Pitch=1024,Yaw=-16000,Roll=14000)
     Health=700
     HurtThreshold=40
     MaxProtection=250
     PickupClass=Class'JWVanDE.JWVan_sh_roundPickup'
     PlayerViewOffset=(X=0.000000,Y=9.000000,Z=-20.000000)
     AttachmentClass=Class'JWVanDE.JWVan_sh_roundAttachment'
     ItemName="Round Shield"
}
