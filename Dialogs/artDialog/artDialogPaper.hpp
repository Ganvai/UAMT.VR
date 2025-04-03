class artDialogPaper
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
			text = "Artillery Fire Support";
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
			text = "Artillery:";
			colorBackground[] = {1,1,1,0};
			colorText[] = {0,0,0,1};
			font = "Caveat";
			sizeEx = "0.03 / (getResolution select 5)";			
		};
		
		class NameTag2: NameTag1
		{
			y = safeZoneY + safeZoneH * 0.30;
			text = "Ammunition:";			
		};

		class NameTag3: NameTag1
		{
			idc = 9900104;
			y = safeZoneY + safeZoneH * 0.35;
			text = "Rounds: 0";
		};

		class NameTag4: NameTag1
		{
			y = safeZoneY + safeZoneH * 0.40;
			text = "Dispersion  Pattern:";
		};

		class NameTag5: NameTag1
		{
			idc = 9900106;
			y = safeZoneY + safeZoneH * 0.45;
			text = "Radius: 0m";
		};
	};
	
	class Controls
	{
		class BtnCall
		{
			idc = 9900108;
			x = safeZoneX + safeZoneW * 0.245;
			y = safeZoneY + safeZoneH * 0.78;
			w = safeZoneW * 0.12;
			h = safeZoneH * 0.03;
			type = 1;
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
			text = "Call Artillery";
			action = "[(lbCurSel 9900101),(lbCurSel 9900102),(sliderPosition 9900103),(lbCurSel 9900105),(sliderPosition 9900107)] spawn artDialog_fnc_artCallDialog;";
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
			action = "[] spawn artDialog_fnc_artCloseDialog;";
		};
		
		class BtnHelp: BtnClose
		{
			idc = 200;
			x = safeZoneX + safeZoneW * 0.18;
			text = "Help";
			action = "call artDialog_fnc_artDialogHelp;";
		};

		// Artillery Element - Combo
		class Ctrl1 {
			type = 4;
			idc = 9900101;
			x = safeZoneX + safeZoneW * 0.30;
			y = safeZoneY + safeZoneH * 0.26;
			w = safeZoneW * 0.14;
			h = safeZoneH * 0.03;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			maxHistoryDelay = 0;
			sizeEx = "0.03 / (getResolution select 5)";
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
			tooltip = "Choose your Artillery Element for this strike.";
			onLBSelChanged = "[_this select 1] call artDialog_fnc_artGetAmmo;";
		};
		
		// Ammunition - Combo
		class Ctrl2: Ctrl1
		{
			idc = 9900102;
			y = safeZoneY + safeZoneH * 0.31;
			tooltip = "Ammunition the artillery will use.";
			onLBSelChanged = "[_this select 1] call artDialog_fnc_artManageRounds;";
		};

		// Rounds - Slider
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

		// Distribution Pattern - Combo
		class Ctrl4: Ctrl1
		{
			idc = 9900105;
			y = safeZoneY + safeZoneH * 0.41;
			class Items
			{
				class rapidFire
				{
					text = "Rapid Fire";
					picture = "\a3\Modules_F_Curator\Data\iconOrdnance_ca.paa";
					tooltip = "Fires a series of rounds rapidly onto target without forced dispersion.\nRadius has no effect!";
					default = 1;
				};
				class normalDisp
				{
					text = "Extended Dispersion";
					tooltip = "Rounds are distributed to an area with a focus towards the middle.\nNeeds Radius larger then 0!";
				};
				class Area
				{
					text = "Area";
					tooltip = "Rounds are evenly distributed in area around target.\nNeeds Radius larger then 0.";
				};
				class invertedDispersion
				{
					text = "Inverted Dispersion";
					tooltip = "Rounds are distributed in radius around target with a tendency\ntowards the outer radius.\nNeeds Radius larger then 0.";
				};
				class ring
				{
					text = "Ring";
					tooltip = "Rounds are distributed in a ring around target.\nThe ring is appx. 30m broad.\nUsefull if supporting a dfensive position.\nNeeds Radius larger then 0.";
				};
			};
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			tooltip = "Distributionpattern for the Artillery Strike";
			onLBSelChanged = "if(_this select 1 > 0) then {'artMrkRadius' setMarkersize [sliderPosition 9900107,sliderPosition 9900107];'artMrkRadius' setMarkerAlpha 1;}else{'artMrkRadius' setMarkerAlpha 0;}";
		};
		
		// Distance - Slider
		class Ctrl5: Ctrl1
		{
			type = 43;
			idc = 9900107;
			y = safeZoneY + safeZoneH * 0.46;
			style = 1024;
			colorActive[] = {0.988,0.933,0.698,1};
			colorSelect[] = {0.988,0.933,0.698,1};
			arrowEmpty = "\A3\ui_f\data\GUI\Cfg\Slider\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\Cfg\Slider\arrowFull_ca.paa";
			border = "\A3\ui_f\data\GUI\Cfg\Slider\border_ca.paa";
			sliderStep = 10;
			sliderRange[] = {0, 200};
			sliderPosition = 0;
			thumb = "\A3\ui_f\data\GUI\Cfg\Slider\thumb_ca.paa";
			tooltip = "Radius in which the artillery rounds will be delivered";
			onSliderPosChanged = "[_this select 1] call artDialog_fnc_artCheckRadiusDialog";
		};		
	};
	
};
