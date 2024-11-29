_pad = (nearestObjects [player,["Land_Tablet_01_F", "Land_Tablet_02_F", "Land_Tablet_02_black_F", "Land_Tablet_02_sand_F"],2,false]) select 0;

_code = _pad getVariable "_code";

_input = ctrlText 9900200;

if (_code isNotEqualTo _input) exitWith {
	playSound3D ["a3\missions_f_beta\data\sounds\firing_drills\drill_start.wss",_pad];
};

playSound3D ["a3\missions_f_beta\data\sounds\firing_drills\drill_finish.wss",_pad];

_pad setObjectTextureGlobal [0,"Dialogs\keypad_unlocked_CO.paa"];

_house = _pad getVariable "_house";
_doors = _pad getVariable "_doors";
_target = _pad getVariable "_target";
_actionID = _pad getVariable "_actionID";

{
	_doorName = format ["bis_disabled_Door_%1",_x];
	_house setVariable [_doorName,0,true];
}forEach _doors;

closeDialog 1;

playSound3D ["a3\missions_f_beta\data\sounds\firing_drills\target_pop-up_large.wss",_pad];