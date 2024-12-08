createDialog "vlsDialog";

_map = findDisplay 99005 ctrlCreate ["RscMapControl", -1];
_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];

vlsAvailable = false;
publicVariable "vlsAvailable";

createMarker ["vlsMrk",[0,0,0]];
"vlsMrk" setMarkerAlpha 0;
"vlsMrk" setMarkerType "mil_destroy_noShadow";
"vlsMrk" setMarkerText "VLS Target";

_menuEntry = format ["Cruise Missile HE (%1 Missiles)",vlsHERounds];
lbAdd [9900501,_menuEntry];
_menuEntry = format ["Cruise Missile Cluster (%1 Missiles)",vlsClusterRounds];
lbAdd [9900501,_menuEntry];

lbSetCurSel [9900501,0];

[] onMapSingleClick {
	"vlsMrk" setMarkerPos _pos;
	"vlsMrk" setMarkerAlpha 1;
};

sleep 1;

if (findDisplay 99005 == displayNull) exitWith {hint "Error when calling Terminal"; deleteMarker "vlsMrk";onMapSingleClick "";vlsAvailable = true;publicVariable "vlsAvailable";};
