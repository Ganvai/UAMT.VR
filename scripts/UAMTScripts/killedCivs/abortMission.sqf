if (!isServer) exitWith {};

sleep 5;

["end4",false,true,true,true] remoteExec ["BIS_fnc_endMission"];