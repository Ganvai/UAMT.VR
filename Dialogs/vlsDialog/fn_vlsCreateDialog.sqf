if ((missionNameSpace getVariable ["vlsStatus",0]) > 1) exitWith {
	switch (missionNameSpace getVariable ["vlsStatus",0]) do {
		case 2 : {["VLS not available. VLS strike in progress", "Error"] call BIS_fnc_guiMessage;};
		case 3 : {["VLS not available. Readying missile array after firemission.", "Error"] call BIS_fnc_guiMessage;};
	};
};

[] spawn {

	sleep 1;

	if (findDisplay 99005 == displayNull) exitWith {
		hint "Error when calling Terminal"; 
		deleteMarker (player getVariable ["vlsMrkLocal",""]);
		onMapSingleClick "";
	};
};

_display = "";
_map = "";

if (getMissionConfigValue "paperInterface" == "true") then {
	_display = createDialog ["vlsDialogPaper"];
	_map = _display ctrlCreate ["RscMapControl", -1];
	_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.496,safeZoneY + safeZoneH * 0.142,safeZoneW * 0.343,safeZoneH * 0.705];

}
else {
	_display = createDialog ["vlsDialogTablet"];
	_map = _display ctrlCreate ["RscMapControl", -1];
	_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.232,safeZoneY + safeZoneH * 0.253,safeZoneW * 0.533,safeZoneH * 0.464];
};

_vlsMrkLocal = format ["VLSMrkLocal %1 %2",clientowner,((missionNameSpace getVariable ["vlsCount",0]) + 1)];
player setVariable ["vlsMrkLocal",_vlsMrkLocal];
_vlsMrkText = format ["VLS Target %1",((missionNameSpace getVariable ["vlsCount",0]) + 1)];

createMarkerLocal [_vlsMrkLocal,[0,0,0]];
_vlsMrkLocal setMarkerAlphalocal 0;
_vlsMrkLocal setMarkerTypelocal "mil_destroy_noShadow";
_vlsMrkLocal setMarkerTextlocal _vlsMrkText;

_menuEntry = format ["Cruise Missile HE (%1 Missiles)",(missionNameSpace getVariable ["vlsHERounds",0])];
lbAdd [9900501,_menuEntry];
_menuEntry = format ["Cruise Missile Cluster (%1 Missiles)",(missionNameSpace getVariable ["vlsClusterRounds",0])];
lbAdd [9900501,_menuEntry];

lbSetCurSel [9900501,0];

[_vlsMrkLocal] onMapSingleClick {

	params ["_vlsMrkLocal"];

	_firezoneCheck = false;

	{	
		_fireZoneCheck = _pos inArea _x;
	}forEach getMissionConfigValue "vlsNoFireZones";

	if (_fireZoneCheck) exitWith {
		["Target is in No Fire Zone!", "Error"] call BIS_fnc_guiMessage;
	};
	
	_vlsMrkLocal setMarkerPos _pos;
	_vlsMrkLocal setMarkerAlpha 1;
};
