_result = false;
private _result = ["Do you want to insert by Helicopter?", "Insertion", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

closeDialog 0;

insHeloSetReturn = 0;
publicVariable "insHeloSetReturn";

insHeloSetReturnTarget = 1;
publicVariable "insHeloSetReturnTarget";

insControl = 1;
publicVariable "insControl";

insHeloLZs = [];
publicVariable "insHeloLZs";

openMap true;

playsound "3DEN_notificationDefault";

_heliCount = count insHeloVeh;

_msg = format ["<t color='#ffffff' size='2' shadow = '2'>Choose the Landing Zones for each Helicopter.<br/>You have %1 Helicopters available for transport.</t>",_heliCount];
titleText [_msg, "PLAIN DOWN", 2, true, true];

_mapCloseHandle = [] execVM "Scripts\UAMTScripts\insertion\heloMapClose.sqf";

[_mapCloseHandle] onMapSingleClick {
	params ["_mapCloseHandle"];
	[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\insertion\heloMapPos.sqf";
};

_timer = time;

waitUntil {sleep 0.5; insHeloSetReturn >= insHeloSetReturnTarget || time - _timer > 180 };

if (insHeloSetReturn != 1) exitWith {

	switch insHeloSetReturn do  {
		case 0:  {
			Player onMapSingleClick "";
			terminate _mapCloseHandle;
			openMap false;
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>Helo Insertion Setup timed out after 3 minutes.</t>", "PLAIN DOWN", 1, true, true];
		};

		case 5: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>Helo Insertion Setup was cancelled while choosing a Landing Zone.</t>", "PLAIN DOWN", 1, true, true];
		};

		case 6: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>More LZs then Helicopters. Bad Script Error. Please start again.</t>", "PLAIN DOWN", 1, true, true];
		};
	};
	
	{
		deleteMarker _x;
	} forEach insHeloLZs;
	
	insControl = 0;
	publicVariable "insControl";
};

[[side Player],"scripts\UAMTScripts\insertion\heloExecute.sqf"] remoteExec ["execVM",2];