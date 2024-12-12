if (casStatus > 0) exitWith {
	switch casStatus do {
		case 1 : {["CAS not available. Another Element is currently requesting a CAS Strike", "Error"] call BIS_fnc_guiMessage;};
		case 2 : {["CAS not available. CAS strike in progress", "Error"] call BIS_fnc_guiMessage;};
		case 3 : {["CAS not available. Rerouting plane for new strike.", "Error"] call BIS_fnc_guiMessage;};
	};
};

casStatus = 1;
publicVariable "casStatus";

createDialog "casStrikeDialog";

_map = findDisplay 99003 ctrlCreate ["RscMapControl", -1];
_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];

createMarker ["casStrikeMrk",[0,0,0]];
"casStrikeMrk" setMarkerAlpha 0;
"casStrikeMrk" setMarkerType "mil_destroy_noShadow";
"casStrikeMrk" setMarkerText "CAS Target";

createMarker ["casDirMrk",[0,0,0]];
"casDirMrk" setMarkerAlpha 0;
"casDirMrk" setMarkerType "mil_arrow_noShadow";
"casDirMrk" setMarkerText "CAS Approach Vector";

_line = format ["Machine Gun (%1 left)",casMGruns];
lbAdd [9900301,_line];
lbSetData [9900301,1,"0"];

_line = format ["Missiles (%1 left)",casMisRuns];
lbAdd [9900301,_line];
lbSetData [9900301,2,"1"];

_mmgRuns = 0;
if (casMisRuns > 0 && casMGruns > 0) then {
	if (casMisRuns > casMGruns) then {
		_mmgRuns = casMGruns;
	}
	else {
		_mmgRuns = casMisRuns;
	};
};

_line = format ["Miss + MG (%1 left)",_mmgRuns];
lbAdd [9900301,_line];
lbSetData [9900301,3,"2"];

_line = format ["Bombs (%1 left)",casBombRuns];
lbAdd [9900301,_line];
lbSetData [9900301,4,"3"];

[] onMapSingleClick {

	_firezoneCheck = false;

	{	
		_fireZoneCheck = _pos inArea _x;
	}forEach casNoFireZones;

	if (_fireZoneCheck) exitWith {
		["Target is in No Fire Zone!", "Error"] call BIS_fnc_guiMessage;
	};
	
	"casStrikeMrk" setMarkerPos _pos;
	"casStrikeMrk" setMarkerAlpha 1;
	"casDirMrk" setMarkerAlpha 1;
	
	_dir = sliderPosition 9900303;
	"casDirMrk" setMarkerPos (_pos getPos [500,_dir]);
	"casDirMrk" setMarkerDir (_dir + 180);
};

sleep 2;

if (findDisplay 99003 == displayNull) exitWith {
	hint "Error when calling Terminal"; 
	deleteMarker "casStrikeMrk";
	deleteMarker "casDirMrk";
	onMapSingleClick "";
	casStatus = 0;
	publicVariable "casStatus";
};
