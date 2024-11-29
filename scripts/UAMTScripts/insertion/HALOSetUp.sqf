_result = false;
private _result = ["Do you want to insert by HALO-Jump?", "Insertion", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

closeDialog 0;

insHALOSetReturn = 0;
publicVariable "insHALOSetReturn";

insHALOSetReturnTarget = 1;
publicVariable "insHALOSetReturnTarget";

insControl = 1;
publicVariable "insControl";

openMap true;

playsound "3DEN_notificationDefault";
titleText ["<t color='#ffffff' size='2' shadow = '2'>Choose the HALO Drop Position.</t>", "PLAIN DOWN", 2, true, true];

_mapCloseHandle = [] execVM "Scripts\UAMTScripts\insertion\HALOMapClose.sqf";

[_mapCloseHandle] onMapSingleClick {
	params ["_mapCloseHandle"];
	[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\insertion\HALOMapPos.sqf";
};

_timer = time;

waitUntil {sleep 0.5; insHALOSetReturn >= insHALOSetReturnTarget || time - _timer > 180 };

if (insHALOSetReturn != 1) exitWith {

	switch insHALOSetReturn do  {
	
		case 0:  {
			Player onMapSingleClick "";
			terminate _mapCloseHandle;
			openMap false;
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>HALO Insertion Setup timed out after 3 minutes.</t>", "PLAIN DOWN", 1, true, true];
		};

		case 5: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>HALO Insertion Setup was cancelled while choosing a Drop Position.</t>", "PLAIN DOWN", 1, true, true];
		};

	};
	
	insControl = 0;
	publicVariable "insControl";
};

playsound "3DEN_notificationDefault";
titleText ["<t color='#ffffff' size='2' shadow = '2'>Choose an Approach Vektor for the HALO.<br/>Approach Vector must be at least 2000m away from the Drop Position and 500m away from the Aircraft Starting Position!</t>", "PLAIN DOWN", 2, true, true];

insHALOSetReturnTarget = 2;
publicVariable "insHALOSetReturnTarget";

[_mapCloseHandle] onMapSingleClick {
	params ["_mapCloseHandle"];
	[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\insertion\HALOApproachMapPos.sqf";
};

_timer = time;

waitUntil {sleep 0.5; insHALOSetReturn >= insHALOSetReturnTarget || time - _timer > 180 };

if (insHALOSetReturn != 2) exitWith {
	
	deleteMarker "Halo Drop Position";
	
	switch insHALOSetReturn do  {
	
		case 1:  {
			Player onMapSingleClick "";
			terminate _mapCloseHandle;
			openMap false;
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>HALO Insertion Setup timed out after 3 minutes.</t>", "PLAIN DOWN", 1, true, true];
		};

		case 5: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>HALO Insertion Setup was cancelled while choosing an approach vector Position.</t>", "PLAIN DOWN", 1, true, true];
		};
	};
	
	insControl = 0;
	publicVariable "insControl";
};

playsound "3DEN_notificationDefault";
titleText ["", "PLAIN DOWN", 1, true, true];

[[side player],"scripts\UAMTScripts\insertion\HALOexecute.sqf"] remoteExec ["execVM",2];