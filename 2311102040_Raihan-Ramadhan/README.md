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
    <strong>Raihan Ramadhan</strong><br>
    <strong>2311102040</strong><br>
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

Flutter merupakan framework open-source yang dikembangkan oleh Google untuk membangun aplikasi multiplatform menggunakan bahasa pemrograman Dart. Flutter memungkinkan pengembang membuat aplikasi Android, iOS, Web, dan Desktop dari satu basis kode (*single codebase*). Flutter menggunakan konsep *widget* sebagai komponen utama dalam membangun antarmuka pengguna (*User Interface/UI*).

## 1.2 State Management

*State Management* adalah teknik untuk mengelola data atau keadaan (*state*) dalam sebuah aplikasi. State dapat berubah akibat interaksi pengguna, seperti menekan tombol atau memasukkan data. Pengelolaan state yang baik membuat aplikasi lebih terstruktur, mudah dipelihara, dan responsif terhadap perubahan data.

## 1.3 Provider

Provider merupakan salah satu metode *state management* yang populer pada Flutter. Provider bekerja dengan memanfaatkan class `ChangeNotifier` untuk menyimpan dan mengelola state aplikasi. Ketika terjadi perubahan data, method `notifyListeners()` akan memberi tahu widget yang menggunakan state tersebut sehingga tampilan dapat diperbarui secara otomatis tanpa perlu melakukan *refresh* secara manual.

Keunggulan Provider antara lain:

* Mudah digunakan dan dipahami.
* Memiliki performa yang baik.
* Memisahkan logika bisnis dari tampilan (*UI*).
* Mendukung arsitektur aplikasi yang lebih terstruktur.

## 1.4 ChangeNotifier

`ChangeNotifier` adalah class bawaan Flutter yang digunakan untuk memberikan notifikasi ketika terjadi perubahan data. Class ini sering digunakan bersama Provider. Saat data berubah, method `notifyListeners()` dipanggil sehingga widget yang mendengarkan perubahan tersebut akan melakukan *rebuild* dan menampilkan data terbaru.

## 1.5 Local Notification

*Local Notification* adalah notifikasi yang dibuat dan ditampilkan langsung oleh aplikasi tanpa memerlukan server eksternal. Notifikasi lokal dapat digunakan untuk memberikan informasi, pengingat, atau pemberitahuan kepada pengguna berdasarkan kondisi tertentu dalam aplikasi.

Pada Flutter, implementasi *Local Notification* dapat dilakukan menggunakan package `flutter_local_notifications`. Package ini menyediakan fitur untuk menampilkan notifikasi pada berbagai platform seperti Android, iOS, Windows, Linux, dan macOS.

## 1.6 Flutter Local Notifications

`flutter_local_notifications` merupakan package Flutter yang digunakan untuk membuat dan mengelola notifikasi lokal. Package ini mendukung berbagai konfigurasi seperti judul notifikasi, isi pesan, prioritas, suara, ikon, serta penjadwalan notifikasi.

Pada praktikum ini, package tersebut digunakan untuk menampilkan notifikasi setiap kali nilai counter bertambah. Notifikasi akan menampilkan informasi nilai counter terbaru sehingga pengguna dapat mengetahui perubahan yang terjadi pada aplikasi.

## 1.7 Counter Application

*Counter Application* merupakan aplikasi sederhana yang digunakan untuk mempelajari konsep dasar *state management* pada Flutter. Aplikasi ini memiliki sebuah nilai counter yang dapat bertambah ketika pengguna menekan tombol tertentu. Pada praktikum ini, nilai counter dikelola menggunakan Provider dan setiap perubahan nilai counter akan memicu munculnya notifikasi lokal sebagai bentuk implementasi fitur *Local Notification*.

# 2. Struktur Project

Struktur folder pada aplikasi Counter App adalah sebagai berikut:

```text
counter_app/
├── lib/
│   ├── main.dart                 ← UI + setup Provider
│   ├── counter_provider.dart     ← State management
│   └── notification_service.dart ← Local notification
├── android/app/src/main/
│   └── AndroidManifest.xml       ← Permission notifikasi
├── pubspec.yaml                  ← Dependencies
└── LAPORAN.md                    ← Laporan singkat
```

## 2.1 main.dart

File `main.dart` merupakan *entry point* aplikasi Flutter yang bertugas menjalankan aplikasi, menginisialisasi layanan notifikasi, serta menghubungkan Provider dengan seluruh widget dalam aplikasi. Selain itu, file ini juga berisi tampilan utama (*User Interface*) dari Counter App.

## 2.2 counter_provider.dart

File `counter_provider.dart` berisi class `CounterProvider` yang digunakan untuk mengelola state counter menggunakan Provider. Class ini menyimpan nilai counter dan menyediakan fungsi untuk menambah maupun mengatur ulang nilai counter.

## 2.3 notification_service.dart

File `notification_service.dart` berisi implementasi layanan notifikasi lokal menggunakan package `flutter_local_notifications`. File ini bertanggung jawab untuk melakukan inisialisasi notifikasi serta menampilkan notifikasi ketika nilai counter berubah.

## 2.4 AndroidManifest.xml

File `AndroidManifest.xml` digunakan untuk mengatur konfigurasi aplikasi Android, termasuk pemberian izin (*permission*) yang diperlukan agar aplikasi dapat menampilkan notifikasi pada perangkat Android.

## 2.5 pubspec.yaml

File `pubspec.yaml` merupakan file konfigurasi utama Flutter yang digunakan untuk mendefinisikan dependency atau package yang dibutuhkan aplikasi, seperti `provider` dan `flutter_local_notifications`.

## 2.6 LAPORAN.md

File `LAPORAN.md` digunakan untuk mendokumentasikan hasil praktikum, penjelasan implementasi program, serta hasil pengujian aplikasi yang telah dibuat.

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
      title: 'Counter Provider App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterProvider>().counter;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: const Text(
          'Counter App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Counter',
            onPressed: () {
              context.read<CounterProvider>().reset();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Label
            Text(
              'Nilai Counter',
              style: TextStyle(
                fontSize: 22,
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),

            // Counter display
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primaryContainer,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '$counter',
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            // Tombol Tambah
            ElevatedButton.icon(
              onPressed: () async {
                context.read<CounterProvider>().increment();
                final newValue = context.read<CounterProvider>().counter;
                await NotificationService().showCounterNotification(newValue);
              },
              icon: const Icon(Icons.add, size: 28),
              label: const Text(
                'Tambah (+)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
            ),

            const SizedBox(height: 24),

            // Info notifikasi
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.notifications_active,
                      color: colorScheme.secondary, size: 20),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Notifikasi akan muncul setiap kali counter bertambah',
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSecondaryContainer,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```
### Penjelasan

File `main.dart` merupakan entry point aplikasi Flutter. Pada fungsi `main()`, aplikasi terlebih dahulu melakukan inisialisasi notifikasi menggunakan `NotificationService().init()`. Setelah itu aplikasi dijalankan dengan `ChangeNotifierProvider` yang menyediakan objek `CounterProvider` ke seluruh widget yang berada di dalam aplikasi.

Class `MyApp` berfungsi sebagai konfigurasi utama aplikasi yang mengatur tema, warna, dan halaman awal aplikasi. Tema menggunakan Material 3 dengan warna utama ungu (`Color(0xFF6750A4)`).

Class `CounterPage` merupakan halaman utama aplikasi yang menampilkan nilai counter dan berbagai komponen antarmuka pengguna. Nilai counter diperoleh melalui `context.watch<CounterProvider>()`, sehingga tampilan akan diperbarui secara otomatis ketika nilai counter berubah.

Aplikasi menyediakan tombol **Tambah (+)** yang berfungsi untuk meningkatkan nilai counter. Ketika tombol ditekan, method `increment()` dari `CounterProvider` akan dipanggil, kemudian aplikasi akan menampilkan notifikasi yang berisi nilai counter terbaru melalui `NotificationService().showCounterNotification()`.

Selain itu terdapat tombol **Reset** pada AppBar yang digunakan untuk mengembalikan nilai counter menjadi nol. Tampilan aplikasi juga dilengkapi informasi bahwa notifikasi akan muncul setiap kali nilai counter bertambah.

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

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showCounterNotification(int counterValue) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'counter_channel',
      'Counter Notifications',
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
      'Counter Update',
      'Nilai counter saat ini: $counterValue',
      details,
    );
  }
}
```

### Penjelasan

File `notification_service.dart` digunakan untuk mengelola seluruh fungsi notifikasi lokal pada aplikasi. Class `NotificationService` menerapkan pola Singleton sehingga hanya terdapat satu instance yang digunakan selama aplikasi berjalan.

Method `init()` bertugas melakukan inisialisasi plugin notifikasi untuk Android dan iOS. Pada Android, aplikasi menggunakan ikon launcher sebagai ikon notifikasi. Selain itu, aplikasi juga meminta izin notifikasi untuk perangkat Android 13 ke atas melalui `requestNotificationsPermission()`.

Method `showCounterNotification()` digunakan untuk menampilkan notifikasi setiap kali nilai counter berubah. Notifikasi menggunakan channel dengan ID `counter_channel` dan nama `Counter Notifications`. Pesan notifikasi menampilkan nilai counter terbaru dengan format *"Nilai counter saat ini: X"*.

ID notifikasi yang digunakan adalah `0`, sehingga notifikasi baru akan menggantikan notifikasi sebelumnya dan tidak menumpuk pada panel notifikasi perangkat.

## 3.4 Konfigurasi AndroidManifest.xml

### Kode Program

```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.VIBRATE"/>
```

```xml
<receiver
    android:exported="false"
    android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />

<receiver
    android:exported="false"
    android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">

    <intent-filter>
        <action android:name="android.intent.action.BOOT_COMPLETED"/>
        <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
        <action android:name="android.intent.action.QUICKBOOT_POWERON"/>
        <category android:name="android.intent.category.DEFAULT"/>
    </intent-filter>

</receiver>
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
<img src="assets\hasil.png" alt="Logo" width="700"> 

## 4.1 Hasil Implementasi

Setelah aplikasi berhasil dijalankan menggunakan Flutter, diperoleh tampilan antarmuka berupa aplikasi Counter App yang menerapkan state management menggunakan Provider dan fitur Local Notification menggunakan package `flutter_local_notifications`.

Pada tampilan utama aplikasi terdapat informasi nilai counter yang ditampilkan di dalam komponen berbentuk lingkaran. Selain itu tersedia tombol **Tambah (+)** untuk menambahkan nilai counter dan tombol **Reset** pada AppBar untuk mengembalikan nilai counter ke nilai awal.

**Gambar 4.1 Tampilan Counter App dan Notifikasi**

*(Masukkan screenshot hasil running aplikasi di sini)*

## 4.2 Pembahasan

Berdasarkan hasil pengujian, aplikasi berhasil menampilkan nilai counter yang dikelola menggunakan Provider. Pada saat tombol **Tambah (+)** ditekan, nilai counter bertambah dari 0 menjadi 1, kemudian menjadi 2, dan seterusnya. Pada gambar terlihat bahwa nilai counter telah mencapai angka **3**, yang menunjukkan bahwa fungsi `increment()` berjalan dengan baik.

Perubahan nilai counter terjadi secara real-time tanpa perlu melakukan refresh halaman. Hal ini karena `CounterProvider` menggunakan `ChangeNotifier` dan method `notifyListeners()` yang secara otomatis memberitahu widget untuk melakukan rebuild ketika data berubah.

Selain pembaruan tampilan, aplikasi juga berhasil menampilkan notifikasi lokal setiap kali nilai counter bertambah. Pada gambar terlihat notifikasi dengan judul **"Counter Bertambah"** dan isi pesan **"Nilai counter sekarang: 3"**. Notifikasi tersebut muncul setelah fungsi `showCounterNotification()` dipanggil pada saat tombol **Tambah (+)** ditekan.

Implementasi Provider dan Local Notification berjalan dengan baik karena kedua fitur dapat bekerja secara terintegrasi. Ketika pengguna menekan tombol tambah, Provider memperbarui state aplikasi sedangkan Notification Service menampilkan informasi perubahan nilai counter melalui notifikasi sistem.

Secara keseluruhan, aplikasi berhasil memenuhi tujuan praktikum yaitu mengimplementasikan state management menggunakan Provider serta menampilkan Local Notification berdasarkan perubahan state yang terjadi pada aplikasi.
