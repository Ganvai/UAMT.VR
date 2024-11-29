_backpack = player getVariable "savedBackpack";

if (backpack player != _backpack) then {
	removeBackpack player;
	_items =  player getVariable "savedItems";
	player addBackpack _backpack;
	{player addItemToBackpack _x;}forEach _items;
	titletext ["<t color='#ffffff' size='1.5' font='RobotoCondensed' shadow = '2' >Parachute was stored and you got your Backpack back!</t>", "PLAIN DOWN", 1.5, true, true];
}
else {
	titletext ["<t color='#ffffff' size='1.5' font='RobotoCondensed' shadow = '2' >You already stored your Parachute.</t>", "PLAIN DOWN", 1.5, true, true];
};
