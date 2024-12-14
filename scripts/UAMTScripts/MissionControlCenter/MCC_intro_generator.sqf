if (isDedicated) exitWith {};

params ["_intro","_line1","_line2","_line3","_titleHeader","_title","_tickerCountry","_tickerLocation"];

//Initialising Variables
_introTrack = "";
_trackStart = 0;
_fadeInTime = 1;
_fadeOutTime = 1;
_startWait = 1;
_introWait = 1;
_backgroundWait = 1;
_missionWait = 1;
_titleWait = 1;

_ttline1 = format ["<t color='#ffffff' size='2'>%1</t>",_line1];
_ttline2 = format ["<t color='#ffffff' size='2'>%1</t>",_line2];
_ttline3 = format ["<t color='#ffffff' size='2'>%1</t>",_line3];
_ttline4 = format ["<t color='#ffffff' size='1'>%1<br/>____________________</t><br/><t color='#ffffff' size='5'>%2</t><br/><br/><img image='images\Clan-Logo.paa' shadow='0' size='8'/>",_titleHeader,_title];

//Switch to choose track and set Times
switch (_intro) do {
	case 1: {
				//set introTrack
				_introTrack = "LeadTrack01a_F";
				//set Track start
				_trackStart = 5;
				//set fadeInTime
				_fadeInTime = 2;
				//set fadeOutTime
				_fadeOutTime = 2;
				//set startWait
				_startWait = 4;				
				//set introWait
				_introWait = 21;
				//set backgroundWait
				_backgroundWait = 21;
				//set missionWait
				_missionWait = 21;
				//set titleWait
				_titleWait = 6;
	};
	case 2: {
				//set introTrack
				_introTrack = "LeadTrack01_F_Jets";
				//set Track start
				_trackStart = 29;
				//set fadeInTime
				_fadeInTime = 1;
				//set fadeOutTime
				_fadeOutTime = 8;
				//set startWait
				_startWait = 3.5;				
				//set introWait
				_introWait = 20;
				//set backgroundWait
				_backgroundWait = 20;
				//set missionWait
				_missionWait = 20;
				//set titleWait
				_titleWait = 5;
	};
	case 3: {
				//set introTrack
				_introTrack = "LeadTrack01_F_Heli";
				//set Track start
				_trackStart = 43;
				//set fadeInTime
				_fadeInTime = 1;
				//set fadeOutTime
				_fadeOutTime = 8;
				//set startWait
				_startWait = 1;				
				//set introWait
				_introWait = 16;
				//set backgroundWait
				_backgroundWait = 16;
				//set missionWait
				_missionWait = 16;
				//set titleWait
				_titleWait = 3;
	};
	case 4: {
				//set introTrack
				_introTrack = "LeadTrack03_F_Tacops";
				//set Track start
				_trackStart = 30;
				//set fadeInTime
				_fadeInTime = 1;
				//set fadeOutTime
				_fadeOutTime = 10;
				//set startWait
				_startWait = 1;				
				//set introWait
				_introWait = 18;
				//set backgroundWait
				_backgroundWait = 18;
				//set missionWait
				_missionWait = 18;
				//set titleWait
				_titleWait = 5;
	};
	case 5: {
				//set introTrack
				_introTrack = "LeadTrack01_F_EPA";
				//set Track start
				_trackStart = 35;
				//set fadeInTime
				_fadeInTime = 1;
				//set fadeOutTime
				_fadeOutTime = 20;
				//set startWait
				_startWait = 1;				
				//set introWait
				_introWait = 17;
				//set backgroundWait
				_backgroundWait = 17;
				//set missionWait
				_missionWait = 17;
				//set titleWait
				_titleWait = 5;
	};
	case 6: {
				//set introTrack
				_introTrack = "MainTheme_F_Tank";
				//set Track start
				_trackStart = 133;
				//set fadeInTime
				_fadeInTime = 1;
				//set fadeOutTime
				_fadeOutTime = 20;
				//set startWait
				_startWait = 1;				
				//set introWait
				_introWait = 22;
				//set backgroundWait
				_backgroundWait = 22;
				//set missionWait
				_missionWait = 22;
				//set titleWait
				_titleWait = 5;
	};
};

//Needed for fadeMusic to work
ace_hearing_disableVolumeUpdate = true;

// Set threshold for NVGs
_brightness = 50;

//set Music to zero for FadeIn
0 fadeMusic 0;

// Debug Play, needed because sometimes Arme has problems starting a Track
// that is not defined in the Missions CfGMusic.
playMusic _introTrack;

sleep 0.1;

playMusic [_introTrack,_trackStart];
_fadeInTime fadeMusic 1;

sleep _startWait;

player action ["nvGogglesOff", player];

//Camera creating
_camera = "camera" camCreate [0,0,0];
_camera cameraEffect ["internal","back"];
camUseNVG false;
showCinemaBorder true;

_target = player;
_height = 2;

_camera camSetpos position _target;
_camera camSettarget _target;
_center = [position _target select 0, position _target select 1,_height];
_camera camSetPos _center;
_camera camSetTarget _target;
_camera camCommit 0;

//-------------------------------------------------------------
// Intro Message
//-------------------------------------------------------------
titleText [_ttline1, "PLAIN", 3, true, true];

_sleep = _introWait / 120;

//Intro Cam Movement up from Player

_range = 60;

_camera camSetRelPos [0,_range,4];
_camera camCommit 0;

//NVG or not
if (((getLightingAt _camera ) select 3 )> _brightness || ((getLightingAt _camera ) select 1 ) > 0.4) then {
	camUseNVG false;
}
else {
	camUseNVG true;
};

//Zoom in on Player
while {_range > -60} do {
	_range = _range - 1;

	_camera camSetRelPos [0,_range,4];
	_camera camCommit _sleep;
	sleep _sleep;
};

//-------------------------------------------------------------
// Background Message
//-------------------------------------------------------------
titleText [_ttline2, "PLAIN", 3, true, true];

_sleep = _backgroundWait / 360;

//Background Cam Movement in circle
_height = 4;
_angle = 0;
_distance = 5;
_maxAngle = 360;

_camera camSetRelPos [_distance*cos(_angle),_distance*sin(_angle),_height];
_camera camCommit 0;

//NVG or not
if (((getLightingAt _camera ) select 3 )> _brightness || ((getLightingAt _camera ) select 1 ) > 0.4) then {
	camUseNVG false;
}
else {
	camUseNVG true;
};

//Circle around Player
while {_angle < _maxAngle} do {
	_angle = _angle + 1;

	_camera camSetRelPos [_distance*cos(_angle),_distance*sin(_angle),_height];
	_camera camCommit _sleep;
	sleep _sleep;	
};

//-------------------------------------------------------------
// Mission Message
//-------------------------------------------------------------
titleText [_ttline3, "PLAIN", 3, true, true];

_sleep = _missionWait / 50;

//Mission Cam Movement
_height = 2;

_camera camSetRelPos [0,0,_height];
_camera camCommit 0;

//NVG or not
if (((getLightingAt _camera ) select 3 )> _brightness || ((getLightingAt _camera ) select 1 ) > 0.4) then {
	camUseNVG false;
}
else {
	camUseNVG true;
};

//Zoom out on top of Player
while {_height < 50} do {
	_height = _height + 1;

	_camera camSetRelPos [0,0,_height];
	_camera camCommit _sleep;
	sleep _sleep;
};

//-------------------------------------------------------------
// Title Screen
//-------------------------------------------------------------
//Camera destroying - terminates the 'camera view'
_camera CameraEffect ["Terminate","back"];
CamDestroy _camera;

//Show Title Screen
titleText [_ttline4, "BLACK FADED", 10, true, true];
waitUntil { camCommitted _camera; };
sleep _titleWait;
_fadeOutTime fadeMusic 0;

//Fade Out
titleText [_ttline4, "BLACK IN", 5, true, true];
sleep 5;

//Text Ticker
[[[_tickerCountry,"size = '0.7' font='PuristaBold'"],["","<br/>"],[_tickerLocation,"size = '0.7'","#aaaaaa"]],safeZoneX / 4, safeZoneH / 2,true,"<t font='PuristaBold'>%1</t>",[],{ false },true] spawn BIS_fnc_typeText2;	
sleep 8;
private _t = [daytime, "HH:MM"] call BIS_fnc_timeToString;			// time at missionstart as a string
[["Time: "+_t],safeZoneX / 4, safeZoneH / 2,true,"<t font='PuristaBold'>%1</t>",[],{ false },true] spawn BIS_fnc_typeText2;

sleep 10;

playMusic "";
0 fadeMusic 1;
ace_hearing_disableVolumeUpdate = false;