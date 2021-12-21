//=============================================================================
// AK91ChargeRifle.
//
// A dangerously reverse engineered amp/supercharger gun.
// Primary fire does damage, increases gun heat, and supercharges enemies.
// At high heat, use alt fire to fire a supercharger blast! This'll blow them up...
// ...and probably you too.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AK91ChargeRifle extends BallisticWeapon;

//Gun Heat
var float		HeatLevel;			// Current Heat level, duh...
var() Sound		OverHeatSound;		// Sound to play when it overheats
var() Sound		HighHeatSound;		// Sound to play when heat is dangerous
var Actor GlowFX;

var   Emitter		LaserDot;
var   bool			bLaserOn;
var bool		bFirstDraw;

var name			BulletBone;
var name			BulletBone2;

var   AK91_ChargeControl	ChargeControl;

replication
{
	reliable if (ROLE==ROLE_Authority)
		ClientSetHeat, ChargeControl;
}


// ====================================
// Heat stuff
//=====================================

simulated function float ChargeBar()
{
	return HeatLevel / 10;
}
simulated event Tick (float DT)
{
	if (HeatLevel > 0)
	{
			Heatlevel = FMax(HeatLevel - 0.35 * DT, 0);
	}

	super.Tick(DT);
}


simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (HeatLevel >= 5 && Instigator.IsLocallyControlled() && GlowFX == None && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GlowFX == None || GlowFX.bDeleteMe))
		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'HMCBarrelGlow', DrawScale, self, 'tip3');
	else if (HeatLevel < 5)
	{
		if (GlowFX != None)
			Emitter(GlowFX).kill();
	}
	
//	if (GlowFX != None)
//		HMCBarrelGlow(GlowFX).ScaleEmitter(HMCBarrelGlow(GlowFX),HeatLevel/10);

}

simulated function AddHeat(float Amount)
{

	HeatLevel += Amount;
	
	if (HeatLevel >= 9.5)
	{
		Heatlevel = 12;
        BallisticInstantFire(FireMode[0]).FireRate=0.210000;
		//PlaySound(OverHeatSound,,3.7,,32);
		//class'BallisticDamageType'.static.GenericHurt (Instigator, 10, Instigator, Instigator.Location, -vector(Instigator.GetViewRotation()) * 30000 + vect(0,0,10000), class'DTPlasmaCannonOverheat');
	}
	if (HeatLevel >= 5.0)
	{
		PlaySound(HighHeatSound,,1.0*(HeatLevel/10),,32);
	}
	
	else if (Heatlevel <=0 )
	{
        BallisticInstantFire(FireMode[0]).FireRate=BallisticInstantFire(FireMode[0]).default.FireRate;
		Heatlevel = 0;
	}

}

simulated function ClientSetHeat(float NewHeat)
{
	HeatLevel = NewHeat;
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
    local bool bPossiblySwitch, bJustSpawned;

    Instigator = Other;
    W = Weapon(Other.FindInventoryType(class));
    if ( W == None )
    {
		bJustSpawned = true;
        Super(Inventory).GiveTo(Other);
        bPossiblySwitch = true;
        W = self;
		if (Pickup != None && BallisticWeaponPickup(Pickup) != None)
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
		if (AK91Pickup(Pickup) != None)
			HeatLevel = FMax( 0.0, AK91Pickup(Pickup).HeatLevel - (level.TimeSeconds - AK91Pickup(Pickup).HeatTime) * 0.25 );
		if (level.NetMode == NM_ListenServer || level.NetMode == NM_DedicatedServer)
			ClientSetHeat(HeatLevel);
    }
    else if ( !W.HasAmmo() )
	    bPossiblySwitch = true;

    if ( Pickup == None )
        bPossiblySwitch = true;

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if ( FireMode[m] != None )
        {
            FireMode[m].Instigator = Instigator;
            GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }

	if ( (Instigator.Weapon != None) && Instigator.Weapon.IsFiring() )
		bPossiblySwitch = false;

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}

//==========================================
// Supercharging stuff
//==========================================


simulated function PostNetBeginPlay()
{
	local AK91_ChargeControl FC;

	super.PostNetBeginPlay();
	if (Role == ROLE_Authority && ChargeControl == None)
	{
		foreach DynamicActors (class'AK91_ChargeControl', FC)
		{
			ChargeControl = FC;
			return;
		}
		ChargeControl = Spawn(class'AK91_ChargeControl', None);
	}
}

function AK91_ChargeControl GetChargeControl()
{
	return ChargeControl;
}

//==========================================
function ConicalBlast(float DamageAmount, float DamageRadius, vector Aim)
{
 local actor Victims;
 local float damageScale, dist;
 local vector dir;

 if( bHurtEntry )
  return;

 bHurtEntry = true;
 foreach CollidingActors( class 'Actor', Victims, DamageRadius, Location )
 {
  if( (Victims != Instigator) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) )
  {
   if ( Aim dot Normal (Victims.Location - Location) < 0.5)
    continue;
   
   if (!FastTrace(Victims.Location, Location))
    continue;
    
   dir = Victims.Location - Location;
   dist = FMax(1,VSize(dir));


   dir = dir/dist;
   damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
   class'BallisticDamageType'.static.GenericHurt
   (
    Victims,
    damageScale * DamageAmount * Heatlevel,
    Instigator,
    Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
    vect(0,0,0),
    class'DTA49Shockwave'
   );
   
   if(Pawn(Victims) != None && Pawn(Victims).bProjTarget)
    Pawn(Victims).AddVelocity(vect(0,0,200) + (Normal(Victims.Acceleration) * -FMin(Pawn(Victims).GroundSpeed, VSize(Victims.Velocity)) + Normal(dir) * 3000 * damageScale));
      
   if (Instigator != None && Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
    Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, Instigator.Controller, class'DTA49Shockwave', 0.0f, Location);
  }
 }
 bHurtEntry = false;
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	if (Anim == 'Fire' || Anim == 'ReloadEmpty')
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 2)
		{
			SetBoneScale(2,0.0,BulletBone);
			SetBoneScale(3,0.0,BulletBone2);
		}
	}
	super.AnimEnd(Channel);
}



simulated function BringUp(optional Weapon PrevWeapon)
{

	if (bFirstDraw && MagAmmo > 0)
	{
     	BringUpTime=2.0;
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

		SetBoneScale(2,0.0,BulletBone);
		SetBoneScale(3,0.0,BulletBone2);
		ReloadAnim = 'ReloadEmpty';
	}
	else
	{
		ReloadAnim = 'Reload';
	}

	super.BringUp(PrevWeapon);
	SoundPitch = 56;

}

simulated function Destroyed()
{
	if (GlowFX != None)
		GlowFX.Destroy();
	super.Destroyed();
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockSim()
{
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}


simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}


simulated function PlayReload()
{
    if (MagAmmo < 1)
    {
       ReloadAnim='ReloadEmpty';
    }
    else
    {
       ReloadAnim='Reload';
    }

	SafePlayAnim(ReloadAnim, ReloadAnimRate, , 0, "RELOAD");
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipUp()
{
	SetBoneScale(2,1.0,BulletBone);
	SetBoneScale(3,1.0,BulletBone2);
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();

	if(MagAmmo < 1)
	{
	SetBoneScale(2,0.0,BulletBone);
	SetBoneScale(3,0.0,BulletBone2);
	}
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
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	/*if (B.Skill > Rand(6))
	{
		if (Chaos < 0.1 || Chaos < 0.5 && VSize(B.Enemy.Location - Instigator.Location) > 500)
			return 1;
	}*/
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
     bShowChargingBar=True
     OverHeatSound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Overload'
	 HighHeatSound=Sound'BWBP_SKC_Sounds.Misc.CXMS-FireSingle'
     UsedAmbientSound=Sound'BW_Core_WeaponSound.A73.A73Hum1'
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWBP_SKC_Tex.AK91.BigIcon_AK91'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     BulletBone="Bullet1"
     BulletBone2="Bullet2"
     bWT_Bullet=True
     SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;0.5;0.8;0.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
     MagAmmo=30
     CockAnimPostReload="ReloadEndCock"
     CockSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-Cock',Volume=1.500000)
     ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-ClipHit',Volume=1.500000)
     ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-ClipOut',Volume=1.500000)
     ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-ClipIn',Volume=1.500000)
     ClipInFrame=0.650000
     bNeedCock=False
     bCockOnEmpty=False
     bNoCrosshairInScope=True
     WeaponModes(0)=(bUnavailable=True,ModeID="WM_None")
     WeaponModes(1)=(ModeName="Semi-Auto",Value=1.000000)
     CurrentWeaponMode=2
     SightPivot=(Pitch=64)
     SightOffset=(X=-5.000000,Y=-10.020000,Z=20.600000)
     SightDisplayFOV=20.000000
	 ParamsClasses(0)=Class'AK91ChargeRifleWeaponParamsArena'
     SightingTime=0.300000
     FireModeClass(0)=Class'BWBP_SKCExp_Pro.AK91PrimaryFire'
     FireModeClass(1)=Class'BWBP_SKCExp_Pro.AK91SecondaryFire'
     BringUpTime=0.900000
     PutDownTime=0.700000
     IdleAnimRate=0.400000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     Description="AK-91 Charge Rifle||Manufacturer: Zavod Tochnogo Voorujeniya (ZTV Export)|Primary: 7.62 AP Rounds|Secondary: Emergency Vent||Chambering 7.62mm armor piercing rounds, this rifle is a homage to its' distant predecessor, the AK-47. Though the weapons' looks have hardly changed at all, this model features a vastly improved firing mechanism, allowing it to operate in the most punishing of conditions. Equipped with a heavy reinforced stock, launchable ballistic bayonet, and 20 round box mag, this automatic powerhouse is guaranteed to cut through anything in its way. ZVT Exports designed this weapon to be practical and very easy to maintain. With its rugged and reliable design, the AK490 has spread throughout the cosmos and can be found just about anywhere."
     Priority=65
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
	 GroupOffset=11
     PickupClass=Class'BWBP_SKCExp_Pro.AK91Pickup'
     PlayerViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBP_SKCExp_Pro.AK91Attachment'
     IconMaterial=Texture'BWBP_SKC_Tex.AK91.SmallIcon_AK91'
     IconCoords=(X2=127,Y2=31)
     ItemName="[B] AK-91 Charge Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_AK91'
     DrawScale=0.350000
     SoundPitch=56
     SoundRadius=32.000000
}
