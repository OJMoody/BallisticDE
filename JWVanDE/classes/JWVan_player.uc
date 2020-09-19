//=============================================================================
// Player.
//
// An mp3player.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_player extends JunkObject;

var Actor PlrDmgr;

//Spawns in a timed radius damaging actor and attaches it to the Instigator.
function bool SendFireEffect(WeaponFire Fire, JunkFireInfo FI, Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
 if (PlrDmgr != None)
  return true;
 PlrDmgr = Weapon.Instigator.Spawn(class'JWVan_PlayerDamager',Weapon.Instigator);
 return false;
}

defaultproperties
{
     HandOffset=(X=2.000000,Z=-6.000000)
     PickupMesh=StaticMesh'JWVanStatic.playerLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Walkman. D-d-d-d-drop the bass!"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'JWVanStatic.Player'
     RightGripStyle=GS_Capacitor
     AttachOffset=(Z=1.500000)
     AttachPivot=(Yaw=-2548,Roll=-800)
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=1000.000000,Max=1000.000000)
         SwipePoints(0)=(Weight=1,offset=(Pitch=-16384))
         ImpactManager=Class'JWVanDE.IM_player'
         HookStopFactor=1.000000
         Damage=(head=110,Limb=30,Misc=45)
         KickForce=8000
         DamageType=Class'JWVanDE.DTplayer'
         RefireTime=1.000000
         AnimRate=0.000001
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'JWVanDE.JWVan_player.JunkFireInfo0'

     SelectSound=(Sound=SoundGroup'JunkWarSounds.Misc.Pullout-Avg')
     FriendlyName="Walkman"
     InventoryGroup=2
     MeleeRating=67.000000
     RangeRating=0.000000
     PainThreshold=55
     StaticMesh=StaticMesh'JWVanStatic.Player'
     DrawScale=1.350000
}
