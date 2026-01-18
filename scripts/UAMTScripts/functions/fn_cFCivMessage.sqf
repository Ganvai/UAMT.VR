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
				_messageAudio = "msg_CivCas_1";
			};
	case 1 : {
				_messageText = "Goddammit, whats happening there? If you keep shooting Civilians we have to abort the mission.";
				_messageAudio = "msg_CivCas_2";
			};
	case 2 : {
				_messageText = "You've got a dead civilian there. This is unacceptable. Watch your shots.";
				_messageAudio = "msg_CivCas_3";
			};
	case 3 : {
				_messageText = "What the fuck is going on there. We will investigate this.";
				_messageAudio = "msg_CivCas_4";
			};
};

_id = getMissionConfigValue "supportControlName";

if (getMissionConfigValue "supportCustomAudio" == "false") then {
		_messageAudio = "Radio";
};

_messageText = format ["%1 Suspect: %2",_messageText, (name _killer)];

[_messageText,_id,_messageAudio,side _killer,1,"fffff","PLAIN DOWN"] call UAMT_fnc_quickMsg;
