//----------------------------------------------------------------
//----------------------------------------------------------------
//
//		Casualty Feature Friendly Message
//
// UAMT exclusive function. Only works with additional dependencies
// in UAMT config and initServer with customised Event Handler
//
// Triggered by Eventhandler on friendly units und chooses a
// random message to be played wenn a friendly unit is killed by a 
// player
//
// Attributes:
// _killer : <OBJECT> player who killed the civilian unit
//
// [_player] call UAMT_fnc_cFCivMessage;
//
//----------------------------------------------------------------
//----------------------------------------------------------------

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