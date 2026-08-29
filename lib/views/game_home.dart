import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/core/text_styles.dart';
import 'package:tic_tac_toe_game/logic/game_logic.dart';
import 'package:tic_tac_toe_game/views/select_your_side.dart';
import 'package:tic_tac_toe_game/views/widgets/cell_item.dart';
import 'package:tic_tac_toe_game/views/widgets/reset_game_button.dart';
import 'package:tic_tac_toe_game/views/widgets/winning_line.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.withAI, required this.selectedSide});
  final bool withAI;
  final PlayerSide selectedSide;
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool playWithAI = false;
  // Game settings
  // if with AI is true  -> Play with AI
  // false -> Play with Friend
  //-------- Game state variables
  String currentPlayer = PlayerSide.X.name; // active
  String? result;
  bool gameOver = false;
  // Scores
  int drawScore = 0; // مفيش حد كسب
  String player2Name = 'Player 2';
  int player1Score = 0;
  int player2Score = 0; // player 2 or ai score
  final game = Game();
  late PlayerSide humanPlayer;
  late PlayerSide aiPlayer;
  List<String> board = List.filled(9, '');
  late ConfettiController confettiController; // confetti celebration controller

  @override
  void initState() {
    super.initState();
    confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    humanPlayer = widget.selectedSide;
    aiPlayer = widget.selectedSide == PlayerSide.X
        ? PlayerSide.O
        : PlayerSide.X;
    playWithAI = widget.withAI;
    game.selectedSide = widget.selectedSide;
    board = game.board;
    player2Name = (playWithAI == false) ? 'Player 2' : 'AI';

    if (playWithAI && humanPlayer == PlayerSide.O) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        aiMove();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          // wrap with stack to show celebration
          children: [
            orientation == Orientation.portrait
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      // row of scores
                      _rowScores(),
                      const SizedBox(height: 20),
                      // Text of player turn
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Player $currentPlayer Turn',
                          textAlign: TextAlign.center,
                          style: AppStyles.styleBold20(context),
                        ),
                      ),
                      // Card - Grid view
                      Center(
                        child: Card(
                          color: Colors.white,
                          elevation: 6,
                          margin: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Center(child: buildGrid()),
                          ),
                        ),
                      ),
                      // Result text
                      if (result != null) ...[
                        Text('$result', style: AppStyles.styleBold20(context)),
                        const SizedBox(height: 15),
                      ],
                      // Reset game button
                      ResetGameButton(onReset: resetGame),
                      const SizedBox(height: 15),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // row of scores
                            _rowScores(),
                            const SizedBox(height: 20),
                            // Text of player turn
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                'Player $currentPlayer Turn',
                                textAlign: TextAlign.center,
                                style: AppStyles.styleBold20(context),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Result text
                            if (result != null) ...[
                              Text(
                                '$result',
                                style: AppStyles.styleBold20(context),
                              ),
                              const SizedBox(height: 15),
                            ],
                            // Reset game button
                            ResetGameButton(onReset: resetGame),
                          ],
                        ),
                      ),
                      // Card - Grid view
                      Expanded(
                        child: Card(
                          color: Colors.white,
                          elevation: 6,
                          margin: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Center(child: buildGrid()),
                          ),
                        ),
                      ),
                    ],
                  ),
            // Celebration - confetti widget
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 30,
                gravity: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // row of scores widget
  Row _rowScores() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          child: Text('Player 1', maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              '$player1Score - $player2Score',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
        ),
        Flexible(
          child: Text(
            player2Name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Reset game
  void resetGame() {
    setState(() {
      game.reset();
      board = game.board;
      currentPlayer = 'X';
      gameOver = false;
      result = null;
    });
  }

  // Player move -- on tap on any cell
  void play(int index) async {
    if (gameOver) return;

    // check if the cell is empty
    if (board[index].isNotEmpty) return;

    // AI's turn → user can't play
    if (playWithAI && currentPlayer == aiPlayer.name) {
      return;
    }
    // user move
    game.playGame(index, currentPlayer);

    // Check result of Human move
    if (checkGameResult(currentPlayer)) {
      return;
    }

    // switch player
    setState(() {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    });

    // AI turn
    // If playing against AI, let AI play
    if (playWithAI && currentPlayer == aiPlayer.name) {
      await aiMove();
    }
  }

  // Check game result
  bool checkGameResult(String player) {
    // player is current player
    if (game.hasWinner(board, player)) {
      setState(() {
        if (player == humanPlayer.name) {
          player1Score++;
        } else {
          player2Score++;
        }
        // Celebrate
        confettiController.play();
        endGame(player);
      });
      return true;
    }

    if (game.isDraw()) {
      setState(() {
        drawScore++;
        endGame(null);
      });
      return true;
    }
    return false;
  }

  // Ai move
  Future<void> aiMove() async {
    if (gameOver) return;
    // Wait before AI makes its move
    await Future.delayed(const Duration(milliseconds: 700));
    await game.aiMove();
    setState(() {});

    // Check game result
    if (checkGameResult(aiPlayer.name)) {
      return;
    }
    // Switch back to Human
    setState(() {
      currentPlayer = humanPlayer.name;
    });
  }

  // END GAME
  void endGame(String? winningPlayer) {
    gameOver = true;
    if (winningPlayer == null) {
      result = 'It\'s a draw!';
    } else {
      result = 'Player ${winningPlayer.toUpperCase()} is the winner!';
    }
  }

  // Grid view of the game
  Widget buildGrid() {
    return Stack(
      // wrap with stack to draw the winning pattern above the grid
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return CellItem(
              board: board,
              index: index,
              play: () => play(index),
            );
          },
        ),
        // Winning pattern above the grid
        if (game.winningPattern.isNotEmpty)
          WinningLine(pattern: game.winningPattern),
      ],
    );
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }
}
