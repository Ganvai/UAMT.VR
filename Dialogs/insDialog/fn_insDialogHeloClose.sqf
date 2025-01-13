closeDialog 0;
onMapSingleClick "";

{
	_waypoints = _x select 2;
	
	for "_i" from 0 to ((count _waypoints) - 1) do {
		_markerName = _waypoints select _i;
		deleteMarkerLocal _markerName;
	};
}forEach (player getVariable ["insHeloArray",[]]);

player setVariable ["insHeloArray",[],true];

