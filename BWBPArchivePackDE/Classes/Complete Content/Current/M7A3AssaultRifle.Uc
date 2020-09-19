//=============================================================================
// CommandoAssaultRifle.
//
// Highly compact, but innacurate assault rifle with switchable stock,
// lasersight, large mag, quick reloading and red-dot sights.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class M7A3AssaultRifle extends BallisticWeapon;

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	if (SightingState != SS_None && Type != 1)
		TemporaryScopeDown(0.5);
}

// Secondary fire doesn't count for this weapon
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
function byte BestMode()	{	return 0;	}

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
	Result += (Dist-1000) / 2000;

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}
// End AI Stuff =====

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWWeaponPackArchive-Tex.M7A3.BigIcon_M7A3'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="340.0;30.0;1.2;60.0;0.9;0.0;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.R78.R78Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.R78.R78Putaway')
     MagAmmo=40
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BWWeaponPack2Archive-Sounds.M7A3.Cock',Volume=350.500000)
     ClipHitSound=(Sound=Sound'BWWeaponPack2Archive-Sounds.M7A3.Reload3',Volume=350.500000)
     ClipOutSound=(Sound=Sound'BWWeaponPack2Archive-Sounds.M7A3.Reload1',Volume=350.500000)
     ClipInSound=(Sound=Sound'BWWeaponPack2Archive-Sounds.M7A3.Reload2',Volume=350.500000)
     ClipInFrame=0.650000
     WeaponModes(0)=(ModeName="Single Fire")
     WeaponModes(1)=(bUnavailable=True)
     FullZoomFOV=50.000000
     bNoMeshInScope=False
     bNoCrosshairInScope=True
     SightOffset=(X=-10.000000,Y=-0.30000,Z=11.280000)
     SightDisplayFOV=38.000000
     SightingTime=0.250000
	 ReloadAnimRate=1.25
     GunLength=16.000000
     LongGunPivot=(Pitch=2000,Yaw=-1024)
     LongGunOffset=(X=-20.000000,Y=0.000000,Z=-15.000000)
     CrouchAimFactor=0.900000
     JumpOffSet=(Pitch=1000,Yaw=-500)
     JumpChaos=0.300000
     AimAdjustTime=0.350000
     ViewRecoilFactor=0.200000
     ChaosDeclineTime=1.000000
     ChaosSpeedThreshold=1200.000000
	 SprintOffSet=(Pitch=-3000,Yaw=-4000)
     RecoilXCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=0.060000),(InVal=0.150000,OutVal=-0.060000),(InVal=0.200000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000,OutVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=-0.050000),(InVal=0.150000),(InVal=0.200000,OutVal=0.300000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilMax=3840.000000
     RecoilDeclineTime=0.800000
	 RecoilDeclineDelay=0.120000
     FireModeClass(0)=Class'BWBPArchivePackDE.M7A3PrimaryFire'
     FireModeClass(1)=Class'BCoreDE.BallisticScopeFire'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bSniping=True
     Description="M7A3 Assault Rifle||Manufacturer: UTC Defense Tech|Primary: Automatic 4.77mm Fire|Secondary: Activate Zooming Scope||The M7A3 Assault Rifle, made by UTC Defense Tech, is one of the newer additions to the modern day battlefield. Using a special bullpup magazine and specialized 4.77mm rounds, the M7A3 can accurately pick off long range targets with ease. The low recoil and good controllability of the rounds more than make up for their subpar damage ratings, and soldiers on average can bring twice as many clips into the field with minimal added fatigue. The M7A3 is a good alternative for those who deem the M50 uncontrollable and who dislike its tendency to buck when firing."
     DisplayFOV=55.000000
     Priority=33
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
	 InventorySize=12
     PickupClass=Class'BWBPArchivePackDE.M7A3Pickup'
     PlayerViewOffset=(X=10.000000,Y=5.500000,Z=-7.000000)
     AttachmentClass=Class'BWBPArchivePackDE.M7A3Attachment'
     IconMaterial=Texture'BWWeaponPackArchive-Tex.M7A3.SmallIcon_M7A3'
     IconCoords=(X2=127,Y2=35)
     ItemName="M7A3 Sub-Machine Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BWWeaponPackAnims.M7A3_FPm'
     DrawScale=1.0000000
}
