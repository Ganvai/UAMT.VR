params ['_newValue'];	

_mrkSize = 0;

if (((((missionNameSpace getVariable "fullArti") select lbCurSel 9900101) select 2) select lbCurSel 9900102) select 3 == "true") then {
	{	
		if ((getMarkerSize _x) select 0 >= (getMarkerSize _x) select 1) then {
			_mrkSize = (getMarkerSize _x) select 0;
		}
		else {
			_mrkSize = (getMarkerSize _x) select 1;
		};

		if (getMarkerPos (player getVariable "artMrkRadLocal") distance2D getMarkerPos _x < _newValue + _mrkSize) exitWith {["Dispersion radius is overlapping with No Fire Zone.", "Error"] spawn BIS_fnc_guiMessage;};
	}forEach (getMissionConfigValue "artiNoFireZones");
};


_text = format ['Radius: %1 m',_newValue];
ctrlSetText [9900106, _text];
(player getVariable "artMrkRadLocal") setMarkersize [_newValue,_newValue];

if(_newValue > 0 && lbCurSel 9900105 > 0) then {
	(player getVariable "artMrkRadLocal") setMarkerAlpha 1;
}
else {
	(player getVariable "artMrkRadLocal") setMarkerAlpha 0;
};