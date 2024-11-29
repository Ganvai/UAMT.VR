if (isDedicated) exitWith {};

params [["_outro",2],["_line1",""],["_line2",""],["_tyUnderline",""]]; 

//Initialising Variables
_outroTrack = "";
_trackStart = 0;
_fadeInTime = 1;
_startWait = 1;
_wait = 1;
_playerName = (toUpper profileName) splitString "" joinString " ";;

_ttLine1 = format ["<t color='#ffffff' size='3' font='RobotoCondensed' shadow = '2' >%1</t>",_line1];
_ttLine2 = format["<t color='#ffffff' size='3' font='RobotoCondensed' shadow = '2' >%1</t>",_line2];
_ttLine3 =  format ["<br/><br/><br/><br/><img image='images\Clan-Logo.paa' shadow='0' size='10'/><br/><br/><t color='#ffffff' size='3' font='RobotoCondensed' shadow = '2' >G R E A T   W O R K,   %1</t><br/><br/><t color='#ffffff' size='1.5' font='RobotoCondensed' shadow = '2' >%2</t>", _playerName,_tyUnderline];


//Switch to choose track and set Times
switch (_outro) do {
	case 1: {
				//set introTrack
				_outroTrack = "MainTheme_F_Tank";
				//set Track start
				_trackStart = 167;
				//set fadeInTime
				_fadeInTime = 1;
				//set startWait
				_startWait = 2;				
				//set introWait
				_wait = 13;
	};
	case 2: {
				//set introTrack
				_outroTrack = "AmbientTrack02d_F_EXP";
				//set Track start
				_trackStart = 0;
				//set fadeInTime
				_fadeInTime = 1;
				//set startWait
				_startWait = 2;				
				//set introWait
				_wait = 25;
	};
	case 3: {
				//set introTrack
				_outroTrack = "Music_Outro2_Ending";
				//set Track start
				_trackStart = 110;
				//set fadeInTime
				_fadeInTime = 1;
				//set startWait
				_startWait = 1;				
				//set introWait
				_wait = 13.3;
	};
	case 4: {	// This is War (6th Anniversary Remix)
		
				//set introTrack
				_outroTrack = "LeadTrack01_F_6th_Anniversary_Remix";
				//set Track start
				_trackStart = 95;
				//set fadeInTime
				_fadeInTime = 1;
				//set fadeOutTime
				_startWait = 1;				
				//set introWait
				_wait = 18;
	};
	case 5: {	// Track_O_03
	
				//set introTrack
				_outroTrack = "Track_O_03";
				//set Track start
				_trackStart = 35;
				//set fadeInTime
				_fadeInTime = 1;
				//set fadeOutTime
				_startWait = 1;				
				//set introWait
				_wait = 18;
	};
	case 6: {	// Track_O_12
	
				//set introTrack
				_outroTrack = "Track_O_12";
				//set Track start
				_trackStart = 0;
				//set fadeInTime
				_fadeInTime = 1;
				//set fadeOutTime
				_startWait = 1;				
				//set introWait
				_wait = 13;
	};

	case 7: {	// Track_P_04
	
				//set introTrack
				_outroTrack = "Track_P_04";
				//set Track start
				_trackStart = 115;
				//set fadeInTime
				_fadeInTime = 1;
				//set fadeOutTime
				_startWait = 1;				
				//set introWait
				_wait = 10.3;
	};
};

//Needed for fadeMusic to work
ace_hearing_disableVolumeUpdate = true;

//set Music to zero for FadeIn
0 fadeMusic 0;

// Debug Play, needed because sometimes Arme has problems starting a Track
// that is not defined in the Missions CfGMusic.
playMusic _outroTrack;

sleep 0.1;


playMusic [_outroTrack,_trackStart];
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
titleText [_ttLine1,"PLAIN DOWN", 2, true, true];

_sleep = _wait / 120;

//Intro Cam Movement up from Player

_range = 60;

_camera camSetRelPos [0,_range,4];
_camera camCommit 0;

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
titleText [_ttLine2, "PLAIN DOWN", 3, true, true];

_sleep = _wait / 360;

//Background Cam Movement in circle
_height = 4;
_angle = 0;
_distance = 5;
_maxAngle = 360;

_camera camSetRelPos [_distance*cos(_angle),_distance*sin(_angle),_height];
_camera camCommit 0;

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
titleText [_ttLine3, "PLAIN", 3, true, true];

_sleep = _wait / 50;

//Mission Cam Movement
_height = 2;

_camera camSetRelPos [0,0,_height];
_camera camCommit 0;

//Zoom out on top of Player
while {_height < 50} do {
	_height = _height + 1;

	_camera camSetRelPos [0,0,_height];
	_camera camCommit _sleep;
	sleep _sleep;
};

//Just in Case you are testing the function without triggering a Mission End
sleep 5;
_camera CameraEffect ["Terminate","back"];
CamDestroy _camera;