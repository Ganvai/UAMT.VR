if (!isServer) exitWith {};

params ["_hfsIndex","_side"];

_hfsArray = missionNameSpace getVariable ["hfsArray",0];

_audioMessages = getMissionConfigValue "supportMessages";
_customAudio = getMissionConfigValue "supportCustomAudio";
_supportControlName = getMissionConfigValue "supportControlName";

if (_audioMessages == "true") then {
	if (_customAudio == "true") then {
		["All Units: Helicopters were destroyed.",_supportControlName,"msg_hfsDestroyed",_side] remoteExec ["UAMT_fnc_quickMsg",2];
	}
	else {
		["All Units: Helicopters were destroyed.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",2];
	};
	
	sleep 3;
};


if (getMissionConfigValue "hfsRespawn" == "true") then {

	missionNameSpace setVariable ["hfsStatus",3,true];
	
	_cooldown = getMissionConfigValue "hfsCooldown" + getMissionConfigValue "hfsPenalty";
	
	if (_audioMessages == "true") then {
		
		_cooldownMike = ceil _cooldown / 60;
		
		_msg = format ["We will prepare a new Element. ETA:%1",_cooldownMike];
		if (_customAudio == "true") then {
			[_msg,_supportControlName,"msg_hfsPrepareNew",_side] remoteExec ["UAMT_fnc_quickMsg",2];
		}
		else {
			[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",2];
		};
		
		sleep 3;
	};

	_cooldown = getMissionConfigValue "hfsCooldown" + getMissionConfigValue "hfsPenalty";
		
	sleep _cooldown;

	missionNameSpace setVariable ["hfsStatus",0,true];
	
	if (_audioMessages == "true") then {
		if (_customAudio == "true") then {
			["All Units be advised: Helicopters are standing by for firesupport.",_supportControlName,"msg_hfsAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",2];
		}
		else {
			["All Units be advised: Helicopters are standing by for firesupport.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",2];
		};
	};
}
else {
	missionNameSpace setVariable ["hfsStatus",0,true];
	
	_hfsStillAvailable = false;
	{
		if ((_x select 1) > 0) then {
			_hfsStillAvailable = true;
		};
	} forEach _hfsArray;
	
	missionNameSpace setVariable ["hfsArray",_hfsArray,true];
	
	if _hfsStillAvailable then {
		if (_audioMessages == "true") then {
			if (_customAudio == "true") then {
				["Remaining Helicopters are on standby.",_supportControlName,"msg_hfsRemainingStandBy",_side] remoteExec ["UAMT_fnc_quickMsg",2];
			}
			else {
				["Remaining Helicopters are on standby.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",2];
			};
		};
	}
	else {
		if (_audioMessages == "true") then {
			if (_customAudio == "true") then {
				["No rotary wing elements remaining. Helicopter firesupport not available.",_supportControlName,"msg_hfsEnd",_side] remoteExec ["UAMT_fnc_quickMsg",2];
			}
			else {
				["No rotary wing elements remaining. Helicopter firesupport not available.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",2];
			};
		};
	};
};
