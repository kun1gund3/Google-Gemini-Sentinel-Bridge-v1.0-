#!/data/data/com.termux/files/usr/bin/bash
# Google LiteRT Build-Skript v4 (Ultra-Stable Modus)

echo "Initialisiere Ultra-Stable Build-Prozedur..."

cd ~/litert-lm

# KEIN Reset des Verzeichnisses! 
# Wir machen da weiter, wo wir aufgehört haben (58%), um Zeit zu sparen.
cd build_android

# Wir aktivieren Verbose-Output, damit wir bei einem Fehler genau sehen, welche Datei schuld ist.
# Und wir nutzen nur EINEN Kern (-j1), um den RAM zu entlasten.
echo "Starte Kompilierung im Single-Core Modus (Sicherheitsstandard)..."
make -j1 VERBOSE=1

echo "------------------------------------------"
if [ -f "bin/litert_run" ] || [ -d "bin" ]; then
    echo "Sieg! Build erfolgreich abgeschlossen."
    ls -l bin/
else
    echo "Build unterbrochen. Bitte scrolle hoch und zeige mir die Fehlermeldung ÜBER den 'Error 2' Zeilen."
fi
