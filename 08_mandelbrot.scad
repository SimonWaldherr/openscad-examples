// Funktion zur Berechnung der Mandelbrot-Iterationen
// cx, cy: Koordinaten im Mandelbrot-Set
// x, y: Aktuelle Werte in der Iteration
// i: Aktueller Iterationsschritt
// max_iter: Maximale Anzahl an Iterationen
function mandel_iter(cx, cy, x, y, i, max_iter) = 
    // Prüft, ob der maximale Iterationsschritt erreicht oder der Punkt außerhalb des Radius 2 liegt
    (i >= max_iter || x*x + y*y > 4) ?
        i : // Wenn ja, gibt die aktuelle Iterationsnummer zurück
        // Ansonsten führt eine weitere Iteration mit den aktualisierten Werten durch
        mandel_iter(cx, cy, x*x - y*y + cx, 2*x*y + cy, i + 1, max_iter);

// Funktion zur Initialisierung der Mandelbrot-Iterationen
// cx, cy: Koordinaten im Mandelbrot-Set
// max_iter: Maximale Anzahl an Iterationen
function mandelbrot(cx, cy, max_iter) = mandel_iter(cx, cy, 0, 0, 0, max_iter);

// Modul zum Zeichnen eines Blocks an einer bestimmten Position
// x, y: Position des Blocks
// max_iter: Maximale Anzahl an Iterationen
// scale: Skalierungsfaktor für die Positionierung
// height_scale: Höhenskalierung für die Blöcke
module drawBlock(x, y, max_iter, scale, height_scale) {
    // Berechnet die Anzahl der Iterationen für den Punkt
    iter = mandelbrot(x / scale, y / scale, max_iter);
    // Berechnet die Höhe des Blocks
    height = iter / max_iter * height_scale;
    // Verschiebt den Block an die korrekte Position und zeichnet ihn
    translate([x, y, 0])
        cube([1, 1, height], true);
}

// Modul zum Erstellen des Mandelbrot-Sets
// width, height: Dimensionen des zu erstellenden Mandelbrot-Sets
// max_iter: Maximale Anzahl an Iterationen für die Mandelbrot-Berechnung
// scale: Skalierungsfaktor zur Anpassung der Koordinaten
// height_scale: Skalierungsfaktor zur Anpassung der Blockhöhe
module mandelbrotSet(width, height, max_iter, scale, height_scale) {
    // Iteriert über jede x- und y-Position innerhalb der vorgegebenen Breite und Höhe
    for (x = [0:width - 1])
        for (y = [0:height - 1])
            // Zeichnet für jeden Punkt einen Block
            drawBlock(x - width / 2, y - height / 2, max_iter, scale, height_scale);
}

// Ruft das Mandelbrot-Set-Modul mit spezifischen Parametern auf
// Erstellt ein 350x250 Mandelbrot-Set mit maximal 20 Iterationen,
// einer Skalierung von 100 und einer Höhenskalierung von 10
mandelbrotSet(350, 250, 20, 100, 30);
