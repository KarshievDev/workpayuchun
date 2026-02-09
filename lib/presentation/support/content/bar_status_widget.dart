import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core/core.dart';
import '../bloc/bloc.dart';

class BarStatusWidget extends StatelessWidget {
  const BarStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportBloc, SupportState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Wrap(
          spacing: 20,
          children: List<Widget>.generate(
            supportTicketsButton.length,
            (int index) {
              int selectedIndex = 0;

              switch (state.filter) {
                case Filter.open:
                  selectedIndex = 0;
                  break;
                case Filter.close:
                  selectedIndex = 1;
                  break;
                case Filter.all:
                  selectedIndex = 2;
                  break;
              }

              return ChoiceChip(
                elevation: 3,
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(supportTicketsButton[index]).tr(),
                ),
                // selected: provider.value == index,
                selected: selectedIndex == index,
                backgroundColor: Colors.white,
                selectedColor: const Color(0xFF5DB226),
                labelStyle: TextStyle(
                  fontSize: 13.r,
                  color: selectedIndex == index
                      ? Colors.white
                      : const Color(0xFF5DB226),
                ),
                onSelected: (bool selected) {
                  if (index == 0) {
                    context.read<SupportBloc>().add(OnFilterUpdate(
                        filter: Filter.open, date: state.currentMonth));
                  } else if (index == 1) {
                    context.read<SupportBloc>().add(OnFilterUpdate(
                        filter: Filter.close, date: state.currentMonth));
                  } else {
                    context.read<SupportBloc>().add(OnFilterUpdate(
                        filter: Filter.all, date: state.currentMonth));
                  }
                  // provider.onSelected(selected, index, 1);
                },
              );
            },
          ).toList(),
        ),
      );
    });
  }
}
