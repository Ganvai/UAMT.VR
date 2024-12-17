_display = createDialog ["chtDialog"];

_map = _display ctrlCreate ["RscMapControl", -1];
_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];

{
	_heliName = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_display displayCtrl 9900601 lbAdd _heliName;
} forEach chtClasses;

_display displayCtrl 9900601 lbSetCurSel 0;

chtCount = chtCount + 1;
publicVariable "chtCount";

_chtNumber = chtCount;

_chtPickUpMrkName = format ["chtPickUpMrk%1",_chtNumber];
createMarker [_chtPickUpMrkName,[0,0,0]];
_chtPickUpMrkName setMarkerAlpha 0;
_chtPickUpMrkName setMarkerType "hd_pickup_noShadow";
_pickupmrkText = format ["Transport Pickup %1",_chtNumber];
_chtPickUpMrkName setMarkerText _pickupmrkText;

_display displayCtrl 9900602 lbSetData [0,_chtPickUpMrkName];

_chtDropOffMrkName = format ["chtDropOffMrk%1",_chtNumber];
createMarker [_chtDropOffMrkName,[0,0,0]];
_chtDropOffMrkName setMarkerAlpha 0;
_chtDropOffMrkName setMarkerType "hd_end_noShadow";
_dropoffmrkText = format ["Transport Drop-Off %1",_chtNumber];
_chtDropOffMrkName setMarkerText _dropoffmrkText;

_display setVariable ["chtCallPUMrk",_chtPickUpMrkName];
_display setVariable ["chtCallDOMrk",_chtDropOffMrkName];

_display displayCtrl 9900602 lbSetData [1,_chtDropOffMrkName];

[_display,_chtPickUpMrkName,_chtDropOffMrkName] onMapSingleClick {
	
	params ["_display","_pickup","_dropOff"];
	
	if ( lbCurSel (_display displayCtrl 9900602) == 0) then {
		_pickup setMarkerPos _pos;
		_pickup setMarkerAlpha 1;
		_pickup setMarkerAlpha 1;
	}
	else {
		_dropOff setMarkerPos _pos;
		_dropOff setMarkerAlpha 1;
		_dropOff setMarkerAlpha 1;	
	};
};

sleep 1;

if (findDisplay 99006 == displayNull) exitWith {
	hint "Error when calling Terminal"; 
	deleteMarker _chtPickUpMrkName;
	deleteMarker _chtDropOffMrkName;
	onMapSingleClick "";
	chtAvailable = true;
	publicVariable "chtAvailable";
};
