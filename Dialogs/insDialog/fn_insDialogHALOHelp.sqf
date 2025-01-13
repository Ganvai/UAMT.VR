_noBoCMsg = "3. After ordering a HALO, there will be a crate available where all soldiers can store their backpacks and recieve a parachute.<br/>";

if (isClass(configFile >> "cfgPatches" >> "BackpackOnChest")) then {
	_noBoCMsg = "3. Soldiers have to put their backpack on their chest and have to get their parachute from the arsenal.<br/>";
};

_helpText = format [ "<t size='1.3'>Insertion HALO Setup</t><br/><br/>
<t size='0.9'>On this screen you can choose a drop zone and a approach vector for the HALO jump.</t><br/><br/>
<t size='0.9' underline='1'>How To:</t><br/>
<t size='0.9'>1. Click on the map to select the position for the drop zone.<br/>
2. Use the slider to choose an approach vector.<br/>
%1
<br/>
<t size='0.9' underline='1'>Important to know:</t><br/>
<t size='0.9'>1. Jump height will depend on the vehicle available (Helicopters 4000m, planes 7000m).<br/>
2. Speed on approach to the drop zone will differ significantly between planes and helicopters. When conducting HALO Jump from planes, it is recommended to jump on the 1000m mark given by the pilot.<br/>
3. The Pilot of the halo vehicle will inform you when reaching the 1000m mark to the drop zone.<br/>
</t>", _noBoCMsg];

[_helpText,"Help"]spawn BIS_fnc_guiMessage;

