// Here you can add several Supply Points that should have the Supply Point function available.
// Give them a Variable in the 3den Editor and add the variable to the array.
// Then add the Offset Position where the box should be spawne, according to the getRelPos Function:
// object getRelPos [distance, direction]
// f.e. when it should be spawned directly on a Marker, give 0,0. If it should be spawned at the rear of a truck, use 7 (the distance from the middle of the object), 180 (the direction pointing at the end of the truck).
_supplyPointInitPath = format ["%1supplyPointInit.sqf",supplyPath];
{
	_obj = _x select 0;
	
	[_x select 0,_x select 1,_x select 2]	execVM _supplyPointInitPath
}forEach supplyPoints;