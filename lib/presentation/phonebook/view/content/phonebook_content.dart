import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/phonebook/view/content/phonebook_search.dart';
import 'package:strawberryhrm/presentation/phonebook/view/content/phonebook_employees.dart';
import 'package:strawberryhrm/presentation/phonebook/view/content/filter_popup_menu/popup_menus_filter_content.dart';

import '../../bloc/phonebook_bloc.dart';

class PhoneBookContent extends StatelessWidget {
  final Settings? settings;

  const PhoneBookContent({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PhoneBookSearch(
                bloc: context.read<PhoneBookBloc>(),
              ),
            ),
            PopupMenusFilerContent(bloc: context.read<PhoneBookBloc>(), settings: settings)
          ],
        ),
        const Expanded(child: PhoneBookEmployees())
      ],
    );
  }
}
