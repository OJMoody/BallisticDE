class IM_Ammo57AP extends DKIM;

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
     HitEffects(0)=Class'UberSoldierVehicles.FX_AP_SmalMetal'
     HitEffects(1)=Class'UberSoldierVehicles.FX_AP_SmalConcrete'
     HitEffects(2)=Class'UberSoldierVehicles.FX_AP_SmalDirt'
     HitEffects(3)=Class'UberSoldierVehicles.FX_AP_SmalMetal'
     HitEffects(4)=Class'UberSoldierVehicles.FX_AP_SmalDirt'
     HitEffects(5)=Class'UberSoldierVehicles.FX_AP_SmalDirt'
     HitEffects(6)=Class'UberSoldierVehicles.FX_AP_SmalFlesh'
     HitEffects(7)=Class'UberSoldierVehicles.FX_AP_SmalDirt'
     HitEffects(8)=Class'UberSoldierVehicles.FX_AP_SmalDirt'
     HitEffects(10)=Class'UberSoldierVehicles.FX_AP_SmalDirt'
     HitDecals(0)=Class'UberSoldierVehicles.DT_TankExplosionDecalLow'
     HitSounds(0)=SoundGroup'DKoppIISound.Hit.TankMetalHit'
     HitSounds(1)=SoundGroup'DKoppIISound.Hit.ApImpactDirt'
     HitSounds(2)=SoundGroup'DKoppIISound.Hit.ApImpactDirt'
     HitSounds(3)=SoundGroup'DKoppIISound.Hit.TankMetalHit'
     HitSounds(4)=SoundGroup'DKoppIISound.Hit.TankWoodHit'
     HitSounds(9)=SoundGroup'DKoppIISound.Hit.TankWaterHit'
     HitSoundVolume=255.000000
     HitSoundRadius=600.000000
}
