import 'package:meta_club_api/meta_club_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../util/horizontal_scrollbar.dart';
import '../util/multi_select_item.dart';

/// A widget meant to display selected values as chips.
///
List<Qualification>? updatedQualification = [];
// ignore: must_be_immutable
class MultiSelectChipDisplay<V> extends StatelessWidget {
  /// The source list of selected items.
  final List<MultiSelectItem<V>?>? items;

  /// Fires when a chip is tapped.
  final Function(V)? onTap;

  /// Set the chip color.
  final Color? chipColor;

  /// Change the alignment of the chips.
  final Alignment? alignment;

  /// Style the Container that makes up the chip display.
  final BoxDecoration? decoration;

  /// Style the text on the chips.
  final TextStyle? textStyle;

  /// A function that sets the color of selected items based on their value.
  final Color? Function(V)? colorator;

  /// An icon to display prior to the chip's label.
  final Icon? icon;

  /// Set a ShapeBorder. Typically a RoundedRectangularBorder.
  final ShapeBorder? shape;

  /// Enables horizontal scrolling.
  final bool scroll;

  /// Enables the scrollbar when scroll is `true`.
  final HorizontalScrollBar? scrollBar;

  // final ScrollController _scrollController = ScrollController();

  /// Set a fixed height.
  final double? height;

  /// Set the width of the chips.
  final double? chipWidth;

  bool? disabled;

  final Function(List<MultiSelectItem<V>?>?) updatedItems;

  MultiSelectChipDisplay({super.key,
    this.items,
    this.onTap,
    this.chipColor,
    this.alignment,
    this.decoration,
    this.textStyle,
    this.colorator,
    this.icon,
    this.shape,
    this.scroll = false,
    this.scrollBar,
    this.height,
    required this.updatedItems,
    this.chipWidth,
  }) {
    disabled = false;
  }

  MultiSelectChipDisplay.none({super.key,
    this.items = const [],
    required this.updatedItems,
    this.disabled = true,
    this.onTap,
    this.chipColor,
    this.alignment,
    this.decoration,
    this.textStyle,
    this.colorator,
    this.icon,
    this.shape,
    this.scroll = false,
    this.scrollBar,
    this.height,
    this.chipWidth,
  });

  @override
  Widget build(BuildContext context) {

    if (items == null || items!.isEmpty) return Container();
    return Container(
      decoration: decoration,
      alignment: alignment ?? Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: scroll ? 0 : 10),
      child: Wrap(
        children: items != null ? items!.map((item) => _buildItem(item!, context,onYearChanged: (year){

         final index = items!.indexOf(item);

          items![index]!.year = year;

          if (kDebugMode) {
            print(items![index]!.year);
          }

          updatedItems(items);
        },onInstitutionChanged: (institution){

          final index = items!.indexOf(item);

          items![index]!.institution = institution;
          if (kDebugMode) {
            print(items![index]!.institution);
          }
          updatedItems(items);
        })).toList() : <Widget>[Container()],
      ),
    );
  }

  Widget _buildItem(MultiSelectItem<V> item, BuildContext context,{Function(String)? onYearChanged,Function(String)? onInstitutionChanged}) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Expanded(child: Text(item.label,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),),
            const SizedBox(width: 10,),
            Expanded(
                child: TextFormField(
                  onChanged: onYearChanged,
                    decoration: const InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                      hintText: "Passing Year",
                      hintStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
            )),
            const SizedBox(width: 10,),
            Expanded(
                child: TextFormField(
                  onChanged: onInstitutionChanged,
                  decoration: const InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                    hintText: "Institute",
                    hintStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
            ))
          ],
        ));
  }
}

// child: ChoiceChip(
// shape: shape as OutlinedBorder?,
// avatar: icon != null
// ? Icon(
// icon!.icon,
// color: colorator != null && colorator!(item.value) != null
// ? colorator!(item.value)!.withValues(alpha: 1)
// : icon!.color ?? Theme.of(context).primaryColor,
// )
// : null,
// label: SizedBox(
// width: chipWidth,
// child: Text(
// item.label,
// overflow: TextOverflow.ellipsis,
// style: TextStyle(
// color: colorator != null && colorator!(item.value) != null
// ? textStyle != null
// ? textStyle!.color ?? colorator!(item.value)
// : colorator!(item.value)
// : textStyle != null && textStyle!.color != null
// ? textStyle!.color
//     : chipColor != null
// ? chipColor!.withValues(alpha: 1)
// : null,
// fontSize: textStyle != null ? textStyle!.fontSize : null,
// ),
// ),
// ),
// selected: items!.contains(item),
// selectedColor: colorator != null && colorator!(item.value) != null
// ? colorator!(item.value)
// : chipColor ?? Theme.of(context).primaryColor.withValues(alpha: 0.33),
// onSelected: (_) {
// if (onTap != null) onTap!(item.value);
// },
// ),
