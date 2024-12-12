if (supplyDropStatus > 0) exitWith {
	switch supplyDropStatus do {
		case 1: {["Supply Drop NOT available. Another Player is currently ordering a supply Drop.", "Error"] call BIS_fnc_guiMessage;};
		case 2: {["Supply Drop NOT available. Supply Drop is currently being executed.", "Error"] call BIS_fnc_guiMessage;};
		case 3: {["Supply Drop NOT available. A new Supply Drop is currently being prepared.", "Error"] call BIS_fnc_guiMessage;};
		case 4: {["No Supply Drops available.", "Error"] call BIS_fnc_guiMessage;};
	};
};

if (supplyDropCount >= supplyDropMax) exitWith {
	["Supply Drop not available. All Supply Drops used.", "Error"] call BIS_fnc_guiMessage;
};

supplyDropStatus = 1;
publicVariable "supplyDropStatus";

createDialog "sdpDialog";

_map = findDisplay 99007 ctrlCreate ["RscMapControl", -1];
_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];

createMarker ["sdpMrk",[0,0,0]];
"sdpMrk" setMarkerAlpha 0;
"sdpMrk" setMarkerType "mil_destroy_noShadow";
"sdpMrk" setMarkerText "Supply Drop";

createMarker ["sdpDirMrk",[0,0,0]];
"sdpDirMrk" setMarkerAlpha 0;
"sdpDirMrk" setMarkerType "mil_arrow_noShadow";
"sdpDirMrk" setMarkerText "Supply Drop Approach Vector";

[] onMapSingleClick {
	"sdpMrk" setMarkerPos _pos;
	"sdpMrk" setMarkerAlpha 1;
	"sdpDirMrk" setMarkerAlpha 1;
	
	_dir = sliderPosition 9900403;
	"sdpDirMrk" setMarkerPos (_pos getPos [500,_dir]);
	"sdpDirMrk" setMarkerDir (_dir + 180);
};

sleep 2;

if (findDisplay 99007 == displayNull) then {
	onMapSingleClick "";
	deleteMarker "sdpMrk";
	deleteMarker "sdpDirMrk";
	supplyDropStatus = 0;
	publicVariable "supplyDropStatus";
};