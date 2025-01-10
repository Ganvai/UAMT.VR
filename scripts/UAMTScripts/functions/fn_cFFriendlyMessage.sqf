if (!isServer) exitWith {};

params ["_killer"];

_messageText = "";
_messageAudio = "";

_message = floor (random 4);

switch _message do {
	case 0 : {
				_messageText = "Fuck this. You are shooting our own troops.";
				_messageAudio = "cFFriendlyMsg_0";
			};
	case 1 : {
				_messageText = "God damit, stop shooting our own guys.";
				_messageAudio = "cFFriendlyMsg_1";
			};
	case 2 : {
				_messageText = "Friendly fire. I repeat: Friendly fire. Watch your shots!";
				_messageAudio = "cFFriendlyMsg_2";
			};
	case 3 : {
				_messageText = "What the fuck is going on there? Someone of you just shot a friendly.";
				_messageAudio = "cFFriendlyMsg_3";
			};
};

_id = getMissionConfigValue "supportControlName";

if (getMissionConfigValue "supportCustomAudio" == "false") then {
		_messageAudio = "Radio";
};

[_messageText,_killer,_id,_messageAudio] remoteExec  ["UAMT_fnc_cFquickMessage"];