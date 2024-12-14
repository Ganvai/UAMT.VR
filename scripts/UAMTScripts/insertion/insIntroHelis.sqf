if (isDedicated) exitWith {};

params ["_line1","_line2","_line3","_titleHeader","_title","_tickerCountry","_tickerLocation"];

_ttline1 = format ["<t color='#ffffff' size='2'>%1</t>",_line1];
_ttline2 = format ["<t color='#ffffff' size='2'>%1</t>",_line2];
_ttline3 = format ["<t color='#ffffff' size='2'>%1</t>",_line3];
_ttline4 = format ["<t color='#ffffff' size='1'>%1<br/>____________________</t><br/><t color='#ffffff' size='5'>%2</t><br/><br/><img image='images\Clan-Logo.paa' shadow='0' size='8'/>",_titleHeader,_title];

//Needed for fadeMusic to work
ace_hearing_disableVolumeUpdate = true;

// Set threshold for NVGs
_brightness = 50;

//set Music to zero for FadeIn
0 fadeMusic 0;

// Debug Play, needed because sometimes Arme has problems starting a Track
// that is not defined in the Missions CfGMusic.
playMusic ["MainTheme_F_Tank",167];

sleep 1;

playMusic ["MainTheme_F_Tank",167];
1 fadeMusic 1;

player action ["nvGogglesOff", player];

//Camera creating
_camera = "camera" camCreate [0,0,0];
_camera cameraEffect ["internal","back"];

showCinemaBorder true;

_target = vehicle player;

_camera camSetTarget _target;
_camera camCommit 0;

_startPos = getMarkerPos ["insHeloCam1_1",true];
_endPos = getMarkerPos ["insHeloCam1_2",true];

_camera camSetPos _startPos;
_camera camCommit 0;

//NVG or not
if (((getLightingAt _camera ) select 3 )> _brightness || ((getLightingAt _camera ) select 1 ) > 0.4) then {
	camUseNVG false;
}
else {
	camUseNVG true;
};

_camera camSetPos _endPos;
_camera camCommit 12;

titleText [_ttline1, "PLAIN", 1, true, true];

waitUntil { camCommitted _camera; };

_startPos = getMarkerPos ["insHeloCam2_1",true];
_endPos = getMarkerPos ["insHeloCam2_2",true];

_camera camSetPos _startPos;
_camera camCommit 0;

//NVG or not
if (((getLightingAt _camera ) select 3 )> _brightness || ((getLightingAt _camera ) select 1 ) > 0.4) then {
	camUseNVG false;
}
else {
	camUseNVG true;
};

_camera camSetPos _endPos;
_camera camCommit 11;

titleText [_ttline2, "PLAIN", 1, true, true];

waitUntil { camCommitted _camera; };

_pos = getPosATL _target;
_startPos = _target getRelPos [200, 0];
_startPos set [2,(_pos select 2)];

_camera camSetPos _startPos;
_camera camCommit 0;

//NVG or not
if (((getLightingAt _camera ) select 3 )> _brightness || ((getLightingAt _camera ) select 1 ) > 0.4) then {
	camUseNVG false;
}
else {
	camUseNVG true;
};

titleText [_ttline3, "PLAIN", 1, true, true];

sleep 11;

//-------------------------------------------------------------
// Title Screen
//-------------------------------------------------------------
//Camera destroying - terminates the 'camera view'
_camera CameraEffect ["Terminate","back"];
CamDestroy _camera;

//Show Title Screen
titleText [_ttline4, "PLAIN", 0.6, true, true];

sleep 6;

//Text Ticker
[[[_tickerCountry,"size = '0.7' font='PuristaBold'"],["","<br/>"],[_tickerLocation,"size = '0.7'","#aaaaaa"]],safeZoneX / 4, safeZoneH / 2,true,"<t font='PuristaBold'>%1</t>",[],{ false },true] spawn BIS_fnc_typeText2;	
sleep 8;
private _t = [daytime, "HH:MM"] call BIS_fnc_timeToString;			// time at missionstart as a string
[["Time: "+_t],safeZoneX / 4, safeZoneH / 2,true,"<t font='PuristaBold'>%1</t>",[],{ false },true] spawn BIS_fnc_typeText2;

ace_hearing_disableVolumeUpdate = false;