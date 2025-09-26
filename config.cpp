class CfgPatches
{
    class bal_main
	{
    name = "Break A Leg";
    author = "Raoden";
    requiredAddons[] = { "A3_Modules_F", "cba_xeh_a3", "CBA_events" };
    units[] = { };
    weapons[] = { };
    };
};

class CfgFunctions {
    class BAL {
        class functions {
            file = "bal_main\functions";
            #include "\bal_main\functions\functions.hpp"
        };
    };
};

class Extended_PreInit_EventHandlers {
    class bal_main {
        init = "[] call compile preprocessFileLineNumbers '\bal_main\addon_settings.sqf';";
    };
};