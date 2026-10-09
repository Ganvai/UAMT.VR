params ["_ctrl","_lbCurSel"];

_display = findDisplay 99100;

_ctrlArsenalLB = _display displayCtrl 104;
_ctrlInventoryLB = _display displayCtrl 108;

_indexArsenalLB = lbCurSel _ctrlArsenalLB;
_indexInventoryLB = lbCurSel _ctrlInventoryLB;

_switch = {
	params ["_lb","_i"];
	sleep 0.1;
	_lb lbSetCurSel _i;
};

if ((_ctrl == 104) && (_indexInventoryLB > -1)) then {
	_ctrlInventoryLB lbSetCurSel -1;
	[_ctrlArsenalLB,_indexArsenalLB] spawn _switch;
};

if ((_ctrl == 108) && (_indexArsenalLB > -1)) then {
	_ctrlArsenalLB lbSetCurSel -1;
	[_ctrlInventoryLB,_indexInventoryLB] spawn _switch;
};
