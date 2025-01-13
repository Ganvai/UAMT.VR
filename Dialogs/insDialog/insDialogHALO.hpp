class insDialogHALO
{
	idd = 99103;
	onLoad = "[_this select 0]execVM 'Dialogs\insDialog\fn_insDialogHALOInit.sqf';";
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.171875;
			y = safeZoneY + safeZoneH * -0.01736111;
			w = safeZoneW * 0.65625;
			h = safeZoneH * 1.03472223;
			style = 0+48;
			text = "Dialogs\Military_Interface.paa";
			colorBackground[] = {1,1,1,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class titleCASStrike
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.29394532;
			y = safeZoneY + safeZoneH * 0.24131945;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.02256945;
			style = 2;
			text = "HALO Insertion Setup";
			colorBackground[] = {1,1,1,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class TitleBar
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.29394532;
			y = safeZoneY + safeZoneH * 0.26909723;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.00520834;
			style = 2;
			text = "";
			colorBackground[] = {0.5843,0.8902,0.349,1};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class titleBTNDir
		{
			type = 0;
			idc = 9910302;
			x = safeZoneX + safeZoneW * 0.43;
			y = safeZoneY + safeZoneH * 0.28645834;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.02777778;
			style = 0;
			text = "Approach from: NORTH";
			colorBackground[] = {1,1,1,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class mapFrame
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.31347657;
			y = safeZoneY + safeZoneH * 0.32986112;
			w = safeZoneW * 0.37304688;
			h = safeZoneH * 0.375;
			style = 0;
			text = "";
			colorBackground[] = {0.5843,0.8902,0.349,1};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		
	};
	class Controls
	{
		
		class sliderDir
		{
			type = 43;
			idc = 9910303;
			x = safeZoneX + safeZoneW * 0.527;
			y = safeZoneY + safeZoneH * 0.29166667;
			w = safeZoneW * 0.155;
			h = safeZoneH * 0.02083334;
			style = 1024;
			arrowEmpty = "\A3\ui_f\data\GUI\Cfg\Slider\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\Cfg\Slider\arrowFull_ca.paa";
			border = "\A3\ui_f\data\GUI\Cfg\Slider\border_ca.paa";
			color[] = {0.5843,0.8902,0.349,1};
			colorActive[] = {1,1,1,1};
			sliderStep = 5;
			sliderRange[] = {0, 360};
			sliderPosition = 180;
			thumb = "\A3\ui_f\data\GUI\Cfg\Slider\thumb_ca.paa";
			onSliderPosChanged = "params ['_control', '_newValue'];	_insert = 0; switch _newValue do {case 0 : {_insert = 'NORTH';};case 360 : {_insert = 'NORTH';};case 90 : {_insert = 'EAST';};case 180 : {_insert = 'SOUTH';};case 270 : {_insert = 'WEST';};default {_insert = _newValue;};};_text = format ['Approach from: : %1',_insert];ctrlSetText [9910302, _text];if (markerAlpha 'insHALOMrk' == 1) then {'insHALODirMrk' setMarkerPosLocal ((getMarkerPos 'insHALOMrk') getPos [2000,_newValue]);'insHALODirMrk' setMarkerAlphaLocal 1;'insHALODirMrk' setMarkerDirLocal (_newValue + 180);};";
		};
		
		class callStrike
		{
			type = 1;
			idc = 9910304;
			x = safeZoneX + safeZoneW * 0.43066407;
			y = safeZoneY + safeZoneH * 0.72048612;
			w = safeZoneW * 0.13867188;
			h = safeZoneH * 0.03645834;
			style = 0+2;
			text = "Order HALO Insertion";
			borderSize = 0;
			colorBackground[] = {0.2,0.2,0.2,1};
			colorBackgroundActive[] = {0.302,0.302,0.302,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			offsetPressedX = 0.005;
			offsetPressedY = 0.005;
			offsetX = 0.005;
			offsetY = 0.005;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			action = "[(sliderPosition 9910303)] spawn UAMTins_fnc_insDialogHALOCall;";
		};
		
		class BtnClose
		{
			type = 1;
			idc = 300;
			x = safeZoneX + safeZoneW * 0.64635417;
			y = safeZoneY + safeZoneH * 0.24;
			w = safeZoneW * 0.04635417;
			h = safeZoneH * 0.02222223;
			style = 2;
			text = "Exit";
			borderSize = 0;
			colorBackground[] = {0.2,0.2,0.2,1};
			colorBackgroundActive[] = {0.302,0.302,0.302,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			offsetPressedX = 0.005;
			offsetPressedY = 0.005;
			offsetX = 0.005;
			offsetY = 0.005;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			default = false;
			shadow = 0;
			action = "call UAMTins_fnc_insDialogHALOClose;";
		};
	};
};