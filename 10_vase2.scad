// Funktion zur Berechnung eines Punktes auf dem Catmull-Rom-Spline
function catmullRom(p0, p1, p2, p3, t) = 
    let(
        a = 0.5 * [-p0 + 3*p1 - 3*p2 + p3],
        b = 0.5 * [2*p0 - 5*p1 + 4*p2 - p3],
        c = 0.5 * [-p0 + p2],
        d = 0.5 * [2*p1]
    )
    a*t*t*t + b*t*t + c*t + d;

// Funktion, die die Catmull-Rom-Spline-Interpolation für eine Liste von Punkten ausführt
function interpolateCatmullRom(points, numPoints) =
    let(
        extendedPoints = concat([points[len(points) - 1]], points, [points[0], points[1]])
    )
    [for (i = [1 : len(extendedPoints) - 3])
        for (t = [0 : 1 / numPoints : 1])
            catmullRom(extendedPoints[i - 1], extendedPoints[i], extendedPoints[i + 1], extendedPoints[i + 2], t)
    ];

// Profilkurve
polygon_points = [
    [-30, 0], [20, 0], [30, 20], [25, 50], [20, 80], [15, 110], [10, 130], [15, 150], [-5, 150], [15, 20], [-30, 20]
];

// Glätte die Profilkurve
smooth_points = interpolateCatmullRom(polygon_points, 10);

// Entfernen der Verschachtelung in smooth_points
flattened_smooth_points = [for (point_set = smooth_points) for (point = point_set) point];

// Rotieren der geglätteten Profilkurve um die Z-Achse
module vase() {
    rotate_extrude()
        translate([36, 0, 0])
            polygon(flattened_smooth_points);
}

vase();
