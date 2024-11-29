params ["_number"];

_pad = (nearestObjects [player,["Land_Tablet_01_F", "Land_Tablet_02_F", "Land_Tablet_02_black_F", "Land_Tablet_02_sand_F"],2,false]) select 0;
_code = _pad getVariable "_code";

_text = ctrlText 9900200;

//check if Keypad is already full
if (count _text >= count _code) exitWith {
	playSound3D ["a3\missions_f_beta\data\sounds\firing_drills\drill_start.wss",_pad];
};

playSound3D ["a3\missions_f_beta\data\sounds\firing_drills\timer.wss",_pad];

_text = _text + _number;

ctrlSetText [9900200,_text];