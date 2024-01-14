// Erstellung eines komplexen geometrischen Musters
module geometricPattern(size, count) {
    for (i = [0 : count - 1]) {
        for (j = [0 : count - 1]) {
            angle = (i + j) * 360 / count;
            translate([i * size * 2, j * size * 2, 0])
                rotate([0, 0, angle])
                square(size, center = true);
        }
    }
}

geometricPattern(10, 5); // Erzeugt ein Muster mit 5x5 Quadraten, jedes 10 Einheiten groß
