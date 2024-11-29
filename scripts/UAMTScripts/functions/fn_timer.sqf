//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
//						Timer Function
//
// Shows a Countdown Timer as Hint in Optional Color and Sound
//
// Call in Multiplayer:
// [_timer,_title,_sound,_color] remoteExec ["UAMT_fnc_timer"];
//
// _timer = Number - Seconds the Timer counts down
// _title = String - Description standing above the Timer
// _sound = Boolean - Activates sound (Optional - default: true)
// _color = String - RGB color (Optional - default: ff0000 (Red) / 00ff00 for green or ffffff white f.e.)
//
// Credits go to Enigx from the Bohemia Arma Forum
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
if (isDedicated) exitWith {};

params ["_time","_title",["_sound",true],["_color","ff0000"]];

while {(_time > 0)} do {
	_time = _time - 1;
	
	if (_sound) then {
		playSound "beep";
	};
	
	_txtCnd = format["<t font='PuristaMedium' t size='1.25' t color='#%3'>%2<br/><t size='2.25'>%1<br/></t>", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring,_title,_color];
	hintsilent parseText format[_txtCnd];
	if (_time != 0) then {
		sleep 1;
	}
	else {
		if (_sound) then {
			playSound "beep";
			sleep 0.12;
			playSound "beep";
			sleep 0.12;
			playSound "beep";
		};
	};
};
