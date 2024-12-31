_display = findDisplay 1234; //1234 = Idd of my Project
_listbox = _display displayCtrl 100; //100 = Idc of my ListBox

_roles = [missionConfigFile >> "CfgRoles" >> "roles"] call BIS_fnc_returnConfigEntry;
{ _index = _listbox lbAdd (_x select 0); } forEach _roles;



/*
_display = findDisplay 1234; //1234 = Idd of my Project
_listbox = _display displayCtrl 100; //100 = Idc of my ListBox

loadout = [];
publicVariable "loadout";
loadoutindex = [];
publicVariable "loadoutindex";

_rolessqf = format ["loadouts\%1\roles.sqf", factionVariable];
execVM _rolessqf;

{
	loadout pushBack (_x select 0);
	loadoutindex pushback (_x select 1);
} forEach roles;

{
	lbAdd [100, _x];
	lbSetData [100, _forEachIndex, loadoutIndex select _forEachIndex];	 
} forEach loadout;

*/