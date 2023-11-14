import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    required this.imageUrl,
  });

  final String imageUrl;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black, //.withOpacity(0.1),
      ),
      child: Stack(
        children: [
          //Blur Effect
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 1000.0, sigmaY: 1000.0),
              child: Container(
                color: Colors.black.withOpacity(0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          //Gradient Effect
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withOpacity(0.20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.15),
                  Colors.white.withOpacity(0.05),
                ],
              ),
            ),
          ),
          //Child
          child
        ],
      ),
    );
  }
}
