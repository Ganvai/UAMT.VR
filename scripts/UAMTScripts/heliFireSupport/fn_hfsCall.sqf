params ["_hfsIndex"];

if (missionNameSpace getVariable ["hfsStatus",0] > 0) exitWith {
	switch (missionNameSpace getVariable ["hfsStatus",0]) do {
		case 1 : {["Heli Fire Support not available. Another Element is currently requesting a Heli for fire support.", "Error"] call BIS_fnc_guiMessage;};
		case 2 : {["Heli Fire Support not available. Heli Fire Support deployed.", "Error"] call BIS_fnc_guiMessage;};
		case 3 : {["Heli Fire Support not available. Refuelling and rearming Helicopters for new strike.", "Error"] call BIS_fnc_guiMessage;};
	};
};

if ((((missionNameSpace getVariable ["hfsArray",0]) select _hfsIndex) select 1 == 0 ) || (((missionNameSpace getVariable ["hfsArray",0]) select _hfsIndex) select 2 == 0 )) exitWith {
	cutText ["<t color='#ff0000' size='2' shadow = '2'>Helicopters are not available anymore!</t>", "PLAIN", 2, true, true];
};

_firezoneCheck = false;

{	
	_fireZoneCheck = (getPos player) inArea _x;
}forEach getMissionConfigValue "hfsNoFireZones";

if (_fireZoneCheck) exitWith {
	cutText ["<t color='#ff0000' size='2' shadow = '2'>Heli Fire Support not allowed in this area!</t>", "PLAIN", 2, true, true];
};

missionNameSpace setVariable ["hfsStatus",1,true];
	
_result = false;
private _result = ["You are calling Helicopters for Firesupport to your position. Do you confirm?", "Confirm Helicopter Firesupport?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {
	missionNameSpace setVariable ["hfsStatus",0,true];
};

_pos = getPos player;
_dir = (getDir player) + 180;
_side = side player;

[[_pos,_dir,_side, _hfsIndex, true],UAMThfs_fnc_hfsExecute] remoteExec ["spawn",2];