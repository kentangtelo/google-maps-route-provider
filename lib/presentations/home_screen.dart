import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_route_provider/widgets/origin_to_destination_text_widget.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/home_provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewInsets.bottom -
                  MediaQuery.of(context).viewInsets.top -
                  MediaQuery.of(context).viewPadding.top -
                  MediaQuery.of(context).viewPadding.bottom,
              child: GoogleMap(
                initialCameraPosition: Constants.initialCameraPosition,
                mapType: MapType.normal,
                markers: homeProvider.markers,
                polylines: homeProvider.polylines,
                onMapCreated: (controller) {
                  homeProvider.googleMapController.complete(controller);
                },
              ),
            ),
            const OriginToDestinationTextWidget()
          ],
        ),
      ),
    );
  }
}
