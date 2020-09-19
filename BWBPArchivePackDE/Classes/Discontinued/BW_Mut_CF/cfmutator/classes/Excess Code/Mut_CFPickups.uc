//=============================================================================
// Mut_CFPickups.
//
// by Paul "Grum" Haack.
// Copyright(c) 2013 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class Mut_CFPickups extends Mutator;

var  CFPickupWidget		PendingWidget;
var  CF_PickupTrigger	PendingTrigger;

simulated function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local CF_PickupTrigger BWPickupTrigger;
	local CFPickupWidget widget;
	local bool bRes;

	bRes = Super.CheckReplacement(Other, bSuperRelevant);

	if(BallisticWeaponPickup(Other) != none)
	{
		BWPickupTrigger = Spawn(class'CF_PickupTrigger',Other ,, Other.Location);
		BWPickupTrigger.bwPickUp = BallisticWeaponPickup(Other);
		BWPickupTrigger.SetBase(Other);
		BWPickupTrigger.SetCollisionSize(Other.CollisionRadius, Other.CollisionHeight);

		widget = Spawn(class'CFPickupWidget');
		widget.bwPickUp = BallisticWeaponPickup(Other);
		widget.InitWidget(); // initialize the widget with some stuff it needs to know

		BWPickupTrigger.widget = widget;  // the widget will be destroyed by the pickup trigger

		BallisticWeaponPickup(Other).SetCollision(false);

		if(PendingWidget != none)
			Timer();

		PendingWidget = widget;
		PendingTrigger = BWPickupTrigger;
		SetTimer(0.1, false);

	}
	return bRes;
}

simulated event Timer()
{
	super.Timer();

	if (PendingWidget == None || PendingTrigger == None)
		return;

	PendingWidget.magAmmo = PendingWidget.bwPickUp.MagAmmo; // time to replicate the mag ammo
	PendingWidget.InitWidget(); // server side

	PendingTrigger.InitTrigger();

	PendingWidget = none;
}

defaultproperties
{
     bAddToServerPackages=True
     FriendlyName="Crazy-Froggers | Pickups"
     Description="This Mutator enables Far Cry 2 alike weapon pickups and Borderlands alike overlays for the thrown pickups."
}
