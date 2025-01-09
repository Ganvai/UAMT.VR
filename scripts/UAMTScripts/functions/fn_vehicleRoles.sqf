player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	
	if (_vehicle isKindOf "Tank" || _vehicle isKindOf "Helicopter" || _vehicle isKindOf "Plane") then {
		_type = "";
		
		if (_vehicle isKindOf "Tank") then {_type = "Tank";};
		
		if (_vehicle isKindOf "Helicopter") then {_type = "Helicopter";};
		
		if (_vehicle isKindOf "Plane") then {_type = "Plane";};
		
		switch _type do {
			case "Tank" :	 {
								if ("tank" in (player getVariable ["_vehicleProf",[]])) then {} else {
									if (_role != "cargo" || assignedCommander _vehicle == player) then {
										moveOut _unit;
										hint "You can't control this Vehicle";
									};
								};
							};
			case "Helicopter" :	 {
								if ("Helicopter" in (player getVariable ["_vehicleProf",[]])) then {} else {
									if (_role == "driver" || _turret isEqualTo ["turret",[0]]) then {
										moveOut _unit;
										hint "You can't control this Vehicle";
									};
								};
							};
			case "Plane" :	 {
								if ("Plane" in (player getVariable ["_vehicleProf",[]])) then {} else {
									if (_role == "cargo" || _turret isEqualTo ["turret",[0]]) then {
										moveOut _unit;
										hint "You can't control this Vehicle";
									};
								};
							};
		};
	};
}];

player addEventHandler ["SeatSwitchedMan", {
	params ["_unit1", "_unit2", "_vehicle"];

	if (_vehicle isKindOf "Tank" || _vehicle isKindOf "Helicopter" || _vehicle isKindOf "Plane") then {
		_type = "";
		
		if (_vehicle isKindOf "Tank") then {_type = "Tank";};
		
		if (_vehicle isKindOf "Helicopter") then {_type = "Helicopter";};
		
		if (_vehicle isKindOf "Plane") then {_type = "Plane";};
		
		switch _type do {
			case "Tank" :	 {
								if ("tank" in (player getVariable ["_vehicleProf",[]])) then {} else {
									if (assignedCommander _vehicle == player || assignedGunner _vehicle == player || assignedDriver _vehicle  == player) then {
										moveOut player;
										hint "You can't control this Vehicle";
									};
								};
							};
			case "Helicopter" :	 {
								if ("Helicopter" in (player getVariable ["_vehicleProf",[]])) then {} else {
									if (assignedDriver _vehicle  == player || assignedVehicleRole player isEqualTo ["turret",[0]]) then {
										moveOut player;
										hint "You can't control this Vehicle";
									};
								};
							};
			case "Plane" :	 {
								if ("Plane"in (player getVariable ["_vehicleProf",[]])) then {} else {
									if (assignedDriver _vehicle  == player ||  assignedCommander _vehicle == player || assignedVehicleRole player isEqualTo ["turret",[0]]) then {
										moveOut player;
										hint "You can't control this Vehicle";
									};
								};
							};
		};
	};
	
}];

MGI_keysOrder = ["carForward","Turbo","carSlowForward","carBack","carLeft","carRight"] apply {actionkeys _x select 0};

0 = [] spawn {
  waitUntil {!isNull findDisplay 46};
  if (isnil "MGI_keysDriving") then {  
  MGI_keysDriving = (findDisplay 46) displayAddEventHandler ["KeyDown",  
    {

      private _handled = false;  
      if (!isNull objectParent player && player == effectiveCommander vehicle player && {(_this select 1) in MGI_keysOrder}) then {  
        _handled = true  
      };  
      _handled  
    }];
  };
}; 