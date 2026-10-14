# WorkManager (pulled in by a plugin) creates its Room database reflectively.
# R8 otherwise strips the generated constructor and the app crashes on launch.
-keep class * extends androidx.room.RoomDatabase { <init>(); }
-keep class androidx.work.impl.WorkDatabase_Impl { *; }
-keep class androidx.work.** { *; }

# ML Kit / Play Services models are loaded reflectively.
-keep class com.google.mlkit.** { *; }
-keep class com.google.android.gms.internal.mlkit_vision_** { *; }
-dontwarn com.google.mlkit.**
