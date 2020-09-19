class HUD_Injector extends Emitter placeable;

simulated function Tick(float dt)
{
 local Hud               VictimHud;
 local PlayerController  Master;
 local int               j;
 local HandlingOverlay   LFOL;

 Master = Level.GetLocalPlayerController();

 foreach AllActors( class'Hud', VictimHud )
 {
  for (j=0; j<VictimHud.Overlays.Length; j++)
  if (VictimHud.Overlays[j].IsA('HandlingOverlay'))
   {
    LFOL = HandlingOverlay(VictimHud.Overlays[j]);
    LFOL.ThisHud = VictimHud;
   }
  if (LFOL == none)
   VictimHud.AddHudOverlay(Spawn(class'HandlingOverlay'));
 }
}

defaultproperties
{
     bHidden=True
     bAlwaysRelevant=True
}
