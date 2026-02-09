import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SearchableDropdownContent extends StatefulWidget {
  final List<Company> items;
  final Company? selectedItem;
  final ValueChanged<Company> onChanged;

  const SearchableDropdownContent({
    super.key,
    required this.items,
    required this.onChanged,
    this.selectedItem,
  });

  @override
  State<SearchableDropdownContent> createState() =>
      _SearchableDropdownContentState();
}

class _SearchableDropdownContentState extends State<SearchableDropdownContent> {
  late Company? selectedCompany;
  late List<Company> filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCompany =
        widget.selectedItem ??
        (widget.items.isNotEmpty ? widget.items.first : null);
    filteredItems = widget.items;
    if (selectedCompany != null) widget.onChanged(selectedCompany!);
  }

  void _openDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [Colors.white.withAlpha(180), Colors.white],
                ),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) {
                      setSheetState(() {
                        filteredItems =
                            widget.items
                                .where(
                                  (item) => item.companyName!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()),
                                )
                                .toList();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (_, index) {
                        final item = filteredItems[index];
                        return ListTile(
                          title: Text(item.companyName ?? ''),
                          trailing:
                              item == selectedCompany
                                  ? const Icon(Icons.check, color: Colors.green)
                                  : null,
                          onTap: () {
                            setState(() => selectedCompany = item);
                            widget.onChanged(item);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDropdown(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(180),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: colorPrimary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedCompany?.companyName ?? '',
              style: TextStyle(
                color: selectedCompany != null ? Colors.black : Colors.grey,
                fontSize: 16,
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
