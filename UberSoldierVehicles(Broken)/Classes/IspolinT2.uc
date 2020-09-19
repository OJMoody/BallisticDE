class IspolinT2 extends DKWeapons;

defaultproperties
{
     MinAim=0.300000
     YawBone="Turret"
     PitchBone="Barrel"
     PitchDownLimit=63000
     WeaponFireAttachmentBone="A"
     RotationsPerSecond=0.250000
     Spread=0.020000
     RedSkin=Shader'DKVehiclesTex.m1.m1'
     BlueSkin=Shader'DKVehiclesTex.m1.m1'
     FireInterval=0.100000
     AltFireInterval=0.120000
     FireSoundClass=Sound'DKoppIISound.Fire.12mm1'
     FireSoundVolume=255.000000
     FireSoundRadius=500.000000
     AltFireSoundClass=Sound'DKoppIISound.Fire.12mm1'
     RotateSound=None
     ProjectileClass=Class'UberSoldierVehicles.PROJ_M1MG'
     AltFireProjectileClass=Class'UberSoldierVehicles.PROJ_M1BG'
     AIInfo(0)=(RefireRate=0.500000)
     AIInfo(1)=(RefireRate=0.500000)
     Mesh=SkeletalMesh'DKVehiclesAnim.m1'
     Skins(0)=Shader'DKVehiclesTex.m1.m1'
     Skins(1)=Shader'DKVehiclesTex.m1.Mount'
}
