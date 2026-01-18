//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//
//		Quick Message Play Function
//
// Showing a text message on the screen and optional playing sound.
// Meant to be used with remoteExec to send formated Messages to all Players quickly. This is so the HTML formatted text is not filtered in Multiplayer!
//
// IMPORTANT: If you want to avoid overlapping audio messages use UAMT_fnc_quickMessage with QMqueue parameter 'true'. This will add all 
// quick messages to a queue and play them one after another with a short break to avoid audio clusterfucks
//
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//
// PARAMETERS:
// _msg = STRING or ARRAY - Message text to be displayed. Can be a STRING or an Array of Strings. When array, each Array Element is a line that gets seperated with a linebreak (<br/>)
//
// _id = STRING - Optional - Default "" (nothing) - Name of the Caller giving the message - can be "" to show only the _msg text
//
// _sound = STRING - Optional - Default: "Radio" -  Classname of Sound to be played. Can be "Radio" to play generic Radio noise. 
//													Can be "" to not play any sound and just show the text. Only classes from CFGSounds
//
// _idColor = STRING or SIDE - Optional - Default: west (BluFor blue) - Color for the ID. If SIDE, the standard color from the side is chosen. 
//																		If STRING it has to be a RGB color Code WITHOUT the leading '#'
//
// _duration = NUMBER - Optional - Default: 0.5 (5 Seconds) - How long the message will be displayed. Number is * 10, so giving a 1 means the message will be displayed 10 seconds.
//
// _txtColor = STRING - Optional - Default: "ffffff" (White) - Color the text is displayed in. Has to be a six digit RGB code without the leading '#'
//
// _style = STRING - Optional - Default: "PLAIN DOWN" - Style the message is displayed in. See titleText Effect Types for more Options
//
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//
// EXECUTION:
//
// Method with all customisations:
// ["Message","Caller ID","SoundClass from CfgSound","ff8800",1,"fffff","PLAIN DOWN"] remoteExec ["UAMT_fnc_quickMsg"];
//
// If you want to use a default value, use 'nil' as value.
// ["Message","Caller ID",nil,nil,1,"fffff","PLAIN DOWN"] remoteExec ["UAMT_fnc_quickMsg"];
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// For Server Performance
if (isDedicated) exitWith {};

params ["_msg",["_id",""],["_sound","Radio"],["_idColor",west],["_duration",0.5],["_txtColor","ffffff"],["_style","PLAIN DOWN"]];

// Defining variable for later
_finalMsg = "";

// If an _id is given, set it to the beginning of the _finalMsg variable
if (_id != "") then {

	// If a Side is given for _idColor then get the default color from that side
	if (typeName _idColor == "SIDE") then {
		switch _idColor do {
			case east: {_idColor = "FF800000";};
			
			case independent: {_idColor = "FF008000";};
			
			case civilian: {_idColor = "FF660080";};
			
			//Using Blu-For color as default value
			default {_idColor = "FF004C99";};
		};
	};
	
	// Set ID with color format at the beginning of the displayed message
	_finalMsg = format ["<t color='#%1' size='1.5' shadow = '2'>%2: </t>", _idColor, _id];
};

// Evaluating if Message is single or multi lined
if (typeName _msg == "STRING") then {
	// If message is single lined we can just put the _msg String in the final output
	_finalMsg = format ["%1<t color='#%2' size='1.5' shadow = '2'>%3</t>", _finalMsg, _txtColor, _msg];
}
else {
	// Getting the first line of the multi lined message
	_finalMsg = format ["%1<t color='#%2' size='1.5' shadow = '2'>%3</t>", _finalMsg, _txtColor, _msg select 0];
	
	// Delete the first line
	_msg = _msg deleteAt 0;

	// Add all other lines to the message and add a linebreak before it.
	{
		_finalMsg = format ["%1<br/><t color='#%2' size='1.5' shadow = '2'>%3</t>", _finalMsg, _txtColor, _x];
	}forEach _msg;
};

// Evaluate if a sound is given and should be played
if (_sound != "") then {
	if (_sound == "Radio") then {
		// If you give no Custom sound, the Function will play a vanilla random radio noise
		
		// The spawn is used to arrange the sounds so it feels like an actual radio call
		[] spawn {
			// Plays a Pling
			playSound ["TacticalPing3",true];
			sleep 0.3;
						
			// Plays Radio Chatter
			_radioSound = playSound ["RadioAmbient2",true];
			sleep 2.6;
			deleteVehicle _radioSound;
			
			// Plays a Pling
			playSound ["TacticalPing4",true];
		};
	}
	else {
		// Plays the given Sound Class that has to be defined in CfgSounds
		playSound [_sound,true];
		
		// Needed to skip the Subtitles. If custom sound the Subtitle duration should be set to 0 in CFGSounds
		sleep 0.1;
	};
};

//Showing the formated Message
titleText [_finalMsg, _style, _duration, true, true];
