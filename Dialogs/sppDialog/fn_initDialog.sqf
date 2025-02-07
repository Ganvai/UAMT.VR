params ["_display"];

//Remove ESC Close Display
(_display) displayAddEventhandler ['KeyDown', {(_this select 1) isEqualTo 1}];
(_display) displayAddEventhandler ['KeyDown', {(_this select 1) isEqualTo 205}];
(_display) displayAddEventhandler ['KeyDown', {(_this select 1) isEqualTo 203}];
//Add new ESC functionality
(_display) displayAddEventhandler ['KeyDown', {											
													//Add new function for ESC key
													if ((_this select 1) isEqualTo 1) then {
														call sppDialog_fnc_closeSupplyPoint;
													};

													if ((_this select 1) isEqualTo 205) then {
														[1] call sppDialog_fnc_addItem;
													};

													if ((_this select 1) isEqualTo 203) then {
														[-1] call sppDialog_fnc_addItem;
													};

												}];