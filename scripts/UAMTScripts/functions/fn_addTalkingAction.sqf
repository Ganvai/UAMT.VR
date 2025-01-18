//-------------------------------------------------------------------
//-------------------------------------------------------------------
//
//				Random Dialogue Lines
//
// Creates a simple random dialogue line for the player using the
// talk function on the unit this function is attached to.
// Copy the Code below to add a hold action with the random dialogue
// function attached to.
// Don't forget to give the fitting Parameters in the execVM call.
//
// [object,speaker,faction,text] call UAMT_fnc_addTalkingAction;
//
// Attributes:
// object: Object that the Hold Action is attached to
// speaker: String - name of the Unit speaking to you
// faction: String - Defines the Color of the speakers name - available Options: BLU, IND, OPF, CIV
// text: String (optional) - Text displayed when the unit is still alive
//
// Example for Object Init in Eden Editor:
// [this,"UN-Guard","IND","A preconfiged text that skips the random function."] call UAMT_fnc_addTalkingAction;
//-------------------------------------------------------------------
//-------------------------------------------------------------------

params [["_object",objNull],["_speaker","Soldier"],["_faction","BLU"],["_text",""]];

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
	"_this distance _target < 3 && alive _target", 
	"_caller distance _target < 3", 
	{}, 
	{}, 
	{ 
		_speaker = (_this select 3) select 0;
		_color = (_this select 3) select 1;
		_text = (_this select 3) select 2;

		if (_text == "") then {
			_dialogue = round selectRandom 17;

			switch (_dialogue) do {
				case 0: {_text = "Hey man, good luck out there.";};
				case 1: {_text = "Thank you for taking out these Mortars. That was really close.";};
				case 2: {_text = "Good to have you guys around. You already saved our asses.";};
				case 3: {_text = "Do me a favor and kick some butt out there.";};
				case 4: {_text = "Man, you SEALs really get some nice equipment";};
				case 5: {_text = "So glad you are here. Hope you be all good out there.";};
				case 6: {_text = "This Spiderman guy of yours is really obsessed about Mods.";};
				case 7: {_text = "These Mortars gave me a heart attack. Good you were here.";};
				case 8: {_text = "If it weren't for you, these guys would have bombed our asses right out of Kujari.";};
				case 9: {_text = "God, that heat is killing me.";};
				case 10: {_text = "I wish I could go out with you and kick in some doors.";};
				case 11: {_text = "I once was a SEAL too. But then I took an arrow to the knee.";};
				case 12: {_text = "Man, use these fucking chlorine tablets. It tastes shitty, but I swear, I didn't leave the bathroom for two days.";};
				case 13: {_text = "Wetwipes! Always pack wetwipes. You ever been out in this bush for more than three days and you will thank me.";};
				case 14: {_text = "Have you seen snakes in the camp? I hate snakes.";};
				case 15: {_text = "Well, you pack a punch, but when shit comes to shove, you team guys bleed like everyone of us.";};
				case 16: {_text = "SEAL Team, huh. I am some kind of an operator myself, you know.";};
				case 17: {_text = "Cheeki Breeki.";};
			};
		};

		_message = format ["<t align = 'center' shadow = '2' color='%1' size='1.5' font='RobotoCondensedBold' >%2: </t><t color='#ffffff' size='1.5' font='RobotoCondensed' shadow = '2' >%3</t>",_color,_speaker,_text];

		titletext [_message, "PLAIN DOWN", 1, true, true];
	}, 
	{}, 
	[_speaker,_color,_text], 
	1, 
	0,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, _object];