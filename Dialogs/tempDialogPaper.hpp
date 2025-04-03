class tempDialogPaper
{
	idd = 99001;
	onLoad = "[_this select 0]execVM 'Dialogs\artDialog\fn_artInitDialog.sqf';";
	
	class ControlsBackground
	{
		class ArtBackground
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
			text = "TitleLine";
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
			idc = 0;
			x = safeZoneX + safeZoneW * 0.18;
			y = safeZoneY + safeZoneH * 0.25;
			w = safeZoneW * 0.12;
			h = safeZoneH * 0.05;
			style = 0;
			text = "Title:";
			colorBackground[] = {1,1,1,0};
			colorText[] = {0,0,0,1};
			font = "Caveat";
			sizeEx = "0.03 / (getResolution select 5)";			
		};
		
		class NameTag2: NameTag1
		{
			y = safeZoneY + safeZoneH * 0.30;
			text = "Title:";			
		};

		class NameTag3: NameTag1
		{
			y = safeZoneY + safeZoneH * 0.35;
			text = "Title:";
		};

		class NameTag4: NameTag1
		{
			y = safeZoneY + safeZoneH * 0.40;
			text = "Title:";
		};

		class NameTag5: NameTag1
		{
			y = safeZoneY + safeZoneH * 0.45;
			text = "Title:";
		};
	};
	
	class Controls
	{
		class BtnCall
		{
			type = 1;
			idc = 100;
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
			text = "Call ";
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
		};
		
		class BtnHelp: BtnClose
		{
			idc = 200;
			x = safeZoneX + safeZoneW * 0.18;
			text = "Help";
		};

		// Control Name - Control Type
		class Ctrl1 {
			type = 4;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.30;
			y = safeZoneY + safeZoneH * 0.26;
			w = safeZoneW * 0.14;
			h = safeZoneH * 0.03;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			maxHistoryDelay = 0;
			sizeEx = "0.02 / (getResolution select 5)";
			wholeHeight = 0.3;
			color[] = {0.988,0.933,0.698,1};
			colorActive[] = {0,0,0,1};
			colorSelect[] = {0,0,0,1};
			colorSelectBackground[] = {0.992,0.922,0.608,1};
			colorText[] = {0,0,0,1};
			colorBackground[] =  {0.988,0.933,0.698,1};
			colorBackgroundActive[] =  {0.988,0.933,0.698,1};
			colorBackgroundDisabled[] =  {0.2,0.2,0.2,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorFocused[] = {0.6,0.6,0.6,1};
			colorShadow[] = {0,0,0,0};
			colorScrollbar[] = {0.3,0.3,0.3,1};
			colorPicture[] = {0,0,0,1};
			colorPictureSelected[] = {0,0,0,1};
			colorPictureDisabled[] = {0.2,0.2,0.2,1};
			colorPictureRight[] = {0,0,0,1};
			colorPictureRightSelected[] = {0,0,0,1};
			colorPictureRightDisabled[] = {0.2,0.2,0.2,1};
			colorTextRight[] = {0,0,0,1};
			colorSelectRight[] = {0,0,0,1};
			colorSelect2Right[] = {0,0,0,1};
			tooltipColorText[] = {1,1,1,1};
			tooltipColorBox[] = {0.8,0.8,0.8,0};
			tooltipColorShade[] = {0,0,0,0.65};
			font = "Caveat";
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			tooltip = "";
		};
		
		// Control Name - Control Type
		class Ctrl2: Ctrl1
		{
			idc = 0;
			y = safeZoneY + safeZoneH * 0.31;
			tooltip = "";
		};

		// Control Name - Control Type
		class Ctrl3: Ctrl1
		{
			type = 43;
			idc = 9900103;
			y = safeZoneY + safeZoneH * 0.36;
			style = 1024;
			colorActive[] = {0.988,0.933,0.698,1};
			colorSelect[] = {0.988,0.933,0.698,1};
			arrowEmpty = "\A3\ui_f\data\GUI\Cfg\Slider\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\Cfg\Slider\arrowFull_ca.paa";
			border = "\A3\ui_f\data\GUI\Cfg\Slider\border_ca.paa";
			sliderStep = 1;
			sliderRange[] = {0, 999};
			sliderPosition = 0;
			thumb = "\A3\ui_f\data\GUI\Cfg\Slider\thumb_ca.paa";
			tooltip = "Number of projectiles.";
			onSliderPosChanged = "params ['_control', '_newValue'];	_text = format ['Rounds: %1',_newValue];ctrlSetText [9900104, _text];";
		};

		// Control Name - Control Type		
		class Ctrl4: Ctrl1
		{
			idc = 0;
			y = safeZoneY + safeZoneH * 0.41;
			tooltip = "";
		};
		
		// Control Name - Control Type
		class Ctrl5: Ctrl1
		{
			type = 43;
			idc = 0;
			y = safeZoneY + safeZoneH * 0.46;
			style = 1024;
			colorActive[] = {0.988,0.933,0.698,1};
			colorSelect[] = {0.988,0.933,0.698,1};
			arrowEmpty = "\A3\ui_f\data\GUI\Cfg\Slider\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\Cfg\Slider\arrowFull_ca.paa";
			border = "\A3\ui_f\data\GUI\Cfg\Slider\border_ca.paa";
			sliderStep = 1;
			sliderRange[] = {0, 999};
			sliderPosition = 0;
			thumb = "\A3\ui_f\data\GUI\Cfg\Slider\thumb_ca.paa";
			tooltip = "Radius in which the artillery rounds will be delivered";
			onSliderPosChanged = "[_this select 1] call artDialog_fnc_artCheckRadiusDialog";
		};		
	};
	
};
