if (artiStatus == 1 || artiStatus == 2 || artiStatus == 3) exitWith {

	_idColor = "FF004C99";
	_idSide = side player;
	_finalMessage = "";

	switch _idSide do {
		case east: {_idColor = "FF800000";};
		
		case independent: {_idColor = "FF008000";};
		
		case civilian: {_idColor = "FF660080";};
		
		default {_idColor = "FF004C99";};
	};

	switch artiStatus do
	{
		case 1: { 
					_msg = "Artillery call in progress from other user.";
					_finalMessage = format ["<t color='#%1' size='2' shadow = '2'>%2: </t><t color='#%3' size='2' shadow = '2'>%4</t>",_idColor,supportControlName,"ffffff",_msg];
				};
		case 2: { 
					_msg = "Artillery Strike in Progress. Wait until Artillery unit is available again.";
					_finalMessage = format ["<t color='#%1' size='2' shadow = '2'>%2: </t><t color='#%3' size='2' shadow = '2'>%4</t>",_idColor,supportControlName,"ffffff",_msg];
				};
		case 3: { 
					_msg = "Artillery is reloading and will be available within a short time.";
					_finalMessage = format ["<t color='#%1' size='2' shadow = '2'>%2: </t><t color='#%3' size='2' shadow = '2'>%4</t>",_idColor,supportControlName,"ffffff",_msg];
				};
		
		default {_finalMessage = "";};
	};
	
	titleText [_finalMessage, "PLAIN", 0.5, true, true];
};

createDialog "artilleryDialog";

artiStatus = 1;
publicVariable "artiStatus";