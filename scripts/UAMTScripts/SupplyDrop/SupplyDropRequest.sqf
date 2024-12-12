if (supplyDropStatus > 0) exitWith {
	switch supplyDropStatus do {
		case 1: {["Supply Drop NOT available. Another Player is currently ordering a supply Drop.", "Error"] call BIS_fnc_guiMessage;};
		case 2: {["Supply Drop NOT available. Supply Drop is currently being executed.", "Error"] call BIS_fnc_guiMessage;};
		case 3: {["Supply Drop NOT available. A new Supply Drop is currently being prepared.", "Error"] call BIS_fnc_guiMessage;};
		case 4: {["No Supply Drops available.", "Error"] call BIS_fnc_guiMessage;};
	};
};

if (supplyDropCount >= supplyDropMax) exitWith {
	["Supply Drop not available. All Supply Drops used.", "Error"] call BIS_fnc_guiMessage;
};

_side = side Player;

supplyDropPosReturn = 0;
publicVariable "supplyDropPosReturn";

supplyDropPosTarget = 1;
publicVariable "supplyDropPosTarget";

supplyDropReturn = 0;
publicVariable "supplyDropReturn";

_customAudio = supportCustomAudio;

_supportControlName = supportControlName;

openMap true;

playsound "3DEN_notificationDefault";

titleText ["<t color='#ffffff' size='2' shadow = '2'>Choose the Supply Drop Position.<br/>Close the Map to cancel the Process!</t>", "PLAIN DOWN", 2, true, true];

_mapCloseHandle = [] execVM "Scripts\UAMTScripts\SupplyDrop\supplyDropMapClose.sqf";

[_mapCloseHandle] onMapSingleClick {
	params ["_mapCloseHandle"];
	[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\SupplyDrop\supplyDropMapPos.sqf";
};

_timer = time;

waitUntil {sleep 0.5; supplyDropPosReturn >= 1 || time - _timer > 180 };

if (supplyDropPosReturn != 1) exitWith {

	switch supplyDropPosReturn do  {
	
		case 0:  {
			Player onMapSingleClick "";
			terminate _mapCloseHandle;
			openMap false;
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>Supply Drop Request timed out after 3 minutes while choosing the Drop Position.</t>", "PLAIN DOWN", 1, true, true];
		};
		
		case 3: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>Supply Drop Request was cancelled by User while choosing the Drop Position.</t>", "PLAIN DOWN", 1, true, true];
		};

		case 5: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>Supply Drop Request was cancelled because Map was closed while choosing the Drop Position.</t>", "PLAIN DOWN", 1, true, true];
		};
	};
	
	supplyDropAvailable = true;
	publicVariable "supplyDropAvailable";

};

titleText ["", "PLAIN DOWN", 0.01, true, true];

playsound "3DEN_notificationDefault";

titleText ["<t color='#ffffff' size='2' shadow = '2'>Choose an Approach Vektor for the Supply Drop.<br/>Close the Map to cancel the Process!</t>", "PLAIN DOWN", 2, true, true];

supplyDropPosTarget = 2;
publicVariable "supplyDropPosTarget";

[_mapCloseHandle] onMapSingleClick {
	params ["_mapCloseHandle"];
	[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\SupplyDrop\supplyDropApproachMapPos.sqf";
};

_timer = time;

waitUntil {sleep 0.5; supplyDropPosReturn > 1 || time - _timer > 180 };

titleText ["", "PLAIN DOWN", 0.01, true, true];

if (supplyDropPosReturn != 2) exitWith {
	
	deleteMarker supplyDropMarkerName;
	
	switch supplyDropPosReturn do  {
	
		case 1:  {
			Player onMapSingleClick "";
			terminate _mapCloseHandle;
			openMap false;
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>Supply Drop Request timed out after 3 minutes while choosing an approach vector.</t>", "PLAIN DOWN", 1, true, true];
		};
		
		case 3: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>Supply Drop Request was cancelled by User while choosing an approach vector.</t>", "PLAIN DOWN", 1, true, true];
		};

		case 5: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>Supply Drop Request was cancelled because Map was closed while choosing an approach vector.</t>", "PLAIN DOWN", 1, true, true];
		};
	};
	
	supplyDropAvailable = true;
	publicVariable "supplyDropAvailable";
};


supplyDropCount = supplyDropCount + 1;
publicVariable "supplyDropCount";

[[getMarkerPos supplyDropMarkerName,getMarkerPos supplyDropApproachMarker,SupplyDropMinDistSpawnConfig,supplyDropVehicleConfig,supplyDropPilotConfig,[],true,_customAudio,_supportControlName,_side],"Scripts\UAMTScripts\SupplyDrop\supplyDrop.sqf"]remoteExec ["execVM",2];

waitUntil {sleep 1;supplyDropReturn > 0};

sleep 5;

if (supplyDropCount < supplyDropMax) then {

	_cooldown = supplyDropDelay;
	
	if (supplyDropReturn == 1) then {
		_cooldown = _cooldown + supplyDropDelayPenalty;
	};
	
	_coolDownMike = ceil (_cooldown / 60);
	_msg = format ["We are preparing a new Supply Drop. Available in: %1 Mike.",_coolDownMike];

	if (_customAudio) then {
		[_msg,_supportControlName,"msg_supplyDropPrepare",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
	
	sleep _cooldown;
	
	supplyDropAvailable = true;
	publicVariable "supplyDropAvailable";

	if (_customAudio) then {
		["All Elements, be advised: New Supply Drop is available.",_supportControlName,"msg_supplyDropAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["All Elements, be advised: New Supply Drop is available.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
}
else {
	if (_customAudio) then {
		["This was the last Supply Drop available. We can't send anymore.",_supportControlName,"msg_supplyDropLast",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["This was the last Supply Drop available. We can't send anymore.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};