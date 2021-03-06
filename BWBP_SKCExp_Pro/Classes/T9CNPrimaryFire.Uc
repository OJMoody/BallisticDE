//=============================================================================
// XK2PrimaryFire.
//
// Very rapid, weak fire for XK2 SMG. can be silenced to reduce chances of
// detetion and damage of weapon.
//
// SIGHT FIRE CODE - Kaboodles. 
// Pauses fire anims when scoped.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class T9CNPrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=1024.000000
     CutOffStartRange=476.000000
     Damage=14.000000
     RangeAtten=0.500000
     WaterRangeAtten=0.600000
     DamageType=Class'BWBP_SKCExp_Pro.DTT9CN'
     DamageTypeHead=Class'BWBP_SKCExp_Pro.DTT9CNHead'
     DamageTypeArm=Class'BWBP_SKCExp_Pro.DTT9CN'
     KickForce=5000
     PenetrateForce=180
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-2',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryPistol',Volume=0.700000)
     bDryUncock=True
     MuzzleFlashClass=Class'BWBP_SKCExp_Pro.T9CNFlashEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-25.000000,Z=-5.000000)
	 AimedFireAnim="SightFire"
	 FireAnim="Fire"
     FireRecoil=80.000000
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_SoundsExp.T9CN.T9CN-FireOld',Volume=1.300000)
     bPawnRapidFireAnim=True
     FireRate=0.100000
     AmmoClass=Class'BWBP_SKCExp_Pro.Ammo_9mmT9CN'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=8000.000000,Y=8000.000000,Z=8000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
}
