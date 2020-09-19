//=============================================================================
// Scoped F2000.
//=============================================================================
class MG36MachineGun extends BallisticWeapon;

//Grenade
var() Sound		GrenOpenSound;		//Sounds for grenade reloading
var() Sound		GrenLoadSound;		//
var() Sound		GrenCloseSound;		//
var() name			GrenadeLoadAnim;	//Anim for grenade reload

//IR/NV
var() BUtil.FullSound	ThermalOnSound;	// Sound when activating thermal mode
var() BUtil.FullSound	ThermalOffSound;// Sound when deactivating thermal mode
var() BUtil.FullSound	NVOnSound;	// Sound when activating NV/Meat mode
var() BUtil.FullSound	NVOffSound; // Sound when deactivating NV/Meat mode
var   Array<Pawn>		PawnList;		// A list of all the potential pawns to view in thermal mode
var() material				WallVisionSkin;	// Texture to assign to players when theyare viewed with Thermal mode
var   bool					bThermal;		// Is thermal mode active?
var   bool					bUpdatePawns;	// Should viewable pawn list be updated
var   Pawn					UpdatedPawns[16];// List of pawns to view in thermal scope
var() material				Flaretex;		// Texture to use to obscure vision when viewing enemies directly through the thermal scope
var() float					ThermalRange;	// Maximum range at which it is possible to see enemies through walls
var   bool					bMeatVision;
var   Pawn					Target;
var   float					TargetTime;
var   float					LastSendTargetTime;
var   vector				TargetLocation;
var   Actor					NVLight;

replication
{
	reliable if (Role == ROLE_Authority)
		Target, bMeatVision, ClientGrenadePickedUp;
	reliable if (Role < ROLE_Authority)
		ServerAdjustThermal;
}

// Notifys for greande loading sounds
simulated function Notify_F2000GrenOpen()	{	PlaySound(GrenOpenSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_F2000GrenLoad()		{	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_F2000GrenClose()	{	PlaySound(GrenCloseSound, SLOT_Misc, 0.5, ,64); MARSSecondaryFire(FireMode[1]).bLoaded = true; }

// A grenade has just been picked up. Loads one in if we're empty
function GrenadePickedUp ()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (Instigator.Weapon == self)
			LoadGrenade();
		else

			MARSSecondaryFire(FireMode[1]).bLoaded=true;
	}
	if (!Instigator.IsLocallyControlled())
		ClientGrenadePickedUp();
}

simulated function ClientGrenadePickedUp()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (ClientState == WS_ReadyToFire)
			LoadGrenade();
		else
			MARSSecondaryFire(FireMode[1]).bLoaded=true;
	}
}

simulated function bool IsGrenadeLoaded()
{
	return MARSSecondaryFire(FireMode[1]).bLoaded;
}

// Tell our ammo that this is the MARS it must notify about grenade pickups
/*function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
	Super.GiveAmmo(m, WP, bJustSpawned);
	if (Ammo[1] != None && Ammo_MARSGrenades(Ammo[1]) != None)
		Ammo_MARSGrenades(Ammo[1]).DaF2K = self;
}*/

// Load in a grenade
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 1 || MARSSecondaryFire(FireMode[1]).bLoaded)
	{
		if(!MARSSecondaryFire(FireMode[1]).bLoaded)
			PlayIdle();
		return;
	}

	if (ReloadState == RS_None)
	{
		ReloadState = RS_GearSwitch;
		PlayAnim(GrenadeLoadAnim, 1.1, , 0);
	}
}

function ServerStartReload (optional byte i)
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;

	GetAnimParams(channel, seq, frame, rate);
	if (seq == GrenadeLoadAnim)
		return;

	if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
	{
		if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
		{
			LoadGrenade();
			ClientStartReload(1);
		}
		return;
	}
	super.ServerStartReload();
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
		{
			if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
				LoadGrenade();
		}
		else
			CommonStartReload(i);
	}
}

simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode == 1)
		return FireCount < 1;
	return super.CheckWeaponMode(Mode);
}

function bool BotShouldReloadGrenade ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

//==============================================
//=========== Scope Code - Targetting + IRNV ===
//==============================================
function ServerWeaponSpecial(optional byte i)
{
	bMeatVision = !bMeatVision;
	if (bMeatVision)
		class'BUtil'.static.PlayFullSound(self, NVOnSound);
	else
		class'BUtil'.static.PlayFullSound(self, NVOffSound);
}
simulated event WeaponTick(float DT)
{
	local actor T;
	local float BestAim, BestDist;
	local Pawn Targ;
	local vector HitLoc, HitNorm, Start, End;

	super.WeaponTick(DT);

	if (AIController(Instigator.Controller) != None && !IsGrenadeLoaded()&& AmmoAmount(1) > 0 && BotShouldReloadGrenade() && !IsReloadingGrenade())
		LoadGrenade();

	if (bThermal && bScopeView)
	{
		SetNVLight(true);

		Start = Instigator.Location+Instigator.EyePosition();
		End = Start+vector(Instigator.GetViewRotation())*1500;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(16,16,16));
		if (T==None)
			HitLoc = End;

		if (VSize(HitLoc-Start) > 400)
			NVLight.SetLocation(Start + (HitLoc-Start)*0.5);
		else
			NVLight.SetLocation(HitLoc + HitNorm*30);
	}
	else
		SetNVLight(false);

	if (!bScopeView || Role < Role_Authority)
		return;

	Start = Instigator.Location + Instigator.EyePosition();
	BestAim = 0.995;
	Targ = Instigator.Controller.PickTarget(BestAim, BestDist, Vector(Instigator.GetViewRotation()), Start, 20000);
	if (Targ != None)
	{
		if (Targ != Target)
		{
			Target = Targ;
			TargetTime = 0;
		}
		else if (Vehicle(Targ) != None)
			TargetTime += 1.2 * DT * (BestAim-0.95) * 20;
		else
			TargetTime += DT * (BestAim-0.95) * 20;
	}
	else
	{
		TargetTime = FMax(0, TargetTime - DT * 0.5);
	}
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	Target = None;
	TargetTime = 0;
	super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

simulated event RenderOverlays (Canvas C)
{
	local float ImageScaleRatio;
	local Vector X, Y, Z;

	if (!bScopeView)
	{
		Super.RenderOverlays(C);
		if (SightFX != None)
			RenderSightFX(C);
		return;
	}
	if (bScopeView && ( (PlayerController(Instigator.Controller).DesiredFOV == PlayerController(Instigator.Controller).DefaultFOV && PlayerController(Instigator.Controller).bZooming==false)
		|| (Level.bClassicView && (PlayerController(Instigator.Controller).DesiredFOV == 90)) ))
	{
		SetScopeView(false);
		PlayAnim(ZoomOutAnim);
	}

    	if (bThermal)
		DrawThermalMode(C);

	if (!bNoMeshInScope)
	{
		Super.RenderOverlays(C);
		if (SightFX != None)
			RenderSightFX(C);
	}
	else
	{
		GetViewAxes(X, Y, Z);
		if (BFireMode[0].MuzzleFlash != None)
		{
			BFireMode[0].MuzzleFlash.SetLocation(Instigator.Location + Instigator.EyePosition() + X * SMuzzleFlashOffset.X + Z * SMuzzleFlashOffset.Z);
			BFireMode[0].MuzzleFlash.SetRotation(Instigator.GetViewRotation());
			C.DrawActor(BFireMode[0].MuzzleFlash, false, false, DisplayFOV);
		}
		if (BFireMode[1].MuzzleFlash != None)
		{
			BFireMode[1].MuzzleFlash.SetLocation(Instigator.Location + Instigator.EyePosition() + X * SMuzzleFlashOffset.X + Z * SMuzzleFlashOffset.Z);
			BFireMode[1].MuzzleFlash.SetRotation(Instigator.GetViewRotation());
			C.DrawActor(BFireMode[1].MuzzleFlash, false, false, DisplayFOV);
		}
		SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
		SetRotation(Instigator.GetViewRotation());
	}

	// Draw Scope View
	// Draw the Scope View Tex
	C.SetDrawColor(255,255,255,255);
	C.SetPos(C.OrgX, C.OrgY);
	C.Style = ERenderStyle.STY_Alpha;
	C.ColorModulate.W = 1;
	ImageScaleRatio = 1.3333333;

	if (bThermal)
	{

    		C.DrawTile(Texture'BallisticRecolors4TexPro.MARS.MARS-ScopeRed', (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);

        	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(Texture'BallisticRecolors4TexPro.MARS.MARS-ScopeRed', C.SizeY, C.SizeY, 0, 0, 1024, 1024);

        	C.SetPos(C.SizeX - (C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(Texture'BallisticRecolors4TexPro.MARS.MARS-ScopeRed', (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);
	}
	else if (bMeatVision)
	{
    		C.DrawTile(Texture'BallisticRecolors4TexPro.MARS.MARS-ScopeTarget', (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);

        	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(Texture'BallisticRecolors4TexPro.MARS.MARS-ScopeTarget', C.SizeY, C.SizeY, 0, 0, 1024, 1024);

        	C.SetPos(C.SizeX - (C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(Texture'BallisticRecolors4TexPro.MARS.MARS-ScopeTarget', (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);
	}
	else
	{
    		C.DrawTile(ScopeViewTex, (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);

        	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(ScopeViewTex, C.SizeY, C.SizeY, 0, 0, 1024, 1024);

        	C.SetPos(C.SizeX - (C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(ScopeViewTex, (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);
	}
		
	if (bMeatVision)
		DrawMeatVisionMode(C);
}

simulated event Timer()
{
	if (bUpdatePawns)
		UpdatePawnList();
	else
		super.Timer();
}

simulated function UpdatePawnList()
{

	local Pawn P;
	local int i;
	local float Dist;

	PawnList.Length=0;
	ForEach DynamicActors( class 'Pawn', P)
	{
		PawnList[PawnList.length] = P;
		Dist = VSize(P.Location - Instigator.Location);
		if (Dist <= ThermalRange &&
			( Normal(P.Location-(Instigator.Location+Instigator.EyePosition())) Dot Vector(Instigator.GetViewRotation()) > 1-((Instigator.Controller.FovAngle*0.9)/180) ) &&
			((Instigator.LineOfSightTo(P)) || Normal(P.Location - Instigator.Location) Dot Vector(Instigator.GetViewRotation()) > 0.985 + 0.015 * (Dist/ThermalRange)))
		{
			if (!Instigator.IsLocallyControlled())
			{
				P.NetUpdateTime = Level.TimeSeconds - 1;
				P.bAlwaysRelevant = true;
			}
			UpdatedPawns[i]=P;
			i++;
		}
	}
}

simulated function SetScopeView(bool bNewValue)
{

	bScopeView = bNewValue;
	if (!bScopeView)
	{
		Target = None;
		TargetTime=0;
	}
	if (Level.NetMode == NM_Client)
		ServerSetScopeView(bNewValue);
	bScopeView = bNewValue;
	SetScopeBehavior();

	if (!bNewValue && Target != None)
		class'BUtil'.static.PlayFullSound(self, NVOffSound);
}


// draws red blob that moves, scanline, and target boxes.
simulated event DrawMeatVisionMode (Canvas C)
{
	local Vector V, V2, V3, X, Y, Z;
	local float ScaleFactor;

	// Draw RED stuff
	C.Style = ERenderStyle.STY_Modulated;
	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
	C.SetDrawColor(255,255,255,255);
	C.DrawTile(FinalBlend'BallisticRecolors4TexPro.MARS.F2000TargetFinal', (C.SizeY*1.3333333) * 0.75, C.SizeY, 0, 0, 1024, 1024);

	// Draw some panning lines
	C.SetPos(C.OrgX, C.OrgY);
	//C.DrawTile(FinalBlend'BallisticUI2.M75.M75LinesFinal', C.SizeX, C.SizeY, 0, 0, 512, 512);

    C.Style = ERenderStyle.STY_Alpha;
	
	if (Target == None)
		return;

	// Draw Target Boxers
	ScaleFactor = C.ClipX / 1600;
	GetViewAxes(X, Y, Z);
	V  = C.WorldToScreen(Target.Location - Y*Target.CollisionRadius + Z*Target.CollisionHeight);
	V.X -= 32*ScaleFactor;
	V.Y -= 32*ScaleFactor;
	C.SetPos(V.X, V.Y);
	V2 = C.WorldToScreen(Target.Location + Y*Target.CollisionRadius - Z*Target.CollisionHeight);
	C.SetDrawColor(160,185,200,255);
      C.DrawTileStretched(Texture'BallisticRecolors3TexPro.X82.X82Targetbox', (V2.X - V.X) + 32*ScaleFactor, (V2.Y - V.Y) + 32*ScaleFactor);

    V3 = C.WorldToScreen(Target.Location - Z*Target.CollisionHeight);
}

// Draws players through walls and all the other Thermal Mode stuff
simulated event DrawThermalMode (Canvas C)
{
	local float ImageScaleRatio;//, OtherRatio;

	ImageScaleRatio = 1.3333333;

	C.Style = ERenderStyle.STY_Modulated;
	// Draw Spinning Sweeper thing
	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
	C.SetDrawColor(255,255,255,255);
	C.DrawTile(FinalBlend'BallisticRecolors4TexPro.MARS.F2000IRNVFinal', (C.SizeY*ImageScaleRatio) * 0.75, C.SizeY, 0, 0, 1024, 1024);
}

simulated function AdjustThermalView(bool bNewValue)
{
	if (AIController(Instigator.Controller) != None)
		return;
	if (!bNewValue)
		bUpdatePawns = false;
	else

	{
		bUpdatePawns = true;
		UpdatePawnList();
		SetTimer(1.0, true);
	}
	ServerAdjustThermal(bNewValue);
}

function ServerAdjustThermal(bool bNewValue)
{

	local int i;
//	bThermal = bNewValue;
	if (bNewValue)
	{
		bUpdatePawns = true;
		UpdatePawnList();
		SetTimer(1.0, true);
	}
	else
	{
		bUpdatePawns = false;
//		SetTimer(0.0, false);
		for (i=0;i<ArrayCount(UpdatedPawns);i++)
		{
			if (UpdatedPawns[i] != None)
				UpdatedPawns[i].bAlwaysRelevant = false;
		}
	}
}

//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
	if (!bThermal && !bMeatVision) //Nothing on, turn on IRNV!
	{
		bThermal = !bThermal;
		if (bThermal)
				class'BUtil'.static.PlayFullSound(self, ThermalOnSound);
		else
				class'BUtil'.static.PlayFullSound(self, ThermalOffSound);
		AdjustThermalView(bThermal);
		if (!bScopeView)
			PlayerController(InstigatorController).ClientMessage("Activated nightvision scope.");
		return;
	}
	if (bThermal && !bMeatVision) //IRNV on! turn it off and turn on targeting!
	{
		bThermal = !bThermal;
		if (bThermal)
				class'BUtil'.static.PlayFullSound(self, ThermalOnSound);
		else
				class'BUtil'.static.PlayFullSound(self, ThermalOffSound);
		AdjustThermalView(bThermal);
		if (!bScopeView)
			PlayerController(InstigatorController).ClientMessage("Activated infrared targeting scope.");
		bMeatVision = !bMeatVision;
		if (bMeatVision)
				class'BUtil'.static.PlayFullSound(self, NVOnSound);
		else
				class'BUtil'.static.PlayFullSound(self, NVOffSound);
		return;
	}
	if (!bThermal && bMeatVision) //targeting on! turn it off!
	{
		bMeatVision = !bMeatVision;
		if (bMeatVision)
				class'BUtil'.static.PlayFullSound(self, NVOnSound);
		else
				class'BUtil'.static.PlayFullSound(self, NVOffSound);
		if (!bScopeView)
			PlayerController(InstigatorController).ClientMessage("Activated standard scope.");
		return;
	}
}

//==============================================
//=========== Bullet in mag ====================
//==============================================
simulated function Notify_ClipOutOfSight()
{
}

//==============================================
//=========== Light + Garbage Cleanup ==========
//==============================================

simulated event Destroyed()
{
	AdjustThermalView(false);

	if (NVLight != None)
		NVLight.Destroy();
		
	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = false;

	super.Destroyed();
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		AdjustThermalView(false);
		return true;
	}

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = false;

	return false;
}

simulated function SetNVLight(bool bOn)
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (bOn)
	{
		if (NVLight == None)
		{
			NVLight = Spawn(class'MARSNVLight',,,Instigator.location);
			NVLight.SetBase(Instigator);
		}
		NVLight.bDynamicLight = true;
	}
	else if (NVLight != None)
		NVLight.bDynamicLight = false;
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
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AmmoAmount(1) < 1 || !IsGrenadeLoaded())
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
	// Too close for grenade
	if (Dist < 500 &&  VDot > 0.3)
		result -= (500-Dist) / 1000;
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

simulated function bool IsReloadingGrenade()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == GrenadeLoadAnim)
 		return true;
	return false;
}

function bool CanAttack(Actor Other)
{
	if (!IsGrenadeLoaded())
	{
		if (IsReloadingGrenade())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadGrenade())
		{
			LoadGrenade();
			return false;
		}
	}
	return super.CanAttack(Other);
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
function float SuggestAttackStyle()	{	return -0.4;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.4;	}
// End AI Stuff =====

defaultproperties
{
     WeaponModes(0)=(bUnavailable=True)
	 CurrentWeaponMode=2
     GrenOpenSound=Sound'BallisticSounds2.M50.M50GrenOpen'
     GrenLoadSound=Sound'BallisticSounds2.M50.M50GrenLoad'
     GrenCloseSound=Sound'BallisticSounds2.M50.M50GrenClose'
     GrenadeLoadAnim="GLReload"
     ThermalOnSound=(Sound=Sound'BallisticSounds2.M75.M75ThermalOn',Volume=0.500000,Pitch=1.000000)
     ThermalOffSound=(Sound=Sound'BallisticSounds2.M75.M75ThermalOff',Volume=0.500000,Pitch=1.000000)
     NVOnSound=(Sound=Sound'PackageSounds4Pro.AH104.AH104-SightOn',Volume=1.600000,Pitch=0.900000)
     NVOffSound=(Sound=Sound'PackageSounds4Pro.AH104.AH104-SightOff',Volume=1.600000,Pitch=0.900000)
     WallVisionSkin=FinalBlend'BallisticEffects.M75.OrangeFinal'
     Flaretex=FinalBlend'BallisticEffects.M75.OrangeFlareFinal'
     ThermalRange=2500.000000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticRecolors4TexPro.MARS.BigIcon_F2000'
     BigIconCoords=(Y1=30,Y2=235)
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="Powerful automatic fire. Has the best sustained damage output of its class, but has recoil to match."
     ManualLines(1)="Launches a smoke grenade. Upon impact, generates a cloud of smoke and deals minor radius damage. There is a bonus for a direct hit."
     ManualLines(2)="The Weapon Function key switches between various integrated scopes.|The Normal scope offers clear vision.|The Night Vision scope (green) illuminates the environment and shows enemies in orange.|The Infrared scope (red) highlights enemies with a box, even underwater or through smoke or trees.||Effective at medium range."
     SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;0.8;0.5;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway')
     CockAnimPostReload="ReloadEndCock"
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'PackageSounds4ProExp.MARS.MARS-BoltPull',Volume=1.100000,Radius=32.000000)
     ReloadAnimRate=0.500000
     ClipHitSound=(Sound=Sound'PackageSounds4ProExp.MARS.MARS-MagFiddle',Volume=1.400000,Radius=32.000000)
     ClipOutSound=(Sound=Sound'PackageSounds4ProExp.MARS.MARS-MagOut',Volume=1.400000,Radius=32.000000)
     ClipInSound=(Sound=Sound'PackageSounds4ProExp.MARS.MARS-MagIn',Volume=1.400000,Radius=32.000000)
     ClipInFrame=0.650000
     ZoomType=ZT_Logarithmic
     ScopeViewTex=Texture'BallisticRecolors4TexPro.MARS.MARS-Scope'
     ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=45.000000
     bNoMeshInScope=True
     bNoCrosshairInScope=True
     SightOffset=(Y=-3.000000,Z=73.500000)
     SightingTime=0.400000
     MinZoom=2.000000
     MaxZoom=8.000000
     ZoomStages=6
     SMuzzleFlashOffset=(X=15.000000,Z=-10.000000)
     CrouchAimFactor=0.650000
     SprintOffSet=(Pitch=-3000,Yaw=-4096)
     AimSpread=96
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=5000.000000
     ChaosAimSpread=4096
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.250000,OutVal=0.250000),(InVal=0.500000,OutVal=0.050000),(InVal=0.650000,OutVal=-0.200000),(InVal=0.900000,OutVal=-0.100000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.220000
     RecoilYFactor=0.220000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.140000
     FireModeClass(0)=Class'BWBPArchivePackDE.MG36PrimaryFire'
     FireModeClass(1)=Class'BCoreDE.BallisticScopeFire'
     PutDownTime=0.700000
     BringUpTime=0.330000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.700000
     CurrentRating=0.700000
	 MagAmmo=150
     Description="The 2 variant of the Modular Assault Rifle System is one of many rifles built under NDTR Industries' MARS project. The project, which aimed to produce a successor to the army's current M50 and M30 rifles, has produced a number of functional prototypes. The 2 variant is a sharpshooter model with a longer barrel and an advanced, integral scope. Current tests show the MARS-2 to be reliable and effective, yet expensive."
     Priority=65
     HudColor=(G=0)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=6
     PickupClass=Class'BWBPArchivePackDE.MG36Pickup'
     PlayerViewOffset=(X=-15.000000,Y=20.000000,Z=-50.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBPArchivePackDE.MG36Attachment'
     IconMaterial=Texture'BallisticRecolors4TexPro.MARS.SmallIcon_F2000'
     IconCoords=(X2=127,Y2=31)
     ItemName="[B] MG36 Machinegun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBPArchivePack2Anim.MG36_FP'
     DrawScale=1.000000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
}
