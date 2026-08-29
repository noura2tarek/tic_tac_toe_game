import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/core/app_images.dart';

class CellItem extends StatelessWidget {
  const CellItem({
    super.key,
    required this.board,
    required this.index,
    this.play,
  });

  final List<String> board;
  final int index;
  final void Function()? play;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: play,
      child: Container(
        height: orientation == Orientation.portrait ? 120 : 90,
        width: orientation == Orientation.portrait ? 120 : 90,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: index < 6
                ? const BorderSide(color: Colors.green, width: 2)
                : BorderSide.none,
            right: index % 3 != 2 && index < 9
                ? const BorderSide(color: Colors.red, width: 2)
                : BorderSide.none,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: board[index] == 'X'
              ? Image.asset(
                  AppImages.x,
                  width: orientation == Orientation.portrait ? 100 : 80,
                  height: orientation == Orientation.portrait ? 100 : 80,
                )
              : board[index] == 'O'
              ? Image.asset(
                  AppImages.o,
                  width: orientation == Orientation.portrait ? 100 : 80,
                  height: orientation == Orientation.portrait ? 100 : 80,
                )
              : null,
        ),
      ),
    );
  }
}
