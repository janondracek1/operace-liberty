private _positionStart = (getMarkerPos ["camCityStart"] vectorAdd [0, 0, 30]);
private _positionEnd = (getMarkerPos ["camCityEnd"] vectorAdd [0, 0, 30]);
private _positionDirectionPos = getMarkerPos["camCityDirection"];

titleCut ["","BLACK OUT",0];
titleCut ["","BLACK IN",1];

sleep 1;

private _date = date;
private _dateString = format["%1. %2. %3, %4:%5", _date select 2, _date select 1, _date select 0, _date select 3, _date select 4]; 
[
	[
		["FERUZ ABAD, NE checkpoint", "<t align = 'center' shadow = '1' size = '1' font='PuristaBold'>%1</t><br/>", 5],
		[_dateString, "<t align = 'center' shadow = '1' size = '0.7'>%1</t>", 5]
	]
] spawn BIS_fnc_typeText;

//create camera
private _camera = "camera" camCreate (_positionStart);
//switch player to camera
_camera cameraEffect ["internal", "back"];
//rotate camera
_camera camPrepareTarget _positionDirectionPos;

_camera camCommitPrepared 0;

//move camera
_camera camPreparePos _positionEnd;
_camera camCommitPrepared 10;
waitUntil{camCommitted _camera};

//lock camera on vehicle
_group = missionNamespace getVariable "impostorGroup";
_vehicle = (vehicle leader _group);
_camera camPrepareTarget _vehicle;
_camera camCommitPrepared 0;
_camera camPrepareRelPos [0, -15, 10];
_camera camCommitPrepared 0;
_camera attachTo [_vehicle];

sleep 5;
detach _camera;

_camera camPreparePos _positionEnd;
_camera camCommitPrepared 0;

waitUntil{isNull objectParent (leader _group)};

private _impostorWaypoint = (getMarkerPos "impostorWaypoint" vectorAdd [100, 100, 30]);
_camera camPreparePos _impostorWaypoint;
_camera camCommitPrepared 20;

waitUntil{camCommitted _camera};
titlecut ["","BLACK OUT", 1];

sleep 1;
_camera cameraEffect ["terminate", "back"];
titlecut ["","BLACK IN", 1];