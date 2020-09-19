//=============================================================================
// M30A2AssaultRifle.
//
// M30A2 Assault Rifle, aka thez Z. Med fire rate, good damage, high accuracy, good range, Burst, Semi-Auto
// Has underslung
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MG33MachineGun extends BallisticWeapon;

var float BladeAlpha;
var float DesiredBladeAlpha;
var float BladeShiftSpeed;

var ChainsawPanner ChainsawPanner;
var float ChainSpeed;

var bool bLatchedOn;

simulated event WeaponTick(float DT)
{
	local float AccelLimit;
	super.WeaponTick(DT);

	if (Role == ROLE_Authority)
	{
        if (FireMode[0].IsFiring())
    	{
    		DesiredBladeAlpha = 0;
    		BladeShiftSpeed = 4; //4

    		if (BladeAlpha <= 0)
    		{
    			if (bLatchedOn && ChainSpeed != 1.5)
    			{
    				AccelLimit = (0.5 + 4.0*(ChainSpeed/2))*DT;
    				ChainSpeed += FClamp(1.5 - ChainSpeed, -AccelLimit, AccelLimit);
    			}
    			else if (!bLatchedOn && ChainSpeed != 2)
    			{
    				AccelLimit = (0.5 + /*2.0*(*/ChainSpeed/*/2)*/)*DT;
    				ChainSpeed += FClamp(2 - ChainSpeed, -AccelLimit, AccelLimit);
    			}
    		}
    	}

        if (FireMode[1].IsFiring())
    	{
    		DesiredBladeAlpha = 0;
    		BladeShiftSpeed = 4;

    		if (BladeAlpha <= 0)
    		{
    			if (bLatchedOn && ChainSpeed != 1.5)
    			{
    				AccelLimit = (0.5 + 4.0*(ChainSpeed/2))*DT;
    				ChainSpeed += FClamp(3.5 - ChainSpeed, -AccelLimit, AccelLimit);
    			}
    			else if (!bLatchedOn && ChainSpeed != 2)
    			{
    				AccelLimit = (0.5 + /*2.0*(*/ChainSpeed/*/2)*/)*DT;
    				ChainSpeed += FClamp(5 - ChainSpeed, -AccelLimit, AccelLimit);
    			}
    		}
    	}

	if (DesiredBladeAlpha == 0)
		SoundPitch = 32 + 32 * ChainSpeed;
	else
		SoundPitch = default.SoundPitch;

	if (ChainsawPanner!=None)
		ChainsawPanner.PanRate = -ChainSpeed;
    }
	
	if (!Instigator.IsLocallyControlled())
		return;
}

simulated function PlayIdle()
{
	super.PlayIdle();
	if (ChainSpeed <=0)
	{
		DesiredBladeAlpha = 1;
		BladeShiftSpeed = 3;
	}
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		DesiredBladeAlpha = 0;
		BladeShiftSpeed = 3;
//		SetBladesOpen(1);
		return true;
	}
	return false;
}

simulated function Destroyed()
{
 	if (ChainsawPanner!=None)
 		level.ObjectPool.FreeObject(ChainsawPanner);
	super.Destroyed();
}

simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 250)
		return 0;
	if (Dist < FireMode[1].MaxRange() && FRand() > 0.3)
		return 1;
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0 && (VSize(B.Enemy.Velocity) < 100 || Normal(B.Enemy.Velocity) dot Normal(Instigator.Velocity) < 0.5))
		return 1;
	return Rand(2);
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
	if (!HasMagAmmo(0) && Ammo[0].AmmoAmount < 1)
	{
		if (Dist > 400)
			return 0;
		return Result / (1+(Dist/400));
	}
	// Enemy too far away
	if (Dist > 1000)
		Result -= (Dist-1000) / 2000;
	// If the enemy has a knife too, a gun looks better
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result += 0.1 * B.Skill;
	// Sniper bad, very bad
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bSniping && Dist > 500)
		Result -= 0.3;
	Result += 1 - Dist / 1000;

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 7;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = -1 * (B.Skill / 6);
	Result *= (1 - (Dist/4000));
    return FClamp(Result, -1.0, -0.3);
}
// End AI Stuff =====

defaultproperties
{
     PlayerSpeedFactor=1.050000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture''
     BallisticInventoryGroup=6
     SightFXClass=Class'BallisticDE.M50SightLEDs'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;0.8;0.5;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway')
     MagAmmo=6
     InventorySize=40
     CockAnimPostReload="ReloadEndCock"
     CockSound=(Sound=Sound'BallisticSounds2.M50.M50Cock')
     ClipHitSound=(Sound=Sound'BallisticSounds2.M50.M50ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.M50.M50ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.M50.M50ClipIn')
     ClipInFrame=0.650000
     bNeedCock=True
     WeaponModes(0)=(ModeName="Semi-Automatic")
     CurrentWeaponMode=2
     bNoCrosshairInScope=true
     FullZoomFOV=45.000000
     ChaosDeclineTime=1.500000
     RecoilDeclineDelay=0.3
	 RecoilDeclineTime=2.2
	 RecoilMax=1600
     bNoMeshInScope=False
     SightPivot=(Pitch=600,Roll=-1024)
     SightOffset=(X=-1.000000,Y=-1.000000,Z=11.600000)
     SightDisplayFOV=20.000000
     CrouchAimFactor=0.500000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     ViewAimFactor=0.300000
     ViewRecoilFactor=0.700000
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilYawFactor=0.300000
     RecoilXFactor=0.200000
     RecoilYFactor=0.200000
     FireModeClass(0)=Class'BWBPAnotherPackDE.JohnsonPrimaryFire'
     FireModeClass(1)=Class'BWBPAnotherPackDE.JohnsonSecondaryFire'
     PutDownTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     Description="MARS-2 Assault Rifle||Manufacturer: Enravion Combat Solutions|Primary: Accurate Rifle Fire|Secondary: Charged Gauss Fire|Special: Laser Dot||A further improvement on their crowning achievement, the M30A1 is the long range version of the famed rifle. With a forward mounted laser sight and heavy 7.62 rifle rounds, the M30A1 Tactical Rifle can accurately snipe targets at any distance. In order to compensate for the slower firing speed and increased recoil, Enravion added a secondary gauss projectile accelerator to the barrel. By simply depressing the trigger twice in quick succession, the user can activate the system and propel the bullet at a much higher velocity through the armor and flesh of unsuspecting victims. (With regards to a 2 second recharge time.) The A1 comes equipped with a mounted camera sight for increased accuracy."
     Priority=65
     InventoryGroup=8
     PickupClass=Class'BWBPAnotherPackDE.JohnsonPickup'
     PlayerViewOffset=(X=0.500000,Y=6.000000,Z=-8.200000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBPAnotherPackDE.JohnsonAttachment'
     IconMaterial=Texture''
     IconCoords=(X2=127,Y2=31)
     ItemName="Johnson 71 'Hell Shredder' Stake Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBPAnotherPackAnims.FPm_Johnson'
     DrawScale=0.350000

}
