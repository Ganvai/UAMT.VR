onMapSingleClick "";

deleteMarkerLocal (player getVariable "CHT_CallPUMrk");
deleteMarkerLocal (player getVariable "CHT_CallDOMrk");

missionNameSpace setVariable ["chtStatus",0,true];

closeDialog 0;