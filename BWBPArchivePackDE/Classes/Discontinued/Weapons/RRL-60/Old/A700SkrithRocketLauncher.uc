//=============================================================================
// G5Bazooka.
//
// Big rocket launcher. Fires a dangerous, not too slow moving rocket, with
// high damage and a fair radius. Low clip capacity, long reloading times and
// hazardous close combat temper the beast though.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A700SkrithRocketLauncher extends BallisticWeapon;

var   /*Actor*/ A700Rocket			CurrentRocket;			//Current rocket of interest. The rocket that can be used as camera or directed with laser
var() Shader			ScopeViewShad;		// Shader displayed in Scope View. Fills the screen

var   float				DetAllStartTime;	// Time when started holding down the DetonateAll key.
var() float				DetAllDelayTime;	// DetonateAll key must be held fown for this long. Safety Device...
var() Sound				DetonateSound;		// Sound when detoanter is used

replication
{
	reliable if (Role==ROLE_Authority)
		ClientSetCurrentRocket, ClientRocketDie;//, CurrentRocket;
	//reliable if (Role < ROLE_Authority)
	//	SetCurrentRocket;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (MagAmmo > 1)
	{
		SetBoneScale (0, 1.0, 'RocketBone');
		ThirdPersonActor.SetBoneScale (0, 1.0, 'RocketBone');
	}
	else if (MagAmmo == 0)
	{
		SetBoneScale (0, 0.0, 'RocketBone');
		ThirdPersonActor.SetBoneScale (0, 0.0, 'RocketBone');
	}
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{

     		if (MagAmmo < 1)
			SetBoneScale (0, 0.0, 'Rocket');

		return true;
	}
	return false;
}

simulated function OutOfAmmo()
{
    if ( Instigator == None || !Instigator.IsLocallyControlled() || HasAmmo()  || ( CurrentRocket != None  ))
        return;

    DoAutoSwitch();
}

simulated function ClientRocketDie(/*Actor*/ A700Rocket Rocket)
{
	if (level.netMode == NM_Client)
		RocketDie(Rocket);
}
simulated function RocketDie(/*Actor*/ A700Rocket Rocket)
{
	if (Role == ROLE_Authority && Instigator!= None && !Instigator.IsLocallyControlled())
		ClientRocketDie(Rocket);
}

simulated function PlayReload()
{
	bNeedCock=false;
	if (bScopeView && Instigator.Controller.IsA( 'PlayerController' ))
	{
		PlayerController(Instigator.Controller).EndZoom();
		class'BUtil'.static.PlayFullSound(self, ZoomOutSound);
	}

	SetBoneScale (0, 1.0, 'Rocket');
	if (MagAmmo < 1)
		PlayAnim('Reload', StartShovelAnimRate, , 0);
	else
		PlayAnim('Reload', ReloadAnimRate, , 0);
}

simulated function Notify_ClipIn()
{
	Super.Notify_ClipIn();
	ThirdPersonActor.SetBoneScale (0, 1.0, 'RocketBone');
}


simulated function PlayShovelEnd()
{

	Super.PlayReload();
}


simulated event RenderOverlays (Canvas C)
{
	local float ImageScaleRatio;

	if (!bScopeView)
	{
		Super.RenderOverlays(C);
		if (SightFX != None)
			RenderSightFX(C);
		return;
	}
	if (!bNoMeshInScope)
	{
		Super.RenderOverlays(C);
		if (SightFX != None)
			RenderSightFX(C);
	}
	else
	{
		SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
		SetRotation(Instigator.GetViewRotation());
	}

	// Draw Scope View
    if (ScopeViewShad != None)
    {
   		C.SetDrawColor(255,255,255,255);
		C.SetPos(C.OrgX, C.OrgY);
		// This is the ratio the images in the package were saved at, we took a 1280x1024 image and scaled it down to a 1024x1024 image.
		// Thus if we draw them as a perfect square, they will be squashed looking.
		ImageScaleRatio = 1.3333333;
		C.DrawTile(ScopeViewShad, (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.SizeY, 0, 0, 1, 1);

		C.SetPos((C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.OrgY);
		C.DrawTile(ScopeViewShad, (C.SizeY*ImageScaleRatio), C.SizeY, 0, 0, 1024, 1024);

		C.SetPos(C.SizeX - (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.OrgY);
		C.DrawTile(ScopeViewShad, (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.SizeY, 0, 0, 1, 1);
   }
}


exec simulated function WeaponSpecial(optional byte i)
{
	//if (!bHasDetonator)
	//	return;
	//ServerStartReload(i);
	ServerWeaponSpecial(i);
	if (level.NetMode == NM_Client)
		DetAllStartTime = Level.TimeSeconds;
	//log("1. WeaponSpecial");
}

function ServerWeaponSpecial(optional byte i)
{
	//if (!bHasDetonator)
	//	return;
	DetAllStartTime = Level.TimeSeconds;
	//log("2. ServerWeaponSpecial");
}

exec simulated function WeaponSpecialRelease (optional byte i)
{
	ServerWeaponSpecialRelease(i);
	if (level.NetMode == NM_Client)
		CommonWeaponSpecialRelease(i);
	//log("3. WeaponSpecialRelease");

}
function ServerWeaponSpecialRelease(optional byte i)
{
	//if (!bHasDetonator)
	//	return;
	//log("4. ServerWeaponSpecialRelease");
	Detonate(true); //new
	CommonWeaponSpecialRelease(i);
}
simulated function CommonWeaponSpecialRelease(optional byte i)
{
 	if (AIController(Instigator.Controller) == None && Level.TimeSeconds - DetAllStartTime > DetAllDelayTime)
		Detonate(true);
	//log("5. CommonWeaponSpecialrelease");
	DetAllStartTime = 0;
	//log(DetAllStartTime);
}


simulated function ClientSetCurrentRocket(A700Rocket Proj)
{
	if (level.NetMode == NM_Client)
	{
		//if (A700Rocket(Proj) != None)
		//	A700Rocket(Proj).OnDie = RocketDie;
		//if (Proj != None)
		//	Proj.OnDie = RocketDie;
		CurrentRocket = Proj;
		log("ClientSetCurrentRocket: "$CurrentRocket);
		//log("CurrentRocket: "$CurrentRocket);
	}
}
/*simulated*/ function SetCurrentRocket(A700Rocket Proj)
{
	//if (!bCamView)
	//{
		//if (A700Rocket(Proj) != None)//was uncommented
		//	A700Rocket(Proj).OnDie = RocketDie;//was uncommented
		//CurrentRocket = A700Rocket(Proj);//was uncommented
		//if (Proj != None)//was uncommented
		//	Proj.OnDie = RocketDie;//was uncommented
		CurrentRocket = Proj;
		log("SetCurrentRocket: Rocket is: "$CurrentRocket);
		//if (Role == ROLE_Authority)
		//	ClientSetCurrentRocket(CurrentRocket);
		//log("SetCurrentRocket");
		//log("SetCurrentRocket: "$CurrentRocket);
	//}
}

simulated function Detonate(optional bool bAll)
{
	//local int i;

    if (Instigator.IsLocallyControlled())
		PlaySound(DetonateSound,,0.5);
	//log("Detonate start");
	if (Role < ROLE_Authority)
		return;

	log("In detonate");

	if (CurrentRocket != None)
	{
		log("Detonate - found current rocket");
		//ClientRocketDie(CurrentRocket);//was uncommented
		//A700Rocket(CurrentRocket).Explode(A700Rocket(CurrentRocket).Location,vect(0,0,0));
		//CurrentRocket.Explode(CurrentRocket.Location,vect(0,0,0));
		//CurrentRocket = None;//new
		CurrentRocket.Detonate();
	}
	/*if (bAll)
	{
		//log("In Detonate - bAll if");
		//log("Mine is "$Mines[i]);
		for (i=0;i<Mines.length;i++)
		{
			if (Mines[i] != None/* && Level.TimeSeconds >= Mines[i].DetonateTime*/)
			{
				//log("In Detonate mine check - Mine is: "$Mines[i]);
				//Mines[i].BlowUp(vect(0,0,0));
				//Mines[i].Explode(Mines[i].Location,vect(0,0,1));
				//Mines[i].bDetonate = true;
				Mines[i].Detonate();
				DetonatedMines[DetonatedMines.length]=i;
			}
		}
		for(i=DetonatedMines.length-1; i > -1; i--)
			Mines.Remove(DetonatedMines[i],1);
	}*/

}

// Charging bar shows throw strength
simulated function float ChargeBar()
{
	if (DetAllStartTime > 0)
		return FMin(level.TimeSeconds-DetAllStartTime, 1) / DetAllDelayTime;
	else
		return 0;

}

defaultproperties
{
     ScopeViewShad=Shader'BWSkrithRecolors2Tex.SkrithRL.SkrithRLScopeShader'
     DetAllDelayTime=0.300000
     DetonateSound=Sound'BallisticSounds2.FP9A5.FP9-Detonate'
     PlayerSpeedFactor=0.850000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BWSkrithRecolors2Tex.SkrithRL.BigIcon_SkrithRL'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     InventorySize=51
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Projectile=True
     bWT_Super=True
     SpecialInfo(0)=(Info="300.0;35.0;1.0;80.0;0.8;0.0;1.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.A73.A73Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.A73.A73Putaway')
     MagAmmo=1
     CockSound=(Sound=Sound'BallisticSounds2.G5.G5-Lever')
     ClipOutSound=(Sound=Sound'BallisticSounds2.G5.G5-Load')
     ClipInSound=(Sound=Sound'BallisticSounds2.G5.G5-LoadHatch')
     WeaponModes(0)=(ModeName="Single Fire")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=10.000000
     bNoMeshInScope=True
     bNoCrosshairInScope=True
     SightOffset=(Z=10.000000)
     SprintOffSet=(Pitch=-6000,Yaw=-8000)
     JumpOffSet=(Pitch=-7000)
     AimSpread=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000))
     ChaosSpeedThreshold=380.000000
     ChaosAimSpread=(X=(Min=-1600.000000,Max=1600.000000),Y=(Min=-1600.000000,Max=1600.000000))
     RecoilYawFactor=0.000000
     RecoilMax=512.000000
     RecoilDeclineTime=1.000000
     FireModeClass(0)=Class'BWBPArchivePackDE.A700PrimaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.A700SecondaryFire'
     SelectAnimRate=0.600000
     PutDownAnimRate=0.800000
     PutDownTime=0.800000
     BringUpTime=1.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.750000
     CurrentRating=0.750000
     bShowChargingBar=True
     Description="A700 Shark Skrith Rocket Launcher|Manufacturer: Unknown Skrith Engineers|Primary: Launch Rocket/Detonate Guided Rocket|Secondary: Launch Guided Rocket|Special: Detonate Primary Rocket||Having favored close combat for generations before coming into contact with homo sapiens, Skrith ground troops have historically shunned artillery for requiring less skill than melee combat. For a recent development, the A700 has seemingly gained popularity with Skrith soldiers overnight. Its missiles are powerful enough to turn any unlucky target into a fine mist, while also requiring a higher degree of accuracy than most contemporary human counterparts due to their low blast radius. The A700 is capable of detonating its most recently fired rocket on command, making it a fairly effective weapon at close range (provided the user is hardy enough to survive the resulting blast). The secondary fire shoots a slower missile which is then guided by the user, a feature that has instilled the same fear in UTC dropship pilots that"
     Priority=73
     CenteredOffsetY=10.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=8
     PickupClass=Class'BWBPArchivePackDE.A700Pickup'
     PlayerViewOffset=(X=10.000000,Y=5.500000,Z=-8.000000)
     BobDamping=1.800000
     AttachmentClass=Class'BWBPArchivePackDE.A700Attachment'
     IconMaterial=Texture'BWSkrithRecolors2Tex.SkrithRL.SmallIcon_SkrithRL'
     IconCoords=(X2=127,Y2=31)
     ItemName="A700 Skrith Rocket Launcher"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWSkrithRecolors2Anim.SkrithRocketLauncher'
     DrawScale=0.300000
}
