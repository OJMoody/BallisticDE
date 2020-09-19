class DKEmitter extends BallisticEmitter;

var sound XSound;

var() bool              bFlash;
var() float             FlashBrightness;
var() float             FlashRadius;
var() float             FlashTimeIn;
var() float             FlashTimeOut;
var() float             FlashCurveIn;
var() float             FlashCurveOut;
var   float             FlashTime;

var() rangevector       TeamColorMultiplier;

var() bool              bServerAutoDestroy;
var() float             ServerAutoDestroyTime;

var() Sound             SpawnSound;
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

var() class<Actor>      ClientSpawnClass;
var() vector            ClientSpawnAxes;

simulated event PreBeginPlay()
{
    local int i;
    local rangevector NoRange;

    Super.PreBeginPlay();
    if( bDeleteMe )
        return;

    // Team coloring
    if( TeamColorMultiplier != NoRange )
    {
        for( i=0; i!=Emitters.Length; ++i )
            if( Emitters[i] != None )
                Emitters[i].ColorMultiplierRange = TeamColorMultiplier;
    }
}

simulated event PostBeginPlay()
{
        PlaySound(SpawnSound, SpawnSoundSlot, SpawnSoundVolume, SpawnSoundNoOverride, SpawnSoundRadius, SpawnSoundPitch, SpawnSoundAttenuate);
        PlaySound(EhoFireSound, EhoFireSoundSlot, EhoFireSoundVolume, EhoFireSoundNoOverride, EhoFireSoundRadius, EhoFireSoundPitch, EhoFireSoundAttenuate);
        PlaySound(EhoExpSound, EhoExpSoundSlot, EhoExpSoundVolume, EhoExpSoundNoOverride, EhoExpSoundRadius, EhoExpSoundPitch, EhoExpSoundAttenuate);

    if( bFlash && Level.NetMode != NM_DedicatedServer )
    {
        FlashTime = FlashTimeIn + FlashTimeOut;
    }
}

simulated event Tick(float DeltaTime)
{
    local float Alpha;

    // Flash fade in
    if( FlashTimeIn > 0 )
    {
        FlashTimeIn = FMax(FlashTimeIn - DeltaTime, 0);
        Alpha = 1 - ((FlashTimeIn / default.FlashTimeIn)**FlashCurveIn);
        LightBrightness = default.LightBrightness + (FlashBrightness - default.LightBrightness) * Alpha;
        LightRadius = default.LightRadius + (FlashRadius - default.LightRadius) * Alpha;
    }

    // Flash fade out
    else if( FlashTimeOut > 0 )
    {
        FlashTimeOut = FMax(FlashTimeOut - DeltaTime, 0);
        Alpha = ((FlashTimeOut / default.FlashTimeOut)**FlashCurveOut);
        LightBrightness = FlashBrightness * Alpha;
        LightRadius = FlashRadius * Alpha;
    }

    // Disable flash
    else
    {
        LightType = LT_None;
        bFlash = False;
        Disable('Tick');
    }
}

defaultproperties
{
     bServerAutoDestroy=True
     ServerAutoDestroyTime=0.250000
     SpawnSoundVolume=255.000000
     SpawnSoundRadius=256.000000
     SpawnSoundPitch=1.000000
     ClientSpawnAxes=(X=1.000000,Y=1.000000,Z=1.000000)
     AutoDestroy=True
     bAlwaysRelevant=True
     bReplicateInstigator=True
     RemoteRole=ROLE_SimulatedProxy
     AmbientGlow=100
     MaxLights=24
     SoundOcclusion=OCCLUSION_None
}
