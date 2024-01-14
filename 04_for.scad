// Erstellung einer Reihe von Würfeln mit einer Schleife
for (i = [0 : 5]) {
    translate([i * 15, 0, 0]) // Verschiebung jedes Würfels entlang der X-Achse
        cube(10);
}
// Dieser Code erzeugt eine lineare Anordnung von 6 Würfeln
