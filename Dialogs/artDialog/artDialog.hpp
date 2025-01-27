class artDialog
{
	idd = 99001;
	onLoad = "[_this select 0]execVM 'Dialogs\artDialog\fn_artInitDialog.sqf';";
	
	class ControlsBackground
	{
		class ArtBackground
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.171875;
			y = safeZoneY + safeZoneH * -0.04166666;
			w = safeZoneW * 0.65625;
			h = safeZoneH * 1.08333334;
			style = 2+48;
			text = "Dialogs\Military_Interface.paa";
			colorBackground[] = {1,1,1,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};
		class ArtHeadTitle
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.29394532;
			y = safeZoneY + safeZoneH * 0.22569445;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.03819445;
			style = 2;
			text = "Artillery";
			colorBackground[] = {1,1,1,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};
		class ArtHeadLine
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.26203704;
			w = safeZoneW * 0.4125;
			h = safeZoneH * 0.00370371;
			style = 0;
			text = "";
			colorBackground[] = {0.5843,0.8902,0.349,1};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};
		class ArtGroupTitle
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.2953125;
			y = safeZoneY + safeZoneH * 0.26666667;
			w = safeZoneW * 0.12864584;
			h = safeZoneH * 0.01944445;
			style = 2;
			text = "Artillery";
			colorBackground[] = {0.8902,0.9216,0.7765,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 0.9) / 0.9) / 25) * 0.9);
			
		};
		class ArtAmmoTitle
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.43697917;
			y = safeZoneY + safeZoneH * 0.26666667;
			w = safeZoneW * 0.121875;
			h = safeZoneH * 0.01944445;
			style = 2;
			text = "Ammunition";
			colorBackground[] = {0.8902,0.9216,0.7765,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 0.9) / 0.9) / 25) * 0.9);
			
		};
		class ArtRoundsCount
		{
			type = 0;
			idc = 9900104;
			x = safeZoneX + safeZoneW * 0.5703125;
			y = safeZoneY + safeZoneH * 0.26666667;
			w = safeZoneW * 0.1328125;
			h = safeZoneH * 0.01944445;
			style = 2;
			text = "Rounds: 0";
			colorBackground[] = {0.8902,0.9216,0.7765,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 0.9) / 0.9) / 25) * 0.9);
			
		};
		class MapBack
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.32314815;
			w = safeZoneW * 0.4125;
			h = safeZoneH * 0.34444445;
			style = 0;
			text = "";
			colorBackground[] = {0.5843,0.8902,0.349,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};
		class ArtPatternTitle
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.67407408;
			w = safeZoneW * 0.2046875;
			h = safeZoneH * 0.01944445;
			style = 2;
			text = "Dispersion  Pattern";
			colorBackground[] = {0.8902,0.9216,0.7765,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 0.9) / 0.9) / 25) * 0.9);
			
		};
		class ArtDistCount
		{
			type = 0;
			idc = 9900106;
			x = safeZoneX + safeZoneW * 0.503125;
			y = safeZoneY + safeZoneH * 0.67407408;
			w = safeZoneW * 0.2;
			h = safeZoneH * 0.01944445;
			style = 2;
			text = "Radius: 0m";
			colorBackground[] = {0.8902,0.9216,0.7765,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 0.9) / 0.9) / 25) * 0.9);
			
		};
		class ArtBottomLine
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.72222223;
			w = safeZoneW * 0.4125;
			h = safeZoneH * 0.00370371;
			style = 0;
			text = "";
			colorBackground[] = {0.5843,0.8902,0.349,1};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};
		
	};
	class Controls
	{
		class ArtGroup
		{
			type = 4;
			idc = 9900101;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.29074075;
			w = safeZoneW * 0.1328125;
			h = safeZoneH * 0.02037038;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.2,0.2,0.2,1};
			colorDisabled[] = {0.102,0.102,0.102,1};
			colorSelect[] = {0.5843,0.8902,0.349,1};
			colorSelectBackground[] = {0,0,0,1};
			colorText[] = {0.6,0.6,0.6,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = "0.02 / (getResolution select 5)";
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			tooltip = "Choose your Artillery Element for this strike.";
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			onLBSelChanged = "[_this select 1] call artDialog_fnc_artGetAmmo;";
		};
		class ArtAmmoCB
		{
			type = 4;
			idc = 9900102;
			x = safeZoneX + safeZoneW * 0.43697917;
			y = safeZoneY + safeZoneH * 0.29074075;
			w = safeZoneW * 0.121875;
			h = safeZoneH * 0.02037038;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.2,0.2,0.2,1};
			colorDisabled[] = {0.102,0.102,0.102,1};
			colorSelect[] = {0.5843,0.8902,0.349,1};
			colorSelectBackground[] = {0,0,0,1};
			colorText[] = {0.6,0.6,0.6,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = "0.02 / (getResolution select 5)";
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			tooltip = "Ammunition the artillery will use.";
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			onLBSelChanged = "[_this select 1] call artDialog_fnc_artManageRounds;";
		};
		class ArtRoundsSlider
		{
			type = 43;
			idc = 9900103;
			x = safeZoneX + safeZoneW * 0.56822917;
			y = safeZoneY + safeZoneH * 0.29074075;
			w = safeZoneW * 0.1375;
			h = safeZoneH * 0.02037038;
			style = 1024;
			arrowEmpty = "\A3\ui_f\data\GUI\Cfg\Slider\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\Cfg\Slider\arrowFull_ca.paa";
			border = "\A3\ui_f\data\GUI\Cfg\Slider\border_ca.paa";
			color[] = {0.5843,0.8902,0.349,1};
			colorActive[] = {1,1,1,1};
			sliderStep = 1;
			sliderRange[] = {0, 999};
			sliderPosition = 0;
			thumb = "\A3\ui_f\data\GUI\Cfg\Slider\thumb_ca.paa";
			tooltip = "Number of projectiles.";
			onSliderPosChanged = "params ['_control', '_newValue'];	_text = format ['%1 Rounds',_newValue];ctrlSetText [9900104, _text];";
		};
		class ArtPatternCB
		{
			type = 4;
			idc = 9900105;
			x = safeZoneX + safeZoneW * 0.29427084;
			y = safeZoneY + safeZoneH * 0.6962963;
			w = safeZoneW * 0.2046875;
			h = safeZoneH * 0.02037038;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.2,0.2,0.2,1};
			colorDisabled[] = {0.102,0.102,0.102,1};
			colorSelect[] = {0.5843,0.8902,0.349,1};
			colorSelectBackground[] = {0.2,0.2,0.2,1};
			colorText[] = {0.6,0.6,0.6,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = "0.02 / (getResolution select 5)";
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			tooltip = "Dispersionpattern for the Artillery Strike";
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
			onLBSelChanged = "if(_this select 1 > 0) then {'artMrkRadius' setMarkersize [sliderPosition 9900107,sliderPosition 9900107];'artMrkRadius' setMarkerAlpha 1;}else{'artMrkRadius' setMarkerAlpha 0;}";
		};
		class ArtDistSlider
		{
			type = 43;
			idc = 9900107;
			x = safeZoneX + safeZoneW * 0.50104167;
			y = safeZoneY + safeZoneH * 0.6962963;
			w = safeZoneW * 0.20416667;
			h = safeZoneH * 0.02037038;
			style = 1024;
			arrowEmpty = "\A3\ui_f\data\GUI\Cfg\Slider\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\Cfg\Slider\arrowFull_ca.paa";
			border = "\A3\ui_f\data\GUI\Cfg\Slider\border_ca.paa";
			color[] = {0.5843,0.8902,0.349,1};
			colorActive[] = {1,1,1,1};
			thumb = "\A3\ui_f\data\GUI\Cfg\Slider\thumb_ca.paa";
			sliderStep = 10;
			sliderRange[] = {0, 200};
			sliderPosition = 0;
			tooltip = "Radius in which the artillery rounds will be delivered";
			onSliderPosChanged = "[_this select 1] call artDialog_fnc_artCheckRadiusDialog";
		};
		class ArtCallBt
		{
			type = 1;
			idc = 9900108;
			x = safeZoneX + safeZoneW * 0.42239584;
			y = safeZoneY + safeZoneH * 0.73425926;
			w = safeZoneW * 0.15520834;
			h = safeZoneH * 0.03148149;
			style = 0+2;
			text = "Call Artillery";
			borderSize = 0;
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0.5843,0.8902,0.349,1};
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
			onButtonClick = "[(lbCurSel 9900101),(lbCurSel 9900102),(sliderPosition 9900103),(lbCurSel 9900105),(sliderPosition 9900107)] spawn artDialog_fnc_artCallDialog;";
		};

		class ArtCancel
		{
			type = 1;
			idc = 9900109;
			x = safeZoneX + safeZoneW * 0.65;
			y = safeZoneY + safeZoneH * 0.23425926;
			w = safeZoneW * 0.05104167;
			h = safeZoneH * 0.02222223;
			style = 0+2;
			text = "Cancel";
			borderSize = 0;
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0.5843,0.8902,0.349,1};
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
			onButtonClick = "[] spawn artDialog_fnc_artCloseDialog;";
		};

		class BtnHelp
		{
			type = 1;
			idc = 9900110;
			x = safeZoneX + safeZoneW * 0.59;
			y = safeZoneY + safeZoneH * 0.23425926;
			w = safeZoneW * 0.04635417;
			h = safeZoneH * 0.02222223;
			style = 2;
			text = "Help";
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
			default = false;
			shadow = 0;
			action = "call artDialog_fnc_artDialogHelp;";
		};		
	};
	
};
