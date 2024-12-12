if (hfsStatus > 0) exitWith {
	switch hfsStatus do {
		case 1 : {["Heli Fire Support not available. Another Element is currently requesting a Heli for fire support.", "Error"] call BIS_fnc_guiMessage;};
		case 2 : {["Heli Fire Support not available. Heli Fire Support deployed.", "Error"] call BIS_fnc_guiMessage;};
		case 3 : {["Heli Fire Support not available. Refuelling and rearming Helicopters for new strike.", "Error"] call BIS_fnc_guiMessage;};
	};
};

hfsStatus = 1;
publicVariable "hfsStatus";

createDialog "hfsDialog";

_map = findDisplay 99004 ctrlCreate ["RscMapControl", -1];
_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];

[] spawn {
	sleep 2;

	if (findDisplay 99004 == displayNull) exitWith {
		hint "Error when calling Terminal"; 
		deleteMarker "casStrikeMrk";
		deleteMarker "casDirMrk";
		onMapSingleClick "";
		hfsStatus = 0;
		publicVariable "hfsStatus";
	};
};

createMarker ["hfsMrk",[0,0,0]];
"hfsMrk" setMarkerAlpha 0;
"hfsMrk" setMarkerType "mil_destroy_noShadow";
"hfsMrk" setMarkerText "Heli Target";

createMarker ["hfsDirMrk",[0,0,0]];
"hfsDirMrk" setMarkerAlpha 0;
"hfsDirMrk" setMarkerType "mil_arrow_noShadow";
"hfsDirMrk" setMarkerText "Heli Approach Vector";

{
	_hfsClassName = _x select 0;
	_hfsCount = _x select 1;
	_hfsCalls = _x select 2;
	
	if (_hfsCount > 0 && _hfsCalls > 0) then {
		_hfsName = getText (configFile >> "CfgVehicles" >> _hfsClassName >> "displayName");
		_hfsMenuName = format ["%1 %2 (%3 left)",_hfsCount,_hfsName,_hfsCalls];
		
		lbAdd [9900401,_hfsMenuName];
		lbSetValue [9900401,_forEachIndex,_forEachIndex];
	};
}forEach hfsArray;

lbSetCurSel [9900401,0];

[] onMapSingleClick {
	"hfsMrk" setMarkerPos _pos;
	"hfsMrk" setMarkerAlpha 1;
	"hfsDirMrk" setMarkerAlpha 1;
	
	_dir = sliderPosition 9900403;
	"hfsDirMrk" setMarkerPos (_pos getPos [500,_dir]);
	"hfsDirMrk" setMarkerDir (_dir + 180);
};