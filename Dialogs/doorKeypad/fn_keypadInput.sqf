params ["_pad","_house","_code","_doors","_target","_actionID"];

_display = createDialog ["doorKeypad",true];

playSound3D ["A3\Sounds_F_Orange\MissionSFX\orange_PeriodSwitch_Notification.wss",_pad];

_pad setVariable ["_pad",_pad];
_pad setVariable ["_house",_house];
_pad setVariable ["_code",_code];
_pad setVariable ["_doors",_doors];
_pad setVariable ["_target",_target];
_pad setVariable ["_actionID",_actionID];


