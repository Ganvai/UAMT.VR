//-------------------------------------------------------------------
//-------------------------------------------------------------------
//
//				Talking Dead Action
//
// Adds a talking Action on a unit and replaces it with another Text
// when the unit is dead.
// Copy the Code below to add a hold action with the random dialogue
// function attached to.
// Don't forget to give the fitting Parameters in the execVM call.
//
// [object,speaker,faction,preconfigured Text,dead Text] call UAMT_fnc_addTalkingActionDead;
//
// Attributes:
// object: Object that the Hold Action is attached to
// speaker: String - name of the Unit speaking to you
// faction: String - Defines the Color of the speakers name - available Options: BLU, IND, OPF, CIV
// text1: String - Text displayed when the unit is still alive
// text2: String - Text displayed when the unit is dead
//
// Example for Object init in Eden Editor:
// [this,"UN-Guard","IND","Text displayed when unit alive.","Text displayed when unit is dead."] call UAMT_fnc_addTalkingActionDead;
//-------------------------------------------------------------------
//-------------------------------------------------------------------

params [["_object",objNull],["_speaker","Soldier"],["_faction","BLU"],["_text",""],["_textDead",""]];

_color = "#004C99";

switch (_faction) do {
	case "IND": {_color = "#008000";};
	case "OPF": {_color = "#800000";};
	case "CIV": {_color = "#660080";};
};

_talkTo = format ["talk to %1",_speaker];
[ 
	_object, 
	_talkTo, 
	"\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa", 
	"\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa", 
	"_this distance _target < 3", 
	"_caller distance _target < 3", 
	{}, 
	{}, 
	{ 
		_speaker = (_this select 3) select 0;
		_color = (_this select 3) select 1;
		_text = (_this select 3) select 2;
		_textDead = (_this select 3) select 3;
		_message = "";
		
		if (alive _target) then {
			_message = format ["<t align = 'center' shadow = '2' color='%1' size='1.5' font='RobotoCondensedBold' >%2: </t><t color='#ffffff' size='1.5' font='RobotoCondensed' shadow = '2' >%3</t>",_color,_speaker,_text];
		}
		else {
			_message = format ["<t align = 'center' shadow = '2' color='#ffffff' size='1.5' font='RobotoCondensedBold' >%1</t>",_textDead];
		};

		titletext [_message, "PLAIN DOWN", 1, true, true];
	}, 
	{}, 
	[_speaker,_color,_text,_textDead],
	1, 
	0,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, _object];