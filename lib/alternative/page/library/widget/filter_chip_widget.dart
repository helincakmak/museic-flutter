import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final int index;
  final int selectedChipIndex;
  final Function(int) onChipTap;

  const FilterChipWidget({
    required this.label,
    required this.index,
    required this.selectedChipIndex,
    required this.onChipTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.w),
      child: GestureDetector(
        onTap: () {
          onChipTap(index);
        },
        child: Chip(
          label: Text(
            label,
            style: TextStyle(
              color: selectedChipIndex == index ? Colors.black : Colors.white,
              fontSize: 13.sp,
            ),
          ),
          backgroundColor: selectedChipIndex == index
              ? Color(0xFF7F7F7F)
              : Color(0xFF121212),
          shape: StadiumBorder(
            side: BorderSide(
              color: Color(0xFF7F7F7F),
              width: 1.0,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.w),
        ),
      ),
    );
  }
}
