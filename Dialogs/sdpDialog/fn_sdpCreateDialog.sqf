_supplyDropStatus = missionNameSpace getVariable ["supplyDropStatus",0];

if (_supplyDropStatus > 1) exitWith {
	switch _supplyDropStatus do {
		case 2: {["Supply Drop NOT available. A supply drop is currently in progress.", "Error"] call BIS_fnc_guiMessage;};
		case 3: {["Supply Drop NOT available. A new Supply Drop is currently being prepared.", "Error"] call BIS_fnc_guiMessage;};
		case 4: {["No Supply Drops available.", "Error"] call BIS_fnc_guiMessage;};
	};
};

if ((missionNameSpace getVariable ["supplyDropCount",0]) >= (getMissionConfigValue "supplyDropMax")) exitWith {
	["Supply Drop not available. All Supply Drops used.", "Error"] call BIS_fnc_guiMessage;
};

[] spawn {
	sleep 1;

	if (findDisplay 99007 == displayNull) then {
		onMapSingleClick "";
		deleteMarkerLocal (player getVariable ["sdpMrkLocal",""]);
		deleteMarkerLocal (player getVariable ["sdpDirMrkLocal",""]);
	};
};

_display = createDialog ["sdpDialog"];

_map = _display ctrlCreate ["RscMapControl", -1];
_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];

_sdpMrkLocal = format ["sdpMrkLocal %1 %2",clientowner,((missionNameSpace getVariable ["supplyDropCount",0]) + 1)];
player setVariable ["sdpMrkLocal",_sdpMrkLocal];
_sdpMrkLocalText = format ["Supply Drop %1",((missionNameSpace getVariable ["supplyDropCount",0]) + 1)];

createMarkerLocal [_sdpMrkLocal,[0,0,0]];
_sdpMrkLocal setMarkerAlphaLocal 0;
_sdpMrkLocal setMarkerTypeLocal "mil_destroy_noShadow";
_sdpMrkLocal setMarkerTextLocal _sdpMrkLocalText;

_sdpDirMrkLocal = format ["sdpDirMrkLocal %1 %2",clientowner,((missionNameSpace getVariable ["supplyDropCount",0]) + 1)];
player setVariable ["sdpDirMrkLocal",_sdpDirMrkLocal];
_sdpDirMrkLocalText = format ["Approach Vector %1",((missionNameSpace getVariable ["supplyDropCount",0]) + 1)];

createMarkerLocal [_sdpDirMrkLocal,[0,0,0]];
_sdpDirMrkLocal setMarkerAlphaLocal 0;
_sdpDirMrkLocal setMarkerTypeLocal "mil_arrow_noShadow";
_sdpDirMrkLocal setMarkerTextLocal _sdpDirMrkLocalText;

[_sdpMrkLocal,_sdpDirMrkLocal] onMapSingleClick {
	params ["_sdpMrkLocal","_sdpDirMrkLocal"];
	
	_sdpMrkLocal setMarkerPosLocal _pos;
	_sdpMrkLocal setMarkerAlphaLocal 1;
	_sdpDirMrkLocal setMarkerAlphaLocal 1;
	
	_dir = sliderPosition 9900703;
	_sdpDirMrkLocal setMarkerPosLocal (_pos getPos [500,_dir]);
	_sdpDirMrkLocal setMarkerDirLocal (_dir + 180);
};

