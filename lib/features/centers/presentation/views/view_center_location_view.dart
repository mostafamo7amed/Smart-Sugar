import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../core/utils/widgets/build_app_bar.dart';

class ViewCenterLocationView extends StatefulWidget {
  const ViewCenterLocationView({super.key});
  static const routeName = 'ViewCenterLocationView';

  @override
  State<ViewCenterLocationView> createState() => _ViewCenterLocationViewState();
}

class _ViewCenterLocationViewState extends State<ViewCenterLocationView> {


  final Completer<GoogleMapController> mapController =
  Completer<GoogleMapController>();

  final locationController = Location();

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
      appBar: buildAppBar(context, title: 'Center Location', showProfile: false),
      body:currentPosition!=null? GoogleMap(
        zoomControlsEnabled: false,
        markers: {
          Marker(
            markerId: MarkerId('1'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position: currentPosition!,
            infoWindow: InfoWindow(title: 'Center Location'),
          ),
        },
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition:CameraPosition(target: currentPosition!, zoom: 14.4746,),
        onMapCreated: (GoogleMapController controller) {
          mapController.complete(controller);
        },
      ):  const Center(child: CircularProgressIndicator()),
    );
  }
}
