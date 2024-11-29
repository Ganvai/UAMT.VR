params ["_display"];

//Remove ESC Close Display
(_display) displayAddEventhandler ['KeyDown', {(_this select 1) isEqualTo 1}];

(_display) displayAddEventhandler ['KeyDown', {(_this select 1) isEqualTo 57}];
(_display) displayAddEventhandler ['KeyUP', {(_this select 1) isEqualTo 57}];

//Add new ESC functionality
(_display) displayAddEventhandler ['KeyDown', {
													params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
													
													//Add new function for ESC key
													if (_key isEqualTo 1) then {
														if (ctrlText 9900200 != "") then {
															ctrlSetText [9900200,""];
														}
														else {
															closeDialog 1;
														};
													};
													
													//Add Confirm function to both Enter keys
													if (_key isEqualTo 28 || _key isEqualTo  156)then{call doorKeypad_fnc_keypadConfirm;};
												}
									];