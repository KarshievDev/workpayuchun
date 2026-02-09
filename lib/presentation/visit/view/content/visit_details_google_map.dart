import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:strawberryhrm/presentation/visit/bloc/visit_bloc.dart';

class VisitDetailsGoogleMap extends StatelessWidget {
  final Function(GoogleMapController) onMapCreated;

  const VisitDetailsGoogleMap({super.key, required this.onMapCreated});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitBloc, VisitState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
              child: Text(tr("location"), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.r)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox(
                  height: 180.h,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GoogleMap(
                      mapType: MapType.terrain,
                      initialCameraPosition: CameraPosition(target: state.initialPosition, zoom: 14.4746),
                      markers: state.markers.toSet(),
                      myLocationEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        onMapCreated(controller);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
