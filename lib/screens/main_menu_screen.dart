import 'package:flutter/material.dart';
import 'package:mp_tictactoe/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          CustomButton(
            onTap: (){},
            text: 'Create Room',
          ),
          const SizedBox(height: 20.0,),
          CustomButton(
            onTap: (){},
            text: 'Join Room',
          )

        ],
      )
    );
  }
}
