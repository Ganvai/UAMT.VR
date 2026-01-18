//--------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------
//
//		Quick Message Function
//
// Sending formated Text to the caller and play an optional sound with it.
// This is the Manager that handles the message queue. To play messages promptly without waiting for a queue set _QMqueue to false or use: UAMT_fnc_quickMessagePlay
//
//--------------------------------------------------------------------------------------------------------------------------
// PARAMETERS:
//
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
// _QMQueue = BOOL - Optional - Default: true - Adds the message to the global message queue. Recommended especially for messages with audio
//
//--------------------------------------------------------------------------------------------------------------------------
// EXECUTION:
//
// Quick Method: ["Message"] call UAMT_fnc_quickMsg;
//
// Method with all customisations:
// ["Message","Caller ID","SoundClassName","ff8800",1,"fffff","PLAIN DOWN"] call UAMT_fnc_quickMsg;
//
// If you want to use a default value, use 'nil' as value.
// ["Message","Caller ID",nil,nil,1,"fffff","PLAIN DOWN"] call UAMT_fnc_quickMsg;
//--------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------

// Backwards compatibility for old UAMT versions
if !(isServer) exitWith {};

params ["_msg",["_id",""],["_sound","Radio"],["_idColor",west],["_duration",0.5],["_txtColor","ffffff"],["_style","PLAIN DOWN"],["_QMqueue",true]];

_length = _duration;

// Check if the Message should be played on the global queue or with direct prompt -> Danger of overlapping audio recordings
if (_QMqueue) then {
	
	if (_sound != "Radio" && _sound != "") then {
		_cfgSoundArray = ["CFGSounds",_sound,"sound"] call BIS_fnc_getCfgDataArray;
		
		_soundPath = _cfgSoundArray select 0;
		
		_soundID = playSound3D [getMissionPath _soundPath,objNull,false,[0,0,0],0,1,1,0,true];
		
		_length = (soundParams _soundID) select 2;
	};

	_queueArr = [_msg,_id,_sound,_idColor,((_length + 1) / 10),_txtColor,_style,_length];
	
	(missionNameSpace getVariable ["UAMTQMqueue",[]]) pushback _queueArr;
}
else {
	[_msg,_id,_sound,_idColor,_duration,_txtColor,_style] remoteExec ["UAMT_fnc_quickMsgPlay"];
};