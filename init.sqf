diag_log text "";
diag_log text format["|=============================   %1   =============================|", missionName];
diag_log text "";

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Multiplayer Settings
//
//------------------------------------------------------------------
//------------------------------------------------------------------

enableRadio false;
if (isMultiplayer) then {enableSaving [false, false]};
enableTeamswitch false;

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Friend / Enemy
//
//------------------------------------------------------------------
//------------------------------------------------------------------

east setFriend [civilian,1];
civilian setFriend [east,1];
west setFriend [civilian,1];
civilian setFriend [west,1];

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Debug Options
//
//------------------------------------------------------------------
//------------------------------------------------------------------

//onMapSingleClick "player setpos _pos";
//player allowDamage false;

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Zeus Objects Available
//
//------------------------------------------------------------------
//------------------------------------------------------------------
	
[] spawn {
        {
            _x addCuratorEditableObjects [allUnits, true];
            _x addCuratorEditableObjects [vehicles, true];
            _x addCuratorEditableObjects [allUnitsUAV, true];
            _x addCuratorEditableObjects [allMines, true];
        } forEach allCurators;
    };

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Mission Specific Items
//
// In this follow Up Script you can add Mission Specific Configs
// This makes Updating the UAMT to a new Version easier.
//
//------------------------------------------------------------------
//------------------------------------------------------------------
execVM "MissionSpecifics\MSInit.sqf";

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Developer Mode
//
// Deactivates all Intros in the beginning for a "faster" Load In
//
// Should be deactivated when doing a final Mission extract.
//------------------------------------------------------------------
//------------------------------------------------------------------

devMode = true;
publicVariable "devMode";