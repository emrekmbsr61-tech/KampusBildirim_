// android/app/build.gradle.kts
plugins {
    id("com.android.application")
    id("kotlin-android") // veya id("org.jetbrains.kotlin.android") 
    id("dev.flutter.flutter-gradle-plugin")
    
    //  FIREBASE PLUGIN'İ BURADA
    id("com.google.gms.google-services")
}

android {
    // Namespace de isminizle uyumlu olmalı
    namespace = "com.example.KampusBildirim_"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        //  DİKKAT: Firebase'deki ismin aynısı olmalı!
        // Eğer Firebase'de başında 'com.example' yoksa, buradan da sil.
        applicationId = "com.example.KampusBildirim_"
        
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

flutter {
    source = "../.."
}

dependencies {
    //  FIREBASE KÜTÜPHANELERİ
    implementation(platform("com.google.firebase:firebase-bom:33.7.0"))
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
    implementation("com.google.firebase:firebase-analytics")
}