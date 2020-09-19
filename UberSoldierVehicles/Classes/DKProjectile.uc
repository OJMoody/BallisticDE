class DKProjectile extends BallisticProjectile;

var() Sound             FireSound;
var() ESoundSlot        FireSoundSlot;
var() float             FireSoundVolume;
var() bool              FireSoundNoOverride;
var() float             FireSoundRadius;
var() float             FireSoundPitch;
var() bool              FireSoundAttenuate;

var() ESoundSlot        SpawnSoundSlot;
var() float             SpawnSoundVolume;
var() bool              SpawnSoundNoOverride;
var() float             SpawnSoundRadius;
var() float             SpawnSoundPitch;
var() bool              SpawnSoundAttenuate;

var() Sound             EhoFireSound;
var() ESoundSlot        EhoFireSoundSlot;
var() float             EhoFireSoundVolume;
var() bool              EhoFireSoundNoOverride;
var() float             EhoFireSoundRadius;
var() float             EhoFireSoundPitch;
var() bool              EhoFireSoundAttenuate;

var() Sound             EhoExpSound;
var() ESoundSlot        EhoExpSoundSlot;
var() float             EhoExpSoundVolume;
var() bool              EhoExpSoundNoOverride;
var() float             EhoExpSoundRadius;
var() float             EhoExpSoundPitch;
var() bool              EhoExpSoundAttenuate;

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
        PlaySound(EhoFireSound, EhoFireSoundSlot, EhoFireSoundVolume, EhoFireSoundNoOverride, EhoFireSoundRadius, EhoFireSoundPitch, EhoFireSoundAttenuate);
        PlaySound(EhoExpSound, EhoExpSoundSlot, EhoExpSoundVolume, EhoExpSoundNoOverride, EhoExpSoundRadius, EhoExpSoundPitch, EhoExpSoundAttenuate);
        PlaySound(FireSound, FireSoundSlot, FireSoundVolume, FireSoundNoOverride, FireSoundRadius, FireSoundPitch, FireSoundAttenuate);
	}

	Super.PostBeginPlay();
}

// Returns the amount by which MaxWallSize should be scaled for each surface type. Override in subclasses to change...
simulated function float SurfaceScale (int Surf, out byte bHard) //hurp durp you can't have an out bool.
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
	switch (Surf)
	{
		Case 0:/*EST_Default*/	        return 0;
		Case 1:/*EST_Rock*/		return 0;
		Case 2:/*EST_Dirt*/		return 0;
		Case 3:/*EST_Metal*/		return 0;
		Case 4:/*EST_Wood*/		return 0;
		Case 5:/*EST_Plant*/		return 0;
		Case 6:/*EST_Flesh*/		return 0;
		Case 7:/*EST_Ice*/		return 0;
		Case 8:/*EST_Snow*/		return 0;
		Case 9:/*EST_Water*/		return 1;
		Case 10:/*EST_Glass*/		return 0;
		default:								return 0;
	}
	}
}

defaultproperties
{
     bCheckHitSurface=True
     bRandomStartRotaion=False
     NetTrappedDelay=0.000000
     ShakeRotRate=(X=500.000000,Y=500.000000,Z=500.000000)
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightSaturation=127
     LightBrightness=100.000000
     LightRadius=1.000000
     StaticMesh=StaticMesh'WeaponStaticMesh.RocketProj'
     bDynamicLight=True
     bAlwaysRelevant=True
     NetUpdateFrequency=0.100000
     NetPriority=5.000000
     LifeSpan=20.000000
     DrawScale=0.100000
     bFullVolume=True
     SoundVolume=255
     SoundRadius=1000.000000
     ForceType=FT_Constant
     ForceRadius=100.000000
     ForceScale=5.000000
}
