import 'package:flutter/material.dart';
import 'package:xo_game/constant.dart';
import 'package:xo_game/feature/home/presentation/views/game_screen_view.dart';
import 'package:xo_game/feature/home/presentation/widgets/custom_button.dart';
import 'package:xo_game/feature/home/presentation/widgets/custom_text_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController player1 = TextEditingController();
final TextEditingController player2 = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(Style.kbackGroundColor),
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter Players Name",
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xffFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
              ),
              const SizedBox(
                height: 80,
              ),
              CustomTextForm(hintText: "player1", player: player1),
              const SizedBox(
                height: 30,
              ),
              CustomTextForm(hintText: "player2", player: player2),
              const SizedBox(
                height: 62,
              ),
              CustmoButton(
                btnText: "Start Game",
                color: const Color((Style.KbtnColor)),
                callback: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameScreen(
                                  player1: player1.text,
                                  player2: player2.text,
                                )));
                  }
                },
              )
            ],
          )),
    );
  }
}
