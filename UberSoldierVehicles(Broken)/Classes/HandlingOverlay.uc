class HandlingOverlay extends HudOverlay;

var  LF_Params     LF;
var  float         GlobalScale;
var  Hud           ThisHud;

simulated function bool IsTargetInFrontOfPlayer( Canvas C, Actor Target, out Vector ScreenPos, PlayerController Owner )
{
    if (VSize(normal(Target.Location - Owner.ViewTarget.Location) + normal(vector(Owner.GetViewRotation()))) < 1.4*VSize(normal(Owner.ViewTarget.Location - Target.Location)))
     return false;
    ScreenPos = C.WorldToScreen( Target.Location );
    if ( ScreenPos.X <= 0 || ScreenPos.X >= C.ClipX )
     return false;
	if ( ScreenPos.Y <= 0 || ScreenPos.Y >= C.ClipY )
     return false;

	return true;
}

simulated function Render(Canvas C)
{
  local vector	  ScreenPos;
  local float     XSize;
  local float     YSize;
  local vector    Range;
  local int       i;
  local vector    ScreenSize;

  ScreenSize.X = C.SizeX;
  ScreenSize.Y = C.SizeY;
  GlobalScale  = VSize(ScreenSize)/1500;

  if (ThisHud != None)
   foreach VisibleActors( class'LF_Params', LF, 50000, ThisHud.PlayerOwner.ViewTarget.Location + Pawn(ThisHud.PlayerOwner.ViewTarget).EyePosition() )
		{
          if ( !self.IsTargetInFrontOfPlayer( C, LF, ScreenPos, ThisHud.PlayerOwner ) )
		  continue;

		  LF.Life = Level.TimeSeconds;

		  if (LF.OverHudCorona == true)
		  {
            C.DrawColor = LF.CoronaColor;
            C.DrawColor.A = LF.CoronaOpacity*LF.Brightnes;
            XSize = LF.CoronaTexture.USize*LF.CoronaScale*LF.CoronaScale*GlobalScale;
            YSize = LF.CoronaTexture.VSize*LF.CoronaScale*LF.CoronaScale*GlobalScale;
            C.SetPos(ScreenPos.X-XSize/2, ScreenPos.Y-YSize/2);
            C.DrawTile(LF.CoronaTexture, XSize, YSize, 0.0, 0.0, LF.CoronaTexture.USize, LF.CoronaTexture.VSize);
          }


		  if (LF.OverHudLensFlare == true)
          for (i=0; i<LF.LensFlareTexture.Length; i++)
             {
                XSize = LF.LensFlareTexture[i].USize*GlobalScale*LF.FlareScale[i];
                YSize = LF.LensFlareTexture[i].VSize*GlobalScale*LF.FlareScale[i];
                Range.X = (C.SizeX/2-ScreenPos.X)*LF.FlareRange[i];
                Range.Y = (C.SizeY/2-ScreenPos.Y)*LF.FlareRange[i];
                C.DrawColor = LF.FlareColor[i];
                C.DrawColor.A = LF.Brightnes*LF.FlareOpacity[i]*2*Vsize(Range)/C.SizeX;
                C.SetPos( C.SizeX/2+Range.X-XSize/2, C.SizeY/2+Range.Y-YSize/2 );
                C.DrawTile(LF.LensFlareTexture[i], XSize, YSize, 0.0, 0.0, LF.LensFlareTexture[i].USize, LF.LensFlareTexture[i].VSize);
             }
        }
}

defaultproperties
{
}
