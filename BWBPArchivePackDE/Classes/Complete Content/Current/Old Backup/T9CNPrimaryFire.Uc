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

//Disable fire anim when scoped
/*function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
	// Slightly modified Code from original PlayFiring()
    if (!BW.bScopeView)
        if (FireCount > 0)
        {
            if (Weapon.HasAnim(FireLoopAnim))
                BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
            else
                BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
        }
        else
            BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}*/

defaultproperties
{
     CutOffDistance=1024.000000
     CutOffStartRange=512.000000
	 WaterRangeFactor=0.500000
     Damage=18.000000
     DamageHead=23.000000
     DamageLimb=15.000000
     RangeAtten=0.500000
     WaterRangeAtten=0.600000
     DamageType=Class'BWBPArchivePackDE.DTT9CN'
     DamageTypeHead=Class'BWBPArchivePackDE.DTT9CNHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DTT9CN'
     KickForce=5000
     PenetrateForce=180
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'BallisticSounds3.Misc.ClipEnd-2',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryPistol',Volume=0.700000)
     bDryUncock=True
     MuzzleFlashClass=Class'BWBPArchivePackDE.T9CNFlashEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BallisticDE.Brass_Pistol'
     BrassOffset=(X=-25.000000,Z=-5.000000)
	 AimedFireAnim='Fire'
     RecoilPerShot=80.000000
     XInaccuracy=8.000000
     YInaccuracy=8.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4.T9CN.T9CN-FireOld',Volume=1.300000)
     bPawnRapidFireAnim=True
     FireRate=0.08000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_9mmT9CN'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=8000.000000,Y=8000.000000,Z=8000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
}
