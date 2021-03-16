params["_trigger"];
if(hasInterface) exitWith{};

//just for init sake
_aliveUnits = [0,0];
_nearestCity = (nearestLocations [getPos _trigger, ["NameCity", "NameVillage", "NameCityCapital", "Name"], 50]) select 0;
[west, [str _trigger], ["", "Eliminujte veškeré "+(text _nearestCity), ""], getPos _trigger, "ASSIGNED"] call BIS_fnc_taskCreate;
while{count _aliveUnits > 0} do {
	_allUnits = allUnits inAreaArray _trigger;
	_aliveUnits = _allUnits select {alive _x && side _x == east};
	sleep 2;
};
[str _trigger, "SUCCEEDED"] call BIS_fnc_taskSetState;