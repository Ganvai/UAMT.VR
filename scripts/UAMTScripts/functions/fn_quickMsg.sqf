//--------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------
//
//		Quick Message Function
//
// Sending formated Text to the caller.
// Meant to be used with remoteExec to send formated Messages to all Players quickly.
//
// Quick Method: ["Message"] remoteExec ["UAMT_fnc_quickMsg"];
//
// Method with all customisations:
// ["Message","Caller ID","SoundClass from CfgSound","ff8800",1,"fffff","PLAIN DOWN"] remoteExec ["UAMT_fnc_quickMsg"];
//
// If you want to use a default value, use 'nil' as value.
// ["Message","Caller ID",nil,nil,1,"fffff","PLAIN DOWN"] remoteExec ["UAMT_fnc_quickMsg"];
//--------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------
params ["_msg",["_id","TOC"],["_sound","Radio"],["_idSide",west],["_duration",1],["_txtColor","ffffff"],["_style","PLAIN DOWN"]];

_idColor = "FF004C99";

switch _idSide do {
	case east: {_idColor = "FF800000";};
	
	case independent: {_idColor = "FF008000";};
	
	case civilian: {_idColor = "FF660080";};
	
	default {_idColor = "FF004C99";};
};

//Building the Message string
_finalMsg = format ["<t color='#%1' size='1.5' shadow = '2'>%2: </t><t color='#%3' size='1.5' shadow = '2'>%4</t>",_idColor,_id,_txtColor,_msg];

if (_sound == "Radio") then {

	// If you give no Custom sound, the Function will play something that resembles a Radio Message
	
	// Plays a Pling
	playSound ["TacticalPing3",true];
	sleep 0.3;
	
	//Showing the formated Message
	titleText [_finalMsg, _style, _duration, true, true];
	
	// Plays Radio Chatter
	_radioSound = playSound ["RadioAmbient2",true];
	sleep 2.6;
	deleteVehicle _radioSound;
	
	// Plays a Pling
	playSound ["TacticalPing4",true];
}
else {
	// Plays the given Sound Class that has to be defined in CfgSounds
	playSound [_sound,true];
	// Needed to skip the Subtitles. If custom sound the Subtitle duration should be set to 0
	sleep 0.1;

	//Showing the formated Message
	titleText [_finalMsg, _style, _duration, true, true];
};



