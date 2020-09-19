class LF_Params extends Emitter placeable;

var (Corona)                 bool            OverHudCorona;
var (Corona)  editinlineuse  Texture         CoronaTexture;
var (Corona)  editinlineuse  Color           CoronaColor;
var (Corona)	             float           CoronaOpacity;
var (Corona)                 float           CoronaScale;

var (Flare)	             bool            OverHudLensFlare;
var (Flare)  editinlineuse   array<Texture>  LensFlareTexture;
var (Flare)  editinlineuse   array<Color>    FlareColor;
var (Flare)	             array<float>    FlareOpacity;
var (Flare)	             array<float>    FlareScale;
var (Flare)	             array<float>    FlareRange;

var      	             bool            Visible;
var                          float           Brightnes;
var                          float           Life;
var                          bool            ON;

simulated function Tick(float dt)
{
if ((Brightnes < 1-10*dt) && (ON == true))
  Brightnes = Brightnes + 10*dt;

 if ( ((Level.TimeSeconds - Life) > 0.1) || (ON == false) )
  {
   Visible = false;
   Brightnes = 0;
  }

 Super.Tick(dt);
}

defaultproperties
{
     On=True
     Texture=Texture'Engine.S_Alarm'
}
