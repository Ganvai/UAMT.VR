//-----------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------
//
//						Artillery Fire Function
//
// Let's an existing Artillery fire onto a specified Area around a Target.
// There are six dispersion patterns:
//
// 1. Random  Radius : Fires onto positions in a Radius around the target with a light focus towards 
//						the middle
//
// 2. Random Area : Fires onto a area around the target with a completly even distribution
//
// 3. Normal Distribution : Fire onto position in a random radius with a strong focus towards the 
//							targets original position (Like a "normal" artillery fire would)
//							Barely reaches the outer radius
//
// 4. Inverted Normal Distribution - Random Radius: Same as above, but with a focus toward the 
//													borders of the radius with barely firing into 
//													the center of the radius
//
// 5. Inverted normal Distribution - Random Area: Same as above but with a much stronger focus to the
//												  borders and very rarely coming close to the center
//
// 6. Random Area Ring : Defines a Ring around the Target with radius defining the outer borders 
//						 and innerRadius defining the inner. Only fires in this ring!
//
// Keep in mind that all these patterns and their accuracy depend on reach and the accuracy of the 
// artillery firing.
//
//
// Call:
// [[artilleryArray],_targetPos,_ammunition,_dispersionPattern,_radius,_innerRadius,_delay,_condition] call UAMT_fnc_artilleryFire;
//
// Parameters:
// _artis : ARRAY of Objects / Artillery units you want to fire.
// _target : Position [] or Markername "String" / The Target that is the center of the firepattern
// _ammo : STRING / Ammo the artillery will shoot with - You find a list of common ammos at the
//					bottom of this file 
// _dispPattern : NUMBER 1 - 6 / Dispersion Pattern
// _radius : NUMBER / The radius the artillery will distribute shots around the target
// _innerRadius : NUMBER / the inner radius needed for distribution Pattern 6
// _delay : NUMBER / Maximum of random delay between shots.
// _condition : CODE or NUMBER / If code, the artillery will fire as long as the code return true. 
//								 If Number, ALL artilleries will fire this amount of shots
//
// EXAMPLE:
// [[mortar_1,mortar_2],"target_1","8Rnd_82mm_Mo_shells",6,1000,950,10,{true}] call UAMT_fnc_artilleryFire;
//
// Lets the mortars 1 and 2 fire onto the Marker with Name "Target_1" with 82mm Shells in a Ring with 
// a outer radius of 1000m and a inner radius of 950m. Will never stop firing!
//
// -----------------------
//
// [[mortar_1],"target_1","8Rnd_82mm_Mo_shells",1,100,0,5,{alive mortar_1}] call UAMT_fnc_artilleryFire;
//
// Will only let Mortar_1 fire on Target_1 with 82mm Shells in distribution pattern 1 and will stop 
// firing when mortar_1 is dead
//
// Credits:
// Script by Jan & Spiderman from The Old Boys
//-----------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------
params ["_artis","_target","_ammo","_dispPattern","_radius","_innerRadius","_delay","_condition"];

_center = [0,0,0];
_firemode = {};

if (typeName _target == "STRING") then {
	_center = getMarkerPos _target;
}
else {
	_center = _target;
};

switch _dispPattern do {
	case 1 : { _fireMode = {_pos = _center getPos [random _radius, random 360]} ; }; //Random Radius
	case 2 : { _fireMode = {_pos = _center getPos [_radius * sqrt random 1, random 360]} ; }; //Random Area
	case 3 : { _fireMode = {_pos = _center getPos [_radius * random [- 1, 0, 1], random 180]} ; }; // Normal Distribution
	case 4 : { _fireMode = {_pos = _center getPos [_radius * (1 - abs random [- 1, 0, 1]), random 360]} ; }; // Inverted normal distribution, random radius
	case 5 : { _fireMode = {_pos = _center getPos [_radius * sqrt (1 - abs random [- 1, 0, 1]), random 360]} ; }; //  Inverted normal distribution, random area
	case 6 : { _fireMode = {_pos = _center getPos [sqrt (_innerRadius^2 + random (_radius^2 - _innerRadius^2)), random 360]} ; }; // Random Area Ring
};

if (typeName _condition == "CODE") then {
	{
		[_x,_center,_ammo,_fireMode,_condition,_radius,_innerRadius,_delay] spawn {
			params ["_arti","_center","_ammo","_fireMode","_condition","_radius","_innerRadius","_delay"];
			_pos = [0,0,0];
			
			while _condition do {
				
				[_center,_radius,_innerRadius] call _fireMode;
				
				sleep (2 + (random 2) + (random _delay));
				
				[_arti, [_pos, _ammo, 1]] remoteExec ["doArtilleryFire", _arti];
					
				if (!(canFire _arti)) then {diag_log format["Can not fire %1).", name _arti];};
				_arti setVehicleAmmo 1;	
			};
		
		};
	}forEach _artis;
}
else {
	{
		[_x,_center,_ammo,_fireMode,_condition,_radius,_innerRadius,_delay] spawn {
			params ["_arti","_center","_ammo","_fireMode","_condition","_radius","_innerRadius","_delay"];
			_pos = [0,0,0];
			
			for "_i" from 1 to _condition do {
				
				[_center,_radius,_innerRadius] call _fireMode;
				
				sleep (2 + (random 2) + (random _delay));
				
				[_arti, [_pos, _ammo, 1]] remoteExec ["doArtilleryFire", _arti];
					
				if (!(canFire _arti)) then {diag_log format["Can not fire %1).", name _arti];};
				_arti setVehicleAmmo 1;	
			};
		};
	}forEach _artis;
};

//-----------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------
//			Common Artillery Ammo
//
// Mortar MK6:
//		"8Rnd_82mm_Mo_shells"
//		"8Rnd_82mm_Mo_Flare_white"
//		"8Rnd_82mm_Mo_Smoke_white"
//
// Searas: 
//		"12Rnd_230mm_rockets"
//
// Sholef:
//		"32Rnd_155mm_Mo_shells"
//		"2Rnd_155mm_Mo_Cluster"
//		"6Rnd_155mm_Mo_smoke"
//		"2Rnd_155mm_Mo_LG"
//
// Hilux Podnos (CUP_O_Hilux_podnos_TK_INS) Mortar ClassNames
//		"CUP_8Rnd_82mm_Mo_shells_veh"
//		"CUP_8Rnd_82mm_Mo_Flare_white_veh"
//		"CUP_8Rnd_82mm_Mo_Smoke_white_veh"
//
//-----------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------
