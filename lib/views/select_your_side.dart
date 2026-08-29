// x or o
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/core/app_colors.dart';
import 'package:tic_tac_toe_game/core/app_images.dart';
import 'package:tic_tac_toe_game/core/text_styles.dart';
import 'package:tic_tac_toe_game/views/game_home.dart';
import 'package:tic_tac_toe_game/views/widgets/custom_button.dart';

enum PlayerSide { X, O }

class SelectYourSide extends StatefulWidget {
  const SelectYourSide({super.key, required this.mode});
  final bool mode;
  @override
  State<SelectYourSide> createState() => _SelectYourSideState();
}

class _SelectYourSideState extends State<SelectYourSide> {
  PlayerSide groupValue = PlayerSide.X;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pick your side', style: AppStyles.styleMedium24(context)),
            const SizedBox(height: 35),
            // Radio group
            RadioGroup<PlayerSide>(
              groupValue: groupValue,
              onChanged: (PlayerSide? value) {
                if (value == null) return;

                setState(() {
                  groupValue = value;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(AppImages.x, width: 100, height: 100),

                      const Radio<PlayerSide>(value: PlayerSide.X),
                    ],
                  ),

                  const SizedBox(width: 50),

                  Column(
                    children: [
                      Image.asset(AppImages.o, width: 100, height: 100),

                      const Radio<PlayerSide>(value: PlayerSide.O),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            CustomButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return GamePage(
                        selectedSide: groupValue,
                        withAI: widget.mode,
                      );
                    },
                  ),
                );
              },
              text: 'Continue',
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
