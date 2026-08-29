import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/views/select_play_mode.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tix Tac Toe Game',
      theme: ThemeData(
        fontFamily: 'RobotoMono',
        scaffoldBackgroundColor: const Color(0xfff6f6f6),
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SelectPlayModeScreen(),
    );
  }
}
