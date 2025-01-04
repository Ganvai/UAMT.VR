// fill listbox with roles
// roles are defined in CfgFactionEquipment.hpp -> CfgRoles
_display = findDisplay 1234; //1234 = Idd of my Project
_listbox = _display displayCtrl 100; //100 = Idc of my ListBox

_roles = [missionConfigFile >> "CfgRoles" >> "roles"] call BIS_fnc_returnConfigEntry;
{ _index = _listbox lbAdd (_x select 0); } forEach _roles;