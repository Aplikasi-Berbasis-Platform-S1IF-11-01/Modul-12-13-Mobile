import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';
import '../services/notification_service.dart';
import '../widgets/counter_card.dart';
import '../widgets/glow_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _onIncrement(BuildContext context) async {
    final provider = context.read<CounterProvider>();
    provider.incrementCounter();

    // Tampilkan notifikasi lokal
    await NotificationService().showCounterNotification(provider.counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D0D0D),
              Color(0xFF1A1A1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── App Bar ──
              _buildAppBar(),

              // ── Body ──
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Subtitle
                    Text(
                      'State Management + Local Notification',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.25),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Counter Card
                    Consumer<CounterProvider>(
                      builder: (context, counterProvider, _) {
                        return CounterCard(
                          counterValue: counterProvider.counter,
                        );
                      },
                    ),

                    const SizedBox(height: 56),

                    // Increment Button
                    GlowButton(
                      onPressed: () => _onIncrement(context),
                      size: 80,
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'INCREMENT',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.2),
                        letterSpacing: 3,
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Reset hint
                    Consumer<CounterProvider>(
                      builder: (context, counterProvider, _) {
                        if (counterProvider.counter == 0) {
                          return const SizedBox.shrink();
                        }
                        return GestureDetector(
                          onTap: () =>
                              context.read<CounterProvider>().resetCounter(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.08),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'RESET',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.25),
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // ── Footer ──
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Counter',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'Notification App',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.35),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          // Status indicator
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 24,
            height: 1,
            color: Colors.white.withOpacity(0.1),
          ),
          const SizedBox(width: 12),
          Text(
            'Provider  ·  flutter_local_notifications',
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.18),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 24,
            height: 1,
            color: Colors.white.withOpacity(0.1),
          ),
        ],
      ),
    );
  }
}
