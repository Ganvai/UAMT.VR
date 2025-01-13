class insDialogEdit
{
	idd = 99102;
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.18847657;
			y = safeZoneY + safeZoneH * -0.00868055;
			w = safeZoneW * 0.62402344;
			h = safeZoneH * 1.04340278;
			style = 0+48;
			text = "Dialogs\Military_Interface.paa";
			colorBackground[] = {0.3608,0.4824,0.3451,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class Title
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.30364584;
			y = safeZoneY + safeZoneH * 0.23148149;
			w = safeZoneW * 0.39270834;
			h = safeZoneH * 0.02962963;
			style = 2;
			text = "Edit Insertion Setup";
			colorBackground[] = {1,1,1,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class TitleLine
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.30416667;
			y = safeZoneY + safeZoneH * 0.26574075;
			w = safeZoneW * 0.39270834;
			h = safeZoneH * 0.00092593;
			style = 0;
			text = "";
			colorBackground[] = {0.5843,0.8902,0.349,1};
			colorText[] = {0.3137,0.5373,0.2314,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};		
	};
	class Controls
	{
		class BtnClose
		{
			type = 1;
			idc = 9910201;
			x = safeZoneX + safeZoneW * 0.64635417;
			y = safeZoneY + safeZoneH * 0.23518519;
			w = safeZoneW * 0.04635417;
			h = safeZoneH * 0.02222223;
			style = 0+2;
			text = "Close";
			borderSize = 0;
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0.5843,0.8902,0.349,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0.5843,0.8902,0.349,1};
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
			shadow = 0;
			
		};
		class BtnHelp
		{
			type = 1;
			idc = 9910202;
			x = safeZoneX + safeZoneW * 0.5953125;
			y = safeZoneY + safeZoneH * 0.23518519;
			w = safeZoneW * 0.04635417;
			h = safeZoneH * 0.02222223;
			style = 0+2;
			text = "Help";
			borderSize = 0;
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0.5843,0.8902,0.349,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0.5843,0.8902,0.349,1};
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
			shadow = 0;
			
		};

		class BtnCancel
		{
			type = 1;
			idc = 9910203;
			x = safeZoneX + safeZoneW * 0.40208334;
			y = safeZoneY + safeZoneH * 0.50092593;
			w = safeZoneW * 0.1953125;
			h = safeZoneH * 0.08148149;
			style = 0+2;
			text = "Cancel current Insertion Method and setup new";
			borderSize = 0;
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0.5843,0.8902,0.349,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0.5843,0.8902,0.349,1};
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
			shadow = 0;
			action = "[] spawn UAMTins_fnc_insDialogEditCancel";
		};
		
	};
	
};
