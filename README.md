# OpenSCAD Examples

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.13647185.svg)](https://doi.org/10.5281/zenodo.13647185)  

OpenSCAD is a specialized programming language for creating 3D models. Unlike interactive modeling programs where objects are shaped manually, OpenSCAD is based on the description of objects through text files (scripts). These scripts contain instructions that precisely define how an object should be modeled. Below are some key elements of the OpenSCAD language:

1. **Declarative Syntax**: OpenSCAD uses a declarative syntax, meaning that you describe *what* should be done, not *how* it should be done. This approach allows for clear and concise code that specifies the end result without detailing the step-by-step process to achieve it.

2. **Primitive Shapes**: Basic geometric shapes such as cubes, spheres, and cylinders are used as the starting points for more complex models. These primitives can be combined and manipulated to form intricate designs.

3. **Transformations**: Objects can be scaled, rotated, and translated to achieve the desired shapes and structures. Transformations are essential for positioning and orienting objects in the 3D space.

4. **Boolean Operations**: OpenSCAD allows combining different objects or subtracting them from one another. Common operations include union (combining objects), difference (subtracting one object from another), and intersection (finding the common volume of objects).

5. **Modular Structure**: Scripts can include modules that define reusable components or functions, facilitating code reuse. Modules make it easier to manage and organize complex designs by breaking them down into smaller, reusable parts.

6. **Parameters and Variables**: OpenSCAD supports creating customizable designs where certain aspects of the model can be controlled by adjustable parameters. This feature is particularly useful for designing parts that need to be easily modified or scaled.

7. **2D to 3D Conversion**: OpenSCAD also allows for creating 2D shapes and converting them into 3D objects. This process, known as extrusion, can turn flat designs into three-dimensional models.

8. **Loops and Conditional Statements**: For more complex and repetitive structures, loops and conditional statements can be used. These constructs allow for the creation of patterns, arrays, and structures that follow specific rules or conditions.

9. **Community and Libraries**: There is an active community around OpenSCAD, and many libraries are available that provide additional functions and pre-built objects. These resources can significantly extend the capabilities of OpenSCAD, allowing users to build on the work of others.

OpenSCAD is particularly well-suited for technical and precise models, such as those commonly needed in mechanical design and 3D printing. It requires a methodical approach and a good understanding of mathematical and geometric concepts.

---

## Example Descriptions

Below are descriptions of various example projects included in this repository, illustrating the key concepts and techniques in OpenSCAD:

1. **Simple Cube (`./01_cube.scad`)**:
   - A basic example that creates a cube with a side length of 10 units. This is an introductory example demonstrating the creation of primitive shapes in OpenSCAD.

2. **Parametric Cylinder (`./02_cylinder.scad`)**:
   - Defines a customizable cylinder where the height and radius can be specified as parameters. This project showcases the power of parametric design in OpenSCAD.

3. **Boolean Operations (`./03_boolean.scad`)**:
   - Demonstrates a basic boolean operation by subtracting a cylinder from a cube, resulting in a cube with a cylindrical hole through it. This example highlights how to combine and modify shapes using boolean operations.

4. **Looped Cubes (`./04_for.scad`)**:
   - A loop is used to create an array of six cubes, each spaced 15 units apart along the X-axis. This example demonstrates how to use loops to create repetitive structures in OpenSCAD.

5. **Parametric Box (`./05_parametric.scad`)**:
   - Defines a parametric box where the width, height, and depth can be customized. This example is another demonstration of parametric design, highlighting how to create adaptable and reusable 3D models.

6. **Geometric Pattern (`./06_parametric2.scad`)**:
   - Creates a complex geometric pattern of rotated squares arranged in a grid. Each square is rotated based on its position, and the entire pattern is extruded into a 3D shape. This example showcases how to use loops and transformations to create intricate designs.

7. **Game of Life - Gosper's Glider Gun (`./07_conway.scad`)**:
   - Models Gosper's Glider Gun, a configuration in Conway's Game of Life that periodically produces gliders (moving patterns). The code positions a series of cells (cubes) according to the glider gun's configuration on a base plate.

8. **Mandelbrot Set Visualization (`./08_mandelbrot.scad`)**:
   - This project generates a 3D representation of the Mandelbrot set by iterating over points on the complex plane. The number of iterations before divergence is used to determine the height of blocks in a 3D grid, creating a visual representation of the Mandelbrot set.

9. **Vase with Smooth Profile Curve (`./09_vase.scad` and `./10_vase2.scad`)**:
   - This project creates a vase by rotating a profile curve (defined as a set of 2D points) around the Z-axis. The profile curve is smoothed using Catmull-Rom spline interpolation, resulting in a vase with a rounded, organic shape.

10. **Mug with Handle (`./11_mug.scad`)**:
    - Models a mug with a handle, including the inner hollowing and bottom rounding. This example demonstrates the creation of a more complex and practical 3D object.

11. **SVG to STL Conversion (`./12_svg_to_stl.scad`)**:
    - Shows how to import an SVG file and convert it into a 3D shape by extruding the 2D outline to a specific height. This example illustrates the process of turning 2D designs into 3D models.
