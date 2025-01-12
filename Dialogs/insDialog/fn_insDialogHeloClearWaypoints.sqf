_display  = findDisplay 99104;

_heloIndex = lbCurSel (_display displayCtrl 9910401);

_heloArray = player getVariable ["insHeloArray",[]];

_wp = ((_heloArray select _heloIndex) select 2);

{
	deleteMarkerlocal _x;
}forEach _wp;

(_heloArray select _heloIndex) set [2,[]];

player setVariable ["insHeloArray",_heloArray,true];
