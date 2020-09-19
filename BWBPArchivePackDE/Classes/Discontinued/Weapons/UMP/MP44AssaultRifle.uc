//=============================================================================
// M30A2AssaultRifle.
//
// M30A2 Assault Rifle, aka thez Z. Med fire rate, good damage, high accuracy, good range, Burst, Semi-Auto
// Has underslung
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MP44AssaultRifle extends BallisticWeapon;

var   Emitter		LaserDot;
var   bool			bLaserOn;
var   bool		bFirstDraw;
var() name		RangeBone;			
//var() name		SightBone;			
var() name		ShieldEmitterBone;			
var() name		ShieldBone;			

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (Instigator != None && AIController(Instigator.Controller) != None)
	{
		AimSpread *= 0.30;
		ChaosAimSpread *= 0.10;
	}
	SetBoneScale (0, 0.0, ShieldBone);
	SetBoneScale (1, 0.0, ShieldEmitterBone);
	SetBoneScale (2, 0.0, RangeBone);
	SetBoneScale (3, 0.0, SightBone);



//	AttachToBone(PumaShieldEffect, ShieldBone);

	if (bFirstDraw && MagAmmo > 0)
	{
     		BringUpTime=default.BringUpTime*2;
     		SelectAnim='PulloutFancy';
		bFirstDraw=false;
	}
	else
	{
     		BringUpTime=default.BringUpTime;
		SelectAnim='Pullout';
	}
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		ReloadAnim = 'ReloadEmpty';
	}
	else
	{
		ReloadAnim = 'Reload';
	}
	

	Super.BringUp(PrevWeapon);

}


simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}

simulated function SetBurstModeProps()
{
	if (CurrentWeaponMode == 1)
	{
		BFireMode[0].FireRate = 0.07;
		BFireMode[0].RecoilPerShot = 320;
		BFireMode[0].FireChaos = 0.30;
	}
	else
	{
//		BFireMode[0].FireRate = BFireMode[0].default.FireRate;
//		BFireMode[0].RecoilPerShot = BFireMode[0].default.RecoilPerShot;
//		BFireMode[0].FireChaos = BFireMode[0].default.FireChaos;
		BFireMode[0].FireRate = 0.16;
		BFireMode[0].RecoilPerShot = 512;
		BFireMode[0].FireChaos = 0.15;
	}
}
simulated function ServerSwitchWeaponMode (byte NewMode)
{
	super.ServerSwitchWeaponMode (NewMode);
	SetBurstModeProps();
}
simulated function TickFireCounter (float DT)
{
    if (CurrentWeaponMode == 1)
    {
        if (!IsFiring() && FireCount > 0 && FireMode[0].NextFireTime - level.TimeSeconds < -0.2)
            FireCount = 0;
    }
    else
        super.TickFireCounter(DT);
}




// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (B.Skill > Rand(6))
	{
		if (Chaos < 0.1 || Chaos < 0.5 && VSize(B.Enemy.Location - Instigator.Location) > 500)
			return 1;
	}
	else if (FRand() > 0.75)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 1-Dist/500;
	else if (Dist < 3000)
		Result += (Dist-1000) / 2000;
	else
		Result = (Result + 0.66) - (Dist-3000) / 2500;
	if (Result < 0.34)
	{
		if (CurrentWeaponMode != 2)
		{
			CurrentWeaponMode = 2;
		}
	}

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     RangeBone="RangeFinder"
     ShieldEmitterBone="Emitter"
     ShieldBone="Shield"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticRecolors5A.PUMA.BigIcon_PUMA'
     SightFXClass=Class'BallisticDE.M50SightLEDs'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;0.5;0.8;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway')
     MagAmmo=24
     CockAnimPostReload="ReloadEndCock"
     CockSound=(Sound=Sound'BallisticSounds3.USSR.USSR-Cock')
     ClipHitSound=(Sound=Sound'PackageSounds4A.AK47.AK47-ClipHit',Volume=3.500000)
     ClipOutSound=(Sound=Sound'PackageSounds4A.AK47.AK47-ClipOut',Volume=3.500000)
     ClipInSound=(Sound=Sound'PackageSounds4A.AK47.AK47-ClipIn',Volume=3.500000)
     ClipInFrame=0.650000
     bNeedCock=True
     CurrentWeaponMode=1
     SightBone="Sight"
     SightPivot=(Yaw=-60)
     SightOffset=(X=-20.000000,Z=13.000000)
     SightDisplayFOV=20.000000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimSpread=(X=(Min=-32.125000,Max=32.125000),Y=(Min=-32.125000,Max=32.125000))
     ViewAimFactor=0.200000
     ViewRecoilFactor=0.600000
     ChaosDeclineTime=0.500000
     ChaosAimSpread=(X=(Min=-2024.000000,Max=2024.000000),Y=(Min=-2024.000000,Max=2024.000000))
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilYawFactor=0.400000
     RecoilXFactor=0.300000
     RecoilYFactor=0.200000
     RecoilMax=2524.000000
     RecoilDeclineTime=1.000000
     RecoilDeclineDelay=0.150000
     FireModeClass(0)=Class'BWBPArchivePackDE.MP44SecondaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.MP44PrimaryFire'
     PutDownTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     Description="[Beta] STR-44 Assault Rifle||Manufacturer: UTC Defense Tech|Primary: 7.62 AP Rounds|Secondary: Stock Smack||Chambering 7.62mm armor piercing rounds, this rifle is a homage to its' predecessor, the AK-47. Though the weapons' looks have hardly changed at all, this model features a vastly improved firing mechanism, allowing it to operate in the most punishing of conditions. Featuring a 30 round magazine, this weapon has automatic and semi-automatic firing modes, as well as a heavy reinforced stock. ZVT Exports designed this weapon to be practical and very easy to maintain. Containing few moving, easy to replace parts, means you can find this weapon anywhere and everywhere."
     Priority=65
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=9
     PickupClass=Class'BWBPArchivePackDE.MP44Pickup'
     PlayerViewOffset=(X=-50.000000,Y=-0.220000,Z=0.700000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBPArchivePackDE.MP44Attachment'
     IconMaterial=Texture'BallisticRecolors5A.PUMA.SmallIcon_PUMA'
     IconCoords=(X2=127,Y2=31)
     ItemName="[B]STR-44 Battle Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBPArchivePack2Anim.PUMA_FP'
     DrawScale=0.350000
}
