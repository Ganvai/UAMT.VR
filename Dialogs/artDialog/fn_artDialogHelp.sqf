_helpText = format [ "<t size='1.3'>Artillery Call</t><br/><br/>
<t size='0.9' underline='1'>How To:</t><br/>
<t size='0.9'>1. Choose an Artillery Element from the List 'Artillery'.<br/>
2. Now choose the Ammunition for the strike.<br/>
3. Use the Slider to set how many rounds will be fired.<br/>
4. Search for a position on the Map you want the Artillery Strike to hit and click it.<br/>
5. Select a Firepattern. The Artillery will distribute the rounds in this pattern.<br/>
6. Use the slider to set a radius the firepattern will be distributed to. Is ignored when using 'Rapid Fire'.<br/>
7. Call the Artillery and watch it rain down on your enemy.<br/>
<br/>
<t size='0.9' underline='1'>Important to know:</t><br/>
<t size='0.9'>1. For Firepatterns: Keep in mind that there will be deviations because of dispersion.<br/>
2 'Rapid Fire' will distribute the rounds just on the Point but will make the Artillery shoot much faster because they don't need to adjust their targeting every shot.<br/>
3. There can be 'No Fire Zones' on the Map in which some Ammunition of the Artillery might be prohibited (for example because of the risk of collateral damage).<br/>
4. There is a warning message when the Position for the Strike is not in range for the Artillery. Artillery range can differ depending on wind and used ammunition.<br/>
5. Some Artillery have a minimum distance. When your strike position is to close, you get also the 'not in Range'-Warning. Most of the mechanized Artillery Elements or Rocket-Ammunitions have this limitaion.<br/>
</t>", _noBoCMsg];

[_helpText,"Help"]spawn BIS_fnc_guiMessage;

