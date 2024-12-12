_display = findDisplay 99006;

onMapSingleClick "";

deleteMarker (_display getVariable "_chtPickUpMrkName");
deleteMarker (_display getVariable "_chtDropOffMrkName");

chtAvailable = true;
publicVariable "chtAvailable";

closeDialog 0;