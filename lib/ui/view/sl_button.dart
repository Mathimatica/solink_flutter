import 'package:flutter/material.dart';

class SLButton extends StatelessWidget {
  final VoidCallback onClick;
  const SLButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Ink(
        decoration: const ShapeDecoration(
          color: Colors.lightBlue,
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            onClick();
          },
        ),
      ),
    );
  }
}
