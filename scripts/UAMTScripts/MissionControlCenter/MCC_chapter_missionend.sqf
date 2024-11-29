//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
//
//							MCC_chapter_missionend.sqf
//
// Ends the Mission with an automatic generated Sequence configured in config.cpp.
// Can be called by Zeus or Mission lead via Mission Control Center.
//
// Can be triggered also via script (second parameter "_scripted" = true).
//
// When Scripted, it is possible to give a custom ending sequence which needs also 
// a custom sleep value to end the mission when your custom sequnece is finished.
//
// call in script:
// [[_success,_scripted,_customSeq,_customSleep],"scripts\UAMTScripts\MissionControlCenter\MCC_chapter_missionend.sqf"]remoteExec ["execVM",2];
//
// Values:
// _success: Bool (optional) - Defines if the preconfigured Text from config.cpp for Success or for Continue is shown
// _scripted: Bool (optional) - Defines if the Sequence is ended by script and therefor does not show the control GUI to ask if you really want to end the Mission
// _customSeq: String (optional) - Sets the path to your custom Sequence in your Missionfolder
// _customSleep: Number (optional, needed when _customSeq is used) - Sets the sleep time this application will wait until it ends the Mission.
//																	Idealy it should be as long as your custom ending sequence. 
//																	Is ignored when no _customSeq is set!
//
//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------

params [["_success",true],["_scripted",false],["_customSeq",""],["_customSleep",0]];

_result = true;

if (!_scripted) then {
	sleep 0.5;
	_result = ["Do you want to end the Mission?", "Confirm", true, true] call BIS_fnc_guiMessage;
};

if (!_result) exitWith {};

_outroTrack = 0;
_line1 = "";
_line2 = "";
_line3 = "";

if (_success) then {
	_outroTrack = getMissionConfigValue "outroS";
	_line1 = getMissionConfigValue "successM";
	_line2 = getMissionConfigValue "secondSuccessM";
	_line3 = getMissionConfigValue "tySuccessM";
}
else {
	_outroTrack = getMissionConfigValue "outroC";
	_line1 = getMissionConfigValue "continueM";
	_line2 = getMissionConfigValue "secondContinueM";
	_line3 = getMissionConfigValue "tyContinueM";
};

if (_customSeq == "") then {
	[[_outroTrack,_line1,_line2,_line3],"scripts\UAMTScripts\MissionControlCenter\MCC_outro_generator.sqf"] remoteExec ["execVM"];
	
	_sleepy = 41;

	switch (_outroTrack) do
	{
		case "1": {_sleepy = 41;};
		case "2": {_sleepy = 77;};
		case "3": {_sleepy = 41;};
		case "4": {_sleepy = 55;};
		case "5": {_sleepy = 55;};
		case "6": {_sleepy = 39.5;};
		case "7": {_sleepy = 28;};
	};

	sleep _sleepy;
}
else {
	[[_outroTrack,_line1,_line2,_line3],_customSeq] remoteExec ["execVM"];
	sleep _customSleep;
};


if (_success) then {
	["End1", true, 0, false, false] remoteExec ["BIS_fnc_endMission", 0, true];
}
else {
	["End2", true, 0, false, false] remoteExec ["BIS_fnc_endMission", 0, true];
};
