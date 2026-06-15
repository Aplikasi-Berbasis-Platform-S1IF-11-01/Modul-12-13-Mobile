plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.tugas_modul_12_13"
    compileSdk = flutter.compileSdkVersion

    // Menyamakan toolchain Java dan Kotlin secara otomatis ke Java 17
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
        
        // Tetap di 21 untuk kebutuhan plugin notifikasi lokal
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
    // Tetap pertahankan desugaring library yang diminta sebelumnya
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
