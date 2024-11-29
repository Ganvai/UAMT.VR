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
	case 1 : { _radiocode = radio1; };
	case 2 : { _radiocode = radio2; };
	case 3 : { _radiocode = radio3; };
	case 4 : { _radiocode = radio4; };
	case 5 : { _radiocode = radio5; };
	case 6 : { _radiocode = radio6; };
	case 7 : { _radiocode = radio7; };
	case 8 : { _radiocode = radio8; };
	case 9 : { _radiocode = radio9; };
	case 10 : { _radiocode = radio10; };
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
[player,["Radio",["Radio Log",_logEntry]]] remoteExec ["createDiaryRecord",[0, -2]];

// Send the Radio message to all recipients
[[_radioCodeMessage],"scripts\UAMTScripts\RadioCode\radiomessage.sqf"] remoteExec ["execVM",recipients,false];

// Show the player the radio code he just sent as feedback

_logentryControl = format ["<t color='#0000ff' size='3'>Code Send</t><t color='#ffffff' size='3'>: %1</t>",_radiocode];

titleText [_logentryControl, "PLAIN DOWN", 0.8, true, true];
playSound "OMPhoneRingSMS";
