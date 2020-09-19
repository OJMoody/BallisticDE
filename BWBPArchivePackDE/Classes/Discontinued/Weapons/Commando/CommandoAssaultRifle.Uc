//=============================================================================
// CommandoAssaultRifle.
//
// Highly compact, but innacurate assault rifle with switchable stock,
// lasersight, large mag, quick reloading and red-dot sights.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class CommandoAssaultRifle extends BallisticWeapon;


// This uhhh... thing is added to allow manual drawing of brass OVER the muzzle flash
struct UziBrass
{
	var() actor Actor;
	var() float KillTime;
};
var   array<UziBrass>	UziBrassList;


static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_CommandoClip';
}

// Secondary fire doesn't count for this weapon
simulated function bool HasAmmo()
{
	//First Check the magazine
	if (!bNoMag && FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
		return true;
	return false;	//This weapon is empty
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	return 0;
}
function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	if (Dist > 700)
		Result += 0.3;
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result -= 0.05 * B.Skill;
	if (Dist > 2000)
		Result -= (Dist-2000) / 4000;

	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.1;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticTextures3.ui.BigIcon_SAR12'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     SpecialInfo(0)=(Info="240.0;25.0;0.8;90.0;0.0;1.0;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway')
     CockAnimPostReload="ReloadEndCock"
     CockSound=(Sound=Sound'BallisticSounds3.SAR.SAR-Cock')
     ClipOutSound=(Sound=Sound'BallisticSounds3.SAR.SAR-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds3.SAR.SAR-ClipIn')
     ClipInFrame=0.650000
     SightPivot=(Pitch=50)
     SightOffset=(x=-21.000000,y=9.580000,Z=11.7500000)
     SightDisplayFOV=40.000000
     GunLength=16.000000
     LongGunPivot=(Pitch=2000,Yaw=-1024)
     LongGunOffset=(X=-20.000000,Y=0.000000,Z=-15.000000)
     CrouchAimFactor=0.900000
     JumpOffSet=(Pitch=1000,Yaw=-500)
     JumpChaos=0.300000
     AimAdjustTime=0.400000
     ViewAimFactor=0.050000
     ViewRecoilFactor=0.200000
     ChaosDeclineTime=1.000000
     ChaosSpeedThreshold=1200.000000
     RecoilXCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=0.060000),(InVal=0.150000,OutVal=-0.060000),(InVal=0.200000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000,OutVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=-0.050000),(InVal=0.150000),(InVal=0.200000,OutVal=0.300000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilMax=3840.000000
     RecoilDeclineTime=0.800000
     FireModeClass(0)=Class'BWBPArchivePackDE.CommandoPrimaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.CommandoSecondaryFire'
     SelectForce="SwitchToAssaultRifle"
     Description="Commando Assault Weapon||Manufacturer: UTC Defense Tech|Primary: Select Fire 5.56mm||Whatever this gun once was, it has long since been damaged beyond recognition. Amazingly it still fires."
     DisplayFOV=55.000000
     Priority=32
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     PickupClass=Class'BWBPArchivePackDE.CommandoPickup'
     PlayerViewOffset=(X=8.000000,Z=-9.000000)
     AttachmentClass=Class'BWBPArchivePackDE.CommandoAttachment'
     IconMaterial=Texture'BallisticTextures3.ui.SmallIcon_SAR12'
     IconCoords=(X2=127,Y2=31)
     ItemName="Commando Assault Weapon"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BWWeaponPackAnims.552'
     DrawScale=0.300000
}
