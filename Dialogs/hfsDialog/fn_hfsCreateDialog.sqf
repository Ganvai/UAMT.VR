if (missionNameSpace getVariable ["hfsStatus",0] > 0) exitWith {
	switch (missionNameSpace getVariable ["hfsStatus",0]) do {
		case 1 : {["Heli Fire Support not available. Another Element is currently requesting fire support.", "Error"] call BIS_fnc_guiMessage;};
		case 2 : {["Heli Fire Support not available. Heli Fire Support deployed.", "Error"] call BIS_fnc_guiMessage;};
		case 3 : {["Heli Fire Support not available. Refuelling and rearming Helicopters for new strike.", "Error"] call BIS_fnc_guiMessage;};
	};
};

missionNameSpace setVariable ["hfsStatus",1,true];

diag_log text format ["HFS Call - Status set - %1", profileName];

_display = createDialog ["hfsDialog"];

diag_log text format ["HFS Call - Dialog Created - %1", profileName];

_map = _display ctrlCreate ["RscMapControl", -1];
_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];

diag_log text format ["HFS Call - Map Created - %1", profileName];

createMarkerLocal ["hfsMrk",[0,0,0]];
"hfsMrk" setMarkerAlphaLocal 0;
"hfsMrk" setMarkerTypeLocal "mil_destroy_noShadow";
"hfsMrk" setMarkerTextLocal "Heli Target";

createMarkerLocal ["hfsDirMrk",[0,0,0]];
"hfsDirMrk" setMarkerAlphaLocal 0;
"hfsDirMrk" setMarkerTypeLocal "mil_arrow_noShadow";
"hfsDirMrk" setMarkerTextLocal "Heli Approach Vector";

diag_log text format ["HFS Call - Marker Created - %1", profileName];

{
	_hfsClassName = _x select 0;
	_hfsCount = _x select 1;
	_hfsCalls = _x select 2;
	
	if (_hfsCount > 0 && _hfsCalls > 0) then {
		_hfsName = getText (configFile >> "CfgVehicles" >> _hfsClassName >> "displayName");
		_hfsMenuName = format ["%1 %2 (%3 left)",_hfsCount,_hfsName,_hfsCalls];
		
		_display displayCtrl 9900401 lbAdd _hfsMenuName;
		_display displayCtrl 9900401 lbSetValue [_forEachIndex,_forEachIndex];
	};
}forEach (missionNameSpace getVariable ["hfsArray",[]]);

diag_log text format ["HFS Call - Heli Box Filled - %1", profileName];

_display displayCtrl 9900401 lbSetCurSel 0;

diag_log text format ["HFS Call - Heli Box Select 0 - %1", profileName];

[_display displayCtrl 9900403] onMapSingleClick {
	params ["_ctrl"];
	
	"hfsMrk" setMarkerPosLocal _pos;
	"hfsMrk" setMarkerAlphaLocal 1;
	"hfsDirMrk" setMarkerAlphaLocal 1;
	
	_dir = sliderPosition _ctrl;
	"hfsDirMrk" setMarkerPosLocal (_pos getPos [500,_dir]);
	"hfsDirMrk" setMarkerDirLocal (_dir + 180);
};

diag_log text format ["HFS Call - OnMapClick created - %1", profileName];

sleep 1;

if (findDisplay 99004 == displayNull) exitWith {
	hint "Error when calling Terminal"; 
	deleteMarkerLocal "hfsMrk";
	deleteMarkerLocal "hfsDirMrk";
	onMapSingleClick "";
	missionNameSpace setVariable ["hfsStatus",0,true];
};
