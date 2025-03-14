import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_sugar/features/admin_feature/domain/sugar_center_model.dart';

import '../../../../core/utils/widgets/build_app_bar.dart';

class ViewCenterLocationView extends StatefulWidget {
  const ViewCenterLocationView({super.key, required this.sugarCenter});
  static const routeName = 'ViewCenterLocationView';
  final SugarCenterModel sugarCenter;

  @override
  State<ViewCenterLocationView> createState() => _ViewCenterLocationViewState();
}

class _ViewCenterLocationViewState extends State<ViewCenterLocationView> {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  LatLng? currentPosition;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentPosition = LatLng(
        double.parse(widget.sugarCenter.longitude ?? '0.0'),
        double.parse(widget.sugarCenter.latitude ?? '0.0'));
    return Scaffold(
      appBar:
          buildAppBar(context, title: 'Center Location', showProfile: false),
      body: currentPosition != null
          ? GoogleMap(
              zoomControlsEnabled: false,
              markers: {
                Marker(
                  markerId: MarkerId(widget.sugarCenter.id.toString()),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                  position: currentPosition!,
                  infoWindow: InfoWindow(title: widget.sugarCenter.name),
                ),
              },
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: currentPosition!,
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                mapController.complete(controller);
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
