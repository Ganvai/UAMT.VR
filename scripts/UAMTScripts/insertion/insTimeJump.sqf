//Needed for fadeMusic to work
ace_hearing_disableVolumeUpdate = true;

titletext ["","BLACK",2];

3 fadeSound 0;
3 fadeEnvironment 0;

sleep 4;

titletext ["<t size='3' font='PuristaBold'>30 mike later</t>","BLACK FADED",1,true,true];

sleep 5;

titletext ["<t size='3' font='PuristaBold'>30 mike later</t>","BLACK IN",1,true,true];

5 fadeSound 1;
5 fadeEnvironment 1;

"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [6];
"dynamicBlur" ppEffectCommit 0;
"dynamicBlur" ppEffectAdjust [0.0];
"dynamicBlur" ppEffectCommit 5;

sleep 3;

ace_hearing_disableVolumeUpdate = false;