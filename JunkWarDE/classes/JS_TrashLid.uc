//=============================================================================
// JS_TrashLid.
//
// An old trash can lid. The Classic shield...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JS_TrashLid extends JunkShield;

defaultproperties
{
     UpDir=(Yaw=-4096)
     UpCoverage=0.325000
     BlockRate=0.500000
     rating=45.000000
     ShieldPropClass=Class'JunkWarDE.JS_TrashLidProp'
     Health=400
     HurtThreshold=30
     MinProtection=80
     PickupClass=Class'JunkWarDE.JS_TrashLidPickup'
     AttachmentClass=Class'JunkWarDE.JS_TrashLidAttachment'
     ItemName="Trash Can Lid"
}
