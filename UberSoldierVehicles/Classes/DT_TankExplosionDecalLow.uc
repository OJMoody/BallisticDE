class DT_TankExplosionDecalLow extends DKFadingScorch;

defaultproperties
{
     ProjTextures(0)=Texture'DKVehiclesTex.Effects.Tank_Decal'
     FadePeriod=0.200000
     bRandomRotate=True
     FrameBufferBlendingOp=PB_Add
     FOV=20
     MaxTraceDistance=100
     bProjectActor=False
     bStatic=False
     Physics=PHYS_Trailer
     bHardAttach=True
}
