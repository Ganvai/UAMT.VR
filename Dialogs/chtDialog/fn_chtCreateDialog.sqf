[] spawn {
	sleep 1;

	if (findDisplay 99006 == displayNull) exitWith {
		hint "Error when calling Terminal"; 
		deleteMarkerLocal (player getVariable ["CHT_CallPUMrk",""]);
		deleteMarkerLocal (player getVariable ["CHT_CallDOMrk",""]);
		onMapSingleClick "";
		missionNameSpace setVariable ["chtStatus",0,true];
	};
};

_display = createDialog ["chtDialog"];

_map = _display ctrlCreate ["RscMapControl", -1];
_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];

{
	if (_x select 1 == true) then {
		_heliName = getText (configFile >> "CfgVehicles" >> (_x select 0) >> "displayName");
		_index  = _display displayCtrl 9900601 lbAdd _heliName;
		_display displayCtrl 9900601 lbSetValue [_index, _forEachIndex];
	};
} forEach (missionNameSpace getVariable "chtHeliArray");

if (lbSize (_display displayCtrl 9900601)  == 0) exitWith {
	closeDialog 0;
	["All Helicopters currently in use", "Error"] call BIS_fnc_guiMessage;
};

_display displayCtrl 9900601 lbSetCurSel 0;

_chtNumber = (missionNameSpace getVariable ["chtCount",0]) + 1;
player setVariable ["CHT_CallCount",_chtNumber];

_chtPickUpMrkName = format ["chtPickUpMrk%1 %2",_chtNumber,clientowner];

createMarkerLocal [_chtPickUpMrkName,[0,0,0]];
_chtPickUpMrkName setMarkerAlphaLocal 0;
_chtPickUpMrkName setMarkerTypeLocal "hd_pickup_noShadow";
_pickupmrkText = format ["Transport %1 Pickup",_chtNumber];
_chtPickUpMrkName setMarkerTextLocal _pickupmrkText;

_display displayCtrl 9900602 lbSetData [0,_chtPickUpMrkName];

_chtDropOffMrkName = format ["chtDropOffMrk%1 %2",_chtNumber,clientowner];

createMarkerLocal [_chtDropOffMrkName,[0,0,0]];
_chtDropOffMrkName setMarkerAlphaLocal 0;
_chtDropOffMrkName setMarkerTypeLocal "hd_end_noShadow";
_dropoffmrkText = format ["Transport %1 Drop-Off",_chtNumber];
_chtDropOffMrkName setMarkerTextLocal _dropoffmrkText;

player setVariable ["CHT_CallPUMrk",_chtPickUpMrkName];
player setVariable ["CHT_CallDOMrk",_chtDropOffMrkName];

player setVariable ["CHT_puMrkTxtClean",_pickupmrkText];
player setVariable ["CHT_doMrkTxtClean",_dropoffmrkText];

_display displayCtrl 9900602 lbSetData [1,_chtDropOffMrkName];

[_display,_chtPickUpMrkName,_chtDropOffMrkName] onMapSingleClick {
	
	params ["_display","_pickup","_dropOff"];
	
	if ( lbCurSel (_display displayCtrl 9900602) == 0) then {
		_pickup setMarkerPosLocal _pos;
		_heliName = _display displayCtrl 9900601 lbText (lbCurSel (_display displayCtrl 9900601));
		_markerTxt = format ["%1 (%2)",player getVariable "CHT_puMrkTxtClean" ,_heliName];
		_pickup setMarkerTextLocal _markerTxt;
		_pickup setMarkerAlphaLocal 1;
	}
	else {
		_dropOff setMarkerPos _pos;
		_heliName = _display displayCtrl 9900601 lbText (lbCurSel (_display displayCtrl 9900601));
		_markerTxt = format ["%1 (%2)",player getVariable "CHT_doMrkTxtClean" ,_heliName];
		_dropOff setMarkerTextLocal _markerTxt;
		_dropOff setMarkerAlphaLocal 1;
	};
};


