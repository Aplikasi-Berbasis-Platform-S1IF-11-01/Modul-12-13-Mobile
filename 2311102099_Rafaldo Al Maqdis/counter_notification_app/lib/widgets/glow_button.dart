import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlowButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double size;

  const GlowButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.size = 80.0,
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    setState(() => _isPressed = true);
    await _animationController.forward();
    widget.onPressed();
    await _animationController.reverse();
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF0D0D0D),
            border: Border.all(
              color: Colors.white.withOpacity(0.7),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(_isPressed ? 0.25 : 0.15),
                blurRadius: _isPressed ? 30 : 20,
                spreadRadius: _isPressed ? 4 : 2,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.05),
                blurRadius: 60,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Center(
            child: Text(
              '+',
              style: GoogleFonts.inter(
                fontSize: 36,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
