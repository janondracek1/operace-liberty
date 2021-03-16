params["_arsenalObject"];
_arsenalSign = missionNamespace getVariable "arsenalSign";
_arsenalSign setObjectTexture [0, getMissionPath "images\waitForMission.jpg"];
_arsenalObject call ace_arsenal_fnc_removeBox;

waitUntil{!isNil "missionInitiated"};
waitUntil{missionInitiated == true};

_arsenalSign setObjectTexture [0, getMissionPath "images\arsenal.jpg"];

[_arsenalObject] call RMS_fnc_addArsenal;