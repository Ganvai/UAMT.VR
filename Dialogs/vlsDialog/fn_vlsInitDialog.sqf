params ["_display"];

//Remove ESC Close Display
(_display) displayAddEventhandler ['KeyDown', {(_this select 1) isEqualTo 1}];

//Add new ESC functionality
(_display) displayAddEventhandler ['KeyDown', {											
													//Add new function for ESC key
													if ((_this select 1) isEqualTo 1) then {
														call vlsDialog_fnc_vlsCloseDialog;
													};
												}];