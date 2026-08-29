import 'package:tic_tac_toe_game/views/select_your_side.dart';

// class Player {
//   static List<int> playerX = [];
//   static List<int> playerO = [];
// }

class Game {
  PlayerSide selectedSide = PlayerSide.X; // default -- update this value in init state 

  List<String> board = List.filled(9, '');

  List<int> winningPattern = [];

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

  // PLAY MOVE
  void playGame(int index, String activePlayer) {
    if (board[index].isNotEmpty) return;
    board[index] = activePlayer;
  }

  // CHECK DRAW
  bool isDraw() {
    return board.every((cell) => cell.isNotEmpty);
  }

  // RESET GAME
  void reset() {
    board = List.filled(9, '');
    winningPattern = [];
  }

  // CHECK WINNER
  bool hasWinner(List<String> board, String player) {
    for (final pattern in winningPatterns) {
      final first = pattern[0];
      final second = pattern[1];
      final third = pattern[2];

      if (board[first] == player &&
          board[second] == player &&
          board[third] == player) {
        winningPattern = pattern;
        return true;
      }
    }

    return false;
  }

  // AI MOVE
  Future<void> aiMove() async {
    // Human player
    final humanPlayer = selectedSide.name;

    // AI player
    final aiPlayer = selectedSide == PlayerSide.X
        ? PlayerSide.O.name
        : PlayerSide.X.name;

    // --------------------------------------------------
    // Find a tactical move
    // --------------------------------------------------

    int? findTacticalMove(String player) {
      for (final pattern in winningPatterns) {
        int playerCells = 0;
        int emptyCell = -1;

        for (final index in pattern) {
          if (board[index] == player) {
            playerCells++;
          } else if (board[index].isEmpty) {
            emptyCell = index;
          }
        }

        // Two player's cells + one empty cell
        if (playerCells == 2 && emptyCell != -1) {
          return emptyCell;
        }
      }

      return null;
    }

    // --------------------------------------------------
    // Find first available cell
    // --------------------------------------------------

    int? firstOpenIn(List<int> indexes) {
      for (final index in indexes) {
        if (board[index].isEmpty) {
          return index;
        }
      }

      return null;
    }

    // --------------------------------------------------
    // Decide AI move
    // --------------------------------------------------

    final move =
        // 1. Can AI win?
        findTacticalMove(aiPlayer) ??
        // 2. Can human win? Block them
        findTacticalMove(humanPlayer) ??
        // 3. Take center
        (board[4].isEmpty ? 4 : null) ??
        // 4. Take a corner
        firstOpenIn([0, 2, 6, 8]) ??
        // 5. Take any available cell
        board.indexWhere((cell) => cell.isEmpty);

    // No available moves
    if (move == -1) {
      return;
    }

    // Put AI move on board
    board[move] = aiPlayer;
  }

  // Future<void> autoPlay(activePlayer) async {
  //   int index = 0;
  //   List<int> emptyCells = [];

  //   for (var i = 0; i < 9; i++) {
  //     if (!(Player.playerX.contains(i) || Player.playerO.contains(i)))
  //       emptyCells.add(i);
  //   }

  //   // start - center
  //   if (Player.playerO.containsAll(0, 1) && emptyCells.contains(2))
  //     index = 2;
  //   else if (Player.playerO.containsAll(3, 4) && emptyCells.contains(5))
  //     index = 5;
  //   else if (Player.playerO.containsAll(6, 7) && emptyCells.contains(8))
  //     index = 8;
  //   else if (Player.playerO.containsAll(0, 3) && emptyCells.contains(6))
  //     index = 6;
  //   else if (Player.playerO.containsAll(1, 4) && emptyCells.contains(7))
  //     index = 7;
  //   else if (Player.playerO.containsAll(2, 5) && emptyCells.contains(8))
  //     index = 8;
  //   else if (Player.playerO.containsAll(0, 4) && emptyCells.contains(8))
  //     index = 8;
  //   else if (Player.playerO.containsAll(2, 4) && emptyCells.contains(6))
  //     index = 6;
  //   // start - end
  //   else if (Player.playerO.containsAll(0, 2) && emptyCells.contains(1))
  //     index = 1;
  //   else if (Player.playerO.containsAll(3, 5) && emptyCells.contains(4))
  //     index = 4;
  //   else if (Player.playerO.containsAll(6, 8) && emptyCells.contains(7))
  //     index = 7;
  //   else if (Player.playerO.containsAll(0, 6) && emptyCells.contains(3))
  //     index = 3;
  //   else if (Player.playerO.containsAll(1, 7) && emptyCells.contains(4))
  //     index = 4;
  //   else if (Player.playerO.containsAll(2, 8) && emptyCells.contains(5))
  //     index = 5;
  //   else if (Player.playerO.containsAll(0, 8) && emptyCells.contains(4))
  //     index = 4;
  //   else if (Player.playerO.containsAll(2, 6) && emptyCells.contains(4))
  //     index = 4;
  //   // center - end
  //   else if (Player.playerO.containsAll(1, 2) && emptyCells.contains(0))
  //     index = 0;
  //   else if (Player.playerO.containsAll(4, 5) && emptyCells.contains(3))
  //     index = 3;
  //   else if (Player.playerO.containsAll(7, 8) && emptyCells.contains(6))
  //     index = 6;
  //   else if (Player.playerO.containsAll(3, 6) && emptyCells.contains(0))
  //     index = 0;
  //   else if (Player.playerO.containsAll(4, 7) && emptyCells.contains(1))
  //     index = 1;
  //   else if (Player.playerO.containsAll(5, 8) && emptyCells.contains(2))
  //     index = 2;
  //   else if (Player.playerO.containsAll(4, 8) && emptyCells.contains(0))
  //     index = 0;
  //   else if (Player.playerO.containsAll(4, 6) && emptyCells.contains(2))
  //     index = 2;
  //   // start - center
  //   else if (Player.playerX.containsAll(0, 1) && emptyCells.contains(2))
  //     index = 2;
  //   else if (Player.playerX.containsAll(3, 4) && emptyCells.contains(5))
  //     index = 5;
  //   else if (Player.playerX.containsAll(6, 7) && emptyCells.contains(8))
  //     index = 8;
  //   else if (Player.playerX.containsAll(0, 3) && emptyCells.contains(6))
  //     index = 6;
  //   else if (Player.playerX.containsAll(1, 4) && emptyCells.contains(7))
  //     index = 7;
  //   else if (Player.playerX.containsAll(2, 5) && emptyCells.contains(8))
  //     index = 8;
  //   else if (Player.playerX.containsAll(0, 4) && emptyCells.contains(8))
  //     index = 8;
  //   else if (Player.playerX.containsAll(2, 4) && emptyCells.contains(6))
  //     index = 6;
  //   // start - end
  //   else if (Player.playerX.containsAll(0, 2) && emptyCells.contains(1))
  //     index = 1;
  //   else if (Player.playerX.containsAll(3, 5) && emptyCells.contains(4))
  //     index = 4;
  //   else if (Player.playerX.containsAll(6, 8) && emptyCells.contains(7))
  //     index = 7;
  //   else if (Player.playerX.containsAll(0, 6) && emptyCells.contains(3))
  //     index = 3;
  //   else if (Player.playerX.containsAll(1, 7) && emptyCells.contains(4))
  //     index = 4;
  //   else if (Player.playerX.containsAll(2, 8) && emptyCells.contains(5))
  //     index = 5;
  //   else if (Player.playerX.containsAll(0, 8) && emptyCells.contains(4))
  //     index = 4;
  //   else if (Player.playerX.containsAll(2, 6) && emptyCells.contains(4))
  //     index = 4;
  //   // center - end
  //   else if (Player.playerX.containsAll(1, 2) && emptyCells.contains(0))
  //     index = 0;
  //   else if (Player.playerX.containsAll(4, 5) && emptyCells.contains(3))
  //     index = 3;
  //   else if (Player.playerX.containsAll(7, 8) && emptyCells.contains(6))
  //     index = 6;
  //   else if (Player.playerX.containsAll(3, 6) && emptyCells.contains(0))
  //     index = 0;
  //   else if (Player.playerX.containsAll(4, 7) && emptyCells.contains(1))
  //     index = 1;
  //   else if (Player.playerX.containsAll(5, 8) && emptyCells.contains(2))
  //     index = 2;
  //   else if (Player.playerX.containsAll(4, 8) && emptyCells.contains(0))
  //     index = 0;
  //   else if (Player.playerX.containsAll(4, 6) && emptyCells.contains(2))
  //     index = 2;
  //   else {
  //     Random random = Random();
  //     index = random.nextInt(emptyCells.length);
  //   }

  //   playGame(index, activePlayer);
  // }
}
