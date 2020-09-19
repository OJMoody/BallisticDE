class DKHeadlightProjector extends DynamicProjector;

defaultproperties
{
     MaterialBlendingOp=PB_Modulate
     FrameBufferBlendingOp=PB_Add
     ProjTexture=Texture'BWAddPack-RS-Effects.Light.MRS138LightMark'
     FOV=25
     MaxTraceDistance=3072
     bClipBSP=True
     bClipStaticMesh=True
     bGradient=True
     bProjectOnAlpha=True
     bProjectOnParallelBSP=True
     bNoProjectOnOwner=True
     DrawType=DT_None
     bHidden=False
     bDetailAttachment=True
     RemoteRole=ROLE_SimulatedProxy
     DrawScale=0.020000
     bGameRelevant=True
}
