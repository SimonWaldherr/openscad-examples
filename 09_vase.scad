// Profilkurve
polygon_points = [
    [-30, 0], [20, 0], [30, 20], [25, 50], [20, 80], [15, 110], [10, 130], [15, 150], [-5, 150], [15, 20], [-30, 20]
];

// Rotieren der Profilkurve um die Z-Achse
module vase() {
    rotate_extrude()
        translate([30, 0, 0])
            polygon(polygon_points);
}

vase();