import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_route_provider/widgets/origin_to_destination_text_widget.dart';

import '../constants/constants.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  Completer<GoogleMapController> googleMapController = Completer();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                onMapCreated: (controller) {
                  googleMapController.complete(controller);
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
