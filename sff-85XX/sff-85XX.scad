// LibFile: sff-8501.scad
//   5.25" drive dimensions per SFF-85XX as per 2025/02/01.
//   See https://www.snia.org/technology-communities/sff/specifications?field_data_field_sff_doc_status=All&combine=sff-85&field_release_date_value_2%5Bvalue%5D%5Bdate%5D=&field_release_date_value%5Bvalue%5D%5Bdate%5D=&items_per_page=20 
//   for the full set of 5.25" drive dimension specifications.
// FileGroup: External Bay Drives
// FileSummary: 5.25" Full-height Drives
//
// Includes:
//   include <sff-85XX.scad>
//


include <BOSL2/std.scad>
MAKE = false;


// Section: SFF-8501
//   5.25" disk drive dimensions per SFF-8501 rev 1.1 (1995/06/04).
//   Reference SFF-8501 dimensions from https://members.snia.org/document/dl/25928
//
// Function: sff_8501_dimensions()
// Synopsis: Return a list of 5.25" drive dimensions
// Usage:
//   A = sff_8501_dimensions();
//   A = sff_8501_dimensions(<a1=82.55>);
// Description:
//   Returns a the dimensions as specified in SFF-8501, defining 
//   a 5.25" disk drive, as list a `A`. All measurements returned are in millimeters.
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
//   ![Figure 5-1](images/sff-85XX/sff-8501-figure5-1.png)
//   .
//   Where flagged as "Maximum" in the above table, the dimension may be less than 
//   the stated value (eg for A1, the height of the drive, the drive itself may be 
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
// Example(Render): a basic 5.25" disk drive:
//   sff_8501();
// Example(Render): a half-height 5.25" bay disk drive using a modified set of dimensions from `sff_8501_dimensions()`:
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


// Section: SFF-8551
//   5.25" optical drive dimensions per SFF-8551 rev 3.3 (1995/07/27).
//   Reference SFF-8551 dimensions from https://members.snia.org/document/dl/25931
//
// Function: sff_8551_dimensions()
// Synopsis: Return a list of 5.25" drive dimensions
// Usage:
//   A = sff_8551_dimensions();
//   A = sff_8551_dimensions(<a1=41.53>, <a4=202.80>);
// Description:
//   Returns the dimensions as specified in SFF-8551, defining 
//   a 5.25" optical drive as a list `A`. All measurements returned are in millimeters.
//   Reference table 5-1 from SFF-8551 (https://members.snia.org/document/dl/25931):
//   .
//   | Dimension |Millimeters| Inches |
//   |-----------|----------:|-------:|
//   | A 1       | 41.53     | 1.635* |
//   | A 2       | 42.30     | 1.665  |
//   | A 3       | 148.00    | 5.827  |
//   | A 4       | 202.80    | 7.984* |
//   | A 5       | 146.05    | 5.750  |
//   | A 6       | 139.70    | 5.500  |
//   | A 7       | 3.18      | 0.125  |
//   | A 8       | 79.25     | 3.120  |
//   | A 9       | 47.40     | 1.866  |
//   | A10       | 47.40     | 1.866  |
//   | A11       | 79.25     | 3.120  |
//   | A13       | 10.00     | 0.394  |
//   | A14       | 21.84     | 0.860  |
//   | A16       | 6.50      | 0.256  |
//   | A17       | 5.00      | 0.197  |
//   * = Maximum
//   .
//   ![Figure 5-1](images/sff-85XX/sff-8551-figure5-1.png)
//   .
//   Where flagged as "Maximum" in the above table, the dimension may be less than 
//   the stated value (eg for A4, the length of the drive, the drive itself may be 
//   shorter than `202.80`). There aren't any defined minimums.
// Arguments:
//   ---
//   a1 = Set a value smaller than the above-defined maximum. Default: `41.53`
//   a4 = Set a value smaller than the above-defined maximum. Default: `202.80`
// Continues:
//   It is an error to specify a value for A1 and A4 that is not between `0` its listed maximum value.
//   Dimension elements `0`, `12`, and `15` are set as `undef`, as they do not appear in table 5-1. 
// Example(NORENDER):
//   A = sff_8551_dimensions();
//   echo(A[1]);
//   // Yields: ECHO: 41.53
//
function sff_8551_dimensions(a1=41.53, a4=202.80) = 
    assert(a1 > 0 && a1 <= 41.53, "A1 must be a value between 0 and 41.53")
    assert(a4 > 0 && a4 <= 202.80, "A4 must be a value between 0 and 202.80")
    [
        undef,  // A0 = not present
        a1,     // A1
        42.50,  // A2
        148,    // A3
        a4,     // A4
        146.05, // A5
        139.70, // A6
        3.18,   // A7
        79.25,  // A8
        47.40,  // A9
        47.40,  // A10
        79.25,  // A11
        undef,  // A12 = not listed in spec
        10,     // A13
        21.84,  // A14
        undef,  // A15 = not listed in spec
        6.50,   // A16
        5       // A17
    ];


// Module: sff_8551()
// Synopsis: Model a 5.25" optical drive
// Usage:
//   sff_8551();
//   sff_8551(<bezel=true>, <button=true>, <anchor=CENTER>, <spin=0>, <orient=UP>);
//   [PARENT] sff_8551(<bezel=true>, <button=true>);
// Description:
//   Produces a model of a 5.25" optical drive, according to the dimensions of SFF-8551. 
//   .
//   The resulting model is BOSL2-attachable; see https://github.com/BelfrySCAD/BOSL2/wiki/Tutorial-Attachments for details on how to use this.
//
// Arguments:
//   ---
//   bezel = A boolean which, if set to `false`, will produce a model without its front bezel. Default: `true`
//   button = A boolean which, if set to `false`, will produce a model without a front button. Setting `button` to `true` implicitly sets `bezel` to `true`. Default: `true`
//   a = A list of dimensions from `sff_8551_dimensions()`. Default: `undef`, in which case `sff_8551_dimensions()` will be called and its values used directly
//   anchor = Translates the model so that the specified anchor point is located at origin `[0,0,0]`. Default: `CENTER`
//   spin = Rotates the model this many degrees around the Z-axis after anchoring. Default: `0`
//   orient = Repositions the model in this direction after spin is applied. Default: `UP`
// Continues:
//   SFF-8551 does not define connector position information, and there is none provided by `sff_8551()`.
//   SFF-8551 also does not define screw thread pitch for the eight mounting positions, only general positioning information. However, it does require that 
//   screw mounts must accept at least two threads' worth of engagement at each mount point. For the purposes of this model, the assumption is a 
//   thread pitch of `1` making the minimum depth `2`; `sff_8551()` uses a screw length of `4`.
//   SFF-8551 also does not define the dimensions of the forward button beyond its protruding distance relative to the front of the drive bay. `sff_8551()` makes 
//   a generalized assumption regarding the button's size and placement. 
// Example(Render): a basic 5.25" optical drive:
//   sff_8551();
// Example(Render): a roughly-carved-out 5.25" drive bay mount:
//   diff()
//     sff_8551(button=false)
//       up(2)
//         attach(CENTER)
//           tag("remove")
//             cuboid([140, 203, 42])
//               attach(FWD, BACK)
//                 cuboid([140, 10, 30]);
// Example(Render): a half-depth 5.25" bay drive using a modified set of dimensions from `sff_8551_dimensions()`:
//   short_drive = sff_8551_dimensions(a4=100);
//   sff_8551(a=short_drive);
//
module sff_8551(bezel=true, button=true, a=undef, anchor=CENTER, spin=0, orient=UP) {
    A = (is_list(a)) ? a : sff_8551_dimensions();
    screw_mount_diameter = 3;
    screw_mount_length = 4;
    
    // setting `button` to `true` implies `bezel` must also be `true`:
    bezel_ = (button) ? true : bezel;

    size = [
        (bezel_) ? A[3] : A[5], 
        A[4] + ((button) ? A[16] : ((bezel_) ? A[17] : 0)), 
        A[2]
        ];

    attachable(anchor, spin, orient, size=size) {
        fwd(A[4] - size.y/2)
            difference() {
                cuboid([A[5], A[4], A[1]], anchor=FWD)
                    if (bezel_)
                        attach(FWD, BACK)
                            cuboid([A[3], A[17], A[2]])
                                if (button)
                                    down(A[2]/4)
                                        right(A[3]/3)
                                            attach(FWD, BACK)
                                                cuboid([20, (A[16] - A[17]), 5]);

                xflip_copy() {
                    // four side mounting points, RIGHT side
                    move_copies([
                            [A[5]/2 + 1, A[10],         A[13] - A[1]/2], 
                            [A[5]/2 + 1, A[10],         A[14] - A[1]/2], 
                            [A[5]/2 + 1, A[10] + A[11], A[13] - A[1]/2],
                            [A[5]/2 + 1, A[10] + A[11], A[14] - A[1]/2],
                            ])
                        cyl(d=screw_mount_diameter, l=screw_mount_length, orient=LEFT, anchor=BOTTOM);
                    // two bottom mounting points, RIGHT side
                    move_copies([
                            [A[6]/2, A[9],        -1 * (A[2]/2)],
                            [A[6]/2, A[9] + A[8], -1 * (A[2]/2)],
                            ])
                        cyl(d=screw_mount_diameter, l=screw_mount_length, orient=UP, anchor=BOTTOM);
                }
            }
        children();
    }
}


