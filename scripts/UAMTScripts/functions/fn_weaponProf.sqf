ace_common_SwayFactor = 0;
setUnitRecoilCoefficient = 0;

player addEventHandler ["WeaponChanged", {
	params ["_object", "_oldWeapon", "_newWeapon", "_oldMode", "_newMode", "_oldMuzzle", "_newMuzzle", "_turretIndex"];
	
	
	_prof = player getVariable ["_UAMTweaponsProf",["arifle"]];
	
	_currWeaponCursor = [configFile >> "CFGWeapons" >> _newWeapon, "cursor"] call BIS_fnc_returnConfigEntry;
	
	if (_currWeaponCursor in _prof) then {
		ace_common_SwayFactor = 0;
		player setUnitRecoilCoefficient 0;
	}
	else {
		if (_currWeaponCursor == "arifle" || _currWeaponCursor == "hgun") then {
			ace_common_SwayFactor = 1;
			player setUnitRecoilCoefficient 1;
		}
		else {
			if (_currWeaponCursor in  ["arifle","mg","srifle","hgun","sgun","launcher","missile","smg"]) then {
				ace_common_SwayFactor = 10;
				player setUnitRecoilCoefficient 10;
			}
			else {
				ace_common_SwayFactor = 1;
				player setUnitRecoilCoefficient 1;
			};
		};
	};
}];