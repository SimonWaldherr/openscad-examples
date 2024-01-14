// Definiert eine Zelle in der Game of Life-Welt
module cell(x, y) {
    translate([x, y, 0])
        cube([1, 1, 0.1]);
}

// Definiert die Struktur der Gosper's Gleiterkanone
module gliderGun() {
    // Koordinaten der aktiven Zellen
    active_cells = [
        [1, 5], [1, 6], [2, 5], [2, 6], [11, 5], [11, 6], [11, 7],
        [12, 4], [12, 8], [13, 3], [13, 9], [14, 3], [14, 9],
        [15, 6], [16, 4], [16, 8], [17, 5], [17, 6], [17, 7],
        [18, 6], [21, 3], [21, 4], [21, 5], [22, 3], [22, 4], [22, 5],
        [23, 2], [23, 6], [25, 1], [25, 2], [25, 6], [25, 7],
        [35, 3], [35, 4], [36, 3], [36, 4]
    ];

    // Erstellt jede aktive Zelle
    for (pos = active_cells) {
        cell(pos[0], pos[1]);
    }
}

// Basisplatte
module basePlate(width, height, thickness) {
    translate([-2, -2, -thickness])
        cube([width, height, thickness]);
}

// Erstellt die gesamte Szene
module gliderGunOnBase() {
    basePlate(50, 30, 2);  // Größe der Basisplatte
    gliderGun();
}

// Render die Szene
gliderGunOnBase();
