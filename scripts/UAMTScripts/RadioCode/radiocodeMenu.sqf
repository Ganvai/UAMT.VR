_radioAccess = _this select 0;

if (_radioAccess > 0) then {
	_radio_menu = ["Radiocode","Radiocode","a3\modules_f_curator\data\iconradio_ca.paa",{},{true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _radio_menu] call ace_interact_menu_fnc_addActionToClass;

	_radiocodejoin = ["Radiocode 1","Join Code Channel","",{ execVM "scripts\UAMTScripts\RadioCode\RadiocodeJoinChannel.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocodejoin] call ace_interact_menu_fnc_addActionToClass;

	_radiocodeleave = ["Radiocode 1","Leave Code Channel","",{ execVM "scripts\UAMTScripts\RadioCode\RadiocodeLeaveChannel.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocodeleave] call ace_interact_menu_fnc_addActionToClass;
};

if (_radioAccess == 2) then {
	if (radio1 != "") then {
		_radiocode1 = ["Radiocode 1",radio1,"",{ [1] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode1] call ace_interact_menu_fnc_addActionToClass;
	};

	if (radio2 != "") then {
		_radiocode2 = ["Radiocode 2",radio2,"",{ [2] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode2] call ace_interact_menu_fnc_addActionToClass;
	};

	if (radio3 != "") then {
		_radiocode3 = ["Radiocode 3",radio3,"",{ [3] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode3] call ace_interact_menu_fnc_addActionToClass;
	};

	if (radio4 != "") then {
		_radiocode4 = ["Radiocode 4",radio4,"",{ [4] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode4] call ace_interact_menu_fnc_addActionToClass;
	};

	if (radio5 != "") then {
		_radiocode5 = ["Radiocode 5",radio5,"",{ [5] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode5] call ace_interact_menu_fnc_addActionToClass;
	};

	if (radio6 != "") then {
		_radiocode6 = ["Radiocode 6",radio6,"",{ [6] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode6] call ace_interact_menu_fnc_addActionToClass;
	};
	
	if (radio7 != "") then {
		_radiocode7 = ["Radiocode 7",radio7,"",{ [7] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode7] call ace_interact_menu_fnc_addActionToClass;
	};

	if (radio8 != "") then {
		_radiocode8 = ["Radiocode 8",radio8,"",{ [8] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode8] call ace_interact_menu_fnc_addActionToClass;
	};

	if (radio9 != "") then {
		_radiocode9 = ["Radiocode 9",radio9,"",{ [9] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode9] call ace_interact_menu_fnc_addActionToClass;
	};

	if (radio10 != "") then {
		_radiocode10 = ["Radiocode 10",radio10,"",{ [10] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode10] call ace_interact_menu_fnc_addActionToClass;
	};

};