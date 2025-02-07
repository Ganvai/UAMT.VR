_currBox = uiNamespace getVariable ["sppBox",objNull];

deleteVehicle _currBox;

uiNamespace setVariable ["sppBox",objNull];

closeDialog 0;