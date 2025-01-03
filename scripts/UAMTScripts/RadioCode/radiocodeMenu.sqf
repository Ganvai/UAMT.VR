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
	if (getMissionConfigValue "radio1M" != "") then {
		_radiocode1 = ["Radiocode 1",getMissionConfigValue "radio1M","",{ [1] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode1] call ace_interact_menu_fnc_addActionToClass;
	};

	if (getMissionConfigValue "radio2M" != "") then {
		_radiocode2 = ["Radiocode 2",getMissionConfigValue "radio2M","",{ [2] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode2] call ace_interact_menu_fnc_addActionToClass;
	};

	if (getMissionConfigValue "radio3M" != "") then {
		_radiocode3 = ["Radiocode 3",getMissionConfigValue "radio3M","",{ [3] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode3] call ace_interact_menu_fnc_addActionToClass;
	};

	if (getMissionConfigValue "radio4M" != "") then {
		_radiocode4 = ["Radiocode 4",getMissionConfigValue "radio4M","",{ [4] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode4] call ace_interact_menu_fnc_addActionToClass;
	};

	if (getMissionConfigValue "radio5M" != "") then {
		_radiocode5 = ["Radiocode 5",getMissionConfigValue "radio5M","",{ [5] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode5] call ace_interact_menu_fnc_addActionToClass;
	};

	if (getMissionConfigValue "radio6M" != "") then {
		_radiocode6 = ["Radiocode 6",getMissionConfigValue "radio6M","",{ [6] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode6] call ace_interact_menu_fnc_addActionToClass;
	};
	
	if (getMissionConfigValue "radio7M" != "") then {
		_radiocode7 = ["Radiocode 7",getMissionConfigValue "radio7M","",{ [7] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode7] call ace_interact_menu_fnc_addActionToClass;
	};

	if (getMissionConfigValue "radio8M" != "") then {
		_radiocode8 = ["Radiocode 8",getMissionConfigValue "radio8M","",{ [8] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode8] call ace_interact_menu_fnc_addActionToClass;
	};

	if (getMissionConfigValue "radio9M" != "") then {
		_radiocode9 = ["Radiocode 9",getMissionConfigValue "radio9M","",{ [9] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode9] call ace_interact_menu_fnc_addActionToClass;
	};

	if (getMissionConfigValue "radio10M" != "") then {
		_radiocode10 = ["Radiocode 10",getMissionConfigValue "radio10M","",{ [10] execVM "scripts\UAMTScripts\RadioCode\Radiocode.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Radiocode"], _radiocode10] call ace_interact_menu_fnc_addActionToClass;
	};

};