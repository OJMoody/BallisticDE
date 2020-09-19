class IM_Ammo85FG extends DKIM;

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
     HitEffects(0)=Class'UberSoldierVehicles.FX_FG_MediumMetal'
     HitEffects(1)=Class'UberSoldierVehicles.FX_FG_MediumConcrete'
     HitEffects(2)=Class'UberSoldierVehicles.FX_FG_MediumDirt'
     HitEffects(3)=Class'UberSoldierVehicles.FX_FG_MediumMetal'
     HitEffects(4)=Class'UberSoldierVehicles.FX_FG_MediumDirt'
     HitEffects(5)=Class'UberSoldierVehicles.FX_FG_MediumDirt'
     HitEffects(6)=Class'UberSoldierVehicles.FX_FG_MediumFlesh'
     HitEffects(7)=Class'UberSoldierVehicles.FX_FG_MediumDirt'
     HitEffects(8)=Class'UberSoldierVehicles.FX_FG_MediumDirt'
     HitEffects(10)=Class'UberSoldierVehicles.FX_FG_MediumDirt'
     HitDecals(0)=Class'UberSoldierVehicles.DT_TankExplosionDecalMedium'
     HitSounds(0)=SoundGroup'DKoppIISound.Hit.TankMetalHit'
     HitSounds(1)=Sound'A.swartiweac'
     HitSounds(2)=Sound'A.swartiweac'
     HitSounds(3)=SoundGroup'DKoppIISound.Hit.TankMetalHit'
     HitSounds(4)=SoundGroup'DKoppIISound.Hit.TankWoodHit'
     HitSounds(9)=SoundGroup'DKoppIISound.Hit.TankWaterHit'
     HitSoundVolume=255.000000
     HitSoundRadius=1500.000000
}
