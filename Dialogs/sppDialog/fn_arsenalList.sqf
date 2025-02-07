disableSerialization;

_display = findDisplay 99100;

_ctrlRoleFil = _display displayCtrl 102;
_ctrlTypeFil = _display displayCtrl 103;
_ctrlArsenalLB = _display displayCtrl 104;

lbClear _ctrlArsenalLB;

_role = _ctrlRoleFil lbData (lbCurSel _ctrlRoleFil);
_typeIndex = _ctrlTypeFil lbValue (lbCurSel _ctrlTypeFil);

_itemHM = uiNamespace getVariable ["itemHM",[]];
_type = [];

_type = switch _typeIndex do {
	case 1 : {["Glasses","Headgear","Vest","Uniform","Backpack"]};
	case 2 : {["AssaultRifle","BombLauncher","Cannon","GrenadeLauncher","Handgun","Launcher","MachineGun","MissileLauncher","Mortar","RocketLauncher","Shotgun","Rifle","SubmachineGun","SniperRifle","UnknownWeapon","VehicleWeapon"]};
	case 3 : {["Artillery","Bullet","CounterMeasures","Laser","Missile","Rocket","Shell","ShotgunShell","UnknownMagazine"]};
	case 4 : {["Grenade"]};
	case 5 : {["Mine","MineBounding","MineDirectional"]};
	case 6 : {["AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod"]};
	case 7 : {["Medikit","FirstAidKit"]};
	case 8 : {["Item","Watch","Binocular","Compass","GPS","LaserDesignator","Map","MineDetector","NVGoggles","Radio","Toolkit","UAVTerminal","Unknown","UnknownEquipment","Horn","CounterMeasuresLauncher"]};
	default {[""]};
};

{	
	_key = _x;
	_value = _y;
	//if ((_role == "all" || _role in (_value select 4)) && (_typeIndex == 0 || ({_x in (_value select 3)}count _type > 0) || (({_x in (_value select 3)}count _type == 0) && _typeIndex == 8))) then {
	if ((count ((_value select 4) select {_x in _role}) > 0) && ( (_typeIndex == 0) || ( {_x in (_value select 3)} count _type > 0) )) then {
		[_ctrlArsenalLB,_value select 0,_value select 1,_value select 2,_value select 5] call sppDialog_fnc_addArsenalItem;
	};
}forEach _itemHM;

lbSort _ctrlArsenalLB;
