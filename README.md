# Java2Smali Converter

A simple Bash script to convert a Java file into Smali code (Dalvik bytecode) for Android.

---

## Features

- Checks for required dependencies: `bash`, `javac`, `dx`, `baksmali`
- Compiles a Java file to `.class`
- Converts `.class` to `.dex`
- Disassembles `.dex` to `.smali` files
- Uses a temporary directory for intermediate files

---

## Requirements

- Bash shell
- Java JDK (`javac`)
- Android SDK Build Tools (`dx`)
- [Baksmali](https://github.com/JesusFreke/smali)

---

## Usage

```bash
./main.sh <java file>
```

- Output: `.smali` files will be placed in the current directory

---

### Notes

- Only one Java file can be processed at a time
- Make sure your Java file is compiled with a Java version compatible with Android (e.g., `--release 8`)
- Output: `.smali` files will be placed in the current directory

---

## Conversion Pipeline

```
Java Source (.java)
│
▼
Compiled Classes (.class)
│
▼
Dalvik Bytecode (.dex)
│
▼
Smali Files (.smali)
```
