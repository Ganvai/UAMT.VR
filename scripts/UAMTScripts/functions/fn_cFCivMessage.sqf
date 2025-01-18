//----------------------------------------------------------------
//----------------------------------------------------------------
//
//		Casualty Feature Civ Message
//
// UAMT exclusive function. Only works with additional dependencies
// in UAMT config and initServer with customised Event Handler
//
// Triggered by Eventhandler on civilian unit und chooses a
// random message to be played wenn a Civilian is killed by a 
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
				_messageText = "A civilian got shot. Position marked for further Investigations.";
				_messageAudio = "cFCivMsg_0";
			};
	case 1 : {
				_messageText = "God damit, whats happening there? If you keep shooting Civilians we have to abort the mission.";
				_messageAudio = "cFCivMsg_1";
			};
	case 2 : {
				_messageText = "You got a dead civilian there. We have to report this. This is unacceptable. Watch your shots.";
				_messageAudio = "cFCivMsg_2";
			};
	case 3 : {
				_messageText = "What the fuck is going on there. We will have to investigate this.";
				_messageAudio = "cFCivMsg_3";
			};
};

_id = getMissionConfigValue "supportControlName";

if (getMissionConfigValue "supportCustomAudio" == "false") then {
		_messageAudio = "Radio";
};

[_messageText,_killer,_id,_messageAudio] remoteExec  ["UAMT_fnc_cFquickMessage"];
