params  ["_heliVeh","_heliIndex","_side"];

_audioMessages = supportMessages;
_customAudio = supportCustomAudio;
_supportControlName = supportControlName;

deleteVehicleCrew _heliVeh;
_heliVeh setDamage 1;

if (_audioMessages) then {
	_msg = "All personal be advised: Transport Helicopter was destroyed.";

	if (_customAudio) then {
		[_msg,"TOC","msg_transportDestroyed",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		[_msg,"TOC","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};	

sleep 4;

if (getMissionConfigValue "chtRespawn" > 0) then {

	if (_audioMessages) then {
		_msg = "Preparing Helicopter for new transport request.";

		if (_customAudio) then {
			[_msg,"TOC","msg_transportRefuel",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			[_msg,"TOC","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};	

	_sleepy = parseNumber getMissionConfigValue  "chtRespawn";
	sleep _sleepy;
	
	_heliTempArray = missionNameSpace getVariable "chtHeliArray";
	(_heliTempArray select _heliIndex) set [1,true];

	missionNameSpace setVariable ["chtHeliArray",_heliTempArray,true];

	if (_audioMessages) then {
		_msg = "All personal be advised: Transport helicopter is fueled up and standing by.";

		if (_customAudio) then {
			[_msg,"TOC","msg_transportAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			[_msg,"TOC","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};
};