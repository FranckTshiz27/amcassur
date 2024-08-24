import 'package:flutter/material.dart';

class AmcLoader extends StatelessWidget {
  const AmcLoader({super.key, required Color color});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
