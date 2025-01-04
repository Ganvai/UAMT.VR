// spawned by loadout dialog
// [] spawn UAMT_fnc_loadoutTake;
private _index = lbCurSel 100;

private _roles = [missionConfigFile >> "CfgRoles" >> "roles"] call BIS_fnc_returnConfigEntry;

private _selectedLoadout 	= _roles select _index;
_selectedLoadout params ["_name", "_role"];

closeDialog 0;

// show message
private _txt = format ["Equipping Loadout: %1", _name];
titleText [_txt, "BLACK", 1];
removeallWeapons player;
sleep 2;

// apply selected loadout
player setVariable ["loadout", _role];
_loadoutArr = call UAMT_fnc_loadoutCreate;
[player,_loadoutArr] spawn UAMT_fnc_loadoutApply;

sleep 1;
titleText ["", "BLACK IN", 2];