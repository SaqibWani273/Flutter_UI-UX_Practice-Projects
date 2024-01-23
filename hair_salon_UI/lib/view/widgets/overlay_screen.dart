import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return

        // Floating loading bar
        Positioned.fill(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Center(
        child: Container(
          color: Colors.black.withOpacity(0.8),
          child: Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
                //      Theme.of(context).colorScheme.primary
              ),
            ),
          ),
        ),
      ),
    );
  }
}
