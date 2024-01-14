// Parametrisiertes Design für individuelle Anpassungen
module parametricBox(width, height, depth) {
    // width, height, depth: Dimensionen der Box
    cube([width, height, depth]);
}

parametricBox(30, 20, 10); // Erzeugt eine Box mit den angegebenen Dimensionen
