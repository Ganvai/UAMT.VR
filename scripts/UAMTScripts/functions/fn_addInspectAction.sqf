//-------------------------------------------------------------------
//-------------------------------------------------------------------
//
//				Add Inspect Action
//
// Creates a simple Inspect Hodl Action with the parameters you give
//
// 
//
// [object,ItemName,Text,Highlight,delete] call UAMT_fnc_addInspectAction;
// 
// Attributes:
// object: Object the Hold Action is attached to
// ItemName: String - Item Name shown in the Hold Action Popup
// text: String - Text that is shown when completing the action
// Highlight: String (optional) - Default "None" - Colors the Text in a Highlighting color. Available Options: red, green, blue.
// delete: Boolean (optional) - Default false - When true, the object is deleted globally after using the action. 
//												This makes it possible to use this for Mission critical Intel by checking
//												the object with the "alive" function in Arma.
// 
// Example for Object Init in Eden Editor:
// [this,"Laptop","This is a Laptop"] call UAMT_fnc_addInspectAction;
// [this,"Laptop","This is a Laptop in red","red"] call UAMT_fnc_addInspectAction;
// [this,"Laptop","This is a Laptopthat gets deleted","none",true] call UAMT_fnc_addInspectAction;
//-------------------------------------------------------------------
//-------------------------------------------------------------------

params [["_object",objNull],["_item","Item"],["_text",""],["_highlight","None"],["_delete",false]];

_color = "#ffffff";

_highlightLower = toLower _highlight;

switch (_highlightLower) do {
	case "red": {_color = "#ff0000";};
	case "green": {_color = "#00ff00";};
	case "blue": {_color = "#0000ff";};
	default {_color = "#ffffff";};
};

_talkTo = format ["inspect %1",_item];
[ 
	_object, 
	_talkTo, 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
	"_this distance _target < 3", 
	"_caller distance _target < 3", 
	{}, 
	{}, 
	{ 
		_text = (_this select 3) select 0;
		_color = (_this select 3) select 1;
		_delete = (_this select 3) select 2;

		_message = format ["<t align = 'center' shadow = '2' color='%1' size='1.5' font='RobotoCondensedBold' >%2</t>",_color,_text];

		titletext [_message, "PLAIN DOWN", 1, true, true];
		
		if (_delete) then {
			deleteVehicle _target;
		};
	}, 
	{}, 
	[_text,_color,_delete], 
	1, 
	0,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, _object];