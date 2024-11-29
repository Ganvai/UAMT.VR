params ["_casHeloClass","_casHeloCount"];

_side = side Player;
casHeloAvailable = false;
publicVariable "casHeloAvailable";

casHeloPosReturn = 0;
publicVariable "casHeloPosReturn";

casHeloReturn = 0;
publicVariable "casHeloReturn";

_customAudio = supportCustomAudioMsg;

_supportControlName = supportControlName;

openMap true;

playsound "3DEN_notificationDefault";

titleText ["<t color='#ffffff' size='2' shadow = '2'>Choose the Attack Position for the Helo CAS.</t>", "PLAIN DOWN", 2, true, true];

_mapCloseHandle = [] execVM "Scripts\UAMTScripts\CAS\casHeloMapClose.sqf";

[_mapCloseHandle] onMapSingleClick {
	params ["_mapCloseHandle"];
	[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\CAS\casHeloMapPos.sqf";
};

_timer = time;

waitUntil {sleep 0.5; casHeloPosReturn >= 1 || time - _timer > 180 };

titleText ["", "PLAIN DOWN", 0.01, true, true];

if (casHeloPosReturn != 1) exitWith {

	switch casHeloPosReturn do  {
	
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
	
	casHeloAvailable = true;
	publicVariable "casHeloAvailable";

};

casHeloStrikeCount = casHeloStrikeCount + 1;
publicVariable "casHeloStrikeCount";

if (_customAudio) then {
	["All Units be advised: CAS is being prepared.",_supportControlName,"msg_CASHeloPrepare",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	["All Units be advised: CAS is being prepared.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};

sleep casHeloDelay;

[[_casHeloClass,_casHeloCount,getMarkerPos casHeloMarkerName,getPosATL player,casHeloDuration,_customAudio,_supportControlName,_side],"Scripts\UAMTScripts\CAS\casHelo.sqf"] remoteExec ["execVM",2];

waitUntil {sleep 1;casHeloReturn > 0};

_cooldown = casHeloCooldown;

switch casHeloReturn do {

	// Destroyed on Approach
	case 1: {
				if (_customAudio) then {
					["All Units be advised: CAS Element was lost on approach.",_supportControlName,"msg_CASLostApproach",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				}
				else {
					["All Units be advised: CAS Element was lost on approach.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				};
				_cooldown = _cooldown + casHeloCooldownPenalty;
			};
	
	//Destroyed during Attack
	case 2: {
				if (_customAudio) then {
					["All Units be advised: CAS Element was lost during Firemission.",_supportControlName,"msg_CASLostFire",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				}
				else {
					["All Units be advised: CAS Element was lost during Firemission.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				};
				_cooldown = _cooldown + casHeloCooldownPenalty;
			};

	//Destroyed on Extraction
	case 3: {
				if (_customAudio) then {
					["All Units be advised: CAS Element was lost on extraction.",_supportControlName,"msg_CASHLostExtract",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				}
				else {
					["All Units be advised: CAS Element was lost on extraction.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				};
				_cooldown = _cooldown + casHeloCooldownPenalty;				
			};	
	
	default {
				if (_customAudio) then {
					["All Units be advised: CAS Element has returned to base.",_supportControlName,"msg_CASHeloReturn",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				}
				else {
					["All Units be advised: CAS Element has returned to base.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				};	
			};
};

sleep 5;

if (casHeloStrikeCount < casHeloMaxCount) then {

	_cooldownMike = ceil (_cooldown / 60);
	
	_msg = format ["New CAS is being prepared. ETA: %1 mike.",_cooldownMike];
	
	if (_customAudio) then {
		[_msg,_supportControlName,"msg_CASHeloNewPrepare",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
	
	sleep _cooldown;
	
	casHeloAvailable = true;
	publicVariable "casHeloAvailable";

	if (_customAudio) then {
		["Be advised: New Helo CAS is available.",_supportControlName,"msg_CASHeloAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["Be advised: New Helo CAS is available.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
}
else {
	if (_customAudio) then {
		["This was the last CAS by Helicopter available. We can't send anymore.",_supportControlName,"msg_CASHeloLast",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["This was the last CAS by Helicopter available. We can't send anymore.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};