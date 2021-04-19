//=============================================================================
// AY90 Skrith Boltcaster
//
// The skrith version of a sniper
// 
//
// by Sarge based on code by RS
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90SkrithBoltcaster extends BallisticWeapon;

var Actor GlowFX;
var Actor StringSpark1;
var Actor StringSpark2;
var Actor StringEnd1;
var Actor StringEnd2;
var float		lastModeChangeTime;
var Vector TheEnd2;
var Vector TheEnd;


exec simulated function CockGun(optional byte Type);
function ServerCockGun(optional byte Type);

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
//	SoundPitch = 45;

	GunLength = default.GunLength;

    if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GlowFX == None || GlowFX.bDeleteMe))
		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'AY90GlowFX', DrawScale, self, 'tip');
		
//	if (level.DetailMode > DM_High)
//	{
//		if (StringSpark1 == None)	class'BUtil'.static.InitMuzzleFlash (StringSpark1, class'AY90EmitterBowString', DrawScale, self, 'LBeamA');
//		if (StringSpark2 == None)	class'BUtil'.static.InitMuzzleFlash (StringSpark2, class'AY90EmitterBowString', DrawScale, self, 'RBeamA');	
//	}
		
}

simulated event WeaponTick(float DT)
{
	local Vector End;
	local Vector Start;
	local Vector DirVec;
	local Vector SpecVec;

	super.WeaponTick(DT);

	if (MagAmmo > 0)
	{
		if (StringSpark1 == None)
			class'BUtil'.static.InitMuzzleFlash (StringSpark1, class'AY90EmitterBowString', DrawScale, self, 'LBeamSrc');
		if (StringSpark2 == None)
			class'BUtil'.static.InitMuzzleFlash (StringSpark2, class'AY90EmitterBowString', DrawScale, self, 'RBeamSrc');
		if (StringEnd1 == None)
			class'BUtil'.static.InitMuzzleFlash (StringEnd1, class'AY90EmitterBowStringEnd', DrawScale, self, 'LBeamB');
		if (StringEnd2 == None)
			class'BUtil'.static.InitMuzzleFlash (StringEnd2, class'AY90EmitterBowStringEnd', DrawScale, self, 'RBeamB');
	}
	
	if (StringSpark1 != None)
	{
		if (MagAmmo <= 0)
		{
			StringSpark1.Destroy();
			StringSpark1 = None;
		}
		else
		{
			StringSpark1.bHidden=false;
			//BeamEmitter(Emitter(StringSpark1).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End-StringSpark1.Location,End-StringSpark1.Location);

			//Rotator type
//			StringSpark1.bHidden=false;
//			End = GetBoneCoords('LBeamB').Origin;
//			StringSpark1.SetRotation(Rotator(End - StringSpark1.Location));
//			End = vect(1,0,0) * VSize(End - StringSpark1.Location);
//			BeamEmitter(Emitter(StringSpark1).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End,End);
			
			//Velocity Type
			/*
			End = GetBoneCoords('LBeamB').Origin;
			DirVect = End - StringSpark1.Location;
			StringSpark1.SetRotation(Rotator(End - StringSpark1.Location));
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).BeamDistanceRange.Min = VSize(End - StringSpark1.Location);
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).BeamDistanceRange.Max = VSize(End - StringSpark1.Location);
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).StartVelocityRange.X.Min = DirVect.x;
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).StartVelocityRange.X.Max = DirVect.x;
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).StartVelocityRange.Y.Min = DirVect.y;
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).StartVelocityRange.Y.Max = DirVect.y;
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).StartVelocityRange.Z.Min = DirVect.z;
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).StartVelocityRange.Z.Max = DirVect.z; */

			//Rotator type test
			StringSpark1.bHidden=false;
			End = GetBoneCoords('LBeamB').Origin;
			Start = StringSpark1.Location;
			StringSpark1.SetRotation(Rotator(End - Start));
			End = vect(1,0,0) * (VSize(GetBoneCoords('tip').Origin - End)-6);
			SpecVec = vect(0,0,1) * (VSize(GetBoneCoords('tip').Origin - Start)-14);
			DirVec = End + SpecVec;
			BeamEmitter(Emitter(StringSpark1).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(DirVec,DirVec);
			
			//Easy way out - emitter.startoffset.y = 10*chargePercentage
			
		}
	}
	if (StringSpark2 != None)
	{
		if (MagAmmo <= 0)
		{
			StringSpark2.Destroy();
			StringSpark2 = None;
		}
		else
		{
			//Rotator type test
			StringSpark2.bHidden=false;
			End = GetBoneCoords('RBeamB').Origin;
			Start = StringSpark2.Location;
			End = vect(1,0,0) * VSize(End - Start);
			SpecVec = vect(0,0,1) * (VSize(GetBoneCoords('tip').Origin - Start)-14);
			DirVec = End - SpecVec;
			BeamEmitter(Emitter(StringSpark2).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(DirVec,DirVec);
			
			//StringSpark2.bHidden=false;
			//End = GetBoneCoords('RBeamB').Origin;
			//StringSpark2.SetRotation(Rotator(End - StringSpark2.Location));
			//End = vect(1,0,0) * VSize(End - StringSpark2.Location);
			//BeamEmitter(Emitter(StringSpark2).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End, End);
		}
	}
	
}

simulated event Timer()
{
	if (Clientstate == WS_PutDown)
	{
		class'BUtil'.static.KillEmitterEffect (GlowFX);
		class'BUtil'.static.KillEmitterEffect (StringSpark1);
		class'BUtil'.static.KillEmitterEffect (StringSpark2);
	}
	super.Timer();
}

simulated event Destroyed()
{
	if (GlowFX != None)
		GlowFX.Destroy();
	if (StringSpark1 != None)
		StringSpark1.Destroy();
	if (StringSpark2 != None)
		StringSpark2.Destroy();
	if (StringEnd1 != None)
		StringEnd1.Destroy();
	if (StringEnd2 != None)
		StringEnd2.Destroy();
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
	local Vehicle V;

	if (MagAmmo < 1)
		return 1;

	B = Bot(Instigator.Controller);
	if ( B == None  || B.Enemy == None)
		return Rand(2);

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if ( ( (DestroyableObjective(B.Squad.SquadObjective) != None && B.Squad.SquadObjective.TeamLink(B.GetTeamNum()))
		|| (B.Squad.SquadObjective == None && DestroyableObjective(B.Target) != None && B.Target.TeamLink(B.GetTeamNum())) )
	     && (B.Enemy == None || !B.EnemyVisible()) )
		return 0;
	if ( FocusOnLeader(B.Focus == B.Squad.SquadLeader.Pawn) )
		return 0;

	if (Dist > 300)
		return 0;

	V = B.Squad.GetLinkVehicle(B);
	if ( V == None )
		V = Vehicle(B.MoveTarget);
	if ( V == B.Target )
		return 0;
	if ( (V != None) && (V.Health < V.HealthMax) && (V.LinkHealMult > 0) && B.LineOfSightTo(V) )
		return 0;

	if (Dist < FireMode[1].MaxRange())
		return 1;
//	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0 && (VSize(B.Enemy.Velocity) < 100 || Normal(B.Enemy.Velocity) dot Normal(B.Velocity) < 0.5))
//		return 1;
//	if (FRand() > Dist/500)
//		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;
	local DestroyableObjective O;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return AIRating;

	if (HasMagAmmo(0) || Ammo[0].AmmoAmount > 0)
	{
		V = B.Squad.GetLinkVehicle(B);
		if ( (V != None)
			&& (VSize(Instigator.Location - V.Location) < 1.5 * FireMode[0].MaxRange())
			&& (V.Health < V.HealthMax) && (V.LinkHealMult > 0) )
			return 1.2;

		if ( Vehicle(B.RouteGoal) != None && B.Enemy == None && VSize(Instigator.Location - B.RouteGoal.Location) < 1.5 * FireMode[0].MaxRange()
		     && Vehicle(B.RouteGoal).TeamLink(B.GetTeamNum()) )
			return 1.2;

		O = DestroyableObjective(B.Squad.SquadObjective);
		if ( O != None && B.Enemy == None && O.TeamLink(B.GetTeamNum()) && O.Health < O.DamageCapacity
	    	 && VSize(Instigator.Location - O.Location) < 1.1 * FireMode[0].MaxRange() && B.LineOfSightTo(O) )
			return 1.2;
	}

	if (B.Enemy == None)
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
	if (Dist > 1300)
		Result -= (Dist-1000) / 3000;
	if (Dist < 500)
		Result += 0.5;

	return Result;
}

function bool FocusOnLeader(bool bLeaderFiring)
{
	local Bot B;
	local Pawn LeaderPawn;
	local Actor Other;
	local vector HitLocation, HitNormal, StartTrace;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return false;
	if ( PlayerController(B.Squad.SquadLeader) != None )
		LeaderPawn = B.Squad.SquadLeader.Pawn;
	else
	{
		V = B.Squad.GetLinkVehicle(B);
		if ( V != None )
		{
			LeaderPawn = V;
			bLeaderFiring = (LeaderPawn.Health < LeaderPawn.HealthMax) && (V.LinkHealMult > 0)
							&& ((B.Enemy == None) || V.bKeyVehicle);
		}
	}
	if ( LeaderPawn == None )
	{
		LeaderPawn = B.Squad.SquadLeader.Pawn;
		if ( LeaderPawn == None )
			return false;
	}
	if (!bLeaderFiring)
		return false;
	if ( (Vehicle(LeaderPawn) != None) )
	{
		StartTrace = Instigator.Location + Instigator.EyePosition();
		if ( VSize(LeaderPawn.Location - StartTrace) < FireMode[0].MaxRange() )
		{
			Other = Trace(HitLocation, HitNormal, LeaderPawn.Location, StartTrace, true);
			if ( Other == LeaderPawn )
			{
				B.Focus = Other;
				return true;
			}
		}
	}

	return false;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	 if (!HasNonMagAmmo(0) && !HasMagAmmo(0)) return 1.2; return 0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.5;	}

function bool CanHeal(Actor Other)
{
	if (DestroyableObjective(Other) != None && DestroyableObjective(Other).LinkHealMult > 0)
		return true;
	if (Vehicle(Other) != None && Vehicle(Other).LinkHealMult > 0)
		return true;

	return false;
}
// End AI Stuff =====


// Returns true if gun will need reloading after a certain amount of ammo is consumed. Subclass for special stuff
simulated function bool MayNeedReload(byte Mode, float Load)
{
	if (!bNoMag && BFireMode[1]!= None && BFireMode[1].bUseWeaponMag && (MagAmmo - Load < 5))
		return true;
	return bNeedReload;
//		return true;
//	return false;
}

simulated function float ChargeBar()
{
	if (FireMode[1].bIsFiring == true)
		return FMin(FireMode[1].HoldTime/4, 1);
	else
		return FMin(FireMode[0].HoldTime/4, 1);
}

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     UsedAmbientSound=Sound'BW_Core_WeaponSound.A73.A73Hum1'
     BigIconMaterial=Texture'BWBP_SKC_Tex.A73b.BigIcon_A73E'
     //BallisticInventoryGroup=5
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_RapidProj=True
     bWT_Energy=True
     SpecialInfo(0)=(Info="300.0;25.0;0.5;85.0;0.2;0.2;0.2")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Putaway')
     ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipHit')
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipOut')
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipIn')
     ClipInFrame=0.700000
     bNonCocking=True
     bShowChargingBar=True
     WeaponModes(0)=(ModeName="Plasma Charge",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="Plasma Bomb",ModeID="WM_FullAuto")
     WeaponModes(2)=(ModeName="ALaser",bUnavailable=True)
     WeaponModes(3)=(ModeName="BLaser",bUnavailable=True)
     WeaponModes(4)=(ModeName="CLaser",bUnavailable=True)
     CurrentWeaponMode=0
     SightPivot=(Pitch=768)
     SightOffset=(Y=4.700000,Z=8.000000)
     SightDisplayFOV=40.000000
     //CrosshairCfg=(Pic1=Texture'BallisticUI2.Crosshairs.Misc7',Pic2=Texture'BallisticUI2.Crosshairs.Cross4',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=67,G=68,A=137),Color2=(B=96,G=185,A=208),StartSize1=133,StartSize2=47)
     //CrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,Y2=0.500000),MaxScale=3.000000)
     //CrouchAimFactor=0.600000
     //SprintOffSet=(Pitch=-500,Yaw=-1024)
     //JumpChaos=0.500000
//     ViewAimFactor=0.350000
     //ViewRecoilFactor=0.450000
     //AimDamageThreshold=75.000000
    //ChaosSpeedThreshold=600.000000
    // ChaosAimSpread=(X=(Min=-1740.000000,Max=1740.000000),Y=(Min=-1306.000000,Max=1306.000000))
    // RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.150000,OutVal=0.100000),(InVal=0.250000,OutVal=0.200000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=-0.250000),(InVal=1.000000,OutVal=0.100000)))
     //RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.090000),(InVal=0.150000,OutVal=0.150000),(InVal=0.250000,OutVal=0.120000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.050000),(InVal=500000.000000,OutVal=0.500000)))
    // RecoilPitchFactor=0.800000
    // RecoilYawFactor=0.800000
     //RecoilXFactor=0.300000
    // RecoilYFactor=0.300000
     //RecoilMax=1024.000000
    // RecoilDeclineTime=1.500000
     ParamsClasses(0)=Class'AY90WeaponParamsClassic'
     ParamsClasses(1)=Class'AY90WeaponParamsClassic'
     FireModeClass(0)=Class'BWBP_SKCExp_Pro.AY90PrimaryFire'
     FireModeClass(1)=Class'BWBP_SKCExp_Pro.AY90SecondaryFire'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bMeleeWeapon=True
     Description="AY90 Skrith Boltcaster||Manufacturer: Unknown Skrith Engineers|Primary: Energy Bolt|Secondary: Blade Stab||The A73-E is a specialized version of the Skrith standard rifle and is rarely seen on the battlefield. Aside from the red tint, the Elite model is very similar in appearance to the standard. Scans show, however, that this special version fires projectiles at roughly 3 times the standard heat level and has an odd permanent electrical charge coursing through the blades. If encountered in the field, it is advised to report the occurrence to HQ immediately for testing."
     Priority=92
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=5
     GroupOffset=14
     PickupClass=Class'BWBP_SKCExp_Pro.AY90Pickup'
     PlayerViewOffset=(X=5.000000,Y=2.000000,Z=-6.000000)
     BobDamping=1.600000
     AttachmentClass=Class'BWBP_SKCExp_Pro.AY90Attachment'
     IconMaterial=Texture'BWBP_SKC_Tex.A73b.SmallIcon_A73E'
     IconCoords=(X2=127,Y2=31)
     ItemName="AY90 Skrith Boltcaster"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=180
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWBP_SKC_AnimExpX.SKBow_FP'
     DrawScale=0.188000
//     SoundPitch=32
     bFullVolume=True
     SoundVolume=255
     SoundRadius=256.000000
}
