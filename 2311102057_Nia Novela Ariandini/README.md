<div align="center">
  <br />
  <h1>LAPORAN PRAKTIKUM <br>APLIKASI BERBASIS PLATFORM</h1>
  <br />
  <h3>MODUL 12 & 13<br> Implementasi Provider dan Notifikasi pada Flutter </h3>
  <br />
  <img src="assets/logo.png" alt="Logo" width="300"> 
  <br />
  <br />
  <br />
  <h3>Disusun Oleh :</h3>
  <p>
    <strong>Nia Novela Ariandini</strong><br>
    <strong>2311102057</strong><br>
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

# 1. Dasar Teori

### Flutter
Flutter merupakan framework open-source yang dikembangkan oleh Google untuk membangun aplikasi mobile, web, dan desktop menggunakan satu basis kode (single codebase). Flutter menggunakan bahasa pemrograman Dart dan menyediakan berbagai widget yang memudahkan pengembangan antarmuka pengguna.

### Provider
Provider adalah salah satu metode state management pada Flutter yang digunakan untuk mengelola dan membagikan data ke berbagai widget dalam aplikasi. Provider memanfaatkan class `ChangeNotifier` sehingga perubahan data dapat diperbarui secara otomatis melalui method `notifyListeners()`.

### Local Notification
Local Notification merupakan notifikasi yang dibuat dan ditampilkan langsung oleh aplikasi tanpa memerlukan server eksternal. Pada praktikum ini, notifikasi digunakan untuk memberikan informasi setiap kali nilai counter bertambah.

---

# 2. Implementasi Program

### File `main.dart`

```dart
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
```

**Penjelasan Singkat:**

- `WidgetsFlutterBinding.ensureInitialized()` digunakan untuk memastikan Flutter siap menjalankan proses asynchronous.
- `NotificationService.init()` digunakan untuk menginisialisasi layanan notifikasi.
- `ChangeNotifierProvider` digunakan untuk menyediakan objek `CounterProvider` ke seluruh widget.

### Mengambil Data Provider

```dart
final counterProvider =
    Provider.of<CounterProvider>(context);
```

**Penjelasan Singkat:**

Kode tersebut digunakan untuk mengambil data counter dari Provider sehingga nilai counter dapat ditampilkan dan diperbarui secara otomatis.

### Tombol Increment dan Notifikasi

```dart
onPressed: () {
  counterProvider.increment();

  NotificationService.showNotification(
    counterProvider.counter,
  );
}
```

**Penjelasan Singkat:**

Ketika tombol ditekan, nilai counter akan bertambah satu dan aplikasi akan menampilkan notifikasi yang berisi nilai counter terbaru.

---

# 3. Hasil Tampilan

### Tampilan Awal Aplikasi

<img src="assets/1.png" width="300">

Keterangan:

- Menampilkan nilai counter awal.
- Menggunakan tema soft pink aesthetic.
- Counter berada pada card di tengah layar.

### Tampilan Setelah Tombol Ditekan

<img src="assets/2.png" width="300">

Keterangan:

- Nilai counter bertambah sesuai jumlah klik.
- Tampilan diperbarui secara otomatis oleh Provider.

### Tampilan Notifikasi

<img src="assets/3.png" width="300">

Keterangan:

- Notifikasi muncul setiap kali counter bertambah.
- Isi notifikasi menampilkan nilai counter terbaru.

---

# 4. Cara Kerja Provider pada Aplikasi

Provider digunakan untuk mengelola state berupa nilai counter. Saat aplikasi dijalankan, `CounterProvider` dibuat menggunakan `ChangeNotifierProvider`. Widget kemudian mengambil data counter menggunakan Provider.

Ketika tombol ditekan, method `increment()` dijalankan sehingga nilai counter bertambah satu. Setelah itu method `notifyListeners()` dipanggil sehingga widget yang menggunakan Provider akan melakukan rebuild secara otomatis dan menampilkan nilai terbaru pada layar.

---

# 5. Cara Kerja Notifikasi yang Digunakan

Aplikasi menggunakan package `flutter_local_notifications` untuk menampilkan notifikasi lokal.

Saat tombol ditekan, aplikasi memanggil method `showNotification()` dari `NotificationService`. Method tersebut membuat notifikasi baru yang berisi informasi nilai counter terbaru. Sistem Android kemudian menampilkan notifikasi tersebut pada perangkat pengguna.

Contoh isi notifikasi:

```text
Counter Update
Nilai counter saat ini: 5
```

---

# 6. Kesimpulan

Berdasarkan hasil implementasi yang telah dilakukan, Provider berhasil digunakan sebagai state management untuk mengelola nilai counter secara otomatis. Setiap perubahan data dapat langsung ditampilkan pada antarmuka tanpa perlu melakukan refresh halaman.

Selain itu, fitur Local Notification berhasil memberikan informasi kepada pengguna setiap kali nilai counter bertambah. Dengan menggabungkan Provider dan Local Notification, aplikasi menjadi lebih interaktif, responsif, dan mudah dikembangkan.
