missionNameSpace setVariable ["artiStatus",0,true];

deleteMarkerLocal (player getVariable "artMrkLocal");
deleteMarkerLocal (player getVariable "artMrkRadLocal");

onMapSingleClick "";

closeDialog 0;
