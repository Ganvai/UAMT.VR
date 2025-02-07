disableSerialization;

_display = findDisplay 99100;

_ctrlInv = _display displayCtrl 108;

_currBox = uiNamespace getVariable ["sppBox",objNull];

if (_currBox isNotEqualTo objNull) then {
	_items = [_currBox] call sppDialog_fnc_getBoxCargo;
	
	lbClear _ctrlInv;

	for "_i" from 0 to (count (_items select 0)) do {
		_item = ((_items select 0) select _i);
		_amount = ((_items select 1) select _i);
		
		_configMain = switch (true) do {
			case (isclass (configfile >> "CfGWeapons" >> _item)): {"CfGWeapons"};
			case (isclass (configfile >> "CfgMagazines" >> _item)): {"CfgMagazines"};
			case (isclass (configfile >> "CfgVehicles" >> _item)): {"CfgVehicles"};
			case (isclass (configfile >> "CfgGlasses" >> _item)): {"CfgGlasses"};
			default {"Nope"};
		};
		
		if (_configMain != "nope") then {
			diag_log format ["SPPDIALOG: Item: %1 | Config: %2",_item,_configMain];
			
			_name 		= [configFile >> _configMain >> _item >> "displayName"] call BIS_fnc_returnConfigEntry;
			_image		= [configFile >> _configMain >> _item >> "picture"] call BIS_fnc_returnConfigEntry;
			_description = ([configFile >> _configMain >> _item >> "descriptionShort"] call BIS_fnc_returnConfigEntry) regexReplace ["<br[\W ]*\/>", "\n"];
			
			_index = _ctrlInv lbAdd _name;
			_ctrlInv lbSetTextRight [_index,(str _amount)];
			_ctrlInv lbSetData [_index, _item];
			_ctrlInv lbSetPictureRight [_index, _image];
			_ctrlInv lbSetPictureRightColor [_index,[1,1,1,1]];
			_ctrlInv lbSetPictureRightColorSelected [_index,[1,1,1,1]];
			_ctrlInv lbSetTooltip [_index,_description];
		};
	};
};

lbSort _ctrlInv;

call sppDialog_fnc_updateLoad;