import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  late SMITrigger check;
  late SMITrigger reset;
  late SMITrigger error;
  late SMITrigger confetti;
  bool isLoadingShown = false;
  bool isConfettiShown = false;

  StateMachineController? getRiveController(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    return controller;
  }

  void signIn(BuildContext context) {
    setState(() {
      isLoadingShown = true;
      isConfettiShown = true;
    });
    Future.delayed(
      const Duration(seconds: 1),
          () {
        if (_formKey.currentState!.validate()) {
          check.fire();
          Future.delayed(
            const Duration(seconds: 2),
                () {
              setState(() {
                isLoadingShown = false;
              });
              confetti.fire();
            },
          );
        } else {
          // or error animation
          error.fire();
          Future.delayed(
            const Duration(seconds: 2),
                () {
              setState(() {
                isLoadingShown = false;
              });
            },
          );
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Email",
                  style: TextStyle(color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextFormField(
                    onSaved: (email) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SvgPicture.asset("assets/icons/email.svg"),
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Password",
                  style: TextStyle(color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    onSaved: (password) {},
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SvgPicture.asset("assets/icons/password.svg"),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      signIn(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF77D8E),
                      minimumSize: const Size(double.infinity, 56),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                      ),
                    ),
                    icon: const Icon(
                      CupertinoIcons.arrow_right,
                      color: Color(0xFFFE0037),
                    ),
                    label: const Text("Sign In"),
                  ),
                ),
              ],
            )),
        isLoadingShown
            ? CustomPositioned(
                child: RiveAnimation.asset(
                  'assets/RiveAssets/check.riv',
                  onInit: (artboard) {
                    final controller = getRiveController(artboard);
                    check = controller!.findSMI('Check') as SMITrigger;
                    reset = controller!.findSMI('Reset') as SMITrigger;
                    error = controller!.findSMI('Error') as SMITrigger;
                  },
                ),
              )
            : const SizedBox(),
        isConfettiShown ? CustomPositioned(
          child: Transform.scale(
            scale: 8,
            child: RiveAnimation.asset(
              'assets/RiveAssets/confetti.riv',
              onInit: (artboard) {
                final controller = getRiveController(artboard);
                confetti =
                    controller!.findSMI('Trigger explosion') as SMITrigger;
              },
            ),
          ),
        ) : const SizedBox()
      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, required this.child, this.size = 100});

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
