if (missionNameSpace getVariable ["hfsStatus",0] > 1) exitWith {
	switch (missionNameSpace getVariable ["hfsStatus",0]) do {
		case 2 : {["Heli Fire Support not available. Heli Fire Support deployed.", "Error"] call BIS_fnc_guiMessage;};
		case 3 : {["Heli Fire Support not available. Refuelling and rearming Helicopters for new strike.", "Error"] call BIS_fnc_guiMessage;};
	};
};

[] spawn {
	sleep 1;

	if (findDisplay 99004 == displayNull) exitWith {
		hint "Error when calling Terminal"; 
		deleteMarkerLocal (player getVariable ["_hfsMrkLocal",""]);
		deleteMarkerLocal (player getVariable ["_hfsDirMrkLocal",""]);
		onMapSingleClick "";
	};
};

_display = createDialog ["hfsDialog"];

_map = _display ctrlCreate ["RscMapControl", -1];
_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];

_hfsCountLocal = (missionNameSpace getVariable ["hfsCount",0]) + 1;

_hfsMrkLocal = format ["hfsMrkLocal %1 %2",clientowner,_hfsCountLocal];
player setVariable ["hfsMrkLocal",_hfsMrkLocal];

_hfsMrkLocalText = format ["Heli Target %1",_hfsCountLocal];

createMarkerLocal [_hfsMrkLocal,[0,0,0]];
_hfsMrkLocal setMarkerAlphaLocal 0;
_hfsMrkLocal setMarkerTypeLocal "mil_destroy_noShadow";
_hfsMrkLocal setMarkerTextLocal _hfsMrkLocalText;

_hfsDirMrkLocal = format ["hfsDirMrkLocal %1 %2",clientowner,_hfsCountLocal];
player setVariable ["hfsDirMrkLocal",_hfsDirMrkLocal];

_hfsDirMrkLocalText = format ["Heli Approach Vector %1",_hfsCountLocal];

createMarkerLocal [_hfsDirMrkLocal,[0,0,0]];
_hfsDirMrkLocal setMarkerAlphaLocal 0;
_hfsDirMrkLocal setMarkerTypeLocal "mil_arrow_noShadow";
_hfsDirMrkLocal setMarkerTextLocal _hfsDirMrkLocalText;

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

[_display displayCtrl 9900403,_hfsMrkLocal,_hfsDirMrkLocal] onMapSingleClick {
	params ["_ctrl","_hfsMrkLocal","_hfsDirMrkLocal"];
	
	_hfsMrkLocal setMarkerPosLocal _pos;
	_hfsMrkLocal setMarkerAlphaLocal 1;
	"hfsDirMrk" setMarkerAlphaLocal 1;
	
	_dir = sliderPosition _ctrl;
	_hfsDirMrkLocal setMarkerPosLocal (_pos getPos [500,_dir]);
	_hfsDirMrkLocal setMarkerDirLocal (_dir + 180);
};

diag_log text format ["HFS Call - OnMapClick created - %1", profileName];


