import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:xogame/constant.dart';
import 'package:xogame/features/home/views/home_screen_view.dart';
import 'package:xogame/features/home/views/widgets/custom_button.dart';

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
              ? widget.player1 + " won "
              : _winner == "O"
                  ? widget.player2 + " won  "
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
      backgroundColor: const Color(Style.kbackGroundColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            SizedBox(
              height: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
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
                                ? const Color(0xFFE25041)
                                : const Color(0xFF1C8D9E)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 67, 65, 65),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(15),
              child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () => _makeMove(row, col),
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: const Color(0xff191616),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          _board[row][col],
                          style: TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                            color: _board[row][col] == "X"
                                ? const Color(0xFFE25041)
                                : const Color(0xFF1C8D9E),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustmoButton(
                    btnText: "Reset Game",
                    color: const Color(Style.KbtnColorgreen),
                    callback: () => _resetGame(),
                  ),
                  CustmoButton(
                    btnText: "Restart Game",
                    color: const Color(Style.KbtnColorred),
                    callback: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                      widget.player1 = "";
                      widget.player2 = "";
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
