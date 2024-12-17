if (missionNameSpace getVariable ["casStatus",0] > 0) exitWith {
	switch casStatus do {
		case 1 : {["CAS not available. Another Element is currently requesting a CAS Strike", "Error"] call BIS_fnc_guiMessage;};
		case 2 : {["CAS not available. CAS strike in progress", "Error"] call BIS_fnc_guiMessage;};
		case 3 : {["CAS not available. Rerouting plane for new strike.", "Error"] call BIS_fnc_guiMessage;};
	};
};

missionNameSpace setVariable ["casStatus",1,true];

_display = createDialog ["casStrikeDialog"];

_map = _display ctrlCreate ["RscMapControl", -1];
_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];

createMarkerLocal ["casStrikeMrk",[0,0,0]];
"casStrikeMrk" setMarkerAlphaLocal 0;
"casStrikeMrk" setMarkerTypeLocal "mil_destroy_noShadow";
"casStrikeMrk" setMarkerTextLocal "CAS Target";

createMarkerLocal ["casDirMrk",[0,0,0]];
"casDirMrk" setMarkerAlphaLocal 0;
"casDirMrk" setMarkerTypeLocal "mil_arrow_noShadow";
"casDirMrk" setMarkerTextLocal "CAS Approach Vector";

_weaponsControl = _display displayCtrl 9900301;

_line = format ["Machine Gun (%1 left)",casMGruns];
_weaponsControl lbAdd _line;
_weaponsControl lbSetData [1,"0"];

_line = format ["Missiles (%1 left)",casMisRuns];
_weaponsControl lbAdd _line;
_weaponsControl lbSetData [2,"1"];

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
_weaponsControl lbAdd _line;
_weaponsControl lbSetData [3,"2"];

_line = format ["Bombs (%1 left)",casBombRuns];
_weaponsControl lbAdd _line;
_weaponsControl lbSetData [4,"3"];

[] onMapSingleClick {

	_firezoneCheck = false;

	{	
		_fireZoneCheck = _pos inArea _x;
	}forEach casNoFireZones;

	if (_fireZoneCheck) exitWith {
		["Target is in No Fire Zone!", "Error"] call BIS_fnc_guiMessage;
	};
	
	"casStrikeMrk" setMarkerPosLocal _pos;
	"casStrikeMrk" setMarkerAlphaLocal 1;
	"casDirMrk" setMarkerAlphaLocal 1;
	
	_dir = sliderPosition 9900303;
	"casDirMrk" setMarkerPosLocal (_pos getPos [500,_dir]);
	"casDirMrk" setMarkerDirLocal (_dir + 180);
};

sleep 2;

if (findDisplay 99003 == displayNull) exitWith {
	hint "Error when calling Terminal"; 
	deleteMarkerLocal "casStrikeMrk";
	deleteMarkerLocal "casDirMrk";
	onMapSingleClick "";
	missionNameSpace setVariable ["casStatus",0,true];
};
