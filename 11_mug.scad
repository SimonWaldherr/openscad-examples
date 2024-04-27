// Parameter der Tasse
$fn = 160;                   // Winkelauflösung
totalHeight = 100;           // Gesamthöhe der Tasse
mugDiameter = 100;           // Durchmesser der Tasse
wallThicknessMug = 8.0;      // Wandstärke der Tasse
wallThicknessFloor = 8;      // Stärke des Tassenbodens
bottomRounding = 5;          // Abrundungsradius am unteren Innenrand der Tasse

// Parameter für den Henkel
handleHeight = 70;           // Höhe der Tasse
handleWidth = 20;            // Breite des Henkels
handleDepth = 35;            // Tiefe des Henkels der Tasse
handleWallThickness = 8;     // Wandstärke des Henkels
handleRadius = 25;           // Radius für Basis und Oberseite des Henkels
handleBaseOffset = 20;       // Vertikaler Abstand von der Basis der Tasse bis zum Beginn des Henkels

// Tasse mit Henkel
module mug() {
    difference() {
        union() {
            // Tasse
            cylinder(h=totalHeight - wallThicknessMug / 2, d=mugDiameter, $fn=$fn);
            rotate_extrude(angle=360, $fn=$fn) {
                translate([mugDiameter / 2 - wallThicknessMug / 2, totalHeight - wallThicknessMug / 2])
                circle(d=wallThicknessMug, $fn=$fn / 2);
            };

            // Henkel
            translate([mugDiameter / 2 + handleDepth - handleRadius, 0, handleBaseOffset + handleHeight / 2])
            scale([1, 1, handleHeight / (2 * handleRadius)])
            rotate([-90, 0, 0])
            rotate_extrude(angle=360, $fn=$fn) {
                translate([handleRadius - handleWallThickness / 2, 0])
                scale([1, handleWidth / handleWallThickness, 1])
                circle(d=handleWallThickness, $fn=$fn / 2);
            }
        }

        // Innere Höhlung
        translate([0, 0, wallThicknessFloor + bottomRounding / 2])
        cylinder(h=totalHeight, d=mugDiameter - 2 * wallThicknessMug, $fn=$fn);

        // Abrundung unten
        hull() {
            rotate_extrude(angle=360, $fn=$fn) {
                translate([mugDiameter / 2 - wallThicknessMug - bottomRounding / 2, wallThicknessFloor + bottomRounding / 2])
                circle(d=bottomRounding, $fn=$fn / 2);
            }
        }
    }
}

mug();
