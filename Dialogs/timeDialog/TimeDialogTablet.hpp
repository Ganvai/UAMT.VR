class timeDialogTablet
{
	idd = 112233;
	name = "Time-Dialog";
	
	movingEnable = false;
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.1;
			y = safeZoneY + safeZoneH * 0.1;
			w = safeZoneW * 0.8;
			h = safeZoneH * 0.8;
			style = 48;
			text = "Dialogs\MilitaryInterfaceTablet.paa";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";			
		};

		class TitleText
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.30364584;
			y = safeZoneY + safeZoneH * 0.25;
			w = safeZoneW * 0.39270834;
			h = safeZoneH * 0.02962963;
			style = 2;
			text = "Set Deployment Time";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2275,0.902,0.4118,1};
			font = "PuristaSemiBold";
			sizeEx = "0.02 / (getResolution select 5)";
			shadow = 0;
			
		};
		class TitleLine
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.30364584;
			y = safeZoneY + safeZoneH * 0.29074075;
			w = safeZoneW * 0.39270834;
			h = safeZoneH * 0.00092593;
			style = 0;
			text = "";
			colorBackground[] = {0.2353,0.9294,0.2667,1};
			colorText[] = {0.7647,0.0706,0.7333,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};
		class textline
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.30364584;
			y = safeZoneY + safeZoneH * 0.38;
			w = safeZoneW * 0.39270834;
			h = safeZoneH * 0.02962963;
			style = 2;
			text = "Choose a new time to conduct the Mission.";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.702,0.702,0.702,1};
			font = "PuristaSemiBold";
			sizeEx = "0.02 / (getResolution select 5)";
			shadow = 0;
			
		};
	};
	
	class Controls
	{
		class BtnDudd
		{
			type = 1;
			idc = 301;
			x = safeZoneX + safeZoneW * 0.000001;
			y = safeZoneY + safeZoneH * 0.000001;
			w = safeZoneW * 0.00000001;
			h = safeZoneH * 0.00000001;
			style = 0+2;
			text = "";
			borderSize = 0;
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0.2353,0.9294,0.2667,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0.2353,0.9294,0.2667,1};
			colorText[] = {0.2353,0.9294,0.2667,1};
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
		};

		class BtnExecute
		{
			type = 1;
			idc = 9910404;
			x = safeZoneX + safeZoneW * 0.43066407;
			y = safeZoneY + safeZoneH * 0.72048612;
			w = safeZoneW * 0.13867188;
			h = safeZoneH * 0.03645834;
			style = 2;
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
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			sizeEx = "0.02 / (getResolution select 5)";
			text = "Set new Time";
			action = execVM "Dialogs\timeDialog\setTime.sqf";
		};
		
		class BtnClose
		{
			type = 1;
			idc = 300;
			x = safeZoneX + safeZoneW * 0.64635417;
			y = safeZoneY + safeZoneH * 0.25462963;
			w = safeZoneW * 0.04635417;
			h = safeZoneH * 0.02222223;
			style = 0+2;
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
			sizeEx = "0.02 / (getResolution select 5)";
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			shadow = 0;
			action = "closeDialog 0;";
		};
		
		class ComboTime: BtnExecute
		{
			type = 4;
			idc = 112;
			x = safeZoneX + safeZoneW * 0.425;
			y = safeZoneY + safeZoneH * 0.42;
			w = safeZoneW * 0.15;
			h = safeZoneH * 0.035;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.1,0.1,0.1,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,1,1,1};
			colorSelectBackground[] = {0.5,0.5,0.5,1};
			colorText[] = {0.702,0.702,0.702,1};
			maxHistoryDelay = 0;
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			onLoad = execVM "Dialogs\timeDialog\timelist.sqf";
			default = false;
		};
		
	};
	
};
