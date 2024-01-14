// Ein Zylinder mit einstellbaren Parametern
module customCylinder(h, r) {
    // h: Höhe des Zylinders
    // r: Radius des Zylinders
    cylinder(h = h, r = r);
}

customCylinder(15, 5); // Aufruf der Funktion mit Höhe 15 und Radius 5
