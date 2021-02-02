//=============================================================================
// BRINKAttachment.
//=============================================================================
class BRINKAttachment extends BallisticAttachment;

var	  BallisticWeapon		myWeap;
var Vector		SpawnOffset;

function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
}

defaultproperties
{
     MuzzleFlashClass=Class'BWBPAnotherPackDE.BRINKFlashEmitter'
     AltMuzzleFlashClass=Class'BallisticDE.XK2SilencedFlash'
     ImpactManager=Class'BallisticDE.IM_Bullet'
     FlashScale=0.250000
     BrassClass=Class'BallisticDE.Brass_Rifle'
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BallisticDE.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticDE.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.9000
	 CockingAnim="Cock_RearPull"
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BWBP_SWC_Anims.BRINK_TPm'
     DrawScale=1.000000
}
