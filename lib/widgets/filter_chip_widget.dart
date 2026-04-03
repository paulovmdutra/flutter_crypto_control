import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool selected;

  const FilterChipWidget(
      {super.key, required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) {},
        backgroundColor: Colors.grey.shade800,
        selectedColor: Colors.white,
        labelStyle: TextStyle(color: selected ? Colors.black : Colors.white),
      ),
    );
  }
}
