#!/bin/bash

# Schleife durch alle SCAD-Dateien im aktuellen Verzeichnis
for scad_file in *.scad; do
    # Setze den Namen der STL-Datei basierend auf dem SCAD-Dateinamen
    stl_file="${scad_file%.scad}.scad.stl"

    # Überprüfe, ob die STL-Datei existiert
    if [ ! -f "$stl_file" ]; then
        # STL-Datei existiert nicht, führe die Konvertierung durch
        openscad "$scad_file" -o "$stl_file"
        echo "Konvertierung durchgeführt: $scad_file zu $stl_file"
    else
        # STL-Datei existiert, überprüfe die Timestamps
        scad_time=$(date -r "$scad_file" +%s)
        stl_time=$(date -r "$stl_file" +%s)

        # Berechne die Zeitdifferenz in Minuten
        diff_minutes=$(( ($scad_time - $stl_time) / 60 ))

        # Wenn SCAD-Datei mindestens 10 Minuten neuer ist, führe die Konvertierung durch
        if [ $diff_minutes -ge 10 ]; then
            openscad "$scad_file" -o "$stl_file"
            echo "Aktualisierte Konvertierung durchgeführt: $scad_file zu $stl_file"
        else
            echo "Keine Konvertierung notwendig: $scad_file ist nicht deutlich neuer als $stl_file"
        fi
    fi
done
