//=============================================================================
// A51Grenade
// Skrith Acid Grenade
//=============================================================================
class A51Grenade extends BallisticHandGrenade;

#exec OBJ LOAD FILE=..\StaticMeshes\BWBP_SWC_Static.usx
/*
function DoExplosionEffects()
{
}
*/
function DoExplosion()
{
	local A51AcidControl F;
	local Vector V;

	if (Role == Role_Authority)
	{

		SpecialHurtRadius(HeldDamage, HeldRadius, HeldDamageType, HeldMomentum, Location);
		CheckNoGrenades();

		if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
			V = Location;
		//else
			//V = BallisticGrenadeAttachment(ThirdPersonActor).Location;
		F = Spawn(class'A51AcidControl',,,Location, rot(0,0,0));
		F.Instigator = Instigator;
		F.Initialize(vect(0,0,1),8);
	}
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.SkrithGrenadeProj');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.SkrithGrenadePickupHi');

}

simulated function ClientStartReload(optional byte i)
{
	ClipReleaseTime = Level.TimeSeconds+0.2;
	SetTimer(FuseDelay + 0.2, false);

	SpawnSmoke();
	BFireMode[0].EjectBrass();
	class'BUtil'.static.PlayFullSound(self, ClipReleaseSound);

	if(!IsFiring())
		PlayAnim(ClipReleaseAnim, 1.0, 0.1);
}

defaultproperties
{
     HeldDamage=200
     HeldRadius=250
     HeldMomentum=55000
     HeldDamageType=Class'BWBPArchivePackDE.DTA51Held'
     GrenadeSmokeClass=Class'BallisticDE.NRP57Trail'
     ClipReleaseSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806LSight',Volume=1.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     PinPullSound=(Sound=Sound'2K4MenuSounds.Generic.msfxDrag',Volume=5.000000)
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SWC_Tex.Main.BigIcon_SkrithGrenade'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Grenade=True
     SpecialInfo(0)=(Info="0.0;5.0;-999.0;25.0;-999.0;0.0;0.5")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Putaway')
     FireModeClass(0)=Class'BWBPArchivePackDE.A51PrimaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.A51SecondaryFire'
     SelectAnimRate=1.000000
     BringUpTime=2.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000
     Description="A51 Skrith Acid Grenade||Manufacturer: Unknown Skrith Engineers|Primary: Throw Grenade|Secondary: Roll Grenade|Special: Timed Detonation||Based on the same technology and chemicals sported by the A500 'Reptile' gun, the A51 grenade is often used by Skrith who want to wittle down their opponent's armor before attacking up close. Upon detonation, the A51 creates a pool of acid that eats through anything in its way. Whoever designed this clearly took the Skrith saying ''Don't just kill humans, make them suffer first'' to heart."
     Priority=124
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=0
     PickupClass=Class'BWBPArchivePackDE.A51Pickup'
     PlayerViewOffset=(X=8.000000,Y=10.000000,Z=-12.000000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     BobDamping=1.000000
     AttachmentClass=Class'BWBPArchivePackDE.A51Attachment'
     IconMaterial=Texture'BWBP_SWC_Tex.Main.SmallIcon_SkrithGrenade'
     IconCoords=(X2=127,Y2=31)
	 ParamsClass=Class'A51WeaponParams'
     ItemName="AD-51 Reptile Corossive Grenade"
     Mesh=SkeletalMesh'BWBP_SWC_Anims.FPm_SkrithGrenade'
     DrawScale=0.400000
}
