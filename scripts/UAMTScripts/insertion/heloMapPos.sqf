params ["_pos","_mapCloseHandle"];

if (count insHeloLzs >= count insHeloVeh) exitWith {

	//Something went really wrong
	if (count insHeloLzs  > count insHeloVeh) exitWith {
			insHeloSetReturn = 6;
			publicVariable "insHeloSetReturn";
	};
	
	terminate _mapCloseHandle;
	
	//Everything allright
	insHeloSetReturn = 1;
	publicVariable "insHeloSetReturn";
	
	Player onMapSingleClick "";
	
	openMap false;
};

playsound "click";
Player onMapSingleClick "";

_number = (count insHeloLZs) + 1;
_markerName = format ["LZ %1",_number];
createMarker [_markerName, _pos];
_markerName setMarkerType "hd_objective";
_markerName setMarkerColor "ColorBlack";
_markerName setMarkerText _markerName;

insHeloLZs pushback _markerName;

_result = false;

_msg = format ["Do you want to set the LZ for Helicopter %1",_number];
private _result = [_msg, "Confirm LZ?", true, true] call BIS_fnc_guiMessage;



if (!_result) exitWith {
	deleteMarker _markerName;
	
	insHeloLZs deleteAt ((count insHeloLZs) - 1);
	
	[_mapCloseHandle] onMapSingleClick {
		params ["_mapCloseHandle"];
		[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\insertion\heloMapPos.sqf";
	};

	playsound "addItemFailed";
	titleText ["<t color='#ffffff' size='2' shadow = '2'>Helicopter LZ Position was cancelled. Choose a new Landing Zone.<br/>Cancel Insertion Method by exiting the map.</t>", "PLAIN DOWN", 1, true, true];
};


if (count insHeloLzs >= count insHeloVeh) then {

	//Something went really wrong
	if (count insHeloLzs  > count insHeloVeh) exitWith {
			insHeloSetReturn = 6;
			publicVariable "insHeloSetReturn";
	};
	
	terminate _mapCloseHandle;
	
	//Everything allright
	insHeloSetReturn = 1;
	publicVariable "insHeloSetReturn";
	
	publicVariable "insHeloLZs";
	
	Player onMapSingleClick "";
	
	openMap false;
}
else {

	[_mapCloseHandle] onMapSingleClick {
		params ["_mapCloseHandle"];
		[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\insertion\heloMapPos.sqf";
	};

	titleText ["<t color='#ffffff' size='2' shadow = '2'>Helicopter LZ Position was set. Choose a Landing Zone for the next Helicopter.<br/>Cancel Insertion Method by exiting the map.</t>", "PLAIN DOWN", 1, true, true];
};




