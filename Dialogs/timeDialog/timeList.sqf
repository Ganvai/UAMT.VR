_display = findDisplay 112233; //1234 = Idd of my Project
_listbox = _display displayCtrl 112; //100 = Idc of my ListBox

_listbox lbAdd "Morning, 0600";
_listbox lbAdd "Midday, 1200";
_listbox lbAdd "Afternoon, 1500";
_listbox lbAdd "Evening, 1800";
_listbox lbAdd "Night, 2100";
_listbox lbAdd "Midnight, 2300";

_listbox lbSetData [0, "6"];
_listbox lbSetData [1, "12"];
_listbox lbSetData [2, "15"];
_listbox lbSetData [3, "18"];
_listbox lbSetData [4, "21"];
_listbox lbSetData [5, "23"];
