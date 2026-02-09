import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:strawberryhrm/presentation/internet_connectivity/bloc/bloc.dart';

class NoInternetScreen extends StatelessWidget {
  final Widget child;

  const NoInternetScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetBloc,InternetState>(
      builder: (context,state){
        if(state.status == InternetStatus.offline){
          return Scaffold(
            body: SafeArea(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Lottie.asset(
                        'assets/images/no_internet.json',
                        width: double.infinity,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 55),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: <Widget>[
                              const Spacer(),
                              const Text(
                                "Whoops!",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40.0),
                                child: Text(
                                  "Slow or no internet connection. Please check your internet settings",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                height: 45,
                                width: 170,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<InternetBloc>().checkConnectionStatus();
                                  },
                                  style: ButtonStyle(
                                    shape:
                                    WidgetStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24.0),
                                      ),
                                    ),
                                  ),
                                  child: const Text("Try again",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      )),
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                )),
          );
        }
        return child;
      }
    );
  }
}
