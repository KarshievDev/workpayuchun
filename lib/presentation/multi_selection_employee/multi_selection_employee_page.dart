import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/multi_selection_employee/content/get_multi_employee_content.dart';
import 'package:strawberryhrm/presentation/phonebook/bloc/phonebook_bloc.dart';
import '../../res/widgets/custom_button.dart';

class MultiSelectionEmployee extends StatelessWidget {

  final Function(List<PhoneBookUser>) onItemSelected;

  const MultiSelectionEmployee({super.key,required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    // final user = context.read<AuthenticationBloc>().state.data;
    // final baseUrl = globalState.get(companyUrl);
    return BlocProvider(
      create: (_) => PhoneBookBloc(metaClubApiClient: MetaClubApiClient(httpService: instance()))..add(PhoneBookLoadRequest()),
      child: Scaffold(
          appBar: AppBar(
              title: const Text("Multi Selection Employee"),
              leading: BlocBuilder<PhoneBookBloc, PhoneBookState>(
                  builder: (context, state) {
                return state.isMultiSelectionEnabled
                    ? IconButton(
                        onPressed: () {
                          state.selectedItems.clear();
                          context.read<PhoneBookBloc>().add(IsMultiSelectionEnabled(false));
                        },
                        icon: const Icon(Icons.clear, color: Colors.white,))
                    : IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white,));
              })),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(0)),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<PhoneBookBloc, PhoneBookState>(
                  builder: (context, state) {
                    return CustomHButton(
                      title: "Selected Employee (${state.selectedItems.length})",
                      padding: 16,
                      clickButton: () {
                        onItemSelected(state.selectedItems);
                        Navigator.pop(context);
                      },
                    );
                  },
                )),
          ),
          body: const GetMultiEmployeeContent()),
    );
  }
}
