import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';

class ChooseCenterLocationView extends StatefulWidget {
  const ChooseCenterLocationView({super.key});
  static const routeName = 'chooseCenterLocationView';

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  State<ChooseCenterLocationView> createState() => _ChooseCenterLocationViewState();
}

class _ChooseCenterLocationViewState extends State<ChooseCenterLocationView> {


  final Completer<GoogleMapController> mapController =
  Completer<GoogleMapController>();

  final locationController = Location();
  double? markerLongController;
  double? markerLatController;
  LatLng? currentPosition;

  List<Marker> marker =[];

  Future getLocationUpdate() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        if (mounted) {
          setState(() {
            currentPosition =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
          });
        }
      }
    });
  }

  @override
  void initState() {
    getLocationUpdate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Choose Center Location', showProfile: false),
      floatingActionButton:CustomButton(
        onPressed: () {
          if(markerLongController!=null||markerLatController!=null) {
            Navigator.pop(
                context, LatLng(markerLongController!, markerLatController!));
          }
      },
        text: 'Save Location',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body:currentPosition!=null? Column(
        children: [
          Expanded(
            child: GoogleMap(
              zoomControlsEnabled: false,
              onTap: (argument) {
                  Marker newMachine = Marker(
                    markerId: MarkerId('1'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                    position: LatLng(argument.latitude,argument.longitude),
                    infoWindow: InfoWindow(title: 'Center Location'),
                  );
                  markerLongController = argument.longitude;
                  markerLatController =argument.latitude;
                  marker.add(newMachine);
                  setState(() {});
              },
              markers: marker.map((e)=>e).toSet(),
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: currentPosition!=null? CameraPosition(target: currentPosition!, zoom: 14.4746,): ChooseCenterLocationView._kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                mapController.complete(controller);
              },
            ),
          ),
        ],
      ):  const Center(child: CircularProgressIndicator()),
    );
  }
}
