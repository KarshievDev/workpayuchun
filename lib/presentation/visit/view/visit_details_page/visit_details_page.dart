import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_track/location_track.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/visit/bloc/visit_bloc.dart';
import 'package:strawberryhrm/presentation/visit/view/content/reschedule_cancel_button.dart';
import 'package:strawberryhrm/presentation/visit/view/content/visit_app_bar_action.dart';
import 'package:strawberryhrm/presentation/visit/view/content/visit_details_google_map.dart';
import 'package:strawberryhrm/presentation/visit/view/content/visit_header.dart';
import 'package:strawberryhrm/presentation/visit/view/content/visit_note_content.dart';
import 'package:strawberryhrm/presentation/visit/view/content/visit_photo_upload.dart';
import 'package:strawberryhrm/presentation/visit/view/content/visit_schedule_item.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';

class VisitDetailsPage extends StatelessWidget {
  final int visitID;

  const VisitDetailsPage({super.key, required this.visitID});

  @override
  Widget build(BuildContext context) {

    instance<CurrentLocationUseCase>().call().then((position) {
      if (context.mounted) {
        context.read<VisitBloc>().add(
          VisitDetailsEvent(visitId: visitID, latitude: position?.latitude, longitude: position?.longitude),
        );
      }
    });

    late GoogleMapController mapController;
    BodyVisitCancel bodyStatusChange = BodyVisitCancel();

    return Scaffold(
      bottomNavigationBar: BlocBuilder<VisitBloc, VisitState>(
        builder: (context, state) {
          return Visibility(
            visible: state.visitDetailsResponse?.data?.nextStatus?.statusText?.isEmpty == false,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomHButton(
                  title: state.visitDetailsResponse?.data?.nextStatus?.statusText ?? "",
                  padding: 16,
                  isLoading: state.status == NetworkStatus.loading,
                  clickButton: () {
                    bodyStatusChange.visitId = state.visitDetailsResponse!.data!.id;
                    bodyStatusChange.status = state.visitDetailsResponse?.data?.nextStatus?.status;
                    bodyStatusChange.latitude = state.latitude.toString();
                    bodyStatusChange.longitude = state.longitude.toString();
                    context.read<VisitBloc>().add(
                      VisitStatusEvent(context: context, bodyVisitCancel: bodyStatusChange),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      appBar: AppBar(title: Text("visit_details".tr()), actions: [VisitAppBarAction(visitID: visitID)]),
      body: ListView(
        children: [
          /// Visit Header Part .....
          const VisitHeader(),

          /// Visit Google Map Part .....
          VisitDetailsGoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),

          /// Visit Photo Upload Part .....
          VisitPhoneUpload(visitID: visitID),

          /// Visit Schedule List Part .....
          BlocBuilder<VisitBloc, VisitState>(
            builder: (context, state) {
              VisitDetailsResponse? data = state.visitDetailsResponse?.data;
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data?.schedules?.length ?? 0,
                itemBuilder: (context, index) {
                  Schedule? schedule = data?.schedules?[index];
                  return InkWell(
                    onTap: () async {
                      context.read<VisitBloc>().add(
                        VisitGoToPositionEvent(
                          latLng: LatLng(
                            double.parse(schedule?.latitude.toString() ?? ""),
                            double.parse(schedule?.longitude.toString() ?? ""),
                          ),
                          controller: mapController,
                        ),
                      );
                    },
                    child: VisitScheduleItem(schedule: schedule),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              );
            },
          ),

          /// Visit Note Part .....
          VisitNoteContent(visitID: visitID),

          /// Visit ReSchedule and Cancel Button Part
          RescheduleCancelButton(visitId: visitID),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
