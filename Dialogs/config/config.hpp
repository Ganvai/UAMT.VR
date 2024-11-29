//- GUI Documenation: https://community.bistudio.com/wiki/Arma:_GUI_Configuration
//- Control Types:    https://community.bistudio.com/wiki/Arma:_GUI_Configuration#Control_Types
//- Control Styles:   https://community.bistudio.com/wiki/Arma:_GUI_Configuration#Control_Styles

//Eden Editor macros such as background colour and pixel grid
#include "\a3\3DEN\UI\macros.inc"
//GRIDs
#include "\a3\ui_f\hpp\definecommongrids.inc"
//DIK Key Codes
#include "\a3\ui_f\hpp\definedikcodes.inc"
//Eden Editor IDDs and IDCs as well as control types, styles and macros
#include "\a3\3den\ui\resincl.inc"

//Eden Editor Base Controls
import ctrlActivePicture;
import ctrlActivePictureKeepAspect;
import ctrlActiveText;
import ctrlButton;
import ctrlButtonCancel;
import ctrlButtonClose;
import ctrlButtonCollapseAll;
import ctrlButtonExpandAll;
import ctrlButtonFilter;
import ctrlButtonOK;
import ctrlButtonPicture;
import ctrlButtonPictureKeepAspect;
import ctrlButtonSearch;
import ctrlButtonToolbar;
import ctrlCheckbox;
import ctrlCheckboxBaseline;
import ctrlCheckboxes;
import ctrlCheckboxesCheckbox;
import ctrlCheckboxToolbar;
import ctrlCombo;
import ctrlComboToolbar;
import ctrlControlsGroup;
import ctrlControlsGroupNoHScrollbars;
import ctrlControlsGroupNoScrollbars;
import ctrlControlsGroupNoVScrollbars;
import ctrlDefault;
import ctrlDefaultButton;
import ctrlDefaultText;
import ctrlEdit;
import ctrlEditMulti;
import ctrlHTML;
import ctrlListbox;
import ctrlListNBox;
import ctrlMap;
import ctrlMapEmpty;
import ctrlMapMain;
import ctrlMenu;
import ctrlMenuStrip;
import ctrlProgress;
import ctrlShortcutButton;
import ctrlShortcutButtonCancel;
import ctrlShortcutButtonOK;
import ctrlShortcutButtonSteam;
import ctrlSliderH;
import ctrlSliderV;
import ctrlStatic;
import ctrlStaticBackground;
import ctrlStaticBackgroundDisable;
import ctrlStaticBackgroundDisableTiles;
import ctrlStaticFooter;
import ctrlStaticFrame;
import ctrlStaticLine;
import ctrlStaticMulti;
import ctrlStaticOverlay;
import ctrlStaticPicture;
import ctrlStaticPictureKeepAspect;
import ctrlStaticPictureTile;
import ctrlStaticTitle;
import ctrlStructuredText;
import ctrlToolbox;
import ctrlToolboxPicture;
import ctrlToolboxPictureKeepAspect;
import ctrlTree;
import ctrlXListbox;
import ctrlXSliderH;
import ctrlXSliderV;

//Classic Base Controls
import RscActivePicture;
import RscActivePictureKeepAspect;
import RscActiveText;
import RscButton;
import RscButtonMenu;
import RscButtonMenuCancel;
import RscButtonMenuOK;
import RscButtonMenuSteam;
import RscButtonTextOnly;
import RscCheckBox;
import RscCombo;
import RscControlsGroup;
import RscControlsGroupNoHScrollbars;
import RscControlsGroupNoScrollbars;
import RscControlsGroupNoVScrollbars;
import RscEdit;
import RscFrame;
import RscHTML;
import RscLine;
import RscListBox;
import RscListNBox;
import RscMapControl;
import RscMapControlEmpty;
import RscObject;
import RscPicture;
import RscPictureKeepAspect;
import RscProgress;
import RscShortcutButton;
import RscSlider;
import RscStructuredText;
import RscText;
import RscToolbox;
import RscTree;
import RscVideo;
import RscXListBox;
import RscXSliderH;
import Scrollbar;
