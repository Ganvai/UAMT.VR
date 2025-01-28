//----------------------------------------------------------------------
//
//			Radio Code
//
// Create a new Radio Code message, log it in the radiolog Array and 
// send it to all recepients
// All calculcation is run on the senders machine so all other machines 
// have a minimum performance impact
//
//----------------------------------------------------------------------

//creating needed Variables
_code = _this select 0;
_playerGrp = groupId group player;
_playerName = name player;
_radiocode = "";
_exists = false;

//---------------------------------
//
//	Create Radio Message
//
//---------------------------------

// Choosing which code is sended
switch _code do
{
	case 1 : { _radiocode = getMissionConfigValue "radio1M"; };
	case 2 : { _radiocode = getMissionConfigValue "radio2M"; };
	case 3 : { _radiocode = getMissionConfigValue "radio3M"; };
	case 4 : { _radiocode = getMissionConfigValue "radio4M"; };
	case 5 : { _radiocode = getMissionConfigValue "radio5M"; };
	case 6 : { _radiocode = getMissionConfigValue "radio6M"; };
	case 7 : { _radiocode = getMissionConfigValue "radio7M"; };
	case 8 : { _radiocode = getMissionConfigValue "radio8M"; };
	case 9 : { _radiocode = getMissionConfigValue "radio9M"; };
	case 10 : { _radiocode = getMissionConfigValue "radio10M"; };
};

// Creating the log entry message
_radioCodeMessage = format ["<t color='#00ff00' size='3'>%1 </t><t color='#ffffff' size='3'>: %2</t>", _playerGrp, _radiocode];

// Creating the log entry for the whole platoon
_logEntry = format ["%1 | %2 | %3",_playerGrp,_playerName,_radiocode];


//---------------------------------
//
//	Sending the Code
//
//---------------------------------

// Creating Log Entry
[player,["Manual",["Radio Log",_logEntry]]] remoteExec ["createDiaryRecord",[0, -2]];

// Send the Radio message to all recipients
[[_radioCodeMessage],"scripts\UAMTScripts\RadioCode\radiomessage.sqf"] remoteExec ["execVM",missionNameSpace getVariable ["UAMT_RadioRecipients",[]],false];

// Show the player the radio code he just sent as feedback

_logentryControl = format ["<t color='#0000ff' size='3'>Code Send</t><t color='#ffffff' size='3'>: %1</t>",_radiocode];

titleText [_logentryControl, "PLAIN DOWN", 0.8, true, true];
playSound "OMPhoneRingSMS";
