class IM_AmmoMiniAP extends DKIM;

/*
	EST_Default,	0
	EST_Concrete,		1
	EST_Dirt,		2
	EST_Metal,		3
	EST_Wood,		4
	EST_Plant,		5
	EST_Flesh,		6
    EST_Ice,		7
    EST_Snow,		8
    EST_Water,		9
    EST_Glass,		10
*/

defaultproperties
{
     HitEffects(0)=Class'UberSoldierVehicles.FX_AP_30mmMetal'
     HitEffects(1)=Class'UberSoldierVehicles.FX_AP_SmalConcrete'
     HitEffects(2)=Class'UberSoldierVehicles.FX_AP_VerySmalDirt'
     HitEffects(3)=Class'UberSoldierVehicles.FX_AP_30mmMetal'
     HitEffects(4)=Class'UberSoldierVehicles.FX_AP_VerySmalDirt'
     HitEffects(5)=Class'UberSoldierVehicles.FX_AP_VerySmalDirt'
     HitEffects(6)=Class'UberSoldierVehicles.FX_AP_VerySmalDirt'
     HitEffects(7)=Class'UberSoldierVehicles.FX_AP_VerySmalDirt'
     HitEffects(8)=Class'UberSoldierVehicles.FX_AP_VerySmalDirt'
     HitEffects(10)=Class'UberSoldierVehicles.FX_AP_SmalDirt'
     HitDecals(0)=Class'BallisticDE.AD_BulletConcrete'
     HitDecals(1)=Class'BallisticDE.AD_BulletConcrete'
     HitDecals(2)=Class'BallisticDE.AD_BulletDirt'
     HitDecals(3)=Class'BallisticDE.AD_BulletMetal'
     HitDecals(4)=Class'BallisticDE.AD_BulletWood'
     HitDecals(5)=Class'BallisticDE.AD_BulletConcrete'
     HitDecals(6)=Class'BallisticDE.AD_BulletConcrete'
     HitDecals(7)=Class'BallisticDE.AD_BulletIce'
     HitDecals(8)=Class'BallisticDE.AD_BulletDirt'
     HitDecals(10)=Class'BallisticDE.AD_BulletConcrete'
     HitSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(1)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(2)=SoundGroup'BallisticSounds2.BulletImpacts.BulletDirt'
     HitSounds(3)=SoundGroup'BallisticSounds2.BulletImpacts.BulletMetal'
     HitSounds(4)=SoundGroup'BallisticSounds2.BulletImpacts.BulletDirt'
     HitSounds(5)=SoundGroup'BallisticSounds2.BulletImpacts.BulletDirt'
     HitSounds(6)=SoundGroup'BallisticSounds2.BulletImpacts.BulletDirt'
     HitSounds(7)=SoundGroup'BallisticSounds2.BulletImpacts.BulletDirt'
     HitSounds(8)=SoundGroup'BallisticSounds2.BulletImpacts.BulletDirt'
     HitSounds(10)=SoundGroup'BallisticSounds2.BulletImpacts.BulletDirt'
     HitSoundVolume=255.000000
     HitSoundRadius=100.000000
}
