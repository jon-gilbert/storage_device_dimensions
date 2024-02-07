// LibFile: sff-8200.scad
//   2.5" disk drive dimensions per SFF-82XX as per 2024/02/01. 
//   See https://www.snia.org/technology-communities/sff/specifications?field_data_field_sff_doc_status=All&combine=sff-82&field_release_date_value_2%5Bvalue%5D%5Bdate%5D=&field_release_date_value%5Bvalue%5D%5Bdate%5D=&items_per_page=20 
//   for the full set of 2.5" drive dimension specifications.
// FileGroup: Internal Bay Drives
// FileSummary: 2.5" Disk Drives
// 
// Includes:
//   include <sff-82XX.scad>
//

include <BOSL2/std.scad>
MAKE = false;


// Section: SFF-8200
//   2.5" disk drive dimensions per SFF-8200 rev 3.3 (2016/01/16). 
//   Reference SFF-8200 dimensions from https://members.snia.org/document/dl/25850
//   .
//   The dimensions in SFF-8200 are wholesale replicated into SFF-8201. As SFF-8200
//   seems to be a broader, catch-all specification, callers are encouraged to use 
//   the drive-specific SFF-8201 modules and functions, listed below. 
//
// Function: sff_8200_dimensions()
// Synopsis: Synonym for sff_8201_dimensions()
// Usage:
//   A = sff_8201_dimensions();
//   A = sff_8201_dimensions(<a1=19.06>, <a6=100.45>);
// Description:
//   Synonym for `sff_8201_dimensions()`
// See also: sff_8201_dimensions()
function sff_8200_dimensions(a1=19.05, a6=100.45) = sff_8201_dimensions(a1, a6);


// Module: sff_8200()
// Synopsis: Synonym for sff_8201()
// Usage:
//   sff_8200();
//   sff_8200(<a=undef,>, <anchor=CENTER>, <spin=0>, <orient=UP>);
//   [PARENT] sff_8200();
// Description:
//    Synonym for `sff_8201()`
// See also: sff_8201()
module sff_8200(a=undef, bottom_mounts=true, anchor=CENTER, spin=0, orient=UP) {
    sff_8201(a=a, bottom_mounts=bottom_mounts, anchor=anchor, spin=spin, orient=orient)
        children();
}


// Section: SFF-8201
//   2.5" disk drive dimensions per SFF-8201 rev3.4 (2018/01/19)
//   Reference SFF-8201 dimensions from https://members.snia.org/document/dl/25851
//
// Function: sff_8201_dimensions()
// Synopsis: return a list of dimensions for a 2.5" internally mounted disk drive
// Usage:
//   A = sff_8201_dimensions();
//   A = sff_8201_dimensions(<a1=19.06>, <a6=100.45>);
// Description:
//   Returns a list of 2.5" disk drive dimensions, `A`, as specified by SFF-8200.
//   All values are returned in millimeters (mm). 
//   Reference https://members.snia.org/document/dl/25850 for SFF-8200.
//   .
//   TABLE 3-1 DISK DRIVE DIMENSIONS
//   | Dimension |     | Millimeters | Inches | Comments |
//   |-----------|-----|------------:|-------:|----------|
//   | A1        |     | 19.05       | 0.750  | |
//   | A1        |     | 17.00       | 0.669  | |
//   | A1        |     | 15.00       | 0.591  | |
//   | A1        |     | 12.70       | 0.500  | |
//   | A1        |     | 10.50       | 0.413  | |
//   | A1        |     | 9.50        | 0.374  | A2=A3=0.20 mm |
//   | A1        |     | 8.47        | 0.333  | |
//   | A1        |     | 7.00        | 0.276  | A2=0.20 mm |
//   | A1        |     | 5.00        | 0.197  | A2=A3=0.20 mm |
//   | A2        |     | 0.00        | 0.000  | |
//   | A3        |     | 0.50        | 0.020  | |
//   | A4        |     | 69.85       | 2.750  | |
//   | A5        |     | 0.25        | 0.010  | |
//   | A6        | Max | 101.85      | 4.010  | Obsolete |
//   | A6        | Max | 100.45      | 3.955  | New requirement |
//   | A10       |     | 100.20      | 3.945  | SFF-8212 |
//   | A11       |     | 100.50      | 3.957  | SFF-8223 |
//   | A12       |     | 110.20      | 4.339  | SFF-8222 |
//   | A23       |     | 3.00        | 0.118  | |
//   | A24       |     | 34.93       | 1.375  | Obsolete |
//   | A25       |     | 38.10       | 1.500  | Obsolete |
//   | A26       |     | M3          | N/A    | |
//   | A27       |     | 0.50        | 0.020  | |
//   | A28       |     | 4.07        | 0.160  | |
//   | A29       |     | 61.72       | 2.430  | |
//   | A30       |     | 34.93       | 1.375  | Obsolete |
//   | A31       |     | 38.10       | 1.500  | Obsolete |
//   | A33       |     | 0.50        | 0.020  | |
//   | A37       |     | 8.00        | 0.315  | |
//   | A50       |     | 14.00       | 0.551  | |
//   | A51       |     | 90.60       | 3.567  | |
//   | A52       |     | 14.00       | 0.551  | |
//   | A53       |     | 90.60       | 3.567  | |
//   .
//   Threads
//   | A32 |     | Size        | M3  | |
//   |-----|-----|------------:|----:|-|
//   | A38 | Min | Penetration | 3   | 2 for A1 ≤ 7 mm |
//   | A41 | Min | Penetration | 2.5 | |
//   .
//   ![SFF-8201 Figure 3-1](images/sff-82XX/sff-8201-fig3-1.png)
//   .
//   ![SFF-8201 Figure 3-2](images/sff-82XX/sff-8201-fig3-2-detailB.png)
//   .
//   Where flagged as "Max" in the above table,the dimension may be less 
//   than the stated value (eg, for A6, the value may be shorter than `100.45`).
//   There aren't any defined minimums.
//   .
//   Note that the above table defines several A1 entries while only one is
//   present in the diagram. For SFF-8201, those are the only allowable possible 
//   values for A1.
// Arguments:
//   a1 = Specify an explicit dimension for measurement A1. Default: `19.05`
//   a6 = Specify an explicit dimension for measurement A6. Default: `100.45`
// Continues:
//   It is an error to specify a value for A1 that is not listed in SFF-8200. It is an error 
//   to specify a value for A6 that exceeds its listed maximum, or that is not greater than zero.
//   .
///   Dimension elements `0`, `7` - `9`, and `15` are set as `undef`, as they do not appear in table 3-1. 
//   Several dimension elements are not preset in table 3-1, and will return as `undef` in the position 
//   list returned. They are: `0 7 8 9 13 14 15 16 17 18 19 20 21 22 34 35 36 42 43 44 45 46 47 48 49`.
//   .
//   SFF-8201 defines A26 as `M3`, which is interpreted by `sff_8201_dimensions()` as the diameter 
//   of an M3 metric screw, or `3.00`.
//   Note that A2, A3, and A38 will change based on the value selected for A1 in accordance with 
//   table 3-1, above.
//
// Todo: 
//   A38 and A42 are minimum values, and can concievably be as great as the dimension to which they are applied. 
//
// Example(NORENDER):
//   A = sff_8201_dimensions();
//   echo(A[28]);
//   // Yields: ECHO: 4.07
//
function sff_8201_dimensions(a1=19.05, a6=100.45) =
    let(
        a1_valids = [ 19.05, 17.00, 15.00, 12.70, 10.50, 9.50, 8.47, 7.00, 5.00 ]
    )
    assert(in_list(a1, a1_valids),
        str( "Value A1 for a 2.5\" drive must be one of the following valid values: ", a1_valids ))
    assert(a6 > 0 && a6 <= 101.85, 
        "Value A6 for a 2.5\" drive must be greater than 0 (zero) and no greater than 101.85")
    let(
        a2 = (in_list(a1, [ 9.50, 7.00, 5.00 ])) ? 0.20 : 0.00,
        a3 = (in_list(a1, [ 9.50, 5.00 ])) ? 0.20 : 0.50,
        a38 = (a1 <= 7.00) ? 2 : 3
    )
    [
        undef,  // A0 - not present
        a1,     // A1
        a2,     // A2
        a3,     // A3
        69.85,  // A4
        0.25,   // A5
        a6,     // A6
        undef, undef, undef, // A7 .. A9 - not present
        100.20, // A10
        100.50, // A11
        110.20, // A12
        undef, undef, undef, undef, undef, undef, undef,  // A13 .. A19 - not present
        undef, undef, undef, // A20 .. A22 - not present
        3.00,   // A23
        34.93,  // A24
        38.10,  // A25
        3.00,   // A26 - detailed as "M3"; taking as meant an M3 screw, or 3.0 diam
        0.50,   // A27
        4.07,   // A28
        61.92,  // A29
        34.93,  // A30
        38.10,  // A31
        undef,  // A32 - not present
        0.50,   // A33
        undef, undef, undef, // A34 .. A36 - not present
        8.00,   // A37
        a38,    // A38
        undef,  // A39 - not present
        undef,  // A40 - not present
        2.5,    // A41
        undef, undef, undef, undef, undef, undef, undef, undef, // A42 .. A49 - not present
        14.00,  // A50
        90.60,  // A51
        14.00,  // A52
        90.60,  // A53
    ];


// Module: sff_8201()
// Synopsis: Model a 2.5" internal disk drive
// Usage:
//   sff_8201();
//   sff_8201(<a=undef,>, <bottom_mounts=true>, <anchor=CENTER>, <spin=0>, <orient=UP>);
//   [PARENT] sff_8201();
// Description:
//   Produces a model of a 2.5" internal disk drive, according to the dimensions of SFF-8201. There are variations allowed in some 
//   labeled dimensions detailed in SFF-8201: to use those variations you need to call `sff_8201_dimensions()` and pass the 
//   modified dimension list as an argument `a`.  
//   SFF-8201 usually provides eight mounting points - four on the bottom surface, and two on each of the left and right surfaces. 
//   However, when the device's height (dimension A1) is 7mm or less, the bottom mounts may be optional. To inhibit the addition of 
//   those bottom mount points, set `bottom_mounts` to `false`. Note that bottom mounts are always added when the device's A1 dimension 
//   is larger than 7mm.
//   .
//   SFF-8201 indicates a connector slot but does not provide dimensions for it. In models produced by `sff_8201()`, the connector side is 
//   oriented towards `BACK`, or in the positive Y-axis direction. Other modules produced within the SFF-82XX set can use the model from 
//   `sff_8201()` to produce connecter-specific models for their spec. 
//   .
//   The resulting model from `sff_8201()` is BOSL2-attachable; see https://github.com/BelfrySCAD/BOSL2/wiki/Tutorial-Attachments for details on how to use this.
//
// Arguments:
//   a = A list of dimensions from `sff_8201_dimensions()`. Default: `undef`, in which case `sff_8201_dimensions()` will be called and its values used directly
//   bottom_mounts = If set to `false`, drives with an A1 dimension that is less than or equal to `7.00` will not have bottom mounting holes. Default: `true`
//   anchor = Translates the model so that the specified anchor point is located at origin `[0,0,0]`. Default: `CENTER`
//   spin = Rotates the model this many degrees around the Z-axis after anchoring. Default: `0`
//   orient = Repositions the model in this direction after spin is applied. Default: `UP`
// Continues:
//   SFF-8201 does not define the material or thickness that makes up A37, the diameter around the mount points. For the purposes of 
//   `sff_8201()`, it's set at `0.01` and carved away from the main drive body to show where they'd be placed on an actual device.
// Named Anchors:
//   Y1, Y2, Y3, Y4 = The four mounting points on the left and right hand sides of the drive, oriented outwards.
//   X1, X2, X3, X4 = The four mounting points on the bottom of the drive (if they should be present based on SFF-8201), oriented downwards.
//   CONNECTOR END = The back of the drive, oriented towards the back.
// Figure(3D,Med): Available anchor points:
//   expose_anchors() sff_8201() show_anchors(std=false);
// Example(Render,Med,ScriptUnder): a basic 2.5" disk drive:
//   sff_8201();
// Example(Render,Med,ScriptUnder): a 7mm-thick 2.5" disk drive, using a modified set of dimensions from `sff_8201_dimensions()`:
//   seven_mm = sff_8201_dimensions(a1=7);
//   sff_8201(a=seven_mm);
//
module sff_8201(a=undef, bottom_mounts=true, anchor=CENTER, spin=0, orient=UP) {
    A = (is_list(a)) ? a : sff_8201_dimensions();
    a37_depth = 0.01;
    size = [ A[4], A[6], A[1] + A[2] - A[3] ];

    anchors = _sff_8201_anchors(A, bottom_mounts);

    attachable(anchor, spin, orient, size=size, anchors=anchors) {
        difference() {
            cuboid(size, anchor=CENTER);
            for (anchor=anchors) {
                if (in_list(anchor[0], ["Y1", "Y2", "Y3", "Y4", "X1", "X2", "X3", "X4"])) {
                    screw_len = (in_list(anchor[0], ["Y1", "Y2", "Y3", "Y4"])) ? A[38] : A[41];
                    move(anchor[1])
                        cyl(d=A[38], l=screw_len, anchor=TOP, orient=anchor[2])
                            attach(TOP, BOTTOM, overlap=a37_depth)
                                cyl(d=A[37], l=a37_depth);
                }
            }
        }
        children();
    }
}


function _sff_8201_anchors(A, bottom_mounts) =
    let(
        bmh = (A[1] > 7.00) ? true : bottom_mounts,
        size = [ A[4], A[6], A[1] + A[2] - A[3] ]
    )
    concat(
        [
            named_anchor("CONNECTOR END", [0, size.y/2, 0], BACK, 0),
            //
            named_anchor("Y1", [ size.x/2,      size.y / 2 - A[52], -1 * (size.z/2 - A[23]) ], RIGHT, 0),
            named_anchor("Y2", [ size.x/2,      size.y / 2 - A[53], -1 * (size.z/2 - A[23]) ], RIGHT, 0),
            named_anchor("Y3", [ -1 * size.x/2, size.y / 2 - A[52], -1 * (size.z/2 - A[23]) ], LEFT,  0),
            named_anchor("Y4", [ -1 * size.x/2, size.y / 2 - A[53], -1 * (size.z/2 - A[23]) ], LEFT,  0),
        ],
        (bmh)
            ? [ 
                named_anchor("X1", [ A[29]/2,      size.y/2 - A[50], -1 * (size.z/2) ], DOWN, 0),
                named_anchor("X2", [ A[29]/2,      size.y/2 - A[51], -1 * (size.z/2) ], DOWN, 0),
                named_anchor("X3", [ -1 * A[29]/2, size.y/2 - A[51], -1 * (size.z/2) ], DOWN, 0),
                named_anchor("X4", [ -1 * A[29]/2, size.y/2 - A[50], -1 * (size.z/2) ], DOWN, 0)
                ]
            : []
    );


if (MAKE)
    sff_8201();


// Section: SFF-8212
//   2.5" disk drives with 50-pin connector per SFF-8212 rev 1.4 (1995/07/27). 
//   Revised as EIA-720-B 2016/01 at Rev 1.4 dated August 30, 2014
//   Reference SFF-8212 dimensions from https://members.snia.org/document/dl/25852
//
// Function: sff_8212_dimensions()
// Synopsis: return a list of dimensions for the positioning of a 50-pin connector on a 2.5" disk drive
// Usage:
//   A = sff_8212_dimensions();
//   A = sff_8212_dimensions(<a34=1.00>, <a35=8.00>, <a36=60.20>, <a39=1.25>, <a40=0.25>);
// Description:
//   Returns the dimensions that detail the position of a 50-pin connector on a 2.5" 
//   disk drive, as list `A`. All values are returned in millimeters (mm).
//   .
//   Reference https://members.snia.org/document/dl/25852 for SFF-8212.
//   .
//   TABLE 3-1 50-PIN CONNECTOR LOCATION
//   | Dimension |     | Millimeters | Inches |
//   | ----------|-----|------------:|-------:|
//   | A 7       |     | 31.17       | 1.227  |
//   | A 8       |     | 1.00        | 0.039  |
//   | A 9       |     | 3.99        | 0.157  |
//   | A10       |     | 10.14       | 0.399  |
//   | A11       |     | 2.00        | 0.079  |
//   | A12       |     | 2.00        | 0.079  |
//   | A13       |     | 0.50        | 0.020  |
//   | A14       |     | 0.05        | 0.002  |
//   | A15       |     | 0.75        | 0.030  |
//   | A16       |     | 0.10        | 0.004  |
//   | A17       |     | 0.50        | 0.020  |
//   | A18       |     | 0.05        | 0.002  |
//   | A19       |     | 0.50        | 0.020  |
//   | A20       |     | 0.10        | 0.004  |
//   | A21       |     | 3.86        | 0.152  |
//   | A22       |     | 0.20        | 0.008  |
//   | A34       | Min | 1.00        | 0.039  |
//   | A35       | Max | 8.00        | 0.315  |
//   | A36       | Min | 60.20       | 2.370  |
//   | A39       | Min | 1.25        | 0.049  |
//   | A40       | Min | 0.25        | 0.010  |
//   | A54       |     | 10.24       | 0.403  |
//   .
//   Notes: 
//   * a) X, Y and Z Datums are as defined by SFF-8201.
//   * b) A15 and A19 control the location of the connector as a whole.
//   * c) A16 and A20 control the location of the pins within the connector.
//   ![SFF-8212 Figure 3-1](images/sff-82XX/sff-8212-figure3-1.png)
//
// Arguments:
//   a34 = Specify a value for A34, which has a minimum of `1.00`. Default: `1.00`
//   a35 = Specify a value for A35, which has a maximum of `8.00`. Default: `8.00`
//   a36 = Specify a value for A34, which has a minimum of `60.20`. Default: `60.20`
//   a39 = Specify a value for A34, which has a minimum of `1.25`. Default: `1.25`
//   a40 = Specify a value for A34, which has a minimum of `0.25`. Default: `0.25`
//
// Continues:
//   It is an error to specify a value for A34, A36, A39, & A40 that is below their stated minimum. It 
//   is an error the specify a value for A35 that is above its stated minimum, or that is below or at `0` (zero).
//   Several dimension elements are not preset in table 3-1, and will return as `undef` in the position 
//   list returned. They are: `0 1 2 3 4 5 6 23 24 25 26 27 28 29 30 31 32 33 37 38 41 42 43 44 45 46 47 48 49 50 51 52 53`.
// 
// Example(NORENDER):
//   A = sff_8212_dimensions();
//   echo(A[19]);
//   // Yields: ECHO: 0.50
//
function sff_8212_dimensions(a34=1.00, a35=8.00, a36=60.20, a39=1.25, a40=0.25) = 
    assert(a34 >= 1.00, "Value A34 for a 50-pin connector must be greater than or equal to 1.00")
    assert(a35 <= 8.00 && a35 > 0, "Value A35 for a 50-pin connector must be less than or equal to 8.00")
    assert(a36 >= 60.20, "Value A36 for a 50-pin connector must be greater than than or equal to 60.20")
    assert(a39 >= 1.25, "Value A39 for a 50-pin connector must be greater than than or equal to 1.25")
    assert(a40 >= 0.25, "Value A40 for a 50-pin connector must be greater than than or equal to 0.25")
    [
        undef, undef, undef, undef, undef, undef, undef,  // A0 .. A6 - not present
        31.17,     // A7
        1.00,      // A8
        3.99,      // A9
        10.14,     // A10
        2.00,      // A11
        2.00,      // A12
        0.50,      // A13
        0.05,      // A14
        0.75,      // A15
        0.10,      // A16
        0.50,      // A17
        0.05,      // A18
        0.50,      // A19
        0.10,      // A20
        3.86,      // A21
        0.20,      // A22
        undef, undef, undef, undef, undef, undef, undef,  // A23 .. A29 - not present
        undef, undef, undef, undef,  // A30 .. A33 - not present
        a34,       // A34 = Min
        a35,       // A35 = Max 
        a36,       // A36 = Min
        undef, undef, // A37, A38 - not present
        a39,       // A39 = Min
        a40,       // A40 = Min
        undef, undef, undef, undef, undef, undef, undef, undef, undef,  // A41 .. A49 - not present
        undef, undef, undef, undef,  // A50 .. A53 - not present
        10.24,     // A54
    ];


// Module: sff_8212()
// Synopsis: Model a 2.5" internal disk drive with a 50-pin connector
// Usage:
//   sff_8212();
//   sff_8212(<a=undef>, <b=undef>, <anchor=CENTER>, <spin=0>, <orient=UP>);
// Description:
//   Produces a model of a 2.5" internal disk drive, according to the dimensions of SFF-8212. There are variations allowed in some 
//   labeled dimensions detailed in SFF-8201: to use those variations you need to call `sff_8201_dimensions()` and pass the 
//   modified dimension list as an argument `a`. There are variations also allowed in SFF-8212: to use those variations you need to 
//   call `sff_8212_dimensions()` and pass the modified dimenion list as an argument `b`.  
//   .
//   Reference https://members.snia.org/document/dl/25852 for SFF-8212.
//   .
//   The resulting model from `sff_8201()` is BOSL2-attachable; see https://github.com/BelfrySCAD/BOSL2/wiki/Tutorial-Attachments for details on how to use this.
//
// Arguments:
//   a = A list of dimensions from `sff_8201_dimensions()`. Default: `undef`, in which case `sff_8201_dimensions()` will be called and its values used directly
//   b = A list of dimensions from `sff_8212_dimensions()`. Default: `undef`, in which case `sff_8212_dimensions()` will be called and its values used directly
//   bottom_mounts = If set to `false`, drives with an A1 dimension that is less than or equal to `7.00` will not have bottom mounting holes. Default: `true`
//   anchor = Translates the model so that the specified anchor point is located at origin `[0,0,0]`. Default: `CENTER`
//   spin = Rotates the model this many degrees around the Z-axis after anchoring. Default: `0`
//   orient = Repositions the model in this direction after spin is applied. Default: `UP`
// Named Anchors:
//   Y1, Y2, Y3, Y4 = The four mounting points on the left and right hand sides of the drive, oriented outwards.
//   X1, X2, X3, X4 = The four mounting points on the bottom of the drive (if they should be present based on SFF-8201), oriented downwards.
//   CONNECTOR END = The back of the drive, oriented towards the back.
// Figure(3D,Med): Available anchor points:
//   expose_anchors() sff_8212() show_anchors(std=false);
// Example(Render,Med,ScriptUnder): a basic 2.5" disk drive with a connector. The model is rotated 180 degrees, to show its back in this example:
//   sff_8212(spin=180);
//
module sff_8212(a=undef, b=undef, bottom_mounts=true, anchor=CENTER, spin=0, orient=UP) {
    A = (is_list(a)) ? a : sff_8201_dimensions();
    B = (is_list(b)) ? b : sff_8212_dimensions();

    size = [ A[4], A[6], A[1] + A[2] - A[3] ];

    anchors = _sff_8201_anchors(A, bottom_mounts);

    cavity_size = [ B[36] - B[35], B[21] * 2, B[9] + B[34] ];
    // 
    attachable(anchor, spin, orient, size=size, anchors=anchors) {
        diff() {
            sff_8201(a=A, bottom_mounts=bottom_mounts) {
                down(size.z/2) up(cavity_size.z/2)
                    left(B[35]) right(size.x/2) left(cavity_size.x/2)
                        attach(BACK, FWD, overlap=cavity_size.y)
                            tag("remove")
                                cuboid(cavity_size)
                                    // build an entirly second cavity, just to get the curve from B[40]: 
                                    up(cavity_size.z - 0.1)
                                        attach(BACK, FWD)
                                            cuboid(cavity_size, rounding=-1 * B[40] * 2, edges=[BOTTOM+FWD]);
                fwd(B[12] * 4)
                    up(B[9]) down(size.z/2)
                        left(B[10]) right(size.x/2)
                            attach(BACK, "pin-1")
                                tag("keep")
                                    _sff_8212_50pin_connector(B);
            }
        }
        children();
    }
}


module _sff_8212_50pin_connector(b=undef, anchor=CENTER, spin=0, orient=UP) {
    B = (is_list(b)) ? b : sff_8212_dimensions();

    pin_dimension = [ B[13], B[17], B[21] ]; // oriented up

    size = [
        (B[13] + B[12] * 24) + B[12],
        B[21] * 2,
        (B[11] + B[17]) * 2
        ];
    
    // B[9], B[10] is the position of the upper-left pin (looking towards the front). An anchor
    // is provided for the upper-left pin, on the BACK of the connector, to aid in positioning.
    // note that this anchor is rotated 180 degrees, so that applying it to a surface 
    // (eg, 'attach(BACK, "pin-1")') will orient the attachment correctly without add'l adjustment.
    anchors = [
        named_anchor("pin-1", apply(up(B[11]/2) * back(size.y/2) * right(B[12]/2) * left(size.x/2), CENTER), BACK, 180)
        ];

    attachable(anchor, spin, orient, size=size, anchors=anchors) {
        cuboid([size.x, size.y/2, size.z*0.75], anchor=FWD)
            fwd(B[21]/2 - 0.1)
                xrot(90)
                    grid_copies(spacing=B[12], n=[25, 2])
                        cuboid(pin_dimension, anchor=BOTTOM);
        children();
    }
}


// Section: SFF-8222
//   2.5" disk drives with a SCA-2 connector per SFF-8222 rev 2.3 (2004/07/16).
//   Revised as EIA-720-B 2016/01 at Rev 2.3 dated August 30, 2014
//   Reference SFF-8222 dimensions from https://members.snia.org/document/dl/25854
//
// Function: sff_8222_dimensions()
// Synopsis: return a list of dimensions for the positioning of a SCA-2 connector on a 2.5" disk drive
// Usage:
//   A = sff_8222_dimensions();
//   A = sff_8222_dimensions(<a2=66.50>);
// Description:
//   Returns the dimensions that detail the position of a 50-pin connector on a 2.5" 
//   disk drive, as list `A`. All values are returned in millimeters (mm).
//   .
//   Reference https://members.snia.org/document/dl/25854 for SFF-8222.
//   .
//   TABLE 3-1 SCA-2 CONNECTOR LOCATION
//   | Dimension | Millimeters |       | Comments    |
//   |-----------|------------:|------:|-------------|
//   | A 1       | 69.85       | 2.750 |             |
//   | A 2       | 66.50       | 2.618 | 80-position |
//   | A 2       | 41.10       | 1.618 | 40-position |
//   | A 3       | 1.00        | 0.039 |             |
//   | A 4       | 0.35        | 0.014 |             |
//   | A 5       | 7.00        | 0.276 |             |
//   | A 6       | 1.00        | 0.039 |             |
//   | A 7       | 4.00        | 0.157 |             |
//   | A 8       | 24.00       | 0.945 |             |
//   | A 9       | 0.35        | 0.014 |             |
//   | A10       | 0.50        | 0.020 |             |
//   .
//   ![SFF-8222 Figure 3.2](images/sff-82XX/sff-8222-figure3-2.png)
//
// Arguments:
//   a2 = Specify a value for A2, which has two possible values. Default: `66.50`
//
// Continues:
//   It is an error to specify a value for A2 that is not one of the two listed possible values.
//   Dimension element `0` is set as `undef`, as it does not appear in table 3-1.
//
// Example(NORENDER):
//   A = sff_822_dimensions();
//   echo(A[1]);
//   // Yields: ECHO: 69.85
//
function sff_8222_dimensions(a2=66.50) =
    let(
        a2_valids = [ 66.50, 41.10 ]
    )
    assert(in_list(a2, a2_valids),
        str("Value A2 for a 2.5\" SCA-2 connector must one of the following values: ", a2_valids))
    [
        undef,  // A0 - not present
        69.85,  // A1
        a2,  // A2
        1.00,   // A3
        0.35,   // A4
        7.00,   // A5
        1.00,   // A6
        4.00,   // A7
        24.00,  // A8
        0.35,   // A9
        0.50    // A10
    ];


// Module: sff_8222()
// Synopsis: Model a 2.5" internal disk drive with a SCA-2 connector
// Usage:
//   sff_8222();
//   sff_8222(<a=undef>, <b=undef>, <anchor=CENTER>, <spin=0>, <orient=UP>);
// Description:
//   Produces a model of a 2.5" internal disk drive, according to the dimensions of SFF-8222. There are variations allowed in some 
//   labeled dimensions detailed in SFF-8201: to use those variations you need to call `sff_8201_dimensions()` and pass the 
//   modified dimension list as an argument `a`. There are variations also allowed in SFF-8222: to use those variations you need to 
//   call `sff_8222_dimensions()` and pass the modified dimenion list as an argument `b`.  
//   .
//   The SCA-2 connector is not modeled to its specification in `sff_8222()`, only its outer dimensions.
//   .
//   Reference https://members.snia.org/document/dl/25852 for SFF-8222.
//   .
//   The resulting model from `sff_8222()` is BOSL2-attachable; see https://github.com/BelfrySCAD/BOSL2/wiki/Tutorial-Attachments for details on how to use this.
//
// Arguments:
//   a = A list of dimensions from `sff_8201_dimensions()`. Default: `undef`, in which case `sff_8201_dimensions()` will be called and its values used directly
//   b = A list of dimensions from `sff_8222_dimensions()`. Default: `undef`, in which case `sff_8222_dimensions()` will be called and its values used directly
//   bottom_mounts = If set to `false`, drives with an A1 dimension that is less than or equal to `7.00` will not have bottom mounting holes. Default: `true`
//   anchor = Translates the model so that the specified anchor point is located at origin `[0,0,0]`. Default: `CENTER`
//   spin = Rotates the model this many degrees around the Z-axis after anchoring. Default: `0`
//   orient = Repositions the model in this direction after spin is applied. Default: `UP`
// Named Anchors:
//   Y1, Y2, Y3, Y4 = The four mounting points on the left and right hand sides of the drive, oriented outwards.
//   X1, X2, X3, X4 = The four mounting points on the bottom of the drive (if they should be present based on SFF-8201), oriented downwards.
//   CONNECTOR END = The back of the drive, oriented towards the back.
// Figure(3D,Med): Available anchor points:
//   expose_anchors() sff_8222() show_anchors(std=false);
// Example(Render,Med,ScriptUnder): a basic 2.5" disk drive with a connector. The model is rotated 180 degrees, to show its back in this example:
//   sff_8222(spin=180);
//
module sff_8222(a=undef, b=undef, bottom_mounts=true, anchor=CENTER, spin=0, orient=UP) {
    A = (is_list(a)) ? a : sff_8201_dimensions();
    B = (is_list(b)) ? b : sff_8222_dimensions();

    size = [ A[4], A[6], A[1] + A[2] - A[3] ];
    anchors = _sff_8201_anchors(A, bottom_mounts);

    attachable(anchor, spin, orient, size=size, anchors=anchors) {
        sff_8201(a=A, bottom_mounts=bottom_mounts)
            down(size.z/2)
                up(B[5]/2)
                    attach(BACK, FWD)
                        cuboid([B[2], B[8] - A[52], B[5]]);
        children();
    }
}


//sff-8223.scad
// https://members.snia.org/document/dl/25855
// 2.5" Form Factor Drive with Serial Attached Connector

//sff-8248.scad
// https://members.snia.org/document/dl/25858
//  2.5" Form Factor w/ Combo Connector Inc. USB Micro-B Receptacle

//sff-8252.scad
// https://members.snia.org/document/dl/25860
//  2.5" Form Factor Drive with SFF-8784 Connector


