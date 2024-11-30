import 'package:flutter/material.dart';
import 'dart:ui';

class CustomMessage extends StatelessWidget {
  final String message;
  final bool isPositive;

  const CustomMessage({
    Key? key,
    required this.message,
    required this.isPositive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 0,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isPositive
                    ? [Color(0xFFE0F2F1).withOpacity(0.9), Color(0xFFA7FFEB).withOpacity(0.9)]
                    : [Color(0xFFFFEBEE).withOpacity(0.9), Color(0xFFFFCDD2).withOpacity(0.9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: isPositive ? Color(0xFF4DB6AC) : Color(0xFFEF9A9A),
                width: 1.0,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _AnimatedIcon(isPositive: isPositive),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: isPositive ? Color(0xFF00695C) : Color(0xFFD32F2F),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: isPositive ? Color(0xFF00695C) : Color(0xFFD32F2F),
                    size: 18,
                  ),
                  onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void show({
    required BuildContext context,
    required String message,
    required bool isPositive,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomMessage(
          message: message,
          isPositive: isPositive,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}

class _AnimatedIcon extends StatefulWidget {
  final bool isPositive;

  const _AnimatedIcon({Key? key, required this.isPositive}) : super(key: key);

  @override
  _AnimatedIconState createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<_AnimatedIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Icon(
        widget.isPositive ? Icons.check : Icons.error_outline,
        color: widget.isPositive ? Color(0xFF00695C) : Color(0xFFD32F2F),
        size: 24.0,
      ),
    );
  }
}