disableSerialization;

_display = findDisplay 99100;

_ctrlRoleFil = _display displayCtrl 102;
_ctrlTypeFil = _display displayCtrl 103;
_ctrlArsenalLB = _display displayCtrl 104;

lbClear _ctrlArsenalLB;

_role = _ctrlRoleFil lbData (lbCurSel _ctrlRoleFil);
_typeIndex = _ctrlTypeFil lbValue (lbCurSel _ctrlTypeFil);

_itemHM = player getVariable ["itemHM",[]];
_type = [];

switch _typeIndex do {
	case 1 : {_type = ["Glasses","Headgear","Vest","Uniform","Backpack"]};
	case 2 : {_type = ["AssaultRifle","BombLauncher","Cannon","GrenadeLauncher","Handgun","Launcher","MachineGun","MissileLauncher","Mortar","RocketLauncher","Shotgun","Rifle","SubmachineGun","SniperRifle","UnknownWeapon"]};
	case 3 : {_type = ["Artillery","Bullet","CounterMeasures","Laser","Missile","Rocket","Shell","ShotgunShell","UnknownMagazine"]};
	case 4 : {_type = ["Throw","SmokeShell","Grenade","Flare"]};
	case 5 : {_type = ["Mine","MineBounding","MineDirectional"]};
	case 6 : {_type = ["AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod"]};
	case 7 : {_type = ["Medikit","FirstAidKit"]};
	case 8 : {_type = [""]};
};

{	
	_key = _x;
	_value = _y;
	//if ((_role == "all" || _role in (_value select 4)) && (_typeIndex == 0 || ({_x in (_value select 3)}count _type > 0) || (({_x in (_value select 3)}count _type == 0) && _typeIndex == 8))) then {
	if ((_role == "all" || _role in (_value select 4)) && ( (_typeIndex == 0) || ( {_x in (_value select 3)} count _type > 0) || (({_x in (_value select 3)}count _type == 0) && _typeIndex == 8) ) ) then {
		[_ctrlArsenalLB,_value select 0,_value select 1,_value select 2] call sppDialog_fnc_addArsenalItem;
	};
}forEach _itemHM;

lbSort _ctrlArsenalLB;
