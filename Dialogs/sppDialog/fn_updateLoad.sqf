disableSerialization;

_currBox = uiNamespace getVariable ["sppBox",objNull];

if (_currBox isEqualTo objNull) exitWith {};

_display = findDisplay 99100;
_ctrlProg = _display displayCtrl 107;
_ctrlWeight = _display displayCtrl 106;

_load = load _currBox;
_maxLoad = maxLoad _currBox;
_weight = format ["%1 lbs",(loadAbs _currBox)];

_ctrlProg progressSetPosition _load;

_ctrlWeight ctrlSetText _weight;

switch (true) do {
	case (loadAbs _currBox < ACE_maxWeightCarry) : {
							_ctrlWeight ctrlSetTooltip "Box can be carried.";
							_ctrlWeight ctrlSetTextColor [0.5843,0.8902,0.349,1];
						};
	case (loadAbs _currBox > ACE_maxWeightCarry && loadAbs _currBox < ACE_maxWeightDrag ) : {
							_ctrlWeight ctrlSetTooltip "Box can be dragged.";
							_ctrlWeight ctrlSetTextColor [1,1,0,1];
						};
	case (loadAbs _currBox > ACE_maxWeightDrag) : {
							_ctrlWeight ctrlSetTooltip "Box can only be moved by vehicle.";
							_ctrlWeight ctrlSetTextColor [1,0,0,1];
						};
};