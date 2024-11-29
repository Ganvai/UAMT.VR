params ["_weaponType"];

_side = side Player;

casPlaneAvailable = false;
publicVariable "casPlaneAvailable";

casPlanePosReturn = 0;
publicVariable "casPlanePosReturn";

casPlanePosTarget = 1;
publicVariable "casPlanePosTarget";

casPlaneReturn = 0;
publicVariable "casPlaneReturn";

_customAudio = supportCustomAudioMsg;

_supportControlName = supportControlName;

openMap true;

playsound "3DEN_notificationDefault";

titleText ["<t color='#ffffff' size='2' shadow = '2'>Choose the Attack Position for the CAS.</t>", "PLAIN DOWN", 2, true, true];

_mapCloseHandle = [] execVM "Scripts\UAMTScripts\CAS\casPlaneMapClose.sqf";

[_mapCloseHandle] onMapSingleClick {
	params ["_mapCloseHandle"];
	[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\CAS\casPlaneMapPos.sqf";
};

_timer = time;

waitUntil {sleep 0.5; casPlanePosReturn >= 1 || time - _timer > 180 };

if (casPlanePosReturn != 1) exitWith {

	switch casPlanePosReturn do  {
	
		case 0:  {
			Player onMapSingleClick "";
			terminate _mapCloseHandle;
			openMap false;
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>CAS Request timed out after 3 minutes while choosing an attack position.</t>", "PLAIN DOWN", 1, true, true];
		};
		
		case 3: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>CAS Request was cancelled by User while choosing an attack position.</t>", "PLAIN DOWN", 1, true, true];
		};

		case 4: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>CAS Request was cancelled because Position was in No Fire Zone.</t>", "PLAIN DOWN", 1, true, true];
		};

		case 5: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>CAS Request was cancelled because Map was closed while choosing an attack position.</t>", "PLAIN DOWN", 1, true, true];
		};
	};
	
	casPlaneAvailable = true;
	publicVariable "casPlaneAvailable";

};

titleText ["", "PLAIN DOWN", 0.01, true, true];

playsound "3DEN_notificationDefault";

titleText ["<t color='#ffffff' size='2' shadow = '2'>Choose an Approach Vektor for the CAS.</t>", "PLAIN DOWN", 2, true, true];

casPlanePosTarget = 2;
publicVariable "casPlanePosTarget";

[_mapCloseHandle] onMapSingleClick {
	params ["_mapCloseHandle"];
	[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\CAS\casPlaneApproachMapPos.sqf";
};

_timer = time;

waitUntil {sleep 0.5; casPlanePosReturn > 1 || time - _timer > 180 };

titleText ["", "PLAIN DOWN", 0.01, true, true];

if (casPlanePosReturn != 2) exitWith {
	
	deleteMarker casPlaneMarkerName;
	
	switch casPlanePosReturn do  {
	
		case 1:  {
			Player onMapSingleClick "";
			terminate _mapCloseHandle;
			openMap false;
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>CAS Request timed out after 3 minutes while choosing an approach vector.</t>", "PLAIN DOWN", 1, true, true];
		};
		
		case 3: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>CAS Request was cancelled by User while choosing an approach vector.</t>", "PLAIN DOWN", 1, true, true];
		};

		case 5: {
			playsound "addItemFailed";
			titleText ["<t color='#ff0000' size='2' shadow = '2'>CAS Request was cancelled because Map was closed while choosing an approach vector.</t>", "PLAIN DOWN", 1, true, true];
		};
	};
	
	casPlaneAvailable = true;
	publicVariable "casPlaneAvailable";
};


casPlaneStrikeCount = casPlaneStrikeCount + 1;
publicVariable "casPlaneStrikeCount";

_delayMike = ceil (casPlaneDelay / 60);

_msg = format ["All Units be advised: CAS is rerouted to your coordinates. ETA: %1 mike", _delayMike];

if (_customAudio) then {
	[_msg,_supportControlName,"msg_CASReroute",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};

sleep casPlaneDelay;

[[casPlaneClass,_weaponType,getMarkerPos casPlaneMarkerName,getMarkerPos casPlaneApproachMarker,_customAudio,_supportControlName,_side],"Scripts\UAMTScripts\CAS\casPlane.sqf"]remoteExec ["execVM",2];

waitUntil {sleep 1;casPlaneReturn > 0};

_cooldown = casPlaneCooldown;


if (casPlaneReturn == 4) then {

	if (casPlaneStrikeCount < casPlaneMaxCount) then {

		_cooldownMike = ceil (_cooldown / 60);
		
		_msg = format ["Be advised: CAS Aircraft is returning to holding pattern and preparing for new strike. ETA: %1 mike",_cooldownMike];
		
		if (_customAudio) then {
			[_msg,_supportControlName,"msg_CASPrepare",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
		
		sleep _cooldown;
		
		casPlaneAvailable = true;
		publicVariable "casPlaneAvailable";

		if (_customAudio) then {
			["Be advised: New CAS is available.",_supportControlName,"msg_CASAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			["Be advised: New CAS is available.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	}
	else {
		if (_customAudio) then {
			["Be advised: Aircraft is bingo ammo and RTB. No more CAS Strikes available.",_supportControlName,"msg_CASLastCAS",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			["Be advised: Aircraft is bingo ammo and RTB. No more CAS Strikes available.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};

}
else {
	switch casPlaneReturn do {

		// Destroyed on Approach
		case 1: {
					if (_customAudio) then {
						["All Units be advised: CAS Element was lost on approach.",_supportControlName,"msg_CASLostApproach",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
					}
					else {
						["All Units be advised: CAS Element was lost on approach.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
					};
					_cooldown = _cooldown + casPlaneCooldownPenalty;
				};
		
		//Destroyed during Attack
		case 2: {
					if (_customAudio) then {
						["All Units be advised: CAS Element was lost during Firemission.",_supportControlName,"msg_CASLostFire",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
					}
					else {
						["All Units be advised: CAS Element was lost during Firemission.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
					};
					_cooldown = _cooldown + casPlaneCooldownPenalty;		
				};

		//Destroyed on Extraction
		case 3: {
					if (_customAudio) then {
						["All Units be advised: CAS Element was lost on extraction.",_supportControlName,"msg_CASLostExtract",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
					}
					else {
						["All Units be advised: CAS Element was lost on extraction.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
					};
					_cooldown = _cooldown + casPlaneCooldownPenalty;				
				};
	};
	
	sleep 5;
	
	if (_customAudio) then {
		["No other CAS Aircrafts available. You are on your own now.",_supportControlName,"msg_CASNoCAS",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["No other CAS Aircrafts available. You are on your own now.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};	
};