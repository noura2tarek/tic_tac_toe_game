import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/core/app_colors.dart';
import 'package:tic_tac_toe_game/core/app_images.dart';
import 'package:tic_tac_toe_game/core/text_styles.dart';
import 'package:tic_tac_toe_game/views/widgets/custom_button.dart';

class SelectPlayModeScreen extends StatelessWidget {
  const SelectPlayModeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //row of two images
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.x,
                  width: 100,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                const SizedBox(width: 20),
                Image.asset(
                  AppImages.o,
                  width: 100,
                  height: 170,
                  fit: BoxFit.fill,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'Choose your play mode',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: AppStyles.styleMedium24(context),
              ),
            ),

            //---- buttons
            // Elevated button
            const CustomButton(
              text: 'With AI',
              backgroundColor: AppColors.blue,
              foregroundColor: AppColors.white,
              isAi: true,
            ),
            const SizedBox(height: 20),
            // with friend button
            const CustomButton(
              text: 'With Friend',
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
              isAi: false,
            ),
          ],
        ),
      ),
    );
  }
}

//----------------------
