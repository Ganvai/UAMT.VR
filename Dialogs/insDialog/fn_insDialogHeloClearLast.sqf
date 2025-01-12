_display  = findDisplay 99104;

_heloIndex = lbCurSel (_display displayCtrl 9910401);

_heloArray = player getVariable ["insHeloArray",[]];

_waypoints = ((_heloArray select _heloIndex) select 2);

_wpLast = (count _waypoints) - 1;

deleteMarkerLocal  (_waypoints select _wpLast);

_waypoints deleteAt _wpLast;

(_heloArray select _heloIndex) set [2,_waypoints];

player setVariable ["insHeloArray",_heloArray,true];
