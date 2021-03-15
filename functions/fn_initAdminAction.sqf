params["_unit"];
waitUntil{alive _unit};
_unit addAction ["Zahájit misi", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[] remoteExec ["shawneeo_fnc_initMission", 2];
	_target removeAction _actionId;
}];