class insDialogCrateGeneric
{
	idd = 99105;
	
	class ControlsBackground
	{
		class BackgroundTrans
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.37;
			y = safeZoneY + safeZoneH * 0.23;
			w = safeZoneW * 0.26;
			h = safeZoneH * 0.36;
			style = 0;
			text = "";
			colorBackground[] = {0.102,0.102,0.102,0.6706};
			colorText[] = {0.2078,0.051,0.6824,0};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
		};
		
		class Background
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.38;
			y = safeZoneY + safeZoneH * 0.24;
			w = safeZoneW * 0.24;
			h = safeZoneH * 0.34;
			style = 80;
			text = "";
			colorBackground[] = {0.3,0.3,0.3,1};
			colorText[] = {0.3,0.3,0.3,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";			
		};
		
		class Title
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.385;
			y = safeZoneY + safeZoneH * 0.25;
			w = safeZoneW * 0.23;
			h = safeZoneH * 0.02;
			style = 2;
			text = "Halo Cargo Crate";
			colorBackground[] = {1,1,1,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};
		class TitleLine
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.385;
			y = safeZoneY + safeZoneH * 0.275;
			w = safeZoneW * 0.23;
			h = safeZoneH * 0.001;
			style = 0;
			text = "";
			colorBackground[] = {0.5843,0.8902,0.349,1};
			colorText[] = {0.3137,0.5373,0.2314,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};	
	};
	
	class Controls
	{
		class BtnDudd
		{
			type = 1;
			idc = 999666;
			x = safeZoneX + safeZoneW * 0.000001;
			y = safeZoneY + safeZoneH * 0.000001;
			w = safeZoneW * 0.00000001;
			h = safeZoneH * 0.00000001;
			style = 0+2;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 0.001) / 0.001) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			shadow = 0;
			default = true;
		};
		
		class BtnClose
		{
			type = 1;
			idc = 9910501;
			x = safeZoneX + safeZoneW * 0.58;
			y = safeZoneY + safeZoneH * 0.25;
			w = safeZoneW * 0.03;
			h = safeZoneH * 0.02;
			style = 0+2;
			text = "Close";
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
			sizeEx = "0.015 / (getResolution select 5)";
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			shadow = 0;
			action = "closeDialog 0;";
		};

		class BtnStore
		{
			type = 1;
			idc = 9910503;
			x = safeZoneX + safeZoneW * 0.40208334;
			y = safeZoneY + safeZoneH * 0.32;
			w = safeZoneW * 0.1953125;
			h = safeZoneH * 0.08148149;
			style = 0+2;
			text = "Store Backpack & recieve Parachute";
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
			sizeEx = "0.018 / (getResolution select 5)";
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			shadow = 0;
			action = "[] spawn UAMTins_fnc_insDialogDCSaveBackpack";
		};
		class BtnGetBackpack
		{
			type = 1;
			idc = 9910503;
			x = safeZoneX + safeZoneW * 0.40208334;
			y = safeZoneY + safeZoneH * 0.45;
			w = safeZoneW * 0.1953125;
			h = safeZoneH * 0.08148149;
			style = 0+2;
			text = "Get Backpack back & store Parachute";
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
			sizeEx = "0.018 / (getResolution select 5)";
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			shadow = 0;
			action = "[] spawn UAMTins_fnc_insDialogDCgetBackpack";
		};
		
	};
	
};
