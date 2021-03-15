if(!isServer) exitWith{false};
[] remoteExec ["shawneeo_fnc_initCamera"];

private _impostorPositionStop = getMarkerPos "impostorGateStop";
private _group = missionNamespace getVariable "impostorGroup";
(leader _group) doMove _impostorPositionStop;
waitUntil{speed (vehicle leader _group) > 3};
waitUntil{speed (vehicle leader _group) < 3};

private _gate = missionNamespace getVariable "gate";
_gate animate ["door_1_rot", 1];

private _impostorCityStop = getMarkerPos "impostorCityStop";
(leader _group) doMove _impostorCityStop;
sleep 5;
waitUntil{speed (vehicle leader _group) > 3};
waitUntil{speed (vehicle leader _group) < 3};

{
	_x allowDamage false;
} forEach units _group;

doGetOut units _group;
private _eastGroup = createGroup east;
units _group joinSilent _eastGroup;

private _impostorWaypoint = getMarkerPos "impostorWaypoint";
_waypoint = _eastGroup addWaypoint [_impostorWaypoint, 100, 0];
_waypoint setWaypointType "SAD";

[_eastGroup] spawn {
	params["_group"];
	sleep 30;
	{
		_x allowDamage true;
	} forEach units _group;
};

missionNamespace setVariable ["missionInitiated", true];

private _unhandledScripts = [];
{
	if(["triggerSad", vehicleVarName _x] call BIS_fnc_inString) then {
		private _handle = _x spawn {
			private _subHandle = [_this] execVM getMissionPath "taskTrigger.sqf";
			waitUntil{scriptDone _subHandle};
		};
		_unhandledScripts pushBack _handle;
	};
} forEach allMissionObjects "EmptyDetector";
while{count(_unhandledScripts) > 0} do {
	{
		if(scriptDone _x) then {
			_unhandledScripts = _unhandledScripts - [_x];
		};
	} forEach _unhandledScripts;
	sleep 1;
};
"EveryoneWon" call BIS_fnc_endMissionServer;