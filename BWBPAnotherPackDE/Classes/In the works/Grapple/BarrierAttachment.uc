//=============================================================================
// AK47Attachment.
//
// 3rd person weapon attachment for AK47 Battle Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BarrierAttachment extends HandgunAttachment;

var Actor GlowFX;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();

    if (level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GlowFX == None || GlowFX.bDeleteMe))
		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'BarrierSightFX', DrawScale, self, 'tip');
}


simulated event Destroyed()
{
	if (GlowFX != None)
		GlowFX.Destroy();
	super.Destroyed();
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticDE.A42FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticDE.A42FlashEmitter'
     ImpactManager=Class'BallisticDE.IM_A42Projectile'
	 FlashBone="Muzzle"
     BrassMode=MU_None
     TracerMode=MU_None
     InstantMode=MU_None
     FlashMode=MU_Both
     LightMode=MU_Both
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims2.A42-3rd'
     DrawScale=0.080000
}
