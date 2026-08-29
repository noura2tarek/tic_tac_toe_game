import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/core/text_styles.dart';
import 'package:tic_tac_toe_game/views/select_your_side.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    this.isAi = false,
    this.onPressed,
  });

  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isAi;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(300, 40),
        padding: const EdgeInsets.symmetric(vertical: 10),
        backgroundColor: backgroundColor,
        elevation: 10,
        shadowColor: Colors.blueGrey,
        foregroundColor: foregroundColor,
      ),
      onPressed:
          onPressed ??
          () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return SelectYourSide(mode: isAi);
                },
              ),
            );
          },
      child: Text(
        text,
        style: AppStyles.styleRegular24(context, color: foregroundColor),
      ),
    );
  }
}
