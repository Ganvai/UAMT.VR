//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
//
//							MCC_chapter_missionstart.sqf
//
// Starts the Mission with an automatic generated Sequence configured in config.cpp.
// Can be called by Zeus or Mission lead via Mission Control Center.
//
// Can be triggered also via script (second parameter "_scripted" = true).
//
// When Scripted, it is possible to give a custom ending sequence
//
// call in script:
// [[_scripted,_customSeq],"scripts\UAMTScripts\MissionControlCenter\MCC_chapter_missionstart.sqf"]remoteExec ["execVM",2];
//
// Values:
// _scripted: Bool (optional) - Defines if the Sequence is ended by script and therefore does not show the control GUI to ask if you really want to start the Mission
// _customSeq: String (optional) - Sets the path to your custom Sequence in your Missionfolder
//
//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
params [["_scripted",false],["_customSeq",""]];

_result = true;

if (!_scripted) then {
	sleep 0.5;
	_result = ["Do you want to start the Mission?", "Confirm", true, true] call BIS_fnc_guiMessage;
};

if (!_result) exitWith {};

missionstarted = true;
publicVariable "missionstarted";


if (_customSeq == "") then {
	_intro = getMissionConfigValue "intro";
	_line1 = getMissionConfigValue "introM";
	_line2 = getMissionConfigValue "backgroundM";
	_line3 = getMissionConfigValue "missionM";
	_titleHeader = getMissionConfigValue "titleHeader";
	_title = getMissionConfigValue "title";
	_tickerCountry = getMissionConfigValue "tickerCountry";
	_tickerLocation = getMissionConfigValue "tickerLocation";

	[[_intro,_line1, _line2, _line3, _titleHeader, _title, _tickerCountry, _tickerLocation],"scripts\UAMTScripts\MissionControlCenter\MCC_intro_generator.sqf"] remoteExec ["execVM",[0, -2] select isDedicated];	
}
else {
	_customSeq remoteExec ["execVM"];
};