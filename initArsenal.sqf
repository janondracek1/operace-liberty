params["_arsenalObject"];
if(!isServer) exitWith{};
_arsenalSign = missionNamespace getVariable "arsenalSign";
_arsenalSign setObjectTextureGlobal [0, getMissionPath "images\waitForMission.jpg"];

waitUntil{!isNil{missionNamespace getVariable "missionInitiated"}};
waitUntil{(missionNamespace getVariable "missionInitiated") == true};

_arsenalSign setObjectTextureGlobal [0, getMissionPath "images\arsenal.jpg"];

[_arsenalObject] call RMS_fnc_addArsenal;