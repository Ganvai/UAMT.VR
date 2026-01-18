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
// [_killer] call UAMT_fnc_cFCivMessage;
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
				_messageText = "Watch your shots. Friendly Fire.";
				_messageAudio = "msg_friendlyFire_1";
			};
	case 1 : {
				_messageText = "Goddammit! Stop shooting our own guys.";
				_messageAudio = "msg_friendlyFire_2";
			};
	case 2 : {
				_messageText = "Stop shooting. Friendly fire. I repeat: Friendly fire.";
				_messageAudio = "msg_friendlyFire_3";
			};
	case 3 : {
				_messageText = "What the fuck is going on there? Someone of you just shot a friendly.";
				_messageAudio = "msg_friendlyFire_4";
			};
};

_id = getMissionConfigValue "supportControlName";

if (getMissionConfigValue "supportCustomAudio" == "false") then {
		_messageAudio = "Radio";
};

_messageText = format ["%1 Suspect: %2",_messageText, (name _killer)];

[_messageText,_id,_messageAudio,side _killer,1,"fffff","PLAIN DOWN"] call UAMT_fnc_quickMsg;