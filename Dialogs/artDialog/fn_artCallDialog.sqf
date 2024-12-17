params ["_artIndex", "_ammoIndex", "_rounds", "_pattern", ["_radius",0]];

if (missionNameSpace getVariable ["artiStatus",0] >= 2) exitWith {
	["An artillery strike is already called and in progress. Wait until the Artilelry is available again.", "Error"] call BIS_fnc_guiMessage;
};

_targetPos = getMarkerPos "artMrk";

if (_targetPos isEqualTo [0,0,0]) exitWith {
	["No Target Set", "Error"] call BIS_fnc_guiMessage;
};

if (_artIndex == -1) exitWith {
	["No Artillery selected", "Error"] call BIS_fnc_guiMessage;
};

if (_ammoIndex == -1) exitWith {
	["No Ammo selected", "Error"] call BIS_fnc_guiMessage;
};

if (_rounds == 0) exitWith {
	["No Rounds given", "Error"] call BIS_fnc_guiMessage;
};

if (_pattern == -1) exitWith {
	["No Pattern selected", "Error"] call BIS_fnc_guiMessage;
};

//-------------------------------------------------------------------------------------------------------------
//	Fire Zone Check
//-------------------------------------------------------------------------------------------------------------
_fireZoneCheck = 0;
_mrkSize = 0;

//If Ammo is viable for Fire Zone Check make Firezone Check
if ((((fullArti select lbCurSel 9900101) select 2) select lbCurSel 9900102) select 3 == "true") then {
	{	
		if (_targetPos inArea _x) exitWith {_fireZoneCheck = 1;};
		
		if ((getMarkerSize _x) select 0 >= (getMarkerSize _x) select 1) then {
			_mrkSize = (getMarkerSize _x) select 0;
		}
		else {
			_mrkSize = (getMarkerSize _x) select 1;
		};
		
		if (_targetPos distance2D (getMarkerPos _x) < (_radius + _mrkSize)) exitWith {_fireZoneCheck = 2;};
	}forEach artiNoFireZones;
};

//If Position is in No-Fire zone and Ammo not allowed
if (_fireZoneCheck > 0) exitWith {
	if (_fireZoneCheck == 1) then {
		["Target Position is in No Fire Zone", "Error"] spawn BIS_fnc_guiMessage;
	}
	else {
		["Dispersion Radius is overlapping with No Fire Zone.", "Error"] spawn BIS_fnc_guiMessage;
	};
};


_artName = (fullArti select _artIndex) select 0;

_ammoName = (((fullArti select _artIndex) select 2) select _ammoIndex) select 1;

_patternName = "";
switch _pattern do {
	case 0 : {_patternName = "Rapid Fire";};
	case 1 : {_patternName = "Extended Disperion";};
	case 2 : {_patternName = "Area";};
	case 3 : {_patternName = "Inverted Dispersion";};
	case 4 : {_patternName = "Ring";};
};

_resultText = format ["You are calling an Artillery Strike with %1 , %2 rounds of %3 in %4 Mode in a Radius of %5 meter. Do you Confirm.",_artName,_rounds,_ammoName,_patternName,_radius];

_result = false;

private _result = [_resultText, "Confirm Artillery Firemission?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith{};

onMapSingleClick "";
closeDialog 0;
deleteMarkerLocal "artMrk";
deleteMarkerLocal "artMrkRadius";

[_targetPos,_artIndex,_ammoIndex,_rounds,_pattern,_radius,side player] spawn artDialog_fnc_artExecuteDialog;