closeDialog 0;

if (missionNameSpace getVariable ["insertionActual",""] == "") then {

	_display = createDialog ["insDialogHelo"];

	_map = _display ctrlCreate ["RscMapControl", -1];
	_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.316,safeZoneY + safeZoneH * 0.333,safeZoneW * 0.369,safeZoneH * 0.368];

	_insHeloArray = [];
	{
	
		_heliObject = missionNameSpace getVariable [_x,objNull];
		
		_heliClass = typeOf _heliObject;
		
		_heliName = getText (configFile >> "CfgVehicles" >> _heliClass >> "displayName");
		
		_heliEntry = format ["%1 - %2",_heliName,(_forEachIndex + 1)];
		
		_index  = _display displayCtrl 9910401 lbAdd _heliEntry;
		
		_display displayCtrl 9910401 lbSetValue [_index, _forEachIndex];
		
		_insHeloArray pushback [_heliObject,_heliEntry,[]];
	} forEach (getMissionConfigValue "insHeloVeh");
	
	_display displayCtrl 9910401 lbSetCurSel 0;
	
	player setVariable ["insHeloArray",_insHeloArray,true];
	
	[_display] onMapSingleClick {
		params ["_display"];
		
		_index = lbCurSel (_display displayCtrl 9910401);
		
		_insHeloArray = player getVariable "insHeloArray";
		
		_wpNumber = count ((_insHeloArray select _index) select 2);
		
		_markerName = format ["%1 Heli %2 - WP %3",clientowner,(_index + 1),(_wpNumber + 1)];
		_markerText = format ["Heli %1 - WP %2",(_index + 1),(_wpNumber + 1)];
		
		createMarkerlocal [_markerName,_pos];
		_markerName setMarkerTypeLocal "mil_dot_noShadow";
		_markerName setMarkerTextLocal _markerText;
		
		((_insHeloArray select _index) select 2) pushback _markerName;
		
		player setVariable ["insHeloArray",_insHeloArray,true];
	};
}
else {
	["An Insertion Method was already setup. Coordinate with your Team and avoid multiple Insertion requests!", "Error"] spawn BIS_fnc_guiMessage;
};
