import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_provider.dart';
import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();
  await NotificationService.requestPermission();

  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider =
        Provider.of<CounterProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Counter App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF800020),
              Color(0xFFB22222),
            ],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              children: [
                const SizedBox(height: 30),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),

                  decoration: BoxDecoration(
                    color:
                        Colors.white.withOpacity(0.15),

                    borderRadius:
                        BorderRadius.circular(30),

                    border: Border.all(
                      color:
                          Colors.white.withOpacity(
                        0.3,
                      ),
                    ),
                  ),

                  child: Column(
                    children: [
                      const Icon(
                        Icons.bar_chart_rounded,
                        size: 60,
                        color: Colors.white,
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Current Counter",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "${counterProvider.counter}",
                        style: const TextStyle(
                          fontSize: 90,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 60,

                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.add_circle_outline,
                    ),

                    label: const Text(
                      "Tambah Counter",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.white,
                      foregroundColor:
                          const Color(
                        0xFF800020,
                      ),
                      elevation: 10,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                      ),
                    ),

                    onPressed: () async {
                      counterProvider.increment();

                      await NotificationService
                          .showNotification(
                        counterProvider.counter,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: OutlinedButton.icon(
                    icon: const Icon(
                      Icons.restart_alt,
                    ),

                    label: const Text(
                      "Reset Counter",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    style:
                        OutlinedButton.styleFrom(
                      foregroundColor:
                          Colors.white,

                      side: BorderSide(
                        color:
                            Colors.white.withOpacity(
                          0.7,
                        ),
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                      ),
                    ),

                    onPressed: () async {
                      final confirm =
                          await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Reset Counter",
                            ),
                            content:
                                const Text(
                              "Yakin ingin mengembalikan counter ke 0?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    false,
                                  );
                                },
                                child:
                                    const Text(
                                  "Batal",
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    true,
                                  );
                                },
                                child:
                                    const Text(
                                  "Reset",
                                ),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirm == true) {
                        counterProvider.reset();

                        await NotificationService
                            .showResetNotification();
                      }
                    },
                  ),
                ),

                const Spacer(),

                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color:
                        Colors.white.withOpacity(
                      0.15,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                    border: Border.all(
                      color:
                          Colors.white.withOpacity(
                        0.3,
                      ),
                    ),
                  ),

                  child: const Column(
                    children: [
                      Text(
                        "Naufal Luthfi Assary",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        "2311102125",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        "Praktikum Modul 12 & 13 - Implementasi Provider dan Notifikasi pada Flutter",
                        textAlign:
                            TextAlign.center,
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}