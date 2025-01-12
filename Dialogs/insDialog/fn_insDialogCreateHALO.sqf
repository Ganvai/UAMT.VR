closeDialog 0;

if (missionNameSpace getVariable ["insertionActual",""] == "") then {

	_display = createDialog ["insDialogHALO"];

	_map = _display ctrlCreate ["RscMapControl", -1];
	_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];

	createMarkerLocal ["insHALOMrk",[0,0,0]];
	"insHALOMrk" setMarkerAlphaLocal 0;
	"insHALOMrk" setMarkerTypeLocal "mil_destroy_noShadow";
	"insHALOMrk" setMarkerTextLocal "HALO Drop Pos";

	createMarkerLocal ["insHALODirMrk",[0,0,0]];
	"insHALODirMrk" setMarkerAlphaLocal 0;
	"insHALODirMrk" setMarkerTypeLocal "mil_arrow_noShadow";
	"insHALODirMrk" setMarkerTextLocal "HALO Approach Vector";

	[] onMapSingleClick {
		
		"insHALOMrk" setMarkerPosLocal _pos;
		"insHALOMrk" setMarkerAlphaLocal 1;
		"insHALODirMrk" setMarkerAlphaLocal 1;
		
		_dir = sliderPosition 9900303;
		"insHALODirMrk" setMarkerPosLocal (_pos getPos [2000,_dir]);
		"insHALODirMrk" setMarkerDirLocal (_dir + 180);
	};
}
else {
	["An Insertion Method was already setup. Coordinate with your Team and avoid multiple Insertion requests!", "Error"] spawn BIS_fnc_guiMessage;
};
