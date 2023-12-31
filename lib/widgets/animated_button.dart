import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';


class AnimatedButton extends StatelessWidget {
  const AnimatedButton({
    Key? key,
    required RiveAnimationController buttonAnimationController, required this.press,
  }) : _buttonAnimationController = buttonAnimationController, super(key: key);

  final RiveAnimationController _buttonAnimationController;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
          height: 64,
          width: 260,
          child: Stack(
            children: [
              RiveAnimation.asset('assets/RiveAssets/button.riv',
                controllers: [_buttonAnimationController],),
              Positioned.fill(
                top: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(CupertinoIcons.arrow_right),
                    SizedBox(width: 10,),
                    Text('Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}