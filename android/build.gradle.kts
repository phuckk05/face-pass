allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

subprojects {
    val javaVersion =
        if (name == "tflite_flutter") JavaVersion.VERSION_1_8 else JavaVersion.VERSION_17
    val kotlinJvmTarget =
        if (name == "tflite_flutter") {
            org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_1_8
        } else {
            org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
        }

    plugins.withId("com.android.library") {
        extensions.configure<com.android.build.gradle.LibraryExtension>("android") {
            compileOptions {
                sourceCompatibility = javaVersion
                targetCompatibility = javaVersion
            }
        }
    }

    tasks.withType<JavaCompile>().configureEach {
        sourceCompatibility = javaVersion.toString()
        targetCompatibility = javaVersion.toString()
    }

    tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
        compilerOptions {
            jvmTarget.set(kotlinJvmTarget)
        }
    }
}

plugins {
  id("com.google.gms.google-services") version "4.4.4" apply false
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
