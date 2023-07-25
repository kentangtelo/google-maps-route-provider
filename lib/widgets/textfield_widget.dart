// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_maps_route_provider/providers/home_provider.dart';
import 'package:provider/provider.dart';

class SearchTextWidget extends StatefulWidget {
  final String hintText;
  const SearchTextWidget({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  State<SearchTextWidget> createState() => SearchTextWidgetState();
}

class SearchTextWidgetState extends State<SearchTextWidget> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        15,
        30,
        15,
        5,
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: TextFormField(
              controller: widget.hintText == 'Destination'
                  ? homeProvider.destinationController
                  : homeProvider.originController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                border: InputBorder.none,
                hintText: widget.hintText,
                suffixIcon: widget.hintText == 'Destination'
                    ? IconButton(
                        onPressed: () {
                          homeProvider.getDirectionOriginDestination();
                        },
                        icon: const Icon(Icons.search),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
