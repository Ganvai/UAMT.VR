if (backpack player != "B_Parachute") then {
	player setVariable ["savedItems",backpackItems player];
	player setVariable ["savedBackpack",backpack player];
	removeBackpack player;
	player addBackpack "B_Parachute";
	titletext ["<t color='#ffffff' size='1.5' font='RobotoCondensed' shadow = '2' >Backpack was stored. Parachute recieved!</t>", "PLAIN DOWN", 1.5, true, true];
}
else {
	titletext ["<t color='#ffffff' size='1.5' font='RobotoCondensed' shadow = '2' >You already have a Parachute! Nothing was stored.</t>", "PLAIN DOWN", 1.5, true, true];
};
