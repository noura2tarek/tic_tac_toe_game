import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/core/text_styles.dart';

class ResetGameButton extends StatelessWidget {
  const ResetGameButton({super.key, this.onReset});
  final void Function()? onReset;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: onReset,
      icon: const Icon(Icons.restart_alt, size: 20),
      label: Text('Reset Game', style: AppStyles.styleRegular16(context)),
    );
  }
}
