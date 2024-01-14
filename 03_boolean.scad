// Kombination von Formen zu einem komplexeren Objekt
difference() {
    cube(20, center = true); // Zentralisierter Würfel
    cylinder(h = 30, r = 5, center = true); // Zentralisierter Zylinder
}
// Dieser Code entfernt den Zylinder aus dem Würfel, wodurch ein durchbohrtes Objekt entsteht
