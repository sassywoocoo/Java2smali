
#!/usr/bin/env bash

DEPS=("bash" "javac" "baksmali" "dx")
FILE=$1
ARGC=$#
TMP="/tmp/$RANDOM"
CLASS="*.class"
DEX="a.dex"
SMALI="./"

# Create temp dir
createTmp() {
  mkdir -p "$TMP"
}

# Clean temp dir
cleanTmp() {
  cd - >/dev/null || exit
  cp "$TMP"/*.smali . 2>/dev/null
  rm -rf "$TMP"
}

# Compile Java to class
Java2Class() {
  javac --release 8 "$FILE"
}

# Convert class to dex
Class2Dex() {
  dx --dex --output "$DEX" $CLASS
}

# Convert dex to smali
Dex2Smali() {
  baksmali disassemble "$DEX" -o "$SMALI"
}

# Check if dependency exists
cdeps() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "$1 not found"
    exit 1
  fi
}

main() {
  # Check dependencies
  for dep in "${DEPS[@]}"; do
    cdeps "$dep"
  done

  # Check args
  if [[ $ARGC -ne 1 ]]; then
    echo "Usage: ./main <java file>"
    exit 1
  fi

  # Check if file exists
  if [[ ! -f "$FILE" ]]; then
    echo "$FILE : file not found"
    exit 1
  fi

  createTmp
  cp "$FILE" "$TMP"
  cd "$TMP" || exit
  Java2Class
  Class2Dex
  Dex2Smali
  cleanTmp
}

main

