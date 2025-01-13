_supplyDropStatus = missionNameSpace getVariable ["supplyDropStatus",0];

if (_supplyDropStatus > 0) exitWith {
	switch _supplyDropStatus do {
		case 1: {["Supply Drop NOT available. Another Player is currently ordering a drop.", "Error"] call BIS_fnc_guiMessage;};
		case 2: {["Supply Drop NOT available. Supply Drop is currently being executed.", "Error"] call BIS_fnc_guiMessage;};
		case 3: {["Supply Drop NOT available. A new Supply Drop is currently being prepared.", "Error"] call BIS_fnc_guiMessage;};
		case 4: {["No Supply Drops available.", "Error"] call BIS_fnc_guiMessage;};
	};
};

if ((missionNameSpace getVariable ["supplyDropCount",0]) >= (getMissionConfigValue "supplyDropMax")) exitWith {
	["Supply Drop not available. All Supply Drops used.", "Error"] call BIS_fnc_guiMessage;
};

missionNameSpace setVariable ["supplyDropStatus",1,true];

_display = createDialog ["sdpDialog"];

_map = _display ctrlCreate ["RscMapControl", -1];
_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];

createMarkerLocal ["sdpMrk",[0,0,0]];
"sdpMrk" setMarkerAlphaLocal 0;
"sdpMrk" setMarkerTypeLocal "mil_destroy_noShadow";
"sdpMrk" setMarkerTextLocal "Supply Drop";

createMarkerLocal ["sdpDirMrk",[0,0,0]];
"sdpDirMrk" setMarkerAlphaLocal 0;
"sdpDirMrk" setMarkerTypeLocal "mil_arrow_noShadow";
"sdpDirMrk" setMarkerTextLocal "Supply Drop Approach Vector";

[] onMapSingleClick {
	"sdpMrk" setMarkerPosLocal _pos;
	"sdpMrk" setMarkerAlphaLocal 1;
	"sdpDirMrk" setMarkerAlphaLocal 1;
	
	_dir = sliderPosition 9900403;
	"sdpDirMrk" setMarkerPosLocal (_pos getPos [500,_dir]);
	"sdpDirMrk" setMarkerDirLocal (_dir + 180);
};

sleep 2;

if (findDisplay 99007 == displayNull) then {
	onMapSingleClick "";
	deleteMarkerLocal "sdpMrk";
	deleteMarkerLocal "sdpDirMrk";
	missionNameSpace setVariable ["supplyDropStatus",0,true];
};