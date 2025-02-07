params ["_ctrl","_lbCurSel"];

_display = findDisplay 99100;

_ctrlArsenalLB = _display displayCtrl 104;
_ctrlInventoryLB = _display displayCtrl 108;

if (_ctrl == 104) then {
	_ctrlArsenalLB lbSetCurSel -1;
	_ctrlInventoryLB lbSetCurSel _lbCurSel;
}
else {
	_ctrlInventoryLB lbSetCurSel -1;
	_ctrlArsenalLB lbSetCurSel _lbCurSel;
};