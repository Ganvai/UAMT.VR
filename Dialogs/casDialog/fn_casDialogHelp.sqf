_helpText = format [ "<t size='1.3'>CAS Call</t><br/><br/>
<t size='0.9' underline='1'>How To:</t><br/>
<t size='0.9'>1. Choose the Weapon the CAS should use.<br/>
2. Click on the Map to choose the Strike Position.<br/>
3. Use the Slider to choose the Direction from which the CAS will approach.<br/>
<br/>
<t size='0.9' underline='1'>Important to know:</t><br/>
<t size='0.9'>1. CAS can be hit by AA and you might loose it completely.<br/>
2. The CAS needs some time to arrive at the staging Area.<br/>
3. Choose the direction carefully. This can avoid loosing the plane to AAs or hitting friendly units.<br/>
4. There can be 'No Fire Zones' on the map where CAS strikes are prohibited.<br/>
</t>", _noBoCMsg];

[_helpText,"Help"]spawn BIS_fnc_guiMessage;

