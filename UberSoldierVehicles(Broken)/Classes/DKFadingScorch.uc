class DKFadingScorch extends BallisticDecal;

var()   array<Texture> ProjTextures;
var()   Combiner BlackCombiner;
var()   FadeColor BlackFader;
var()   color Color1;
var()   color Color2;
var()   float FadePeriod;
var()   float PushBack;
var()   float StayScale;
var()   bool  RandomOrient;


// ============================================================================
//  Scorch
// ============================================================================

simulated event PreBeginPlay()
{
    if( Level.NetMode == NM_DedicatedServer )
    {
        GotoState('NoProjection');
    }
    else
    {
        Super(XScorch).PreBeginPlay();
    }
}


simulated event PostBeginPlay()
{
    local vector RX, RY, RZ;
    local rotator R;

    if( PhysicsVolume.bNoDecals )
    {
        Destroy();
        return;
    }

    if( RandomOrient )
    {
        R.Yaw = 0;
        R.Pitch = 0;
        R.Roll = Rand(36)*1820;
        GetAxes(R,RX,RY,RZ);
        RX = RX >> Rotation;
        RY = RY >> Rotation;
        RZ = RZ >> Rotation;
        R = OrthoRotation(RX,RY,RZ);
        SetRotation(R);
    }

    SetLocation( Location - vector(Rotation)*PushBack );

	if (StayScale >= 0)
		StayTime *= StayScale;

    if( Level.NetMode == NM_DedicatedServer )
    {
        GotoState('NoProjection');
        return;
    }

    BlackCombiner = Combiner(Level.ObjectPool.AllocateObject(class'Combiner'));
    BlackFader = FadeColor(Level.ObjectPool.AllocateObject(class'FadeColor'));

    BlackCombiner.CombineOperation = CO_Multiply;
    BlackCombiner.AlphaOperation = AO_Use_Alpha_From_Material1;
    BlackCombiner.Material1 = ProjTextures[Rand(ProjTextures.Length)];
    BlackCombiner.Material2 = BlackFader;

    BlackFader.FadePeriod = LifeSpan*FadePeriod;
    BlackFader.FadePhase = -Level.TimeSeconds;
    BlackFader.Color1 = Color1;
    BlackFader.Color2 = Color2;

    ProjTexture = BlackCombiner;
    SetTimer(BlackFader.FadePeriod,False);

    AttachProjector( FadeInTime );
    if( bProjectActor )
        SetCollision(True, False, False);

    AbandonProjector(LifeSpan);
}

simulated event Timer()
{
    BlackFader.FadePeriod = 0;
}

simulated function StopExpanding ()
{
	bExpandingDecal = False;
    AbandonProjector(StayTime*Level.DecalStayScale);
	Destroy();
}

simulated event Destroyed()
{
    if( BlackFader != None )
    {
        Level.ObjectPool.FreeObject(BlackFader);
        BlackFader = None;
    }

    if( BlackCombiner != None )
    {
        Level.ObjectPool.FreeObject(BlackCombiner);
        BlackCombiner = None;
    }

    Super.Destroyed();
}


// ============================================================================
//  DefaultProperties
// ============================================================================

defaultproperties
{
     Color1=(B=255,G=255,R=255,A=255)
     Color2=(A=255)
     FadePeriod=0.100000
     PushBack=4.000000
     StayTime=1.000000
     FrameBufferBlendingOp=PB_AlphaBlend
     ProjTexture=Texture'Editor.Bad'
     FOV=1
     MaxTraceDistance=250
     bProjectOnParallelBSP=True
     bNoProjectOnOwner=True
     FadeInTime=0.500000
     bNetInitialRotation=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=20.000000
}
