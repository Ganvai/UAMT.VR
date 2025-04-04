closeDialog 0;

if (missionNameSpace getVariable ["insertionActual",""] == "") then {

	_display = "";
	_map = "";

	if (getMissionConfigValue "paperInterface" == "true") then {
		_display = createDialog ["insDialogHALOPaper"];
		_map = _display ctrlCreate ["RscMapControl", -1];
		_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.496,safeZoneY + safeZoneH * 0.142,safeZoneW * 0.343,safeZoneH * 0.705];

	}
	else {
		_display = createDialog ["insDialogHALO"];
		_map = _display ctrlCreate ["RscMapControl", -1];
		_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];
	};

	_markerInsHALOLocal = format ["%1 insHALOMrk",clientowner];
	player setVariable ["insHaloMrkLocal",_markerInsHALOLocal];
	
	createMarkerLocal [_markerInsHALOLocal,[0,0,0]];
	_markerInsHALOLocal setMarkerTypeLocal "mil_destroy_noShadow";
	_markerInsHALOLocal setMarkerTextLocal "HALO Drop Pos";

	_markerInsHALODirLocal = format ["%1 insHALODirMrk",clientowner];
	player setVariable ["insHALODirMrkLocal",_markerInsHALODirLocal];
	
	createMarkerLocal [_markerInsHALODirLocal,[0,0,0]];
	_markerInsHALODirLocal setMarkerTypeLocal "mil_arrow_noShadow";
	_markerInsHALODirLocal setMarkerTextLocal "HALO Approach Vector";

	[] onMapSingleClick {
		
		(player getVariable "insHaloMrkLocal") setMarkerPosLocal _pos;
		
		_dir = sliderPosition 9910303;
		(player getVariable "insHALODirMrkLocal") setMarkerPosLocal (_pos getPos [800,_dir]);
		(player getVariable "insHALODirMrkLocal") setMarkerDirLocal (_dir + 180);
	};
}
else {
	["An Insertion Method was already setup. Coordinate with your Team and avoid multiple Insertion requests!", "Error"] spawn BIS_fnc_guiMessage;
};
