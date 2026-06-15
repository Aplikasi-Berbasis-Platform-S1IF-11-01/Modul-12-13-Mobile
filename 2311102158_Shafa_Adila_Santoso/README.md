<div align="center">
  <br />
  <h1>LAPORAN PRAKTIKUM <br>APLIKASI BERBASIS PLATFORM</h1>
  <br />
  <h3>MODUL 12-13 - Mobile <br> COUNTER APP  </h3>
  <br />
  <img src="assets\logo.jpeg" alt="Logo" width="300"> 
  <br />
  <br />
  <br />
  <h3>Disusun Oleh :</h3>
  <p>
    <strong>Shafa Adila Santoso</strong><br>
    <strong>2311102158</strong><br>
    <strong>IF-11-REG01</strong>
  </p>
  <br />
  <h3>Dosen Pengampu :</h3>
  <p>
    <strong>Dimas Fanny Hebrasianto Permadi, S.ST., M.Kom</strong>
  </p>
  <br />
  <br />
    <h4>Asisten Praktikum :</h4>
    <strong> Apri Pandu Wicaksono </strong> <br>
    <strong>Rangga Pradarrell Fathi</strong>
  <br />
  <h3>LABORATORIUM HIGH PERFORMANCE
 <br>FAKULTAS INFORMATIKA <br>UNIVERSITAS TELKOM PURWOKERTO <br>2026</h3>
</div>

---

# 1. Dasar Teori

## 1.1 Flutter

Flutter adalah framework open-source yang dibuat oleh Google untuk pengembangan aplikasi lintas platform menggunakan bahasa pemrograman Dart. Dengan Flutter, pengembang dapat membangun aplikasi Android, iOS, Web, maupun Desktop hanya dengan satu basis kode (*single codebase*). Framework ini mengadopsi konsep *widget* sebagai elemen utama dalam penyusunan antarmuka pengguna (*User Interface/UI*).

## 1.2 State Management

*State Management* merupakan mekanisme yang digunakan untuk mengatur dan mengelola data atau kondisi (*state*) dalam sebuah aplikasi. Nilai state dapat berubah akibat interaksi pengguna, seperti menekan tombol atau melakukan input data. Pengelolaan state yang baik akan membuat aplikasi lebih mudah dikembangkan, dipelihara, serta mampu merespons perubahan data secara efektif.

## 1.3 Provider

Provider merupakan salah satu pendekatan *state management* yang banyak digunakan dalam pengembangan aplikasi Flutter. Provider memanfaatkan class `ChangeNotifier` untuk menyimpan dan mengelola data aplikasi. Ketika terjadi perubahan pada data, method `notifyListeners()` akan dipanggil sehingga widget yang menggunakan data tersebut dapat memperbarui tampilannya secara otomatis.

Beberapa kelebihan Provider antara lain:

* Implementasinya sederhana dan mudah dipahami.
* Memiliki performa yang cukup baik untuk berbagai kebutuhan aplikasi.
* Membantu memisahkan logika aplikasi dari tampilan pengguna.
* Mendukung struktur kode yang lebih rapi dan terorganisir.

## 1.4 ChangeNotifier

`ChangeNotifier` merupakan class bawaan Flutter yang berfungsi untuk mengirimkan notifikasi ketika data mengalami perubahan. Class ini sering digunakan bersama Provider dalam proses pengelolaan state. Saat data diperbarui, method `notifyListeners()` akan dijalankan sehingga widget yang terhubung dapat melakukan *rebuild* dan menampilkan informasi terbaru.

## 1.5 Local Notification

*Local Notification* adalah notifikasi yang dihasilkan langsung oleh aplikasi tanpa memerlukan layanan atau server eksternal. Fitur ini umumnya digunakan untuk menyampaikan informasi, pengingat, maupun pemberitahuan tertentu kepada pengguna berdasarkan kondisi yang terjadi di dalam aplikasi.

Pada Flutter, implementasi notifikasi lokal dapat dilakukan menggunakan package `flutter_local_notifications`, yang mendukung berbagai platform seperti Android, iOS, Windows, Linux, dan macOS.

## 1.6 Flutter Local Notifications

`flutter_local_notifications` merupakan package Flutter yang menyediakan fitur pembuatan dan pengelolaan notifikasi lokal. Package ini memungkinkan pengembang mengatur berbagai komponen notifikasi, seperti judul, isi pesan, ikon, prioritas, suara, hingga penjadwalan notifikasi.

Pada praktikum ini, package tersebut dimanfaatkan untuk menampilkan notifikasi setiap kali nilai counter mengalami perubahan. Dengan demikian, pengguna dapat memperoleh informasi secara langsung mengenai nilai counter terbaru.

## 1.7 Counter Application

*Counter Application* merupakan aplikasi sederhana yang sering digunakan untuk mempelajari konsep dasar *state management* pada Flutter. Aplikasi ini memiliki nilai counter yang dapat bertambah melalui interaksi pengguna. Dalam implementasi praktikum ini, pengelolaan counter dilakukan menggunakan Provider, sedangkan setiap perubahan nilai counter akan memicu munculnya notifikasi lokal sebagai penerapan fitur *Local Notification*.

# 2. Struktur Project

Berikut merupakan struktur direktori yang digunakan pada aplikasi Counter App:

```text
counter_app/
├── lib/
│   ├── main.dart
│   ├── counter_provider.dart
│   └── notification_service.dart
├── android/app/src/main/
│   └── AndroidManifest.xml
├── pubspec.yaml
└── LAPORAN.md
```

## 2.1 main.dart

File `main.dart` berfungsi sebagai titik awal (*entry point*) aplikasi Flutter. File ini bertanggung jawab untuk menjalankan aplikasi, melakukan inisialisasi layanan notifikasi, serta menghubungkan Provider dengan widget-widget yang membutuhkan state. Selain itu, file ini juga memuat tampilan utama aplikasi.

## 2.2 counter_provider.dart

File `counter_provider.dart` berisi class `CounterProvider` yang digunakan untuk mengatur nilai counter menggunakan Provider. Class ini menyimpan data counter sekaligus menyediakan fungsi untuk menambah dan mengatur ulang nilai counter sesuai kebutuhan aplikasi.

## 2.3 notification_service.dart

File `notification_service.dart` digunakan untuk mengimplementasikan fitur notifikasi lokal melalui package `flutter_local_notifications`. File ini menangani proses inisialisasi layanan notifikasi dan bertugas menampilkan notifikasi ketika nilai counter mengalami perubahan.

## 2.4 AndroidManifest.xml

File `AndroidManifest.xml` berisi konfigurasi yang diperlukan oleh aplikasi Android. Salah satu fungsinya adalah mendefinisikan berbagai izin (*permission*) yang dibutuhkan aplikasi, termasuk izin untuk menampilkan notifikasi pada perangkat Android.

## 2.5 pubspec.yaml

File `pubspec.yaml` merupakan file konfigurasi utama dalam proyek Flutter yang digunakan untuk mendeklarasikan dependency atau package yang diperlukan selama proses pengembangan aplikasi, seperti `provider` dan `flutter_local_notifications`.

## 2.6 LAPORAN.md

File `LAPORAN.md` digunakan sebagai media dokumentasi praktikum yang berisi penjelasan implementasi program, hasil pengujian, serta pembahasan mengenai aplikasi yang telah dikembangkan.

# 3. Implementasi Program

## 3.1 Counter Provider

### Kode Program

```dart
import 'package:flutter/foundation.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void reset() {
    _counter = 0;
    notifyListeners();
  }
}
```

### Penjelasan

File `counter_provider.dart` digunakan untuk mengelola state counter menggunakan Provider. Class `CounterProvider` mewarisi (`extends`) `ChangeNotifier` sehingga dapat memberikan notifikasi kepada widget yang menggunakan data tersebut ketika terjadi perubahan.

Variabel `_counter` digunakan untuk menyimpan nilai counter secara private. Getter `counter` digunakan untuk mengakses nilai tersebut dari luar class. Method `increment()` berfungsi untuk menambah nilai counter sebanyak satu, sedangkan method `reset()` digunakan untuk mengembalikan nilai counter menjadi nol. Setelah terjadi perubahan nilai, method `notifyListeners()` dipanggil agar seluruh widget yang mendengarkan perubahan state dapat melakukan pembaruan tampilan secara otomatis.

---

## 3.2 Main Program dan User Interface

### Kode Program

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter_provider.dart';
import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();

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
      title: 'Sweet Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFC1CC),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const SweetCounterPage(),
    );
  }
}

class SweetCounterPage extends StatelessWidget {
  const SweetCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterProvider>().counter;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Sweet Counter 💖',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                size: 80,
                color: Colors.pink.shade300,
              ),

              const SizedBox(height: 20),

              const Text(
                'Jumlah Love',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.pink,
                ),
              ),

              const SizedBox(height: 20),

              Card(
                elevation: 10,
                shadowColor: Colors.pink.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Container(
                  width: 220,
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$counter',
                        style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: () async {
                  context.read<CounterProvider>().increment();

                  final value =
                      context.read<CounterProvider>().counter;

                  await NotificationService()
                      .showCounterNotification(value);
                },
                icon: const Icon(Icons.favorite),
                label: const Text(
                  'Tambah Love',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade300,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              OutlinedButton.icon(
                onPressed: () {
                  context.read<CounterProvider>().reset();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.pink,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Tekan tombol untuk menambah jumlah love dan melihat notifikasi 💕',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
### Penjelasan

File `main.dart` merupakan titik awal eksekusi aplikasi Flutter. Pada fungsi `main()`, aplikasi terlebih dahulu melakukan inisialisasi layanan notifikasi melalui `NotificationService().init()`. Setelah proses inisialisasi selesai, aplikasi dijalankan menggunakan `ChangeNotifierProvider` yang menyediakan objek `CounterProvider` agar dapat diakses oleh seluruh widget yang membutuhkan data counter.

Class `MyApp` berfungsi sebagai konfigurasi utama aplikasi, termasuk pengaturan tema, warna, serta halaman pertama yang ditampilkan kepada pengguna. Aplikasi menggunakan Material 3 dengan dominasi warna pink pastel sehingga memberikan tampilan yang lebih menarik dan modern.

Class `SweetCounterPage` merupakan halaman utama aplikasi yang menampilkan jumlah love kepada pengguna. Nilai counter diperoleh melalui `context.watch<CounterProvider>()`, sehingga setiap perubahan data akan langsung diperbarui pada tampilan tanpa perlu melakukan refresh secara manual.

Aplikasi menyediakan tombol **Tambah Love** yang digunakan untuk menambah jumlah love. Ketika tombol ditekan, method `increment()` akan dijalankan untuk meningkatkan nilai counter, kemudian aplikasi akan memanggil layanan notifikasi untuk menampilkan informasi jumlah love terbaru kepada pengguna.

Selain itu, tersedia tombol **Reset** yang berfungsi mengembalikan nilai counter ke nilai awal. Pada bagian bawah halaman juga terdapat informasi bahwa notifikasi akan muncul setiap kali jumlah love bertambah.

---

## 3.3 Notification Service

### Kode Program

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(initSettings);

    // Request permission (Android 13+)
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showCounterNotification(int counterValue) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'counter_channel',       // channel id
      'Counter Notifications', // channel name
      channelDescription: 'Notifikasi setiap counter bertambah',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'counter',
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _plugin.show(
  0,
  'Love Bertambah',
  'Jumlah love sekarang: $counterValue',
  details,
);
  }
}
```

### Penjelasan

File `notification_service.dart` digunakan untuk mengelola seluruh fitur notifikasi lokal yang terdapat pada aplikasi. Class `NotificationService` menerapkan pola Singleton sehingga hanya terdapat satu objek layanan notifikasi yang digunakan selama aplikasi berjalan.

Method `init()` berfungsi untuk melakukan konfigurasi awal plugin notifikasi pada platform Android dan iOS. Pada perangkat Android, aplikasi menggunakan ikon launcher sebagai ikon notifikasi. Selain itu, aplikasi juga meminta izin kepada pengguna untuk menampilkan notifikasi, khususnya pada perangkat Android 13 ke atas melalui method `requestNotificationsPermission()`.

Method `showCounterNotification()` digunakan untuk menampilkan notifikasi setiap kali jumlah love bertambah. Notifikasi menggunakan channel dengan ID `counter_channel` dan nama `Counter Notifications`. Pesan yang ditampilkan berisi informasi jumlah love terbaru sehingga pengguna dapat mengetahui perubahan nilai yang terjadi pada aplikasi.

ID notifikasi yang digunakan adalah `0`, sehingga setiap notifikasi baru akan menggantikan notifikasi sebelumnya. Dengan cara ini, panel notifikasi tetap terlihat rapi dan tidak dipenuhi oleh notifikasi yang menumpuk.

## 3.4 Konfigurasi AndroidManifest.xml

### Kode Program

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- Permission untuk Local Notification (Android 13+) -->
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
    <uses-permission android:name="android.permission.VIBRATE" />

    <application
        android:label="counter_provider_app"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>

        <!-- flutter_local_notifications -->
        <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
        <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED"/>
                <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
                <action android:name="android.intent.action.QUICKBOOT_POWERON" />
                <category android:name="android.intent.category.DEFAULT" />
            </intent-filter>
        </receiver>

        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <!-- Required to query activities that can process text, see:
         https://developer.android.com/training/package-visibility and
         https://developer.android.com/reference/android/content/Intent#ACTION_PROCESS_TEXT.
         In particular, this is used by the Flutter engine in io.flutter.plugin.text.ProcessTextPlugin. -->
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>
```

### Penjelasan

File `AndroidManifest.xml` digunakan untuk mengatur konfigurasi aplikasi pada platform Android. Pada aplikasi ini ditambahkan beberapa permission yang diperlukan untuk mendukung fitur Local Notification.

Permission `POST_NOTIFICATIONS` digunakan agar aplikasi dapat menampilkan notifikasi pada perangkat Android 13 ke atas. Permission `VIBRATE` memungkinkan notifikasi memberikan getaran ketika muncul, sedangkan `RECEIVE_BOOT_COMPLETED` digunakan agar layanan notifikasi tetap dapat berjalan setelah perangkat selesai melakukan proses booting atau restart.

Selain itu, ditambahkan konfigurasi receiver dari package `flutter_local_notifications`. Receiver tersebut berfungsi untuk menerima dan mengelola notifikasi yang dijadwalkan serta memastikan notifikasi tetap dapat diproses setelah perangkat dinyalakan kembali. Dengan konfigurasi ini, fitur notifikasi dapat berjalan dengan baik pada sistem operasi Android.

---

## 3.5 Konfigurasi Dependency pada pubspec.yaml

### Kode Program

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  flutter_local_notifications: ^17.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

### Penjelasan

File `pubspec.yaml` merupakan file konfigurasi utama pada proyek Flutter yang digunakan untuk mengelola dependency atau package yang dibutuhkan aplikasi.

Package `provider` digunakan sebagai solusi state management untuk mengelola perubahan data counter secara efisien. Dengan Provider, data counter dapat diakses dan diperbarui oleh widget yang membutuhkan tanpa harus mengirim data secara manual antar widget.

Package `flutter_local_notifications` digunakan untuk mengimplementasikan fitur notifikasi lokal pada aplikasi. Package ini memungkinkan aplikasi menampilkan notifikasi secara langsung pada perangkat Android maupun iOS tanpa memerlukan server eksternal.

Selain itu, terdapat package `flutter_test` yang digunakan untuk kebutuhan pengujian aplikasi Flutter, serta `flutter_lints` yang berfungsi membantu menjaga kualitas kode melalui aturan penulisan kode (*coding standards*) yang direkomendasikan oleh Flutter.

Konfigurasi dependency tersebut diunduh dan dipasang ke dalam proyek menggunakan perintah:

```bash
flutter pub get
```

Perintah tersebut akan mengambil seluruh package yang terdaftar pada file `pubspec.yaml` sehingga dapat digunakan dalam pengembangan aplikasi.

# 4. Hasil dan Pembahasan

## 4.1 Hasil Implementasi

Setelah aplikasi berhasil dijalankan menggunakan Flutter, diperoleh tampilan antarmuka berupa aplikasi **Sweet Counter** yang mengimplementasikan state management menggunakan Provider serta fitur Local Notification melalui package `flutter_local_notifications`.

Pada halaman utama ditampilkan jumlah love yang tersimpan dalam state aplikasi. Nilai tersebut ditampilkan pada sebuah card dengan desain bertema pink pastel yang dilengkapi ikon hati. Selain itu, aplikasi menyediakan tombol **Tambah Love** untuk menambah jumlah love serta tombol **Reset** untuk mengembalikan nilai ke kondisi awal.

<img src="assets\hasil.png" alt="Logo" width="700"> 

Gambar di atas menunjukkan tampilan aplikasi Sweet Counter beserta notifikasi yang muncul ketika jumlah love bertambah.

## 4.2 Pembahasan

Berdasarkan hasil pengujian, aplikasi berhasil menjalankan fungsi state management menggunakan Provider dengan baik. Ketika tombol **Tambah Love** ditekan, nilai counter bertambah secara bertahap sesuai jumlah interaksi yang dilakukan pengguna. Pada hasil pengujian terlihat bahwa jumlah love berhasil bertambah dan ditampilkan secara langsung pada antarmuka aplikasi.

Perubahan nilai tersebut dapat terjadi secara real-time karena `CounterProvider` memanfaatkan `ChangeNotifier` dan method `notifyListeners()`. Setiap kali data berubah, widget yang menggunakan state tersebut akan melakukan rebuild secara otomatis sehingga tampilan selalu menampilkan data terbaru.

Selain memperbarui tampilan aplikasi, sistem juga berhasil menampilkan notifikasi lokal setiap kali pengguna menekan tombol **Tambah Love**. Notifikasi yang muncul berisi informasi jumlah love terbaru sehingga pengguna dapat mengetahui perubahan nilai tanpa harus memperhatikan tampilan utama aplikasi.

Implementasi Provider dan Local Notification berjalan secara terintegrasi. Saat tombol ditekan, Provider bertugas memperbarui state aplikasi, sedangkan Notification Service bertanggung jawab menampilkan notifikasi yang berisi informasi hasil perubahan data tersebut.

Secara keseluruhan, aplikasi Sweet Counter telah berhasil menerapkan konsep state management menggunakan Provider serta fitur Local Notification. Kedua fitur tersebut bekerja dengan baik dan mampu memberikan pengalaman pengguna yang lebih interaktif melalui pembaruan data secara langsung dan pemberitahuan melalui notifikasi.
