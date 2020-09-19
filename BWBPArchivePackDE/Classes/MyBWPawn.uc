class MyBWPawn extends BallisticPawn;

var float StrafeScale, BackScale, GroundSpeedScale, AccelRateScale;
var float MyFriction;
var float mov_oldSpeed;

simulated event ModifyVelocity(float DeltaTime, vector OldVelocity)
{
	local Vector x,y,z,dir;
	local float Fspeed,Control,NewSpeed,drop,XSpeed,YSpeed,CosAngle,MaxStrafeSpeed,MaxBackSpeed;

	//Scaling movementspeed

	if (Physics==PHYS_Walking)
	{
		GetAxes(GetViewRotation(),x,y,z);
		MaxStrafeSpeed = GroundSpeed * StrafeScale;
		MaxBackSpeed = GroundSpeed * BackScale;
		XSpeed = Abs(x dot Velocity);
		if (XSpeed > MaxBackSpeed && (x dot Velocity) < 0)
		{
			//limiting backspeed
			dir=Normal(Velocity);
			CosAngle=Abs(x dot dir);
			velocity=dir*(MaxBackSpeed/CosAngle);
		}
		YSpeed = Abs(y dot velocity);
		if (YSpeed > MaxStrafeSpeed)
		{
			//limiting strafespeed
			dir=Normal(Velocity);
			CosAngle=Abs(y dot dir);
			velocity=dir*(MaxStrafeSpeed/CosAngle);
		}

		//ClientMessage("Speed:"$string(VSize(Velocity)/GroundSpeed));
	}
     
      if(Physics==PHYS_Walking){
         FSpeed=Vsize(Velocity);
         if ( VSize(Acceleration) < 1.00 && FSpeed>1.00){
            if(FSpeed < 100) Control=100;
            else Control = FSpeed;
            drop = Control*DeltaTime*MyFriction;
            NewSpeed = FSpeed + drop;
            NewSpeed = FClamp(NewSpeed, 0, mov_oldSpeed*0.97);
            NewSpeed /= FSpeed;
            velocity *= NewSpeed;

         }
         mov_oldSpeed = Vsize(Velocity);
     }

}

defaultproperties
{
     StrafeScale=0.700000
     BackScale=0.600000
     MyFriction=4.000000
     RagdollLifeSpan=40.000000
     GroundSpeed=270.000000
     WaterSpeed=150.000000
     AirSpeed=270.000000
     AccelRate=256.000000
     WalkingPct=0.300000
     DodgeSpeedFactor=1.200000
     DodgeSpeedZ=190.000000
}
