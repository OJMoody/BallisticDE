//=============================================================================
// FP7SecondaryFire.
// 
// FP7 Grenade rolled underhand
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class APodSecondaryFire extends BallisticMeleeFire;

event ModeDoFire()
{
	local Vector Start, HitLoc, HitNorm, End;
	local Actor T;

    	if (!AllowFire())
        	return;

	Start = Instigator.Location + Instigator.EyePosition();
	End = Start + vector(Instigator.GetViewRotation()) * 120;
	T = Trace(HitLoc, HitNorm, End, Start, true);

	//if (Trace(HitLoc,HitNorm,Start + vector(Instigator.GetViewRotation()) * 120, Start, true) == None)
    	if (T != None && (xPawn(T) != None && Instigator.GetTeamNum() == xPawn(T).GetTeamNum() && level.Game.bTeamGame) )
	{
		//BallisticFireSound.Sound = Sound'BW_Core_WeaponSound.FP9A5.FP9-Throw';
    		FireAnim = 'UseOnAlly';
    	}
    	else
    	{
		//BallisticFireSound.Sound = None;
    		FireAnim = 'UseOnSelf';
    	}


    super.ModeDoFire();
}

function NotifiedDoFireEffect()
{
	local Vector StartTrace;
    	local Rotator Aim, PointAim;
	local int i;
	
	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);

	// Do trace for each point
	for	(i=0;i<NumSwipePoints;i++)
	{
		if (SwipePoints[i].Weight < 0)
			continue;
		PointAim = Rotator(Vector(SwipePoints[i].Offset) >> Aim);
		MeleeDoTrace(StartTrace, PointAim, i==WallHitPoint, SwipePoints[i].Weight);
	}
	//log(SwipeHits.length);
	// Do damage for each victim
	for (i=0;i<SwipeHits.length;i++)
	{
		GiveAdrenaline(SwipeHits[i].Victim, SwipeHits[i].HitLoc, StartTrace, SwipeHits[i].HitDir, 0, 0);
		log(SWipeHits[i].Victim);
	}
	SwipeHits.Length = 0;
}

//for awarding adrenaline to allies
function GiveAdrenaline (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	//local float				Dmg;
	//local class<DamageType>	HitDT;
	local xPawn				Victim;
	//local Vector			RelativeVelocity, ForceDir;

	log("At start of GiveAdrenaline");
	Victim = xPawn(Other);
	log("Victim is: "$Victim);
	if (Victim == None)
	{
		log("GIve adrenaline to self");
		Instigator.Controller.AwardAdrenaline(APodCapsule(BW).AdrenalineAmount);
	}
	else
	{
		log("Victim adrenaline before: "$Victim.Controller.Adrenaline);
		Victim.Controller.AwardAdrenaline(APodCapsule(BW).AdrenalineAmount);
		log("Victim adrenaline after: "$Victim.Controller.Adrenaline);
	}
}


	
function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	/*local float				Dmg;
	local class<DamageType>	HitDT;
	local Actor				Victim;
	local Vector			RelativeVelocity, ForceDir;

	log("At start of GiveAdrenaline");

	Dmg = GetDamage(Other, HitLocation, Dir, Victim, HitDT);
	if (RangeAtten != 1.0)
		Dmg *= Lerp(VSize(HitLocation-TraceStart)/TraceRange.Max, 1, RangeAtten);
	if (WaterRangeAtten != 1.0 && WaterHitLocation != vect(0,0,0))
		Dmg *= Lerp(VSize(HitLocation-WaterHitLocation) / (TraceRange.Max*WaterRangeFactor), 1, WaterRangeAtten);
	if (PenetrateCount > 0)
		Dmg *= PDamageFactor ** PenetrateCount;
	if (WallCount > 0)
		Dmg *= WallPDamageFactor ** WallCount;
	if (bUseRunningDamage)
	{
		RelativeVelocity = Instigator.Velocity - Other.Velocity;
		Dmg += Dmg * (VSize(RelativeVelocity) / RunningSpeedThresh) * (Normal(RelativeVelocity) Dot Normal(Other.Location-Instigator.Location));
	}
	if (HookStopFactor != 0 && HookPullForce != 0 && Pawn(Victim) != None)
	{
		ForceDir = Normal(Other.Location-TraceStart);
		ForceDir.Z *= 0.3;

		//Pawn(Victim).AddVelocity( Normal(Victim.Acceleration) * HookStopFactor * -FMin(Pawn(Victim).GroundSpeed, VSize(Victim.Velocity)) - ForceDir * HookPullForce );
	}

	if (xPawn(Victim) == None)
	{
		log("GIve adrenaline to self");
		Instigator.Controller.AwardAdrenaline(APodCapsule(BW).AdrenalineAmount);
	}
	else
	{
		log("Victim adrenaline before: "$xPawn(Victim).Controller.Adrenaline);
		xPawn(Victim).Controller.AwardAdrenaline(APodCapsule(BW).AdrenalineAmount);
		log("Victim adrenaline after: "$xPawn(Victim).Controller.Adrenaline);
	}*/
}

defaultproperties
{
     bAISilent=True
     FireAnim="UseOnSelf"
     FireAnimRate=1.5
	 FireRate=2.550000
     AmmoClass=Class'BWBP_SWC_Pro.Ammo_APod'
     AmmoPerFire=0
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
}
