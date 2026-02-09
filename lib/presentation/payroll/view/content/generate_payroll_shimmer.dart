import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../res/shimmers.dart';
import 'header_table_row.dart';

class GeneratePayrollShimmer extends StatelessWidget {
  const GeneratePayrollShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(width: 0.5),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: [
            HeaderTableRow(title: 'month'.tr()),
            Center(child: HeaderTableRow(title: 'salary'.tr())),
            Center(
              child: HeaderTableRow(title: 'payslip'.tr()),
            ),
          ],
        ),
        ...List.generate(
            3,
            (index) => TableRow(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildRectangularCardShimmer(),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: buildRectangularCardShimmer(),
                      ),
                    ),
                    Center(
                      child: buildRectangularCardShimmer(),
                    ),
                  ],
                ))
      ],
    );
  }

  RectangularCardShimmer buildRectangularCardShimmer() {
    return const RectangularCardShimmer(
      width: 80,
      height: 20,
    );
  }
}
