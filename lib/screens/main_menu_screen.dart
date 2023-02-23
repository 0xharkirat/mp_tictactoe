import 'package:flutter/material.dart';
import 'package:mp_tictactoe/responsive/responsive.dart';
import 'package:mp_tictactoe/screens/create_room_screen.dart';
import 'package:mp_tictactoe/screens/join_room_screen.dart';
import 'package:mp_tictactoe/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static const routeName = "/main-menu";
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            CustomButton(
              onTap: (){
                Navigator.pushNamed(context, CreateRoomScreen.routeName);
              },
              text: 'Create Room',
            ),
            const SizedBox(height: 20.0,),
            CustomButton(
              onTap: (){
                Navigator.pushNamed(context, JoinRoomScreen.routeName);
              },
              text: 'Join Room',
            )

          ],
        ),
      )
    );
  }
}
