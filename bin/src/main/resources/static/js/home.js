function navDropDown() {
	if (
		document.getElementById("dropdown").style.getPropertyValue("display") ===
		"none"
	) {
		document.getElementById("dropdown").style.flexDirection = "column";
		document.getElementById("dropdown").style.display = "block";
	} else {
		document.getElementById("dropdown").style.display = "none";
	}
}

function resize() {
	var w = window.innerWidth;
	if (w >= 640) {
		document.getElementById("dropdown").style.display = "flex";
		document.getElementById("dropdown").style.flexDirection = "row";
	} else {
		document.getElementById("dropdown").style.display = "none";
	}
}

var form = document.getElementById("form123");

// document.getElementById("searchByRegionButton").value;
function sendForm(region) {
	loading();
	document.getElementById("regionhidden").value = region;
	form.method = "post";
	form.submit();
}

var geolocation = (function () {
	"use strict";

	var geoposition;
	var options = {
		maximumAge: 1000,
		timeout: 15000000,
		enableHighAccuracy: true,
	};

	function _onError(callback, error) {
		alert(
			"to access this service your need to turn on location service, please turn on and retry"
		);
		windows.history.back();
		callback();
	}

	function _onSuccess(callback, position) {
		document.getElementById("xhidden").value = position.coords.latitude;
		document.getElementById("yhidden").value = position.coords.longitude;
		geoposition = position;
		loading();
		callback();
	}

	function _getLocation(callback) {
		navigator.geolocation.getCurrentPosition(
			_onSuccess.bind(this, callback),
			_onError.bind(this, callback),
			options
		);
	}

	return {
		location: _getLocation,
	};
})();

var locationButton = document.getElementById("byLocation");
if (locationButton !== null) {
	locationButton.addEventListener("click", searchByLocation);
}

function searchByLocation() {
	form.action = "/location";
	geolocation.location(() => form.submit());
}

var locationButtons = document.getElementsByName("byLocationFromWL");
for (var i = 0; i < locationButtons.length; i++) {
	if (locationButtons[i] !== null) {
		locationButtons[i].addEventListener("click", searchByLocationWL);
	}
}

function searchByLocationWL() {
	geolocation.location(() => form.submit());
}

// adding map view
var forms = document.getElementsByClassName("medicines");

var route =
	"{'coordinates':[[38.505685,9.035093],[38.505506,9.035377],[38.505203,9.035957],[38.505189,9.036124],[38.505039,9.036828],[38.504881,9.037297],[38.504631,9.037935],[38.504425,9.038314],[38.504127,9.038704],[38.503628,9.03926],[38.503414,9.039449],[38.502447,9.040166],[38.502212,9.040386],[38.501938,9.040123],[38.50181,9.040033],[38.501675,9.040023],[38.501528,9.040057],[38.501429,9.040145],[38.501262,9.040341],[38.501115,9.040219],[38.500903,9.039983],[38.500699,9.039641],[38.500568,9.03958],[38.500418,9.039543],[38.500199,9.039561],[38.500188,9.038158],[38.500169,9.037494],[38.500136,9.036913],[38.500182,9.036561],[38.500323,9.036188],[38.500676,9.035618],[38.503385,9.031609],[38.504208,9.030577],[38.50512,9.029523],[38.5069,9.028088]],'type':'LineString'}";
for (var i = 0; i < coordinates.length; i++) {
	var pharmacy_name = coordinates[i][0];
	var lat = coordinates[i][1];
	var lon = coordinates[i][2];
	var id = coordinates[i][3];

	if (user_lat !== null) {
		var map = L.map("map" + id).setView(
			[parseFloat(user_lon), parseFloat(user_lat)],
			25
		);
		L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
			attribution:
				'&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
		}).addTo(map);

		console.log("routing");

		L.geojson(route).addTo(map);

		L.Routing.control({
			waypoints: [
				L.latLng(parseFloat(lat), parseFloat(lon)),
				L.latLng(parseFloat(user_lat), parseFloat(user_lon)),
			],
			autoRoute: true,
			lineOptions: {
				styles: [{ color: "green", opacity: 0.6, weight: 5 }],
			},
			router: new L.Routing.OSRMv1({
				profile: "foot",
			}),
			createMarker: function (i, wp, nWps) {
				switch (i) {
					case 0:
						return new L.marker(wp.latLng, {
							draggable: true,
						})
							.bindPopup(pharmacy_name)
							.openPopup();
					case nWps - 1:
						return new L.marker(wp.latLng, {
							draggable: true,
						})
							.bindPopup("My Location")
							.openPopup();
				}
			},
		}).addTo(map);
	} else {
		var map = L.map("map" + id).setView([parseFloat(lat), parseFloat(lon)], 20);
		L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
			attribution:
				'&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
		}).addTo(map);
		L.marker([parseFloat(lat), parseFloat(lon)])
			.addTo(map)
			.bindPopup(pharmacy_name)
			.openPopup()
			.addTo(map);
	}
}

function loading() {
	document.getElementById("loading").style = "display: flex";
}

function showMap(element) {
	document.getElementById(element.name).style =
		"display: block; z-index:100000000000000000000000000000000000000000 !important;";
	document.getElementById("close-" + element.name).style =
		"display: block; z-index:100000000000000000000000000000000000000000 !important;";
}
function closeMap(element) {
	document.getElementById(element.name).style = "display: none;";
	document.getElementById(element.id).style = "display: none;";
}
