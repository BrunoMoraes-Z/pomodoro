import 'package:flutter/material.dart';
import 'package:test_web/shared/constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.big = false,
  }) : super(key: key);

  final IconData icon;
  final bool big;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular((big ? 24 : 20) + 1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(big ? 24 : 20),
          color: big ? constants.blue2 : constants.blue1,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: big ? 28 : 16,
          vertical: big ? 20 : 18,
        ),
        child: Icon(
          icon,
          color: constants.blue3,
          size: big ? 40 : 26,
        ),
      ),
    );
  }
}
