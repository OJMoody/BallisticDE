//============================================================================= 
// UniversalSpawner. 
// GP 2015 ----> edit Uber 2016 >:
//============================================================================= 
class UniversalSpawner extends UseTrigger 
       placeable; 

var() localized string UseMessage; 
var() bool TriggerOnPlayerTouch; 
var() bool TriggerOnBotTouch; 
var() bool PutUserInToVehicle; 
var() edfindable Actor SpawnDestinationMarker; 
var() byte VehicleTeam; 
var() class<Vehicle> VehicleClass; 
var() float ReUseDelay;     
var   float UseTime; 

function bool SelfTriggered() 
{ 
       return true; 
} 

function UsedBy( Pawn user ) 
{ 
        local Vehicle NewVehicle;     
           
            
        if ((VehicleClass != none) && (UseTime < level.TimeSeconds)) 
            { 
              UseTime = level.TimeSeconds + ReUseDelay; 

              TriggerEvent(Event, self, user); 
              if (SpawnDestinationMarker != none)              
                 NewVehicle = spawn(VehicleClass, , , SpawnDestinationMarker.Location, SpawnDestinationMarker.Rotation); 
              else 
                 NewVehicle = spawn(VehicleClass, , , Location, Rotation); 

              if (PutUserInToVehicle == true) 
               { 
                 NewVehicle.Team = xPawn(user).GetTeamNum(); 
                 OnsVehicle(NewVehicle).TeamChanged();     
                 NewVehicle.UsedBy(user); 
               } 
              else     
               { 
                 NewVehicle.Team = VehicleTeam; 
                 OnsVehicle(NewVehicle).TeamChanged();     
               } 
            
            } 
} 

function Touch( Actor Other ) 
{ 
       if ( Pawn(Other) != None ) 
       { 
          if  (((AIController(Pawn(Other).Controller) == None) && (TriggerOnPlayerTouch == true)) || ((AIController(Pawn(Other).Controller) != None) && (TriggerOnBotTouch == true)))       
             UsedBy(Pawn(Other)); 
            if( UseMessage != "" ) 
            Pawn(Other).ClientMessage( UseMessage ); 
       } 
}

function Trigger( actor Other, pawn EventInstigator ) 
   { 
      UsedBy( EventInstigator ) ; 
   }

defaultproperties
{
}
