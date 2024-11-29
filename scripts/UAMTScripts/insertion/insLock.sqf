if (!isServer) exitWith {};

{
	_x lock true;
	[_x,0]remoteExec ["setFuel"];
}forEach insHeloVeh;

{
	_x lock true;
	[_x,0]remoteExec ["setFuel"];
}forEach insCarVeh;

insHALOVeh lock true;
[insHALOVeh,0]remoteExec ["setFuel"];
