[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=dnafinder/trigonometria)

📌 Overview
This repository provides the MATLAB function trigon, which computes and displays the main trigonometric and “goniometric” quantities associated with a single angle. For a given angle (in degrees or radians), the function prints a compact summary table of trigonometric values and draws a goniometric circle plot that visually represents sine, cosine, secant, cosecant, tangent, cotangent, and related geometric quantities. For standard angles in degrees (such as 0°, 30°, 45°, 60°, 90°, and their symmetric counterparts up to 330°), the function also shows exact symbolic-like forms (for example, √3/2 or √2/2) together with their numeric approximations. For special angles, the chord length is also displayed in exact radical form when possible (e.g. √2 at 90°).

✨ Features
The trigon function:
- Accepts an angle either in degrees or in radians via a simple flag.
- Computes classical trigonometric functions (sine, cosine, tangent, cotangent, secant, cosecant) and several derived quantities (versed sine, versed cosine, external secant, external cosecant, chord length, circular sector).
- Recognizes a set of special angles in degrees and, for those angles, displays exact analytic forms (e.g. √3/2, √2/2, 1/√3, √2 for the chord at 90°, Inf) together with numeric approximations like (≈ 0.8660) where meaningful.
- Ensures that exact values 0, 1, and -1 are shown cleanly without numeric suffixes, so that cases like cos(90°) and sin(90°) appear as '0' and '1' rather than approximate decimals.
- Ensures that for infinite exact values (e.g. tan(90°), sec(90°), csc(0°)), the table shows 'Inf' or '-Inf' without any misleading numeric approximation.
- Determines the quadrant of the angle based on the signs of sine and cosine.
- Displays a summary table with numeric values, symbolic multiples of pi for the arc, and exact+numeric forms for the main trigonometric functions (and the chord) when available.
- Plots a goniometric circle with radius, arc, chord, projections, and external segments for secant and cosecant, helping to visualize the relationships among trigonometric functions.
- Uses a fixed plotting window with axis limits [-2.5, 2.5] so that the unit circle remains visible even when some trigonometric functions become very large.

🛠 Installation
Download or clone this repository from GitHub:
https://github.com/dnafinder/trigon

Add the folder containing trigon.m to your MATLAB path, either using the graphical Add Folder to Path option or with the addpath command. The function relies only on core MATLAB functionality and does not require additional toolboxes. For best display of the radical symbol (√), use UTF-8 encoding in MATLAB.

▶️ Usage
The function can be called with zero, one, or two input arguments:

- trigon()
  Uses the default angle of 60 degrees.

- trigon(angle)
  Interprets angle as degrees and computes all quantities for that angle.

- trigon(angle, deg)
  Uses angle as the input angle and deg as a flag:
    deg = 1  -> angle is in degrees
    deg = 0  -> angle is in radians

Example:
  trigon(45)
  computes all trigonometric quantities for 45 degrees and displays both the table of values and the goniometric circle. For this angle, the table shows exact forms such as √2/2 for sine and cosine, and √2 for the chord, each accompanied by a numeric approximation where appropriate.

📥 Inputs
The function accepts up to two positional inputs:

angle : Optional scalar numeric value representing the angle. If the second argument deg is 1 (or omitted), angle is interpreted in degrees. If deg is 0, angle is interpreted in radians. By default, angle = 60.

deg : Optional scalar flag (0 or 1) indicating the unit of measure:
  1  -> angle is in degrees (default)
  0  -> angle is in radians

If no inputs are provided, trigon uses angle = 60 and deg = 1.

📤 Outputs
The trigon function does not return any output variables. Instead, it:

- Prints a table with one column (TrigFun) and the following rows:
  - Angle_Deg
  - Arc_Rad
  - Quadrant
  - Radius
  - Circular_Sector
  - Chord
  - Cosine_(cos)
  - Versed_Sine_(versin)
  - External_Secant_(exsec)
  - Secant_(sec)
  - Sine_(sin)
  - Versed_Cosine_(coversin)
  - External_Cosecant_(excsc)
  - Cosecant_(csc)
  - Tangent_(tan)
  - Cotangent_(cot)

For the main trigonometric functions and the chord, the table entries behave as follows:
- At recognised special angles (e.g. 30°, 45°, 60°, 90°), cos, sin, tan, sec, csc, cot, and the chord are shown as a combination of exact form and numeric approximation, for example:
  - "√3/2 (≈ 0.8660)"
  - "√2/2 (≈ 0.7071)"
  - "1/√3 (≈ 0.5774)"
  - "√2 (≈ 1.4142)" for the chord at 90°
- At other angles, these entries are shown as plain numeric values.
- For the exact integer values 0, 1, and -1, the table shows only the exact value (e.g. '0' for cos(90°), '1' for sin(90°), '1' for tan(45°)).
- For singular cases such as tan(90°) or sec(90°), the exact form is displayed as 'Inf' or '-Inf' without any appended numeric approximation.
- Infinite values that are not part of the exact table are represented using MATLAB’s standard Inf or -Inf.

- Opens (or updates) a figure window showing:
  - The unit goniometric circle and coordinate axes.
  - The radius corresponding to the input angle.
  - The arc from 0 to the input angle and the associated circular sector.
  - The chord, cosine and sine projections, versed functions, secant and cosecant segments, and the tangent and cotangent segments.
  - A fixed axis window [-2.5, 2.5] × [-2.5, 2.5], ensuring that the unit circle remains visible even when secant, cosecant, or tangent are very large.

🔍 Interpretation
The textual and graphical outputs are designed as an educational aid to understand the geometry behind trigonometric functions:

- The unit circle shows how sine and cosine are the y- and x-coordinates of the point on the circle corresponding to the angle.
- The chord represents the straight-line distance between the endpoints of the arc, illustrating its relation to the half-angle formula and revealing neat exact values such as √2 for a 90° arc.
- Versed sine and versed cosine (versin and coversin) encode how far cosine and sine are from their reference anchors (1 or -1), which is useful in some historical and engineering contexts.
- The external secant and external cosecant highlight how secant and cosecant extend beyond the unit circle.
- Tangent and cotangent appear as segments connecting the point on the circle with the corresponding intercepts on the axes or secant/cosecant lines.
- For special angles, the combination of exact and approximate values makes it easy to connect the geometric picture, the numerical evaluation, and the exact mathematical expressions such as √3/2, √2/2, and √2 (for the chord).
- For singular cases, showing a clean 'Inf' or '-Inf' in both the exact form and the plot helps emphasize the blow-up behaviour of these functions without visual clutter.

Because all of these constructions are shown in a single plot, trigon can serve both as a quick numeric calculator and as a visual tool for teaching or revising trigonometry.

📝 Notes
The function assumes a unit radius for the goniometric circle. The plotting window is clamped to [-2.5, 2.5] in both X and Y so that the unit circle remains visible even when some trigonometric functions become very large or infinite near 90°, 270°, and related angles. The internal version 2.4.0 adds exact-form support for a set of special angles using a true radical symbol (√), extends exact forms to the chord where possible, and cleans up the display of exact values 0, 1, -1, Inf, and -Inf. For best display results, save and use the file with UTF-8 encoding in MATLAB.

📚 Citation
If you use this code for teaching, educational materials, or technical work, please cite:

Cardillo G. (2024)
"Trigonometria".
Available from GitHub:
https://github.com/dnafinder/trigonometria

👤 Author
Author: Giuseppe Cardillo
Email: giuseppe.cardillo.75@gmail.com
GitHub: https://github.com/dnafinder

⚖️ License
This project is distributed under the MIT License. You are free to use, modify, and redistribute the code, provided that the original copyright notice and license text are preserved. The full license terms are provided in the LICENSE file in this GitHub repository.
