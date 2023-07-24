import 'package:flutter/material.dart';
import 'package:google_maps_route_provider/widgets/textfield_widget.dart';

class OriginToDestinationTextWidget extends StatelessWidget {
  const OriginToDestinationTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SearchTextWidget(
          hintText: 'Origin',
        ),
        SearchTextWidget(
          hintText: 'Destination',
        ),
      ],
    );
  }
}
