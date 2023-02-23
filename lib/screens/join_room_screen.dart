import 'package:flutter/material.dart';
import 'package:mp_tictactoe/resources/socket_methods.dart';
import 'package:mp_tictactoe/responsive/responsive.dart';
import 'package:mp_tictactoe/widgets/custom_button.dart';
import 'package:mp_tictactoe/widgets/custom_text.dart';
import 'package:mp_tictactoe/widgets/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {

  static const routeName = '/join-room-screen';
  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayerStateListener(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _gameIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:  <Widget> [
              const CustomText(
                shadows: [
                  Shadow(
                      blurRadius: 40,
                      color: Colors.blue
                  )
                ],
                text: 'Join Room',
                fontSize: 70,
              ),
              SizedBox(height: size.height * 0.08,),
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter your nickname',

              ),
              const SizedBox(height: 20,),
              CustomTextField(
                controller: _gameIdController,
                hintText: 'Enter game id',

              ),
              SizedBox(height: size.height * 0.045,),
              CustomButton(onTap: () => _socketMethods.joinRoom(_nameController.text, _gameIdController.text ), text: 'Join'),
            ],
          ),
        ),
      ),
    );
  }
}
