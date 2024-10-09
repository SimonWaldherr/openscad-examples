// Planetary Gear Fidget Toy

// Resolution for curved surfaces to ensure smoothness
surfaceResolution = 60;

// Outer diameter of the ring gear in millimeters
outerRingDiameter = 90;

// Thickness of all gears in millimeters
gearThickness = 25;

// Clearance tolerance to prevent gear interference
clearanceTolerance = 0.15;

// Total number of planet gears in the system
planetGearCount = 6;

// Number of teeth on each planet gear
planetGearTeethCount = 7;

// Approximate number of teeth on the sun gear (initial estimate)
approxSunGearTeethCount = 14;

// Pressure angle in degrees, affects gear strength and smoothness
pressureAngle = 42;

// Number of teeth contributing to the twist in herringbone gears
twistTeethCount = 1;

// Width of the hexagonal hole in the center of the sun gear
hexHoleWidth = 1;

// Maximum ratio of tooth depth relative to gear dimensions
maxToothDepthRatio = 0.9;

// Outer diameter of the torus (donut shape) in millimeters
outerTorusDiameter = 122;

// Thickness of the torus in millimeters
torusThickness = 36;

// Calculated variables
planetCount = round(planetGearCount); 
planetTeethCount = round(planetGearTeethCount); 
sunGearTeethCount = approxSunGearTeethCount;
kFactor = round(2 / planetCount * (sunGearTeethCount + planetTeethCount));
kFactorAdjusted = (kFactor * planetCount % 2 != 0) ? kFactor + 1 : kFactor;
actualSunGearTeethCount = kFactorAdjusted * planetCount / 2 - planetTeethCount;
ringGearTeethCount = actualSunGearTeethCount + 2 * planetTeethCount;
pitchDiameter = 0.9 * outerRingDiameter / (1 + min(PI / (2 * ringGearTeethCount * tan(pressureAngle)), PI * maxToothDepthRatio / ringGearTeethCount));
gearPitch = pitchDiameter * PI / ringGearTeethCount;
calculatedHelixAngle = atan(2 * twistTeethCount * gearPitch / gearThickness);
rotationAngle = $t * 360 / planetCount;
innerTorusDiameter = outerTorusDiameter - torusThickness;

echo("Sun Gear Teeth (actualSunGearTeethCount): ", actualSunGearTeethCount);
echo("Gear Pitch: ", gearPitch);
echo("Helix Angle: ", calculatedHelixAngle);

// Define gear rack module
module gearRack(teethCount = 15, pitch = 10, angle = 28, helixAngle = 0, clearance = 0, thickness = 5, isFlat = false) {
    addendum = pitch / (4 * tan(angle));
    
    flatExtrude(height = thickness, isFlat = isFlat) {
        translate([0, -clearance * cos(angle) / 2]) {
            union() {
                translate([0, -0.5 - addendum]) square([teethCount * pitch, 1], center = true);
                for (i = [1 : teethCount]) {
                    translate([pitch * (i - teethCount / 2 - 0.5), 0]) {
                        polygon(points = [[-pitch / 2, -addendum], [pitch / 2, -addendum], [0, addendum]]);
                    }
                }
            }
        }
    }
}

// Define herringbone gear module
module herringboneGear(teethCount = 15, pitch = 10, angle = 28, depthRatio = 1, clearance = 0, helixAngle = 0, thickness = 5) {
    union() {
        gear(teethCount, pitch, angle, depthRatio, clearance, helixAngle, thickness / 2);
        mirror([0, 0, 1]) gear(teethCount, pitch, angle, depthRatio, clearance, helixAngle, thickness / 2);
    }
}

// Define gear module
module gear(teethCount = 15, pitch = 10, angle = 28, depthRatio = 1, clearance = 0, helixAngle = 0, thickness = 5, isFlat = false) {
    pitchRadius = teethCount * pitch / (2 * PI);
    twistAngle = tan(helixAngle) * thickness / pitchRadius * 180 / PI;

    flatExtrude(height = thickness, twist = twistAngle, isFlat = isFlat) {
        gear2D(teethCount, pitch, angle, depthRatio, clearance);
    }
}

// Define flat extrusion module
module flatExtrude(height, twist, isFlat) {
    if (isFlat == false)
        linear_extrude(height = height, twist = twist, slices = twist / 6) children(0);
    else
        children(0);
}

// Define 2D gear profile module
module gear2D(teethCount, pitch, angle, depthRatio, clearance) {
    pitchRadius = teethCount * pitch / (2 * PI);
    baseRadius = pitchRadius * cos(angle);
    toothDepth = pitch / (2 * tan(angle));
    outerRadius = clearance < 0 ? pitchRadius + toothDepth / 2 - clearance : pitchRadius + toothDepth / 2;
    rootRadius = max(baseRadius, pitchRadius - toothDepth / 2 - clearance / 2);
    backlashAngle = clearance / (pitchRadius * cos(angle)) * 180 / PI;
    halfToothAngle = 90 / teethCount - backlashAngle / 2;
    pitchPoint = involute(baseRadius, involuteIntersectAngle(baseRadius, pitchRadius));
    pitchAngle = atan2(pitchPoint[1], pitchPoint[0]);

    intersection() {
        rotate(90 / teethCount)
        circle($fn = teethCount * 3, r = pitchRadius + depthRatio * pitch / 2 - clearance / 2);

        union() {
            rotate(90 / teethCount)
            circle($fn = teethCount * 2, r = max(rootRadius, pitchRadius - depthRatio * pitch / 2 - clearance / 2));

            for (i = [1 : teethCount]) {
                rotate(i * 360 / teethCount) {
                    halfTooth(pitchAngle, baseRadius, rootRadius, outerRadius, halfToothAngle);
                    mirror([0, 1]) halfTooth(pitchAngle, baseRadius, rootRadius, outerRadius, halfToothAngle);
                }
            }
        }
    }
}

// Define half tooth module
module halfTooth(pitchAngle, baseRadius, rootRadius, outerRadius, halfToothAngle) {
    index = [0, 1, 2, 3, 4, 5];
    startAngle = max(involuteIntersectAngle(baseRadius, rootRadius) - 5, 0);
    stopAngle = involuteIntersectAngle(baseRadius, outerRadius);
    angle = index * (stopAngle - startAngle) / (index[len(index) - 1]);

    points = [[0, 0], involute(baseRadius, angle[0] + startAngle), involute(baseRadius, angle[1] + startAngle),
        involute(baseRadius, angle[2] + startAngle), involute(baseRadius, angle[3] + startAngle),
        involute(baseRadius, angle[4] + startAngle), involute(baseRadius, angle[5] + startAngle)];

    difference() {
        rotate(-pitchAngle - halfToothAngle) polygon(points = points);
        square(2 * outerRadius);
    }
}

// Involute and angle calculations
function involuteIntersectAngle(baseRadius, radius) = sqrt(pow(radius / baseRadius, 2) - 1) * 180 / PI;
function involute(baseRadius, involuteAngle) = [
    baseRadius * (cos(involuteAngle) + involuteAngle * PI / 180 * sin(involuteAngle)),
    baseRadius * (sin(involuteAngle) - involuteAngle * PI / 180 * cos(involuteAngle))
];

// Define torus shape module
module torusShape() {
    rotate_extrude(angle = 360, $fn = 180) 
        translate([innerTorusDiameter / 3, 12, 0])
            circle(r = torusThickness / 2, $fn = 60);
}

// Main structure with intersection and translation
// Planetary Gear intersection with torus shape
intersection(){
    translate([0, 0, gearThickness / 2]) {
        difference() {
            cylinder(r = outerRingDiameter, h = gearThickness, center = true, $fn = 100); // Outer ring gear
            
            // Herringbone for the ring gear
            herringboneGear(ringGearTeethCount, gearPitch, pressureAngle, maxToothDepthRatio, -clearanceTolerance, calculatedHelixAngle, gearThickness + 0.2);
            
            difference() {
                translate([0, -outerRingDiameter / 2, 0])
                rotate([90, 0, 0]) {}
                cylinder(r = outerRingDiameter / 2 - 0.25, h = gearThickness + 2, center = true, $fn = 100);
            }
        }

        rotate([0, 0, (planetTeethCount + 1) * 180 / actualSunGearTeethCount + rotationAngle * (actualSunGearTeethCount + planetTeethCount) * 2 / actualSunGearTeethCount]) {
            difference() {
                mirror([0, 1, 0]) herringboneGear(actualSunGearTeethCount, gearPitch, pressureAngle, maxToothDepthRatio, clearanceTolerance, calculatedHelixAngle, gearThickness);
                cylinder(r = hexHoleWidth / sqrt(3), h = gearThickness + 1, center = true, $fn = 6);
            }
        }

        // Planet Gears
        for (i = [1 : planetCount]) {
            rotate([0, 0, i * 360 / planetCount + rotationAngle]) 
            translate([pitchDiameter / 2 * (actualSunGearTeethCount + planetTeethCount) / ringGearTeethCount, 0, 0]) 
            rotate([0, 0, i * actualSunGearTeethCount / planetCount * 360 / planetTeethCount - rotationAngle * (actualSunGearTeethCount + planetTeethCount) / planetTeethCount - rotationAngle]) {
                herringboneGear(planetTeethCount, gearPitch, pressureAngle, maxToothDepthRatio, clearanceTolerance, calculatedHelixAngle, gearThickness);
            }
        }
    }

    // Torus/donut shape
    torusShape();
}