<div align="center">
  <br />
  <h1>LAPORAN PRAKTIKUM <br>APLIKASI BERBASIS PLATFORM</h1>
  <br />
  <h3>MODUL 12 & 13<br> IMPLEMENTASI PROVIDER & NOTIFIKASI <br>(Aplikasi Counter & State Management)</h3>
  <br />
  <img src="assets/Telkom.png" alt="Logo" width="300"> 
  <br />
  <br />
  <br />
  <h3>Disusun Oleh :</h3>
  <p>
    <strong>Bayu Kuncoro Adi</strong><br>
    <strong>2311102031</strong><br>
    <strong>S1 IF-11-REG01</strong>
  </p>
  <br />
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

## 1. Dasar Teori

### 1.1 Flutter
Flutter merupakan framework pengembangan antarmuka pengguna (UI) yang dikembangkan oleh Google dan bersifat open source. Framework ini memungkinkan pengembang membuat aplikasi yang dapat berjalan secara native pada berbagai platform, seperti Android, iOS, web, dan desktop, hanya dengan menggunakan satu basis kode yang sama.

### 1.2 Provider (State Management)
`provider` adalah salah satu package manajemen state yang banyak digunakan dalam Flutter karena sederhana dan mudah diimplementasikan. Package ini bekerja dengan memanfaatkan konsep InheritedWidget untuk mengelola dan mendistribusikan data ke berbagai widget dalam aplikasi. Dengan Provider, logika aplikasi dapat dipisahkan dari tampilan (UI), sehingga kode menjadi lebih terstruktur dan pemeliharaannya lebih mudah. Selain itu, hanya widget yang membutuhkan data tertentu yang akan diperbarui ketika terjadi perubahan state.

### 1.3 Flutter Local Notifications
`flutter_local_notifications` merupakan plugin Flutter yang digunakan untuk menampilkan notifikasi lokal langsung dari aplikasi. Berbeda dengan layanan notifikasi berbasis cloud seperti Firebase Cloud Messaging (FCM), plugin ini tidak memerlukan koneksi internet maupun server eksternal karena seluruh proses notifikasi dijalankan secara lokal pada perangkat pengguna.

### 1.4 ChangeNotifier & Consumer
Pada aplikasi ini digunakan kelas `ChangeNotifier` sebagai mekanisme untuk mengelola perubahan data. Kelas ini menyediakan fungsi `notifyListeners()` yang akan memberi tahu widget terkait ketika terjadi perubahan state. Untuk menampilkan perubahan tersebut pada antarmuka, digunakan widget `Consumer` yang secara otomatis mendengarkan perubahan dari provider dan melakukan pembaruan tampilan (rebuild) hanya pada bagian yang membutuhkan data tersebut. Dengan cara ini, aplikasi menjadi lebih efisien dalam mengelola pembaruan UI.

---

## 2. Implementasi Program

### 2.1 Deskripsi Aplikasi
Aplikasi Counter App Bayu merupakan aplikasi sederhana berbasis Flutter yang dibuat untuk mengimplementasikan konsep State Management menggunakan Provider dan notifikasi lokal (Local Notification). Aplikasi ini menampilkan nilai counter pada halaman utama dan menyediakan tombol Tambah (+) yang berfungsi untuk menambahkan nilai counter secara bertahap. Nilai counter dikelola menggunakan Provider sehingga perubahan data dapat diperbarui secara otomatis pada antarmuka pengguna tanpa perlu melakukan refresh secara manual.

Selain menampilkan perubahan nilai counter pada layar, aplikasi juga memanfaatkan plugin flutter_local_notifications untuk memberikan notifikasi setiap kali tombol tambah ditekan. Notifikasi yang muncul berisi informasi mengenai nilai counter terbaru dengan judul "Counter Update" dan pesan "Nilai counter saat ini: X". Dengan tampilan yang sederhana dan modern, aplikasi ini menjadi contoh implementasi dasar penggunaan Provider dan Local Notification dalam pengembangan aplikasi Flutter.

---

## 3. Code & Penjelasan

### 3.1 `pubspec.yaml` — Menambahkan Dependensi

```yaml
dependencies:
  flutter:
    sdk: flutter

  provider: ^6.1.2
  flutter_local_notifications: ^17.2.3
```

**Penjelasan:**
- `provider`: Digunakan sebagai solusi manajemen state untuk mengelola logika aplikasi secara terpisah dari tampilan (UI). Dengan pendekatan ini, proses seperti penambahan maupun pengaturan ulang nilai counter dapat dikelola dengan lebih terstruktur sehingga kode menjadi lebih rapi, mudah dipelihara, dan bersifat modular.
- `flutter_local_notifications`: Berfungsi untuk mengintegrasikan fitur notifikasi lokal yang tersedia pada sistem operasi Android maupun iOS ke dalam aplikasi Flutter. Plugin ini memungkinkan aplikasi menampilkan notifikasi secara langsung pada perangkat tanpa memerlukan koneksi internet atau layanan server eksternal.

---

### 3.2 Konfigurasi Android — `android/app/build.gradle`

Library `flutter_local_notifications` membutuhkan **core library desugaring** agar bisa berjalan di Android versi lama.

```gradle
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.avatar_counter_provider"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17

        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.avatar_counter_provider"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

flutter {
    source = "../.."
}

```

**Penjelasan:**
- `isCoreLibraryDesugaringEnabled = true` digunakan untuk mengaktifkan dukungan fitur-fitur Java modern pada Android yang lebih lama, sehingga plugin notifikasi dapat berjalan dengan baik dan proses build menggunakan Gradle tidak mengalami kegagalan.
- `minSdk = 21` ditetapkan secara langsung karena plugin `flutter_local_notifications` hanya mendukung perangkat Android dengan minimal API Level 21. Oleh karena itu, aplikasi tidak dapat dijalankan pada versi Android yang berada di bawah batas tersebut..

---

### 3.3 Konfigurasi Izin Notifikasi — `AndroidManifest.xml`

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>

    <application
        android:label="avatar_counter_provider"
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
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
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

**Penjelasan:**
File **AndroidManifest.xml** merupakan salah satu file konfigurasi utama pada aplikasi Android yang berfungsi untuk mendefinisikan informasi penting mengenai aplikasi. Di dalam file ini terdapat pengaturan seperti nama aplikasi, ikon aplikasi, aktivitas utama (*MainActivity*), tema yang digunakan, serta berbagai komponen yang diperlukan agar aplikasi dapat berjalan dengan baik pada sistem operasi Android. Selain itu, AndroidManifest.xml juga berperan sebagai penghubung antara aplikasi Flutter dengan sistem Android melalui deklarasi berbagai konfigurasi yang dibutuhkan selama proses eksekusi aplikasi.

Pada aplikasi **Counter App Bayu**, file AndroidManifest.xml digunakan untuk mendeklarasikan izin **POST_NOTIFICATIONS** agar aplikasi dapat menampilkan notifikasi lokal kepada pengguna, terutama pada perangkat Android 13 ke atas yang memerlukan izin notifikasi secara eksplisit. File ini juga mendefinisikan **MainActivity** sebagai halaman utama yang akan dijalankan saat aplikasi dibuka serta menyertakan konfigurasi Flutter Embedding v2 yang diperlukan agar plugin seperti **flutter_local_notifications** dapat berfungsi dengan baik di dalam aplikasi.


---

### 3.4 State Model — `counter_provider.dart`


```dart
import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}
```

**Penjelasan:**
File **counter_provider.dart** berfungsi sebagai tempat pengelolaan state pada aplikasi dengan memanfaatkan package **Provider** dan kelas **ChangeNotifier**. Di dalam file ini terdapat variabel private `_counter` yang digunakan untuk menyimpan nilai counter serta sebuah *getter* `counter` yang memungkinkan nilai tersebut diakses oleh widget lain tanpa memberikan akses langsung untuk mengubahnya. Dengan cara ini, data dapat dikelola secara lebih aman dan terstruktur sesuai dengan prinsip enkapsulasi.

Selain menyimpan data counter, file ini juga menyediakan fungsi `increment()` yang bertugas menambahkan nilai counter sebanyak satu setiap kali dipanggil. Setelah nilai counter diperbarui, fungsi `notifyListeners()` dijalankan untuk memberi tahu seluruh widget yang sedang mendengarkan perubahan state tersebut. Akibatnya, tampilan antarmuka pengguna akan diperbarui secara otomatis dan menampilkan nilai counter terbaru tanpa perlu melakukan *refresh* atau *reload* aplikasi secara manual.


---

### 3.5 Inisialisasi Sistem Notifikasi — `notification_service.dart`

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel =
  AndroidNotificationChannel(
    'counter_channel',
    'Counter Notification',
    description: 'Notifikasi perubahan nilai counter',
    importance: Importance.max,
  );

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
    InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(settings);

    // Buat notification channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Request permission Android 13+
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showNotification(int counter) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'counter_channel',
      'Counter Notification',
      channelDescription: 'Notifikasi perubahan nilai counter',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      counter,
      'Counter Update',
      'Nilai counter saat ini: $counter',
      notificationDetails,
    );
  }
}
```

**Penjelasan:**
File **notification_service.dart** berfungsi sebagai layanan (*service*) yang menangani seluruh proses notifikasi lokal pada aplikasi. Di dalam file ini dibuat sebuah kelas bernama `NotificationService` yang memanfaatkan plugin **flutter_local_notifications** untuk menginisialisasi sistem notifikasi, membuat *notification channel*, serta mengelola izin notifikasi pada perangkat Android. Dengan memisahkan logika notifikasi ke dalam file tersendiri, kode aplikasi menjadi lebih terstruktur dan mudah dikelola karena fungsi notifikasi tidak bercampur dengan kode antarmuka pengguna (UI).

Selain melakukan konfigurasi awal, file ini juga menyediakan fungsi `showNotification()` yang digunakan untuk menampilkan notifikasi setiap kali nilai counter bertambah. Fungsi tersebut akan mengirimkan notifikasi dengan judul **"Counter Update"** dan pesan yang berisi nilai counter terbaru. Ketika fungsi ini dipanggil dari halaman utama aplikasi, pengguna akan langsung menerima notifikasi lokal yang muncul pada perangkat tanpa memerlukan koneksi internet maupun layanan pihak ketiga seperti Firebase Cloud Messaging (FCM).



---

### 3.6 Membungkus Aplikasi dengan Provider — `main.dart`

Agar `CounterProvider` dapat diakses secara global, ia harus dibungkus pada level tertinggi *widget tree*.

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/counter_provider.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();

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
      title: 'Counter App Bayu',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.cyan,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Counter App Bayu",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.analytics_outlined,
                size: 70,
                color: Colors.cyanAccent,
              ),

              const SizedBox(height: 20),

              const Text(
                "Counter Value",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "${counterProvider.counter}",
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 25),

              const Divider(color: Colors.white24),

              const SizedBox(height: 10),

              const Text(
                "Bayu Kuncoro Adi",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                "2311102031",
                style: TextStyle(
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.cyanAccent,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add),
        label: const Text("Tambah"),
        onPressed: () async {
          counterProvider.increment();

          await NotificationService.showNotification(
            counterProvider.counter,
          );
        },
      ),
    );
  }
}
```

**Penjelasan:**
File **main.dart** merupakan file utama yang menjadi titik awal (*entry point*) dari aplikasi Flutter. Pada file ini dilakukan proses inisialisasi aplikasi, termasuk mengaktifkan layanan notifikasi melalui `NotificationService.init()` serta mendaftarkan `CounterProvider` menggunakan `ChangeNotifierProvider`. Dengan konfigurasi tersebut, state counter dapat diakses dan dikelola oleh seluruh widget yang membutuhkan tanpa harus mengirim data secara manual melalui banyak widget.

Selain sebagai tempat inisialisasi, file **main.dart** juga berisi antarmuka utama aplikasi **Counter App Bayu**. Halaman utama menampilkan nilai counter, identitas pembuat aplikasi, serta tombol **Tambah** yang digunakan untuk menambah nilai counter. Ketika tombol ditekan, aplikasi akan memanggil fungsi `increment()` pada `CounterProvider` untuk memperbarui nilai counter dan secara bersamaan menjalankan fungsi `showNotification()` untuk menampilkan notifikasi lokal yang berisi nilai counter terbaru. Dengan demikian, perubahan data dapat langsung terlihat pada layar dan juga diinformasikan melalui notifikasi kepada pengguna.


---
## 4. Hasil Tampilan (*Output*)


### 1. Allow Notifications
<img src="assets/Allow notifications.jpeg" alt="Allow Notifications" width="300">

### 2. Tampilan Awal
<img src="assets/tampilan awal.jpeg" alt="Tampilan Awal" width="300">

### 3. Tambah Nilai Counter
<img src="assets/tambah nilai coounter.jpeg" alt=" Tambah Nilai Counter" width="300">

### 3. Notifikasi 1
<img src="assets/notif 1.jpeg" alt="Notifikasi 1" width="300">

### 3. Notifikasi 2
<img src="assets/notif 2.jpeg" alt="Notifikasi 2" width="300">