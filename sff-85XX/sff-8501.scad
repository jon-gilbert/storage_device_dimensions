// LibFile: sff-8501.scad
// FileGroup: External Bay Drives
// FileSummary: 5.25" Full-height Drives
// Description:
//   5.25" drive dimensions per SFF-8501 rev 1.1 (1995/06/04).
//   Reference SFF-8501 dimensions from https://members.snia.org/document/dl/25928
//
// Includes:
//   include <sff-8501.scad>

include <BOSL2/std.scad>
MAKE = false;


// Function: sff_8501_dimensions()
// Synopsis: Return a list of 5.25" drive dimensions
// Usage:
//   A = sff_8501_dimensions();
//   A = sff_8501_dimensions(<a1=82.55>);
// Description:
//   Returns a list of dimensions as specified in SFF-8501, defining 
//   a 5.25" disk drive. All measurements returned are in millimeters.
//   Reference table 5-1 from SFF-8501 (https://members.snia.org/document/dl/25931):
//   .
//   TABLE 5-1 5.25" DISK DRIVE DIMENSIONS
//   | Dimension | Millimeters | Inches  |
//   |-----------|------------:|--------:|
//   | A 1       | 82.55 *     | 3.250 * |
//   | A 2       |       *     | .000 *  |
//   | A 3       |       *     | .000 *  |
//   | A 4       | 204.72      | 8.060   |
//   | A 5       | 146.05      | 5.750   |
//   | A 6       | 139.70      | 5.500   |
//   | A 7       | 3.05        | .120    |
//   | A 8       | 79.24       | 3.120   |
//   | A 9       | 80.30       | 3.161   |
//   | A10       | 80.20       | 3.157   |
//   | A11       | 79.24       | 3.120   |
//   | A12       |             | .000    |
//   | A13       | 9.91        | .390    |
//   | A14       | 21.84       | .860    |
//   * = maximum
//   .
//   ![Figure 5-1](images/sff-8501/sff-8501-figure5-1.png)
//   .
//   Where flagged as "Maximum" in the above table, the dimension may be less than 
//   the stated value (eg for `A1`, the height of the drive, the drive itself may be 
//   shorter than `82.55`). There aren't any defined minimums.
//   .
//   Note that the presence of A2 & A3 in the above table is *not* reflected in 
//   SFF-8501's table 5-1. That table defines *three* different A1 entries, but only 
//   one value is present in the provided diagram: there is an editor's note within 
//   the specification document addressing this. In this function, `sff_8501_dimensions()`, 
//   A2 and A3 are the same as A1, which can be lowered at the caller's specific requirement. 
// Arguments:
//   ---
//   a1 = Set a value smaller than the above-defined maximum. Default: `82.55`
// Continues:
//   It is an error to specify a value for A1 that is not between `0` and its listed maximum value.
//   Dimension elements `0` and `12` are set as `undef`, as they do not appear in table 5-1. 
// Example(NORENDER):
//   A = sff_8501_dimensions();
//   echo(A[4]);
//   // Yields: ECHO: 202.72
//
function sff_8501_dimensions(a1=82.55) = 
    assert(a1 > 0 && a1 <= 82.55, "A1 must be a value between 0 and 82.55")
    [
        undef,  // A0 = not present
        a1,     // A1
        a1,     // A2
        a1,     // A3
        202.72, // A4
        146.05, // A5
        139.70, // A6
        3.05,   // A7
        79.24,  // A8
        80.30,  // A9
        80.20,  // A10
        79.24,  // A11
        undef,  // A12 = not listed in spec
        9.91,   // A13
        21.84,  // A14
    ];


// Module: sff_8501()
// Synopsis: Model a 5.25" disk drive
// Usage:
//   sff_8501();
//   sff_8501(<a=undef>, <anchor=CENTER>, <spin=0>, <orient=UP>);
//   [PARENT] sff_8501();
// Description:
//   Produces a model of a 5.25" disk drive, according to the dimensions of SFF-8501. 
//   .
//   The resulting model is BOSL2-attachable; see https://github.com/BelfrySCAD/BOSL2/wiki/Tutorial-Attachments for details on how to use this.
//
// Arguments:
//   ---
//   a = A list of dimensions from `sff_8501_dimensions()`. Default: `undef`, in which case `sff_8501_dimensions()` will be called and its values used directly
//   anchor = Translates the model so that the specified anchor point is located at origin `[0,0,0]`. Default: `CENTER`
//   spin = Rotates the model this many degrees around the Z-axis after anchoring. Default: `0`
//   orient = Repositions the model in this direction after spin is applied. Default: `UP`
// Continues:
//   SFF-8501 does not define connector position information, and there is none provided by `sff_8501()`.
//   .
//   SFF-8501 defines the mounting screw specification as 6-32 UNC 2B, and it requires that
//   screw mounts must accept at least two threads' worth of engagement at each mount point. For the purposes of this model, 
//   `sff_8501()` uses a diameter of `3.6`, and screw length of `4`.
//   .
// Example: a basic 5.25" disk drive:
//   sff_8501();
// Example: a half-height 5.25" bay disk drive using a modified set of dimensions from `sff_8501_dimensions()`:
//   half_height_drive = sff_8501_dimensions(a1=41.27);
//   sff_8501(a=half_height_drive);
//
module sff_8501(bezel=true, button=true, a=undef, anchor=CENTER, spin=0, orient=UP) {
    A = (is_list(a)) ? a : sff_8501_dimensions();
    screw_mount_diameter = 3.6;
    screw_mount_length = 4;
    
    // setting `button` to `true` implies `bezel` must also be `true`:
    bezel_ = (button) ? true : bezel;

    size = [
        A[5],
        A[4],
        A[1]
        ];

    attachable(anchor, spin, orient, size=size) {
        back(size.y / 2)
            difference() {
                cuboid(size, anchor=BACK);

                xflip_copy() {
                    // four side mounting points, RIGHT side
                    move_copies([
                            [A[5]/2 + 1, -1 * (A[10]),         A[13] - A[1]/2], 
                            [A[5]/2 + 1, -1 * (A[10]),         A[14] - A[1]/2], 
                            [A[5]/2 + 1, -1 * (A[10] + A[11]), A[13] - A[1]/2],
                            [A[5]/2 + 1, -1 * (A[10] + A[11]), A[14] - A[1]/2],
                            ])
                        cyl(d=screw_mount_diameter, l=screw_mount_length, orient=LEFT, anchor=BOTTOM);
                    // two bottom mounting points, RIGHT side
                    move_copies([
                            [A[6]/2 + 1, -1 * (A[9]),        -1 * (A[1]/2)],
                            [A[6]/2 + 1, -1 * (A[9] + A[8]), -1 * (A[1]/2)],
                            ])
                        cyl(d=screw_mount_diameter, l=screw_mount_length, orient=UP, anchor=BOTTOM);
                }
            }
        children();
    }
}

if (MAKE)
    sff_8501();

