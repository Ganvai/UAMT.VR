_side = side Player;

transportAvailable = false;
publicVariable "transportAvailable";

transportPosReturn = 0;
publicVariable "transportPosReturn";

transportPosTarget = 1;
publicVariable "transportPosTarget";

transportReturn = 0;
publicVariable "transportReturn";

_customAudio = supportCustomAudioMsg;

_supportControlName = supportControlName;

openMap true;

playsound "3DEN_notificationDefault";

titleText ["<t color='#ffffff' size='2' shadow = '2'>Choose the Transport Pick Up Position.<br/>Close the Map to cancel the Process!</t>", "PLAIN DOWN", 2, true, true];

_mapCloseHandle = [] execVM "Scripts\UAMTScripts\transport\transportMapClose.sqf";

[_mapCloseHandle] onMapSingleClick {
	params ["_mapCloseHandle"];
	[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\transport\transportPickupMapPos.sqf";
};

_timer = time;

waitUntil {sleep 0.5; transportPosReturn >= 1 || time - _timer > 180 };

if (transportPosReturn != 1) exitWith {

	switch transportPosReturn do  {
	
		case 0:  {
			Player onMapSingleClick "";
			terminate _mapCloseHandle;
			openMap false;
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>Transport Request timed out after 3 minutes while choosing the Pick Up Position.</t>", "PLAIN DOWN", 1, true, true];
		};
		
		case 3: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>Transport Request was cancelled while choosing the Pick Up Position.</t>", "PLAIN DOWN", 1, true, true];
		};

		case 5: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>Transport Request was cancelled because Map was closed while choosing the Pick Up Position.</t>", "PLAIN DOWN", 1, true, true];
		};
	};
	
	transportAvailable = true;
	publicVariable "transportAvailable";

};

titleText ["", "PLAIN DOWN", 0.01, true, true];

playsound "3DEN_notificationDefault";

titleText ["<t color='#ffffff' size='2' shadow = '2'>Choose a destination for the Transport.<br/>Close the Map to cancel the Process!</t>", "PLAIN DOWN", 2, true, true];

transportPosTarget = 2;
publicVariable "transportPosTarget";

[_mapCloseHandle] onMapSingleClick {
	params ["_mapCloseHandle"];
	[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\transport\transportTargetMapPos.sqf";
};

_timer = time;

waitUntil {sleep 0.5; transportPosReturn > 1 || time - _timer > 180 };

titleText ["", "PLAIN DOWN", 0.01, true, true];

if (transportPosReturn != 2) exitWith {
	
	deleteMarker "Transport Pick Up";
	
	switch transportPosReturn do  {
	
		case 1:  {
			Player onMapSingleClick "";
			terminate _mapCloseHandle;
			openMap false;
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>Transport Request timed out after 3 minutes while choosing a destination.</t>", "PLAIN DOWN", 1, true, true];
		};
		
		case 3: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>Transport Request was cancelled by User while choosing a destination.</t>", "PLAIN DOWN", 1, true, true];
		};

		case 4: {
			playsound "addItemFailed";
			titleText ["<t color='#ffffff' size='2'>Transport Call was </t><t color='#ff0000' size='2'>cancelled.<br/>Landingzone not clear! Try again and look for a clear area where the Helicopter can land.</t>", "PLAIN DOWN", 1, true, true];
		};
		
		case 5: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>Transport Request was cancelled because Map was closed while choosing a destination.</t>", "PLAIN DOWN", 1, true, true];
		};
	};
	
	transportAvailable = true;
	publicVariable "transportAvailable";
};


[[getMarkerPos "Transport Pick Up",getMarkerPos "Transport Destination",trpSpawnPos,trpVehicleClass,trpAllowDamage,_customAudio,_supportControlName,_side],"Scripts\UAMTScripts\transport\transportFly.sqf"]remoteExec ["execVM",2];

waitUntil {sleep 1;transportReturn > 0};

sleep 5;

_cooldown = trpDelay;

if (transportReturn == 1) then {
	_cooldown = _cooldown + trpDelayPenalty;
};

_coolDownMike = ceil (_cooldown / 60);
_msg = format ["Preparing Helicopter for new transport request. Available in: %1 Mike.",_coolDownMike];

if (_customAudio) then {
	[_msg,_supportControlName,"msg_transportRefuel",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};

deleteMarker "Transport Pick Up";
deleteMarker "Transport Destination";

sleep _cooldown;

transportAvailable = true;
publicVariable "transportAvailable";

if (_customAudio) then {
	["All Elements, be advised: Transport Helicopter is fuelled up and standing by.",_supportControlName,"msg_transportAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	["All Elements, be advised: Transport Helicopter is fuelled up and standing by.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};
