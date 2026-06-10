import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CounterCard extends StatelessWidget {
  final int counterValue;

  const CounterCard({
    super.key,
    required this.counterValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF1A1A1A).withOpacity(0.85),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.04),
            blurRadius: 40,
            spreadRadius: -5,
            offset: const Offset(0, 0),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'COUNTER',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.35),
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 20),
          // Divider atas
          Container(
            height: 1,
            width: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          // Nilai Counter
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: Text(
              '$counterValue',
              key: ValueKey<int>(counterValue),
              style: GoogleFonts.inter(
                fontSize: 64,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1,
                shadows: [
                  Shadow(
                    color: Colors.white.withOpacity(0.15),
                    blurRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          // Divider bawah
          Container(
            height: 1,
            width: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'tap to increment',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.25),
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
