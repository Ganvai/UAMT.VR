if (missionNameSpace getVariable ["casStatus",0] > 1) exitWith {
	switch (missionNameSpace getVariable ["casStatus",0]) do {
		case 2 : {["CAS not available. CAS strike in progress", "Error"] spawn BIS_fnc_guiMessage;};
		case 3 : {["CAS not available. Rerouting plane for new strike.", "Error"] spawn BIS_fnc_guiMessage;};
	};
};

[] spawn {
	sleep 1;

	if (findDisplay 99003 == displayNull) exitWith {
		hint "Error when calling Terminal"; 
		deleteMarkerLocal (player getVariable ["casStrikeMrkLocal",""]);
		deleteMarkerLocal (player getVariable ["casStrikeDirMrkLocal",""]);
		onMapSingleClick "";
	};
};

_display = "";
_map = "";

if (getMissionConfigValue "paperInterface" == "true") then {
	_display = createDialog ["casDialogPaper"];
	_map = _display ctrlCreate ["RscMapControl", -1];
	_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.496,safeZoneY + safeZoneH * 0.142,safeZoneW * 0.343,safeZoneH * 0.705];

}
else {
	_display = createDialog ["casDialogTablet"];
	_map = _display ctrlCreate ["RscMapControl", -1];
	_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.232,safeZoneY + safeZoneH * 0.253,safeZoneW * 0.533,safeZoneH * 0.464];
};

_casStrikeMrkLocal = format ["CasStrike %1 - %2",clientowner,(missionnamespace getVariable ["casCount",0])];
player setVariable ["casStrikeMrkLocal",_casStrikeMrkLocal];

createMarkerLocal [_casStrikeMrkLocal,[0,0,0]];
_casStrikeMrkLocal setMarkerAlphaLocal 0;
_casStrikeMrkLocal setMarkerTypeLocal "mil_destroy_noShadow";
_casStrikeMrkLocal setMarkerTextLocal "CAS Target";

_casStrikeDirMrkLocal = format ["CasStrikeDir %1 - %2",clientowner,(missionnamespace getVariable ["casCount",0])];
player setVariable ["casStrikeDirMrkLocal",_casStrikeDirMrkLocal];

createMarkerLocal [_casStrikeDirMrkLocal,[0,0,0]];
_casStrikeDirMrkLocal setMarkerAlphaLocal 0;
_casStrikeDirMrkLocal setMarkerTypeLocal "mil_arrow_noShadow";
_casStrikeDirMrkLocal setMarkerTextLocal "CAS Approach Vector";

_weaponsControl = _display displayCtrl 9900301;

_line = format ["Machine Gun (%1 left)",(missionNameSpace getVariable ["casMGruns",0])];
_weaponsControl lbAdd _line;
_weaponsControl lbSetData [1,"0"];

_line = format ["Missiles (%1 left)",(missionNameSpace getVariable ["casMisRuns",0])];
_weaponsControl lbAdd _line;
_weaponsControl lbSetData [2,"1"];

_mmgRuns = 0;
if (missionNameSpace getVariable ["casMisRuns",0] > 0 && missionNameSpace getVariable ["casMGruns",0] > 0) then {
	if (missionNameSpace getVariable ["casMisRuns",0] > missionNameSpace getVariable ["casMGruns",0]) then {
		_mmgRuns = missionNameSpace getVariable ["casMGruns",0];
	}
	else {
		_mmgRuns = missionNameSpace getVariable ["casMisRuns",0];
	};
};

_line = format ["Miss + MG (%1 left)",_mmgRuns];
_weaponsControl lbAdd _line;
_weaponsControl lbSetData [3,"2"];

_line = format ["Bombs (%1 left)",(missionNameSpace getVariable ["casBombRuns",0])];
_weaponsControl lbAdd _line;
_weaponsControl lbSetData [4,"3"];

[] onMapSingleClick {

	_firezoneCheck = false;

	{	
		_fireZoneCheck = _pos inArea _x;
	}forEach getMissionConfigValue "casNoFireZones";

	if (_fireZoneCheck) exitWith {
		["Target is in No Fire Zone!", "Error"] spawn BIS_fnc_guiMessage;
	};
	
	(player getVariable ["casStrikeMrkLocal",""]) setMarkerPosLocal _pos;
	(player getVariable ["casStrikeMrkLocal",""]) setMarkerAlphaLocal 1;
	(player getVariable ["casStrikeDirMrkLocal",""]) setMarkerAlphaLocal 1;
	
	_dir = sliderPosition 9900303;
	(player getVariable ["casStrikeDirMrkLocal",""]) setMarkerPosLocal (_pos getPos [500,_dir]);
	(player getVariable ["casStrikeDirMrkLocal",""]) setMarkerDirLocal (_dir + 180);
};

