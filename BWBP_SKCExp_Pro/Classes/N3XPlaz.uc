//==============================================================================
// Unarmed attack style 1, "Brawling" FIXME
//
// Just an unarmed attack style using various punches. Nothing complicated, just
// some quick jabs for primary fire and a powerful haymaker or uppercut for alt
// fire, which should be useful for knocking the enemy back.
//
// by Casey "Xavious" Johnson
//==============================================================================
class N3XPlaz extends BallisticMeleeWeapon;

var bool			bOverheat;
var() Sound			OverHeatSound;		//For vents
var() Sound			VentingSound;		//For DA MAGNETS
var Sound      		ShieldHitSound;
var float			HeatLevel;			// Current Heat level, duh...
var float			MaxHeat;

var Actor			Arc;				// The top arcs

var   float			MagnetSwitchTime, MagnetSwitchFireRate;
var   name			MagnetOpenAnim;
var   name			MagnetCloseAnim;
var   name			MagnetForceCloseAnim;
var   bool			bMagnetOpen;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientSetHeat;
}

simulated event Destroyed()
{
	if (Arc != None)
		Arc.Destroy();
		
	Super.Destroyed();
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	bMagnetOpen=false;
	
	Super.BringUp(PrevWeapon);
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		if (bMagnetOpen)
		{
			bMagnetOpen=false;
			AdjustMagnetProperties();
		}
		if (Arc != None)	Arc.Destroy();
		return true;
	}
	return false;
}

// Magnet Code ================================================================================

exec simulated function WeaponSpecial(optional byte i)
{
	if (bOverheat)
		return;
	if (level.TimeSeconds < MagnetSwitchTime || ReloadState != RS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;

	bMagnetOpen = !bMagnetOpen;

	ReloadState = RS_GearSwitch;

	TemporaryScopeDown(0.4);
	MagnetSwitchTime = level.TimeSeconds + MagnetSwitchFireRate;
	PlayMagnetSwitching(bMagnetOpen);
	AdjustMagnetProperties();
	if (Level.NetMode == NM_Client)
		ServerWeaponSpecial(byte(bMagnetOpen));
}

function ServerWeaponSpecial (byte i)
{
	if (bOverheat)
		return;
	
	bMagnetOpen = bool(i);
	PlayMagnetSwitching(bMagnetOpen);
	AdjustMagnetProperties();
}

//Animation for magnet
simulated function PlayMagnetSwitching(bool bOpen)
{
	if (bOpen)
		PlayAnim(MagnetOpenAnim);
	else
		PlayAnim(MagnetCloseAnim);
}

simulated function Overheat(bool bForceClose)
{
	if (bForceClose)
		PlayAnim(MagnetForceCloseAnim);
	else
		PlayAnim(MagnetCloseAnim);

	ReloadState = RS_GearSwitch;
	bMagnetOpen=false;
	MagnetSwitchTime = level.TimeSeconds + 5;	//delay before magnet can be turned on again
	class'BallisticDamageType'.static.GenericHurt (Instigator, 80, None, Instigator.Location, vect(0,0,0), class'DT_M2020Overheat');
	AdjustMagnetProperties();
}

simulated function AdjustMagnetProperties ()
{
	if (bMagnetOpen)
	{
		if (Arc == None)
			class'bUtil'.static.InitMuzzleFlash(Arc, class'BWBP_SKCExp_Pro.N3XBladeEffect', DrawScale, self, 'EmitterBase');
			
		Instigator.AmbientSound = VentingSound;
		AddSpeedModification(0.7);
	}
	else
	{
		if (Arc != None)
			Emitter(Arc).kill();

		Instigator.AmbientSound = UsedAmbientSound;
		RemoveSpeedModification(1);
	}
	
}

simulated event WeaponTick (float DT)
{
	if (bOverheat && Heatlevel == 0.2)
		Overheat(false);
	super.WeaponTick(DT);
}

simulated event Tick (float DT)
{
	if (bMagnetOpen)
		AddHeat(DT*200, false);
	else if (Heatlevel > 0)
		Heatlevel = FMax(HeatLevel - (DT*200) * 5f, 0);
	else
		Heatlevel = 0;

	super.Tick(DT);
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
    local vector HitNormal;

	if( !DamageType.default.bLocationalHit )
        return;
		
	if (class<BallisticDamageType>(DamageType) != None && !class<BallisticDamageType>(DamageType).default.bMetallic)
		return;

    if ( CheckReflect(HitLocation, HitNormal, 0) )
    {
		AddHeat(Damage*5, false);

		Damage /= 5;
		Momentum /= 5;
		
		PlaySound(ShieldHitSound, SLOT_None);
    }
	
	Super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

function bool CheckReflect( Vector HitLocation, out Vector RefNormal, int AmmoDrain )
{
    local Vector HitDir;
    local Vector FaceDir;

    if (!bMagnetOpen) 
		return false;

    FaceDir = Vector(Instigator.Controller.Rotation);
    HitDir = Normal(Instigator.Location - HitLocation + Vect(0,0,8));

    RefNormal = FaceDir;

	//scalar "dot" product returns product of norm of both vectors (in this case, their size is 1) multiplied by the cosine of the angle between them
	//reversing this convention, we get the protection arc angle = 180-arccos(X), so we measure a cone with slant angle X, around the player's face
	//eg. 180-arccos(-0.37) = 68 degree protection arc (original value), so cos(180-68)=-0.37 is the value to use

    if ( FaceDir dot HitDir < -0.37 )	// 68 degree protection arc
        return true;

    return false;
}

simulated function AddHeat(float Amount, bool bReplicate)
{
	HeatLevel = FClamp(HeatLevel+Amount, 0, MaxHeat);
	
	if (bReplicate && !Instigator.IsLocallyControlled())
		ClientSetHeat(HeatLevel);
		
	if (HeatLevel == MaxHeat && bMagnetOpen)
	{
		PlaySound(OverHeatSound,,3.7,,32);
		Overheat(true);
	}
}

simulated function ClientSetHeat(float NewHeat)
{
	HeatLevel = NewHeat;
	
	if (HeatLevel == MaxHeat && bMagnetOpen)
	{
		PlaySound(OverHeatSound,,3.7,,32);
		Overheat(true);
	}
}

simulated function float ChargeBar()
{
	return (HeatLevel/MaxHeat);
}

//End Magnet Code ================================================================================

// AI Interface =====
function bool CanAttack(Actor Other)
{
	return true;
}

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (VSize(B.Enemy.Location - Instigator.Location) > FireMode[0].MaxRange()*1.5)
		return 1;
	Result = FRand();
	if (vector(B.Enemy.Rotation) dot Normal(Instigator.Location - B.Enemy.Location) < 0.0)
		Result += 0.3;
	else
		Result -= 0.3;

	if (Result > 0.5)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = AIRating;
	// Enemy too far away
	if (Dist > 1500)
		return 0.1;			// Enemy too far away
	// Better if we can get him in the back
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0)
		Result += 0.08 * B.Skill;
	// If the enemy has a knife too, a gun looks better
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result = FMax(0.0, Result *= 0.7 - (Dist/1000));
	// The further we are, the worse it is
	else
		Result = FMax(0.0, Result *= 1 - (Dist/1000));

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 4;
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
	Result *= (1 - (Dist/1500));
    return FClamp(Result, -1.0, -0.3);
}
// End AI Stuff =====

defaultproperties
{
	 OverheatSound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Overload'
	 VentingSound=Sound'BWBP_SKC_Sounds.M2020.M2020-IdleShield'
	 ShieldHitSound=ProceduralSound'WeaponSounds.ShieldGun.ShieldReflection'
	 MaxHeat=4000.000000	//20 seconds * 20 = 4000. this change is to avoid precision errors with adding epsilon of heat
	 MagnetSwitchFireRate=2.000000
	 MagnetOpenAnim="TurnOnOff"
	 MagnetCloseAnim="TurnOnOff"
	 MagnetForceCloseAnim="Asplode"
	 
	 BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.NEX.NEX-Pullout',Volume=2.000000)
	 PutDownSound=(Sound=Sound'BWBP_OP_Sounds.FlameSword.FlameSword-Unequip',Volume=2.000000)
     PlayerSpeedFactor=1.100000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SKC_TexExp.NEX.BigIcon_Nex'
     BigIconCoords=(X1=96,Y1=10,X2=418,Y2=245)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Heal=True
     ManualLines(0)="Strike with the gauntlets. Deals minor damage when charged and blinds the opponent for a short duration. When discharged, deals poor damage. Allies struck by this attack will be healed. A successful strike depletes charge."
     ManualLines(1)="Uppercut with the gauntlets. Deals good damage with some charge remaining. Allies struck will be healed. With over 55% charge, gains power, discharging a shockwave which increases the effectiveness of the attack and causes some radius damage. A successful or empowered strike depletes charge."
     ManualLines(2)="Holding Weapon Function allows the defibrillators to block. This generates a frontal shield which reduces damage from attacks by 35. The weapon will also project pulses which inflict poor healing or damage upon nearby targets. Melee attacks are blocked regardless of charge. Charge drains over time with the shield engaged.||Effective in a defensive and supporting role."
     SpecialInfo(0)=(Info="0.0;-999.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     WeaponModes(0)=(ModeName="Strikes")
     WeaponModes(1)=(ModeName="KILL!",ModeID="WM_FullAuto")
     GunLength=0.000000
     bAimDisabled=True
     FireModeClass(0)=Class'BWBP_SKCExp_Pro.N3XPlazPrimaryFire'
     FireModeClass(1)=Class'BWBP_SKCExp_Pro.N3XPlazSecondaryFire'
     PutDownTime=0.660000
     BringUpTime=0.660000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.200000
     CurrentRating=0.200000
     bMeleeWeapon=True
     bCanThrow=False
     Description="NEX Plas-Edge Sword||Manufacturer: Nexron Defence|Primary: Slash|Secondary: Charged Slash|Special: Block|| The NEX Plas-Edge Mod 0 is the first in a line of high tech energy based swords pioneered by Nexron defense. Unlike the later nanosword designs, the NEX Mod 0 uses only the supercharged ionic gas channel for energy and relies on a traditional metal sword for the cutting. This approach was quickly abandoned as Element 115's plasma field unfortunately proved to be highly unstable with erratic charge levels and random dangerous overheats. The blade's excessive heat also required a different approach - scientists noted that after prolonged exposure the blade ionized the surrounding atmosphere and made breathing difficult. When using the NEX in combat, be careful not to overcharge it as the blade is prone to discharge when completely energized. It should be noted that the plas-edge's coils are incredibly unstable and will absorb any and all incoming energy."
     DisplayFOV=65.000000
     Priority=1
     HudColor=(G=0)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=1
     PickupClass=Class'BWBP_SKCExp_Pro.N3XPlazPickup'
     PlayerViewOffset=(X=40.000000,Z=-10.000000)
     AttachmentClass=Class'BWBP_SKCExp_Pro.N3XPlazAttachment'
     IconMaterial=Texture'BWBP_SKC_TexExp.NEX.SmallIcon_Nex'
     IconCoords=(X2=127,Y2=31)
     ItemName="N3X Plaz Edge Sword"
	 ParamsClasses(0)=Class'N3XWeaponParams'
	 ParamsClasses(1)=Class'NEXWeaponParamsClassic'
     Mesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_NEX'
     DrawScale=3.000000
     bFullVolume=True
     SoundVolume=64
     SoundRadius=128.000000
}
