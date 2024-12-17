if (vlsStatus > 0) exitWith {
	switch vlsStatus do {
		case 1 : {["VLS not available. Another Element is currently requesting a VLS Strike", "Error"] call BIS_fnc_guiMessage;};
		case 2 : {["VLS not available. VLS strike in progress", "Error"] call BIS_fnc_guiMessage;};
		case 3 : {["VLS not available. Readying missile array after firemission.", "Error"] call BIS_fnc_guiMessage;};
	};
};

createDialog "vlsDialog";

_map = findDisplay 99005 ctrlCreate ["RscMapControl", -1];
_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];

missionNameSpace setVariable ["vlsStatus",1,true];

createMarker ["vlsMrk",[0,0,0]];
"vlsMrk" setMarkerAlpha 0;
"vlsMrk" setMarkerType "mil_destroy_noShadow";
"vlsMrk" setMarkerText "VLS Target";

_menuEntry = format ["Cruise Missile HE (%1 Missiles)",vlsHERounds];
lbAdd [9900501,_menuEntry];
_menuEntry = format ["Cruise Missile Cluster (%1 Missiles)",vlsClusterRounds];
lbAdd [9900501,_menuEntry];

lbSetCurSel [9900501,0];

[] onMapSingleClick {

	_firezoneCheck = false;

	{	
		_fireZoneCheck = _pos inArea _x;
	}forEach vlsNoFireZones;

	if (_fireZoneCheck) exitWith {
		["Target is in No Fire Zone!", "Error"] call BIS_fnc_guiMessage;
	};
	
	"vlsMrk" setMarkerPos _pos;
	"vlsMrk" setMarkerAlpha 1;
};

sleep 2;

if (findDisplay 99005 == displayNull) exitWith {
	hint "Error when calling Terminal"; 
	deleteMarker "vlsMrk";
	onMapSingleClick "";
	missionNameSpace setVariable ["vlsStatus",0,true];
};
