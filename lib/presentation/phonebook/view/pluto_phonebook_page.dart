import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/phonebook/bloc/phonebook_bloc.dart';
import 'package:strawberryhrm/presentation/phonebook/view/pluto_content/pluto_phonebook_content.dart';

class PlutoPhoneBookPage extends StatelessWidget {
  final Settings? settings;

  const PlutoPhoneBookPage({super.key, this.settings});

  static Route route(int? userId, Settings? settings) =>
      MaterialPageRoute(builder: (_) => PlutoPhoneBookPage(settings: settings!));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            PhoneBookBloc(metaClubApiClient: MetaClubApiClient(httpService: instance()))..add(PhoneBookLoadRequest()),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'PhoneBook',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Branding.colors.textPrimary),
            ).tr(),
            iconTheme: IconThemeData(color: Branding.colors.textPrimary),
          ),
          body: PlutoPhoneBookContent(
            settings: settings,
          ),
        ));
  }
}
