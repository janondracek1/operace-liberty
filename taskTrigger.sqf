params["_trigger"];

_allUnits = allUnits inAreaArray _trigger;
_aliveUnits = _allUnits;
_nearestCity = (nearestLocations [getPos _trigger, ["NameCity", "NameVillage", "NameCityCapital", "Name"], 400]) select 0;
[west, [str _trigger], ["", "Eliminujte veškeré jednotky ve městě "+(text _nearestCity), ""], getPos _trigger, "ASSIGNED"] call BIS_fnc_taskCreate;
while{count _aliveUnits > 0} do {
	_aliveUnits = _allUnits select {alive _x};
	sleep 2;
};
[str _trigger, "SUCCEEDED"] call BIS_fnc_taskSetState;