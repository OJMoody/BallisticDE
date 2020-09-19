//=============================================================================
// CFMACWeapon.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFMACWeapon extends MACWeapon;

simulated function Notify_Deploy ()
{
	local vector HitLoc, HitNorm, Start, End;
	local actor T;
	local BallisticTurret Turret;
	local float Forward;

	FireMode[1].bIsFiring = false;
   	FireMode[1].StopFiring();
	if (Role < ROLE_Authority || Instigator.HeadVolume.bWaterVolume)
	{
		PlayIdle();
		return;
	}
	// Trace forward and then down. make sure turret is being deployed:
	//   on world geometry, at least 30 units away, on level ground, not on the other side of an obstacle
	Start = Instigator.Location + Instigator.EyePosition();
	for (Forward=75;Forward>=45;Forward-=15)
	{
		End = Start + vector(Instigator.Rotation) * Forward;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(6,6,6));
		if (T != None && VSize(HitLoc - Start) < 30)
		{
			PlayIdle();
			return;
		}
		if (T == None)
			HitLoc = End;
		End = HitLoc - vect(0,0,100);
		T = Trace(HitLoc, HitNorm, End, HitLoc, true, vect(6,6,6));
		if (T != None && T.bWorldGeometry && HitNorm.Z >= 0.7 && FastTrace(HitLoc, Start))
			break;
		if (Forward <= 45)
		{
			PlayIdle();
			return;
		}
	}

	HitLoc.Z += class'CFMutator.CFMACTurret'.default.CollisionHeight - 9;
	Turret = Spawn(class'CFMutator.CFMACTurret', None,, HitLoc, Instigator.Rotation);
	if (Turret != None)
	{
		Turret.InitDeployedTurretFor(self);

		PlaySound(DeploySound, Slot_Interact, 0.7,,64,1,true);
		Turret.TryToDrive(Instigator);
		Destroy();
	}
	else
		log("Notify_Deploy: Could not spawn turret for HAMR Cannon", 'Warning');
}

simulated event RenderOverlays (Canvas C)
{
 	Super(BallisticWeapon).RenderOverlays( C );
 	if (bScopeView)
 	{
  		DrawHAMRScope( C );
 	}
}

defaultproperties
{
     PickupClass=Class'cfmutator.CFMACPickup'
}
