import 'dart:ffi';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key, required this.player1, required this.player2});
  String player1;
  String player2;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameover;

  @override
  Void? initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (index) => ""));
    _currentPlayer = "X";
    _winner = "";
    _gameover = false;
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (index) => ""));
      _currentPlayer = "X";
      _winner = "";
      _gameover = false;
    });
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] != "" || _gameover) {
      return;
    }
    setState(() {
      _board[row][col] = _currentPlayer;
      //check for a winner
      if (_board[row][0] == _currentPlayer &&
          _board[row][1] == _currentPlayer &&
          _board[row][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameover = true;
      } else if (_board[0][col] == _currentPlayer &&
          _board[1][col] == _currentPlayer &&
          _board[2][col] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameover = true;
      } else if (_board[0][0] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameover = true;
      } else if (_board[0][2] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][0] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameover = true;
      }
      //switch players
      _currentPlayer = _currentPlayer == "X" ? "O" : "X";
      //check for tie
      if (!_board.any((row) => row.any((cell) => cell == ""))) {
        _gameover = true;
        _winner = "it's a tie";
      }
      if (_winner != "") {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          btnOkText: "Play Again",
          title: _winner == "X"
              ? widget.player1 + "won !"
              : _winner == "O"
                  ? widget.player2 + "won! "
                  : "It's a tie",
          btnOkOnPress: () {
            _resetGame();
          },
        )..show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Style.kbackGroundColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            SizedBox(
              height: 120,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Turn: ",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        _currentPlayer == "X"
                            ? widget.player1 + " ($_currentPlayer)"
                            : widget.player2 + " ($_currentPlayer)",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: _currentPlayer == "X"
                                ? Color(0xFFE25041)
                                : Color(0xFF1C8D9E)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(5),
              child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () => _makeMove(row, col),
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          _board[row][col],
                          style: TextStyle(
                            fontSize: 120,
                            fontWeight: FontWeight.bold,
                            color: _board[row][col] == "X"
                                ? Color(0xFFE25041)
                                : Color(0xFF1C8D9E),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
