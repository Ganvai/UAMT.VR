params ["_box"];

_mags = getMagazineCargo _box;
_weapons = getWeaponCargo _box;
_backpacks = getBackpackCargo _box;
_items = getItemCargo _box;

_itemsArr = [[],[]];

if (((_items select 0) select 0) isNotEqualTo []) then {
	(_itemsArr select 0) append _items select 0;
	(_itemsArr select 1) append _items select 1;
};


for "_i" from 0 to (count (_mags select 0)) do {
	(_items select 0) pushback ((_mags select 0) select _i);
	(_items select 1) pushback ((_mags select 1) select _i);
};

for "_i" from 0 to (count (_weapons select 0)) do {
	(_items select 0) pushback ((_weapons select 0) select _i);
	(_items select 1) pushback ((_weapons select 1) select _i);
};

for "_i" from 0 to (count (_backpacks select 0)) do {
	(_items select 0) pushback ((_backpacks select 0) select _i);
	(_items select 1) pushback ((_backpacks select 1) select _i);
};

_items;