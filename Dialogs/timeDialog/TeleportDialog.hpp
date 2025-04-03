class teleportDialog
{
	idd = 4321;
	name = "Teleport-Dialog";
	
	movingEnable = false;
	
	class ControlsBackground
	{
		class Background: RscText
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.385;
			y = safeZoneY + safeZoneH * 0.2;
			w = safeZoneW * 0.23;
			h = safeZoneH * 0.39;
			style = 0;
			text = "";
			colorBackground[] = {0.102,0.102,0.102,0.6706};
			colorText[] = {0.2078,0.051,0.6824,0};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
		};

		class Background_solid
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.39;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.22;
			h = safeZoneH * 0.37;
			style = 0+80;
			text = "";
			colorBackground[] = {0.2,0.2,0.2,1};
			colorText[] = {0.2,0.2,0.2,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			shadow = 1;
		};		
		
		class TitleText
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.4;
			y = safeZoneY + safeZoneH * 0.215;
			w = safeZoneW * 0.2;
			h = safeZoneH * 0.03;
			style = 2;
			text = "Teleport";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.8,0.8,0.8,1};
			font = "PuristaSemiBold";
			sizeEx = "0.03 / (getResolution select 5)";
			shadow = 0;
		};
		
		class TitleLine
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.395;
			y = safeZoneY + safeZoneH * 0.252;
			w = safeZoneW * 0.21;
			h = safeZoneH * 0.001;
			style = 0;
			text = "";
			colorBackground[] = {0.4,0.4,0.4,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
		};
	};

	class Controls
	{
		class List
		{
			type = 5;
			idc = 1000;
			x = safeZoneX + safeZoneW * 0.395;
			y = safeZoneY + safeZoneH * 0.27;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.3;
			style = 16;
			colorBackground[] = {0.3,0.3,0.3,1};
			colorSelectBackground[] = {0,0,0,1};
			colorSelectBackground2[] = {0,0,0,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,1,1,1};
			colorText[] = {0.702,0.702,0.702,1};
			colorPicture[] = {1,1,1,1};
			font = "PuristaSemiBold";
			maxHistoryDelay = 0;
			rowHeight = 0;
			sizeEx = "0.02 / (getResolution select 5)";
			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1.0};
			class ListScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			onLoad = execVM "Dialogs\teleportDialog\fn_getPlayerGroups.sqf";
		};
		
		class BtnClose
		{
			type = 1;
			idc = 201;
			x = safeZoneX + safeZoneW * 0.575;
			y = safeZoneY + safeZoneH * 0.223;
			w = safeZoneW * 0.03;
			h = safeZoneH * 0.02;
			style = 2;
			text = "Close";
			borderSize = 0;
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0.5843,0.8902,0.349,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0.1,0.1,0.1,1};
			colorText[] = {0.8,0.8,0.8,1};
			font = "PuristaMedium";
			offsetPressedX = 0.005;
			offsetPressedY = 0.005;
			offsetX = 0.001;
			offsetY = 0.001;
			sizeEx = "0.015 / (getResolution select 5)";
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			shadow = 0;
			action = "closeDialog 0;";
		};

		class BtnExecute: BtnClose
		{
			type = 1;
			idc = 203;
			x = safeZoneX + safeZoneW * 0.505;
			y = safeZoneY + safeZoneH * 0.40;
			w = safeZoneW * 0.095;
			h = safeZoneH * 0.035;
			sizeEx = "0.02 / (getResolution select 5)";
			text = "Teleport to Group";
			action = "call UAMTteleport_fnc_teleport;";
		};
	};
};
