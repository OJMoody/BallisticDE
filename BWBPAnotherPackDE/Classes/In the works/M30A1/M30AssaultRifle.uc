//=============================================================================
// CYLOUAW.
//
// CYLO Versitile Urban Assault Weapon.
//
// This nasty little gun has all sorts of tricks up its sleeve. Primary fire is
// a somewhat unreliable assault rifle with random fire rate and a chance to jam.
// Secondary fire is a semi-auto shotgun with its own magazine system. Special
// fire utilizes the bayonet in an attack by modifying properties of primary fire
// when activated.
//
// The gun is small enough to allow dual wielding, but because the left hand is
// occupied with the other gun, the shotgun can not be used, so that attack is
// swapped with a melee attack.
//
// by Casey 'Xavious' Johnson, Marc 'Sergeant Kelly' and Azarael
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M30AssaultRifle extends BallisticWeapon;

var   sound		MeleeFireSound;
var() Name		SpinningBarrelBone;
var   float		RotationSpeed, CurrentRotation, DecelerationRate;
var   bool		bLockFire;
var   int 		ModeSpinning;

var() float 	DesiredFireRate, BaseFireRate, DecreasePerFire;

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (MeleeState >= MS_Held)
		Momentum *= 0.5;
	
	super.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

// spin the barrel
simulated function WeaponTick(float dt)
{
	local rotator BT;
	super.WeaponTick(dt);
	
	if (RotationSpeed != 0)
	{
		if (!FireMode[0].bIsFiring && !FireMode[1].bIsFiring)
		{
			//lock firing when the barrel is slowing down
			if (!bLockFire)
				bLockFire = true;
			
			RotationSpeed = FMax(0, RotationSpeed - DecelerationRate);
			
			//unlock firing
			if (RotationSpeed == 0)
				bLockFire = false;
		}
		
		CurrentRotation += RotationSpeed * dt;
	
		BT.Roll = CurrentRotation;
		SetBoneRotation(SpinningBarrelBone, BT);
	}
}

function SetRotationSpeeds(float FireSpinRate)
{
	RotationSpeed = 32768/FireSpinRate;
}

function ServerStartReload (optional byte i)
{
	if (bLockFire)
		return;
	
	super.ServerStartReload(i);
}

simulated function float ChargeBar()
{
	if (ModeSpinning == 0)
		return (RotationSpeed / (32768/DesiredFireRate));
		
	else if (ModeSpinning == 1)
		return (M30SecondaryFire(FireMode[1]).ChargePower);
}

// AI Interface =====
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

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AmmoAmount(1) < 1)
		return 0;
	else if (MagAmmo < 1)
		return 1;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	VDot = Normal(B.Enemy.Velocity) Dot Normal(Instigator.Location - B.Enemy.Location);

	Result = FRand()-0.3;
	// Too far for grenade
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	if (VSize(B.Enemy.Velocity) > 50)
	{
		// Straight lines
		if (Abs(VDot) > 0.8)
			Result += 0.1;
		// Enemy running away
		if (VDot < 0)
			Result -= 0.2;
		else
			Result += 0.2;
	}
	// Higher than enemy
//	if (Height < 0)
//		Result += 0.1;
	// Improve grenade acording to height, but temper using horizontal distance (bots really like grenades when right above you)
	Dist = VSize(B.Enemy.Location*vect(1,1,0) - Instigator.Location*vect(1,1,0));
	if (Height < -100)
		Result += Abs((Height/2) / Dist);

	if (Result > 0.5)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}
// End AI Stuff =====

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
	 BaseFireRate=0.270000
	 DesiredFireRate=0.120000
	 DecreasePerFire=0.016000

	 SpinningBarrelBone="RotatingBarrel"
	 DecelerationRate=768.000000
	 
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticRecolors3TexPro.CYLO.BigIcon_CYLO'
     BigIconCoords=(X1=16,Y1=30)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     ManualLines(0)="Automatic fire. Moderate power, fire rate and recoil."
     ManualLines(1)="Engages the secondary shotgun. Has a shorter range than other shotguns and moderate spread."
     ManualLines(2)="Effective at close to medium range."
     SpecialInfo(0)=(Info="240.0;25.0;0.9;85.0;0.1;0.9;0.4")
     MeleeFireClass=Class'BallisticJiffyPackE.M30MeleeFire'
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway')
     MagAmmo=40
	 ReloadEmptyAnim="Reload"
     CockAnimPostReload="Cock"
     CockAnimRate=1.400000
     CockSound=(Sound=Sound'BallisticSounds2.M50.M50Cock')
     ClipHitSound=(Sound=Sound'BallisticSounds2.M50.M50ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.M50.M50ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.M50.M50ClipIn')
     ClipInFrame=0.700000
     bAltTriggerReload=True
	 bShowChargingBar=True
     WeaponModes(0)=(bUnavailable=True)
     bNoCrosshairInScope=False
	 SightAimFactor=0.3
     SightPivot=(Pitch=64)
     SightOffset=(X=0.000000,Y=13.600000,Z=19.500000)
     SightDisplayFOV=25.000000
     GunLength=16.000000
     CrouchAimFactor=1
     SprintOffSet=(Pitch=-3000,Yaw=-8000)
     AimAdjustTime=0.400000
	 
     AimSpread=16
     ChaosDeclineTime=0.5
     ChaosSpeedThreshold=7000.000000
     ChaosAimSpread=768
	 
	 ViewRecoilFactor=0.3
	 RecoilXCurve=(Points=(,(InVal=0.1,OutVal=0.09),(InVal=0.2,OutVal=0.12),(InVal=0.25,OutVal=0.13),(InVal=0.3,OutVal=0.11),(InVal=0.35,OutVal=0.08),(InVal=0.40000,OutVal=0.050000),(InVal=0.50000,OutVal=-0.020000),(InVal=0.600000,OutVal=-0.040000),(InVal=0.700000,OutVal=0.04),(InVal=0.800000,OutVal=0.070000),(InVal=1.000000,OutVal=0.13)))
     RecoilYCurve=(Points=(,(InVal=0.1,OutVal=0.07),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.2600000),(InVal=0.400000,OutVal=0.4000),(InVal=0.500000,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
     RecoilXFactor=0.1
	 RecoilYFactor=0.1
     RecoilDeclineTime=0.4
     RecoilDeclineDelay=0.160000
	 
     FireModeClass(0)=Class'BallisticJiffyPackE.M30PrimaryFire'
     FireModeClass(1)=Class'BallisticJiffyPackE.M30SecondaryFire'
     SelectAnimRate=1.000000
     PutDownAnimRate=1.600000
     PutDownTime=0.330000
     BringUpTime=0.450000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.750000
     CurrentRating=0.750000
	 WeaponModes(1)=(bUnavailable=True)
     Description="Dipheox's most popular weapon, the CYLO Versatile Urban Assault Weapon is designed with one goal in mind: Brutal close quarters combat. The CYLO accomplishes this goal quite well, earning itself the nickname of Badger with its small frame, brutal effectiveness, and unpredictability. UTC refuses to let this weapon in the hands of its soldiers because of its erratic firing and tendency to jam.||The CYLO Versatile UAW is fully capable for urban combat. The rifle's caseless 7.62mm rounds can easily shoot through doors and thin walls, while the shotgun can clear a room quickly with its semi-automatic firing. Proper training with the bayonet can turn the gun itself into a deadly melee weapon."
     DisplayFOV=55.000000
     Priority=41
     HudColor=(G=135)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     GroupOffset=10
     PickupClass=Class'BallisticJiffyPackE.M30Pickup'
     PlayerViewOffset=(X=5.000000,Y=4.750000,Z=-8.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BallisticJiffyPackE.M30Attachment'
     IconMaterial=Texture'BallisticRecolors3TexPro.CYLO.SmallIcon_CYLO'
     IconCoords=(X2=127,Y2=31)
     ItemName="M30 Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBPAnotherPackAnims2.M30_FP'
     DrawScale=0.200000
}
