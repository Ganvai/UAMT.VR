if (!isServer) exitWith {};

params ["_hfsIndex","_side"];

_audioMessages = supportMessages;
_customAudio = supportCustomAudio;
_supportControlName = supportControlName;

if (_audioMessages) then {
	if (_customAudio) then {
		["All Units: Helicopters were destroyed.",_supportControlName,"msg_hfsDestroyed",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["All Units: Helicopters were destroyed.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
	
	sleep 3;
};


if (hfsRespawn) then {

	_cooldown = hfsCooldown + hfsPenalty;
	
	if (_audioMessages) then {
		
		_cooldownMike = ceil _cooldown / 60;
		
		_msg = format ["We will prepare a new Element. ETA:%1",_cooldownMike];
		if (_customAudio) then {
			[_msg,_supportControlName,"msg_hfsPrepareNew",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
		
		sleep 3;
	};

	_cooldown = hfsCooldown + hfsPenalty;
		
	sleep _cooldown;

	hfsAvailable = true;
	publicVariable "hfsAvailable";
	
	if (_audioMessages) then {
		if (_customAudio) then {
			["All Units be advised: Helicopters are standing by for fire support.",_supportControlName,"msg_hfsAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			["All Units be advised: Helicopters are standing by for fire support.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};
}
else {
	_hfsStillAvailable = false;
	{
		if ((_x select 1) > 0) then {
			_hfsStillAvailable = true;
		};
	} forEach hfsArray;
	
	if _hfsStillAvailable then {
		if (_audioMessages) then {
			if (_customAudio) then {
				["Remaining Helicopters are on standby.",_supportControlName,"msg_hfsRemainingStandBy",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			}
			else {
				["Remaining Helicopters are on standby.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			};
		};

		hfsAvailable = true;
		publicVariable "hfsAvailable";
	}
	else {
		if (_audioMessages) then {
			if (_customAudio) then {
				["No rotary wing elements remaining. Helicopter fire support not available.",_supportControlName,"msg_hfsEnd",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			}
			else {
				["No rotary wing elements remaining. Helicopter fire support not available.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			};
		};
	};
};
