class doorKeypad
{
	name="Doorkeypad";
	idd = 99002;
	
	onLoad = "[_this select 0]execVM 'Dialogs\doorKeypad\initDoorKeypad.sqf';";
	
	class ControlsBackground
	{
		class Background_transp
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.40364584;
			y = safeZoneY + safeZoneH * 0.24351852;
			w = safeZoneW * 0.19270834;
			h = safeZoneH * 0.42962963;
			style = 0;
			text = "";
			colorBackground[] = {0.102,0.102,0.102,0.6706};
			colorText[] = {0.2078,0.051,0.6824,0};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class Background_solid
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.41354167;
			y = safeZoneY + safeZoneH * 0.26203704;
			w = safeZoneW * 0.17291667;
			h = safeZoneH * 0.3925926;
			style = 0+80;
			text = "";
			colorBackground[] = {0.2,0.2,0.2,1};
			colorText[] = {0.2,0.2,0.2,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 1;
			
		};
		class frame
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.4234375;
			y = safeZoneY + safeZoneH * 0.2712963;
			w = safeZoneW * 0.153125;
			h = safeZoneH * 0.37407408;
			style = 64;
			text = "";
			colorBackground[] = {0.302,0.302,0.302,1};
			colorText[] = {0.302,0.302,0.302,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 2;
			
		};
		
	};
	class Controls
	{
		class key1
		{
			type = 1;
			idc = 9900201;
			x = safeZoneX + safeZoneW * 0.42864584;
			y = safeZoneY + safeZoneH * 0.35;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.05;
			style = 2;
			text = "1";
			borderSize = 0;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorBackgroundActive[] = {0.102,0.102,0.102,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0.001;
			offsetY = 0.001;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shortcuts[] = {2,79};
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "['1'] call doorkeypad_fnc_inputKey;";
			
		};
		class key2
		{
			type = 1;
			idc = 9900202;
			x = safeZoneX + safeZoneW * 0.4828125;
			y = safeZoneY + safeZoneH * 0.35;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.05;
			style = 2;
			text = "2";
			borderSize = 0;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorBackgroundActive[] = {0.102,0.102,0.102,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0.001;
			offsetY = 0.001;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shortcuts[] = {3,80};
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "['2'] call doorkeypad_fnc_inputKey;";
		};
		class key3
		{
			type = 1;
			idc = 9900203;
			x = safeZoneX + safeZoneW * 0.53385417;
			y = safeZoneY + safeZoneH * 0.35;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.05;
			style = 2;
			text = "3";
			borderSize = 0;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorBackgroundActive[] = {0.102,0.102,0.102,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0.001;
			offsetY = 0.001;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shortcuts[] = {4,81};
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "['3'] call doorkeypad_fnc_inputKey;";
		};
		class key4
		{
			type = 1;
			idc = 9900204;
			x = safeZoneX + safeZoneW * 0.42864584;
			y = safeZoneY + safeZoneH * 0.425;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.05;
			style = 2;
			text = "4";
			borderSize = 0;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorBackgroundActive[] = {0.102,0.102,0.102,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0.001;
			offsetY = 0.001;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shortcuts[] = {5,75};
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "['4'] call doorkeypad_fnc_inputKey;";
		};
		class key5
		{
			type = 1;
			idc = 9900205;
			x = safeZoneX + safeZoneW * 0.4828125;
			y = safeZoneY + safeZoneH * 0.425;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.05;
			style = 2;
			text = "5";
			borderSize = 0;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorBackgroundActive[] = {0.102,0.102,0.102,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0.001;
			offsetY = 0.001;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shortcuts[] = {6,76};
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "['5'] call doorkeypad_fnc_inputKey;";
		};
		class key6
		{
			type = 1;
			idc = 9900206;
			x = safeZoneX + safeZoneW * 0.53385417;
			y = safeZoneY + safeZoneH * 0.425;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.05;
			style = 2;
			text = "6";
			borderSize = 0;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorBackgroundActive[] = {0.102,0.102,0.102,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0.001;
			offsetY = 0.001;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shortcuts[] = {7,77};
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "['6'] call doorkeypad_fnc_inputKey;";
		};
		class key7
		{
			type = 1;
			idc = 9900207;
			x = safeZoneX + safeZoneW * 0.42864584;
			y = safeZoneY + safeZoneH * 0.5;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.05;
			style = 2;
			text = "7";
			borderSize = 0;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorBackgroundActive[] = {0.102,0.102,0.102,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0.001;
			offsetY = 0.001;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shortcuts[] = {8,71};
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "['7'] call doorkeypad_fnc_inputKey;";
		};
		class key8
		{
			type = 1;
			idc = 9900208;
			x = safeZoneX + safeZoneW * 0.4828125;
			y = safeZoneY + safeZoneH * 0.5;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.05;
			style = 2;
			text = "8";
			borderSize = 0;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorBackgroundActive[] = {0.102,0.102,0.102,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0.001;
			offsetY = 0.001;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shortcuts[] = {9,72};
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "['8'] call doorkeypad_fnc_inputKey;";
		};
		class key9
		{
			type = 1;
			idc = 9900209;
			x = safeZoneX + safeZoneW * 0.53385417;
			y = safeZoneY + safeZoneH * 0.5;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.05;
			style = 2;
			text = "9";
			borderSize = 0;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorBackgroundActive[] = {0.102,0.102,0.102,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0.001;
			offsetY = 0.001;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shortcuts[] = {10,73};
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "['9'] call doorkeypad_fnc_inputKey;";
		};
		class keyCancel
		{
			type = 1;
			idc = 9900211;
			x = safeZoneX + safeZoneW * 0.42864584;
			y = safeZoneY + safeZoneH * 0.575;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.05;
			style = 2;
			text = "Cancel";
			borderSize = 0;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorBackgroundActive[] = {0.102,0.102,0.102,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0.8,0.2,0.2,1};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0.001;
			offsetY = 0.001;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "ctrlSetText [9900200,''];";
		};
		class key0
		{
			type = 1;
			idc = 9900210;
			x = safeZoneX + safeZoneW * 0.4828125;
			y = safeZoneY + safeZoneH * 0.575;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.05;
			style = 2;
			text = "0";
			borderSize = 0;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorBackgroundActive[] = {0.102,0.102,0.102,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0.001;
			offsetY = 0.001;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shortcuts[] = {11,82};
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "['0'] call doorkeypad_fnc_inputKey;";
		};
		class keyConfirm
		{
			type = 1;
			idc = 9900212;
			x = safeZoneX + safeZoneW * 0.53385417;
			y = safeZoneY + safeZoneH * 0.575;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.05;
			style = 2;
			text = "Confirm";
			borderSize = 0;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorBackgroundActive[] = {0.102,0.102,0.102,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0.302,0.502,0.302,1};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0.001;
			offsetY = 0.001;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "call doorkeypad_fnc_keypadConfirm;";
		};
		class Input
		{
			type = 0;
			idc = 9900200;
			x = safeZoneX + safeZoneW * 0.4421875;
			y = safeZoneY + safeZoneH * 0.28518519;
			w = safeZoneW * 0.115625;
			h = safeZoneH * 0.03703704;
			style = 2;
			text = "";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "TahomaB";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		
	};
	
};
