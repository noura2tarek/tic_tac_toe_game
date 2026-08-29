import 'dart:math';
import 'package:flutter/material.dart';

// AI Code generated
class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});
 
  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  // ----------------------------------------------------------
  // Game settings
  // ----------------------------------------------------------

  // true  -> Play with AI
  // false -> Play with Friend
  bool playWithAI = true;

  // ----------------------------------------------------------
  // Game state
  // ----------------------------------------------------------

  List<String> board = List.filled(9, '');

  String currentPlayer = 'X';

  String? winner;

  bool gameOver = false;

  // Scores
  int xScore = 0;
  int oScore = 0;
  int drawScore = 0;

  // All possible winning combinations
  final List<List<int>> winningPatterns = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  // ----------------------------------------------------------
  // USER MOVE
  // ----------------------------------------------------------

  void playMove(int index) {
    // Don't allow moves after game ends
    if (gameOver) return;

    // Don't allow playing on occupied cell
    if (board[index].isNotEmpty) return;

    // In AI mode, user is X
    // So don't allow user to play when it's O's turn
    if (playWithAI && currentPlayer == 'O') return;

    setState(() {
      board[index] = currentPlayer;
    });

    // Check if this move won the game
    if (checkWinner()) {
      endGame(currentPlayer);
      return;
    }

    // Check draw
    if (isDraw()) {
      endGame(null);
      return;
    }

    // Switch player
    setState(() {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    });

    // If playing against AI, let AI play
    if (playWithAI && currentPlayer == 'O') {
      Future.delayed(const Duration(milliseconds: 400), makeAiMove);
    }
  }

  // ----------------------------------------------------------
  // AI MOVE
  // ----------------------------------------------------------

  void makeAiMove() {
    if (gameOver) return;

    final bestMove = getBestMove();

    if (bestMove == -1) return;

    setState(() {
      board[bestMove] = 'O';
    });

    // Check AI winner
    if (checkWinner()) {
      endGame('O');
      return;
    }

    // Check draw
    if (isDraw()) {
      endGame(null);
      return;
    }

    // Back to player
    setState(() {
      currentPlayer = 'X';
    });
  }

  // ----------------------------------------------------------
  // MINIMAX AI
  // ----------------------------------------------------------

  int getBestMove() {
    int bestScore = -1000;
    int bestMove = -1;

    for (int i = 0; i < board.length; i++) {
      if (board[i].isEmpty) {
        board[i] = 'O';

        final score = minimax(board, false);

        board[i] = '';

        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }

    return bestMove;
  }

  int minimax(List<String> board, bool isMaximizing) {
    // Check if AI wins
    if (hasWinner(board, 'O')) {
      return 10;
    }

    // Check if player wins
    if (hasWinner(board, 'X')) {
      return -10;
    }

    // Draw
    if (board.every((cell) => cell.isNotEmpty)) {
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -1000;

      for (int i = 0; i < board.length; i++) {
        if (board[i].isEmpty) {
          board[i] = 'O';

          final score = minimax(board, false);

          board[i] = '';

          bestScore = max(bestScore, score);
        }
      }

      return bestScore;
    } else {
      int bestScore = 1000;

      for (int i = 0; i < board.length; i++) {
        if (board[i].isEmpty) {
          board[i] = 'X';

          final score = minimax(board, true);

          board[i] = '';

          bestScore = min(bestScore, score);
        }
      }

      return bestScore;
    }
  }

  // ----------------------------------------------------------
  // CHECK WINNER
  // ----------------------------------------------------------

  bool checkWinner() {
    return hasWinner(board, currentPlayer);
  }

  bool hasWinner(List<String> board, String player) {
    for (final pattern in winningPatterns) {
      final first = pattern[0];
      final second = pattern[1];
      final third = pattern[2];

      if (board[first] == player &&
          board[second] == player &&
          board[third] == player) {
        return true;
      }
    }

    return false;
  }

  // ----------------------------------------------------------
  // CHECK DRAW
  // ----------------------------------------------------------

  bool isDraw() {
    return board.every((cell) => cell.isNotEmpty);
  }

  // ----------------------------------------------------------
  // END GAME
  // ----------------------------------------------------------

  void endGame(String? winningPlayer) {
    setState(() {
      gameOver = true;
      winner = winningPlayer;

      if (winningPlayer == 'X') {
        xScore++;
      } else if (winningPlayer == 'O') {
        oScore++;
      } else {
        drawScore++;
      }
    });

    showGameResult();
  }

  // ----------------------------------------------------------
  // SHOW RESULT
  // ----------------------------------------------------------

  void showGameResult() {
    String message;

    if (winner == null) {
      message = "It's a Draw!";
    } else {
      message = 'Player $winner Wins!';
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over', textAlign: TextAlign.center),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  resetGame();
                },
                child: const Text('Play Again'),
              ),
            ),
          ],
        );
      },
    );
  }

  // ----------------------------------------------------------
  // RESET GAME
  // ----------------------------------------------------------

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = null;
      gameOver = false;
    });
  }

  // ----------------------------------------------------------
  // RESET EVERYTHING
  // ----------------------------------------------------------

  void resetScores() {
    setState(() {
      xScore = 0;
      oScore = 0;
      drawScore = 0;

      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = null;
      gameOver = false;
    });
  }

  // ----------------------------------------------------------
  // UI
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: resetScores,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Scores',
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // ------------------------------------------------
              // Game Mode
              // ------------------------------------------------
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('Play with AI'),
                      selected: playWithAI,
                      onSelected: (value) {
                        setState(() {
                          playWithAI = true;
                        });

                        resetGame();
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ChoiceChip(
                      label: const Text('Play with Friend'),
                      selected: !playWithAI,
                      onSelected: (value) {
                        setState(() {
                          playWithAI = false;
                        });

                        resetGame();
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ------------------------------------------------
              // Score
              // ------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildScore('Player X', xScore),

                  buildScore('Draw', drawScore),

                  buildScore('Player O', oScore),
                ],
              ),

              const SizedBox(height: 30),

              // ------------------------------------------------
              // Current Player
              // ------------------------------------------------
              Text(
                gameOver ? 'Game Over' : 'Player $currentPlayer Turn',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // Board
              // ------------------------------------------------
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 9,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemBuilder: (context, index) {
                        return buildCell(index);
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // Restart Button
              // ------------------------------------------------
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: resetGame,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text(
                    'Restart Game',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // CELL
  // ----------------------------------------------------------

  Widget buildCell(int index) {
    final value = board[index];

    return GestureDetector(
      onTap: () {
        playMove(index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.deepPurple, width: 2),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: value == 'X' ? Colors.blue : Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // SCORE WIDGET
  // ----------------------------------------------------------

  Widget buildScore(String title, int score) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        Text(
          '$score',
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
