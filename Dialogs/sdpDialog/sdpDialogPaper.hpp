class sdpDialogPaper
{
	idd = 99007;
	onLoad = "[_this select 0]execVM 'Dialogs\sdpDialog\fn_sdpInitDialog.sqf';";
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * -0.00625;
			y = safeZoneY + safeZoneH * 0;
			w = safeZoneW * 1.0125;
			h = safeZoneH * 1;
			style = 48;
			text = "Dialogs\MilitaryInterfacePaper.paa";
			colorBackground[] = {0.75,0.75,0.75,1};
			colorText[] = {0.75,0.75,0.75,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
		};
		
		class TitleLine
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.16;
			y = safeZoneY + safeZoneH * 0.22;
			w = safeZoneW * 0.303125;
			h = safeZoneH * 0.025;
			style = 2;
			text = "Supply Drop";
			colorBackground[] = {1,1,1,0};
			colorText[] = {0,0,0,1};
			font = "TahomaB";
			sizeEx = "0.02 / (getResolution select 5)";
		};

		class BottomLine
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.18;
			y = safeZoneY + safeZoneH * 0.77;
			w = safeZoneW * 0.26;
			h = safeZoneH * 0.003;
			style = 2;
			text = "";
			colorBackground[] = {0,0,0,1};
			colorText[] = {0,0,0,1};
			font = "TahomaB";
			sizeEx = "0.02 / (getResolution select 5)";
		};
		
		class headline
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.18;
			y = safeZoneY + safeZoneH * 0.245;
			w = safeZoneW * 0.26;
			h = safeZoneH * 0.0015;
			style = 2;
			text = "";
			colorBackground[] = {0,0,0,1};
			colorText[] = {0,0,0,1};
			font = "TahomaB";
			sizeEx = "0.02 / (getResolution select 5)";
		};

		class breakline2: Headline
		{
			y = safeZoneY + safeZoneH * 0.30;
		};

		class breakline3: Headline
		{
			y = safeZoneY + safeZoneH * 0.35;
		};

		class breakline4: Headline
		{
			y = safeZoneY + safeZoneH * 0.40;
		};

		class breakline5: Headline
		{
			y = safeZoneY + safeZoneH * 0.45;
		};

		class breakline6: Headline
		{
			y = safeZoneY + safeZoneH * 0.50;
		};

		// Nametags
		class NameTag1 {
			type = 0;
			idc = 9900702;
			x = safeZoneX + safeZoneW * 0.18;
			y = safeZoneY + safeZoneH * 0.25;
			w = safeZoneW * 0.12;
			h = safeZoneH * 0.05;
			style = 0;
			text = "Direction: SOUTH";
			colorBackground[] = {1,1,1,0};
			colorText[] = {0,0,0,1};
			font = "Caveat";
			sizeEx = "0.03 / (getResolution select 5)";			
		};
	};
	
	class Controls
	{
		class BtnCall
		{
			type = 1;
			idc = 9900704;
			x = safeZoneX + safeZoneW * 0.245;
			y = safeZoneY + safeZoneH * 0.78;
			w = safeZoneW * 0.12;
			h = safeZoneH * 0.03;
			style = 2;
			borderSize = 0.001;
			colorBackground[] = {1,1,1,0};
			colorBackgroundActive[] = {0.502,0.502,0.502,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,1};			
			font = "Caveat";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0;
			offsetY = 0;
			sizeEx = "0.04 / (getResolution select 5)";
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			default = false;
			text = "Call Supply Drop";
			action = "[sliderPosition 9900703] spawn sdpDialog_fnc_sdpCallDialog;";
		};
		
		class BtnClose: BtnCall
		{
			idc = 300;
			x = safeZoneX + safeZoneW * 0.4165;
			y = safeZoneY + safeZoneH * 0.205;
			w = safeZoneW * 0.022;
			h = safeZoneH * 0.02;
			text = "Close";
			sizeEx = "0.02 / (getResolution select 5)";
			action = "call sdpDialog_fnc_sdpCloseDialog;";
		};
		
		class BtnHelp: BtnClose
		{
			idc = 9900705;
			x = safeZoneX + safeZoneW * 0.18;
			text = "Help";
			action = "call sdpDialog_fnc_sdpDialogHelp;";
		};

		// Direction - Slider
		class Ctrl1 {
			type = 43;
			idc = 9900103;
			x = safeZoneX + safeZoneW * 0.30;
			y = safeZoneY + safeZoneH * 0.26;
			w = safeZoneW * 0.14;
			h = safeZoneH * 0.03;
			style = 1024;
			maxHistoryDelay = 0;
			sizeEx = "0.02 / (getResolution select 5)";
			wholeHeight = 0.3;
			color[] = {0.988,0.933,0.698,1};
			colorActive[] = {0.988,0.933,0.698,1};
			colorSelect[] = {0.988,0.933,0.698,1};
			arrowEmpty = "\A3\ui_f\data\GUI\Cfg\Slider\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\Cfg\Slider\arrowFull_ca.paa";
			border = "\A3\ui_f\data\GUI\Cfg\Slider\border_ca.paa";
			sliderStep = 5;
			sliderRange[] = {0, 360};
			sliderPosition = 180;
			thumb = "\A3\ui_f\data\GUI\Cfg\Slider\thumb_ca.paa";
			tooltip = "Set Direction from where the Supply Drop Helicopter will approach";
			onSliderPosChanged = "params ['_control', '_newValue'];	_insert = 0; switch _newValue do {case 0 : {_insert = 'NORTH';};case 360 : {_insert = 'NORTH';};case 90 : {_insert = 'EAST';};case 180 : {_insert = 'SOUTH';};case 270 : {_insert = 'WEST';};default {_insert = _newValue;};};_text = format ['Direction: %1',_insert];ctrlSetText [9900702, _text];if (markerAlpha (player getVariable ['sdpMrkLocal','']) == 1) then {(player getVariable ['sdpDirMrkLocal','']) setMarkerPos ((getMarkerPos (player getVariable ['sdpMrkLocal',''])) getPos [500,_newValue]);(player getVariable ['sdpDirMrkLocal','']) setMarkerAlpha 1;(player getVariable ['sdpDirMrkLocal','']) setMarkerDir (_newValue + 180);};";
		};
	};
};
