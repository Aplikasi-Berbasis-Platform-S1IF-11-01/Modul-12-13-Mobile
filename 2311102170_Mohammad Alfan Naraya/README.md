<div align="center">
  <br />
  <h1>LAPORAN PRAKTIKUM <br>APLIKASI BERBASIS PLATFORM</h1>
  <br />
  <h3>MODUL 12 & 13<br> IMPLEMENTASI PROVIDER & NOTIFIKASI <br>(Aplikasi Counter & State Management)</h3>
  <br />
  <img src="assets/logo.jpeg" alt="Logo" width="300"> 
  <br />
  <br />
  <br />
  <h3>Disusun Oleh :</h3>
  <p>
    <strong>Mohammad Alfan Naraya</strong><br>
    <strong>2311102170</strong><br>
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
Flutter adalah framework antarmuka pengguna (UI) sumber terbuka dari Google yang digunakan untuk membangun aplikasi secara natively compiled untuk berbagai platform dari satu basis kode (codebase).

### 1.2 Provider (State Management)
`provider` adalah salah satu package manajemen state (state management) yang direkomendasikan secara resmi oleh tim Flutter. Provider berfungsi sebagai pembungkus (*wrapper*) di sekitar *InheritedWidget* untuk membuat penggunaan *InheritedWidget* menjadi lebih mudah dan terstruktur. Konsep utamanya adalah memisahkan antara *business logic* dan *UI*, sehingga saat terjadi perubahan state, hanya widget yang membutuhkan data tersebut yang akan di-rebuild.

### 1.3 Flutter Local Notifications
`flutter_local_notifications` adalah plugin untuk membuat dan menampilkan notifikasi pop-up secara lokal (offline) dari dalam aplikasi, tanpa melalui server atau internet (seperti Firebase Cloud Messaging). Notifikasi ini dikontrol secara langsung oleh sistem operasi ponsel.

### 1.4 ChangeNotifier & Consumer
Aplikasi ini memanfaatkan `ChangeNotifier`, yaitu sebuah kelas dasar bawaan Flutter yang menyediakan mekanisme pemberitahuan perubahan (*notifyListeners*). Di sisi UI, kita menggunakan widget `Consumer` yang berfungsi untuk "mendengarkan" perubahan dari provider dan membangun ulang (*rebuild*) dirinya secara otomatis setiap kali fungsi *notifyListeners()* dipanggil.

---

## 2. Implementasi Program

### 2.1 Deskripsi Aplikasi
Aplikasi bertema **"Implementasi Provider & Notifikasi"** ini dibuat untuk memahami cara mengelola perubahan state aplikasi skala menengah menggunakan pola desain manajemen state yang rapi. Fitur utama yang diimplementasikan:

1. **State Management Counter**: Menampilkan nilai angka counter yang state-nya dipertahankan secara terpusat.
2. **Penambahan Counter**: Terdapat tombol **"Tambah"** untuk menaikkan nilai counter dengan fungsi *increment*.
3. **Reset Counter**: Terdapat tombol **"Reset"** untuk mengembalikan angka menjadi 0.
4. **Notifikasi Sistem**:
   - Muncul notifikasi **"Counter Update"** ketika tombol tambah ditekan (menampilkan angka terakhir).
   - Muncul notifikasi **"Counter Direset"** ketika tombol reset ditekan.
5. **Modern Dark UI**: Tampilan visual mengusung gaya *dark navy* dengan elemen lingkaran bercahaya biru dan tombol bergaya modern.

---

## 3. Code & Penjelasan

### 3.1 `pubspec.yaml` — Menambahkan Dependensi

Dua library eksternal utama yang digunakan untuk menyelesaikan modul ini:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  flutter_local_notifications: ^17.0.0
```

**Penjelasan:**
Blok kode di dalam file pubspec.yaml tersebut berfungsi untuk mendaftarkan paket (library) pihak ketiga yang wajib diunduh agar aplikasi Flutter dapat berjalan. Deklarasi dependencies: bertindak sebagai instruksi utama bagi framework untuk mengintegrasikan seluruh pustaka di bawahnya ke dalam sistem aplikasi. Komponen pertama, yaitu flutter: dan sdk: flutter, merupakan dependensi inti untuk mengimpor seluruh widget dasar UI Flutter seperti tombol, teks, halaman, dan sistem tata letak standar.

Pustaka kedua, provider: ^6.1.2, digunakan untuk mengaktifkan manajemen status (state management) yang bertugas memisahkan logika data counter (backend) dari tampilan antarmuka (user interface), sehingga angka pada layar dapat diperbarui secara otomatis secara real-time. Terakhir, pustaka flutter_local_notifications: ^17.0.0 berfungsi memberikan akses ke sistem operasi perangkat keras HP agar aplikasi memiliki kemampuan untuk memunculkan pop-up banner notifikasi lokal di bagian atas layar setiap kali tombol penambah nilai counter ditekan.

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
    namespace = "com.example.tugas_modul_12_13"
    compileSdk = flutter.compileSdkVersion

    
    @Suppress("UnstableApiUsage")
    kotlinOptions {
        jvmTarget = "17"
    }

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.example.tugas_modul_12_13"
        
        /
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        
        versionCode = providers.gradleProperty("flutter.versionCode").map { it.toInt() }.orElse(1).get()
        versionName = providers.gradleProperty("flutter.versionName").orElse("1.0.0").get()
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}

```

**Penjelasan:**
File konfigurasi build.gradle.kts (Kotlin DSL) ini berfungsi sebagai pengatur utama dalam proses kompilasi dan perakitan proyek Flutter ke dalam arsitektur Android. Pada bagian awal, blok plugins bertugas mengimpor alat-alat krusial seperti com.android.application, kotlin-android, dan dev.flutter.flutter-gradle-plugin untuk mengubah proyek menjadi file aplikasi (.apk) serta menyinkronkan kode Dart milik Flutter ke dalam proses build. Masuk ke blok android, didefinisikan identitas unik aplikasi melalui namespace, bersama dengan pengaturan compileSdk. Demi menghindari error akibat bentroknya versi Java saat kompilasi, konfigurasi kotlinOptions dan compileOptions secara ketat mengunci tingkat kompatibilitas bahasa ke versi Java 17, sekaligus mengaktifkan fitur isCoreLibraryDesugaringEnabled = true agar fitur-fiturnis Java modern tetap kompatibel saat dijalankan di perangkat Android lama.

Pada bagian akhir, blok defaultConfig mengatur properti dasar aplikasi seperti paket unik di Play Store via applicationId, batasan versi sistem operasi melalui minSdk dan targetSdk, serta nomor versi aplikasi (versionCode dan versionName) yang semuanya diambil secara dinamis dari file proyek utama. Selanjutnya, bagian buildTypes mengonfigurasi agar aplikasi versi release menggunakan sertifikat keamanan versi debug demi mempermudah pengujian lokal. Konfigurasi ini ditutup dengan blok flutter untuk mengarahkan jalur direktori utama proyek, serta blok dependencies yang menyuntikkan pustaka pendukung coreLibraryDesugaring. Pustaka ini wajib dihadirkan karena menjadi syarat mutlak dari paket flutter_local_notifications agar fitur pop-up notifikasi counter pada HP Anda dapat berjalan sukses tanpa mengalami crash.

---

### 3.3 Konfigurasi Izin Notifikasi — `AndroidManifest.xml`

Sejak Android 13 (API Level 33), sistem operasi memblokir notifikasi pop-up secara default kecuali izin eksplisit diminta dari pengguna.

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

**Penjelasan:**
Mulai dari Android 13 (API level 33) ke atas, sistem Android mewajibkan setiap aplikasi untuk meminta izin ini secara eksplisit agar memiliki hak legal dalam memunculkan spanduk ataupun pop-up notifikasi di layar HP pengguna. Tanpa adanya deklarasi baris izin ini di dalam manifes, sistem Android akan otomatis memblokir fungsi pengiriman notifikasi lokal yang dipicu oleh paket flutter_local_notifications pada aplikasi.

---


---

---

### 3.4 Membungkus Aplikasi dengan Provider — `main.dart`

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}
```

**Penjelasan:**
Proses membungkus aplikasi dengan Provider dilakukan di dalam fungsi utama main() pada file main.dart menggunakan widget ChangeNotifierProvider. Widget ini ditempatkan tepat di dalam fungsi runApp() untuk membungkus MyApp(), yang merupakan akar dari seluruh pohon widget (widget tree) aplikasi. Melalui properti create, kelas CounterProvider diinstansiasi secara terpusat sehingga status data (state) dan logika bisnis di dalamnya dapat dialirkan ke seluruh halaman di bawahnya. Penempatan Provider di posisi paling luar ini sangat krusial dalam arsitektur Flutter karena memastikan bahwa setiap komponen atau widget anak dapat mendengarkan perubahan data counter dan memicu fungsi notifikasi secara real-time tanpa perlu mengoper data secara manual melalui konstruktor kelas.

---

### 3.5 Membaca State dan Menangani Aksi Tombol — `main.dart`

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. DI SINI KODE UNTUK MEMBACA STATE (Mendengarkan Perubahan Angka)
    final counterProvider = context.watch<CounterProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Tugas Modul 12 & 13')),
      body: Center(
        child: Text(
          // Menampilkan angka counter secara real-time
          '${counterProvider.count}', 
          style: const TextStyle(fontSize: 48),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // 2. DI SINI KODE UNTUK MENANGANI AKSI TOMBOL
        onPressed: () {
          // Menaikkan angka di Provider
          context.read<CounterProvider>().increment();
          
          // Memunculkan pop-up notifikasi secara instan
          NotificationService.showNotification(
            'Counter Bertambah!',
            'Nilai sekarang adalah ${context.read<CounterProvider>().count}',
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

**Penjelasan:**
Proses membaca status (state) dan menangani aksi tombol di dalam file main.dart dilakukan di dalam fungsi Widget build pada kelas halaman utama. Untuk membaca nilai data secara dinamis, aplikasi menggunakan metode context.watch<CounterProvider>() yang diletakkan di bagian atas fungsi build. Metode ini bertugas memantau perubahan nilai counter secara real-time, sehingga setiap kali data angka bertambah, widget teks di tengah layar akan otomatis memperbarui tampilannya tanpa memuat ulang seluruh halaman.

Sementara itu, penanganan aksi tombol dikonfigurasi di dalam properti onPressed milik widget FloatingActionButton. Ketika tombol dengan ikon tambah tersebut ditekan oleh pengguna, fungsi di dalamnya akan mengeksekusi metode context.read<CounterProvider>().increment() untuk menaikkan nilai angka di dalam state management. Tepat setelah nilai berhasil dinaikkan, aksi tombol tersebut langsung memicu fungsi NotificationService.showNotification() untuk mengirimkan perintah ke sistem operasi handphone agar memunculkan spanduk notifikasi lokal secara instan sebagai umpan balik visual bagi pengguna.

---
## 4. Hasil Tampilan (*Output*)

Berikut adalah tangkapan layar (*screenshot*) dari aplikasi yang menunjukkan fitur Provider dan Notifikasi Lokal telah berjalan dengan baik.

*(Ganti gambar ini dengan meletakkan hasil screenshot ke dalam folder `assets/` dengan nama yang sesuai)*

### 1. Halaman Utama
<img src="assets/1.jpeg" alt="Halaman Utama" width="300">

### 2. Menekan Tombol Tambah +1 dan notifikasi Pop-Up (counter bertambah)
<img src="assets/2.jpeg" alt="Proses Tambah" width="300">

### 3. Menekan riset dan notifikasi Pop-Up (riset ulang)
<img src="assets/3.jpeg" alt="Notifikasi Penambahan" width="300">
