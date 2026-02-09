import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class CheckInCheckOutButton extends StatefulWidget {
  final DashboardModel homeData;

  const CheckInCheckOutButton({super.key, required this.homeData});

  @override
  State<CheckInCheckOutButton> createState() => _CheckInCheckOutButtonState();
}

class _CheckInCheckOutButtonState extends State<CheckInCheckOutButton>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        animationBehavior: AnimationBehavior.preserve);

    controller.addStatusListener((AnimationStatus status) {
      if (kDebugMode) {
        print('AnimationStatus ${status.name}');
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onVerticalDragCancel: () {
          controller.reset();
        },
        onHorizontalDragCancel: () {
          controller.reset();
        },
        onTapDown: (_) {
          controller.forward();
        },
        onTapUp: (_) {
          if (controller.status == AnimationStatus.forward) {
            controller.reverse();
            controller.value;
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            const SizedBox(
              height: 175,
              width: 175,
              child: CircularProgressIndicator(
                // strokeWidth: 5,
                value: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            Container(
              height: 185,
              width: 185,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Branding.colors.primaryLight.withValues(alpha: 0.1),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: CircularProgressIndicator(
                strokeWidth: 5,
                value: controller.value,
                valueColor: AlwaysStoppedAnimation<Color>(Branding.colors.primaryLight),
              ),
            ),
            ClipOval(
              child: Material(
                  child: Container(
                height: 170,
                width: 170,
                decoration:  BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Branding.colors.primaryLight, const Color(0xFF00CCFF)],
                      begin: const FractionalOffset(1.0, 0.0),
                      end: const FractionalOffset(0.0, 3.0),
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Image.asset(
                          "assets/images/tap_figer.png",
                          height: 50,
                          width: 50,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          "check_in".tr(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
