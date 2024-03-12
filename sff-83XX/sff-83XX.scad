// LibFile: sff-83XX.scad
//   Suite of 3.5" form-factor disk drives per SFF-83XX as of 2024/03/01.
//   See [these SFF specifications](https://www.snia.org/technology-communities/sff/specifications?field_data_field_sff_doc_status=All&combine=sff-83&field_release_date_value_2%5Bvalue%5D%5Bdate%5D=&field_release_date_value%5Bvalue%5D%5Bdate%5D=&items_per_page=20) 
//   for the full set of 3.5" drive dimension specifications.
// FileGroup: Internal Bay Drives
// FileSummary: 3.5" Disk Drives
//
// Includes:
//   include <sff-83XX.scad>

include <BOSL2/std.scad>
MAKE = false;


// Section: SFF-8300
//   3.5" disk drive dimensions per SFF-8300 rev 2.4 (2016/01/16). 
//   Reference SFF-8300 dimensions from https://members.snia.org/document/dl/25861
//   .
//   The dimensions in SFF-8300 are wholesale replicatred into SFF-8301. As SFF-8300
//   seems to be a broader, catch-all specification, callers are encouraged to use
//   the drive-specific SFF-8301 modules and functions, listed below.
//
// Function: sff_8300_dimensions()
// Synopsis: Synonym for sff_8301_dimensions()
// Usage:
//   A = sff_8300_dimensions();
//   A = sff_8300_dimensions(<a1=17.80>, <a2=147.00>);
// Description:
//   Synonym for `sff_8301_dimensions()`
// See also: sff_8301_dimensions()
function sff_8300_dimensions(a1=17.80, a2=147.00) = sff_8301_dimensions(a1, a2);


// Module: sff_8300()
// Synopsis: Synonym for sff_8301()
// Usage:
//   sff_8300();
//   sff_8300(<a=undef,>, <anchor=CENTER>, <spin=0>, <orient=UP>);
//   [PARENT] sff_8300();
// Description:
//    Synonym for `sff_8301()`
// See also: sff_8301()
module sff_8300(a=undef, bottom_mounts=true, anchor=CENTER, spin=0, orient=UP) {
    sff_8301(a=a, bottom_mounts=bottom_mounts, anchor=anchor, spin=spin, orient=orient)
        children();
}


// Section: SFF-8301
//   3.5" disk drive dimensions per SFF-8301 rev3.4 (2018/01/19)
//   Reference SFF-8301 dimensions from https://members.snia.org/document/dl/25862
//
// Function: sff_8301_dimensions()
// Synopsis: return a list of dimensions for a 3.5" internally mounted disk drive
// Usage:
//   A = sff_8301_dimensions();
//   A = sff_8301_dimensions(<a1=17.80>, <a2=147.00>);
// Description:
//   Returns a list of 3.5" disk drive dimensions, `A`, as specified by SFF-8301. 
//   All values are returned in millimeters (mm).
//   Reference https://members.snia.org/document/dl/25862 for SFF-8301.
//   .
//   TABLE 3-1 3.5" DISK DRIVE DIMENSIONS
//   | Dimension | Millimeters |     | Inches |     |
//   |-----------|------------:|-----|-------:|-----|
//   | A 1       | 17.80       | Max | 0.700  | Max |
//   | A 1       | 26.10       | Max | 1.028  | Max |
//   | A 1       | 42.00       | Max | 1.654  | Max |
//   | A 2       | 147.00      | Max | 5.787  | Max |
//   | A 3       | 101.60      |     | 4.000  |     |
//   | A 4       | 95.25       |     | 3.750  |     |
//   | A 5       | 3.18        |     | 0.125  |     |
//   | A 6       | 44.45       |     | 1.750  |     |
//   | A 7       | 41.28       |     | 1.625  |     |
//   | A 8       | 28.50       |     | 1.122  |     |
//   | A 9       | 101.60      |     | 4.000  |     |
//   | A10       | 6.35        |     | 0.250  |     |
//   | A11       | 0.25        |     | 0.010  |     |
//   | A12       | 0.50        |     | 0.020  |     |
//   | A13       | 76.20       |     | 3.000  |     |
//   .
//   Threads: 6-32 UNC-2B
//   | Penetration | Millimeters |
//   |-------------|------------:|
//   | Min         | 3.0         |
//   | Max         | 3.8         |
//   .
//   ![SFF-8300 Figure 3-1](images/sff-83XX/sff-8300-fig3-1.png)
//   .
//   When flagged as "Max" in the above table, the dimension may be less than 
//   the stated value (eg, for A2, the value may be shorter than 147mm). 
//   There aren't any defined minimums. 
//   .
//   Note that the above table defines several A1 entries while only one is
//   present in the diagram. For SFF-8301, those are the only allowable possible 
//   values for A1. It's unclear why they're listed with "Max" notations in SFF-8300.
//   .
//   Fastener specification for SFF-8301 is to use a 6-32 UNC-2B screw. This has a 
//   nominal diameter of 3.505mm and thread-per-inch of 32, or a thread-pitch of 0.795mm.
//   Neither the diameter nor the pitch are returned as values from `sff_8301_dimensions()`,
//   as they are not present in table 3-1, above. The penetration values for the 
//   fasteners are present, but not labeled and are also not returned.
//
// Arguments:
//   a1 = Specify an explicit dimension for measurement A1. Default: `17.80`
//   a2 = Specify an explicit dimension for measurement A2. Default: `147.00`
// Continues:
//   It is an error to specify a value for A1 that is not listed in SFF-8300. It is an 
//   error to specify a value for A2 that exceeds its listed maximum, or that is not greater 
//   than zero.
//   .
//   Dimension element `0` is set as `undef`, as it does not appear in table 3-1.
//
// Example(NORENDER):
//   A = sff_8300_dimensions();
//   echo(A[3]);
//   // Yields: ECHO: 101.60
//
function sff_8301_dimensions(a1=17.80, a2=147.00) =
    let(
        a1_valids = [ 17.80, 26.10, 42.00 ]
    )
    assert(in_list(a1, a1_valids),
        str( "Value for A1 for a 3.5\" drive must be one of the following valid values: ", a1_valids ))
    assert(a2 > 0 && a2 <= 147.00,
        "Value for A2 for a 3.5\" drive must be greater than 0 (zero) and no greater than 147.00")
    [
        undef,    // A0 - not present
        a1,       // A1
        a2,       // A2
        101.60,   // A3
        95.25,    // A4
        3.18,     // A5
        44.45,    // A6
        41.28,    // A7
        28.50,    // A8
        101.60,   // A9
        6.35,     // A10
        0.25,     // A11
        0.50,     // A12
        76.20     // A13
    ];


// Module: sff_8301()
// Synopsis: Model a 3.5" internal disk drive
// Usage:
//   sff_8301();
//   sff_8301(<a=undef,>, <a6_mounts=true>, <a13_mounts=true>, <anchor=CENTER>, <spin=0>, <orient=UP>);
//   [PARENT] sff_8301();
// Description:
//   Produces a model of a 3.5" internal disk drive, according to the dimensions of SFF-8301. There are variations allowed in some 
//   labeled dimensions detailed in SFF-8301: to use those variations you need to call `sff_8301_dimensions()` and pass the 
//   modified dimension list as an argument `a`.  
//   SFF-8301 usually provides ten mounting points - six on the bottom surface, and two on each of the left and right surfaces. 
//   Two sets of the bottom mounts, those at the A6 and A13 offsets, are optional: setting `a6_mounts` or `a13_mounts` to `false` 
//   will inhibit those mounts.
//   .
//   SFF-8301 indicates a connector slot but does not provide dimensions for it. In models produced by `sff_8301()`, the connector side is 
//   oriented towards `BACK`, or in the positive Y-axis direction. Other modules produced within the SFF-82XX set can use the model from 
//   `sff_8301()` to produce connecter-specific models for their spec. 
//   .
//   The resulting model from `sff_8301()` is BOSL2-attachable; see https://github.com/BelfrySCAD/BOSL2/wiki/Tutorial-Attachments for details on how to use this.
//   .
//   **STL:** an example, pre-built STL for `sff_8301()` should be available [here](stls/sff_8301.stl).
//
// Arguments:
//   a = A list of dimensions from `sff_8301_dimensions()`. Default: `undef`, in which case `sff_8301_dimensions()` will be called and its values used directly
//   a6_mounts = If set to `false`, drives will not be produced with bottom screw mounts at the position offset from the back of the unit at A6. Default: `true`
//   a13_mounts = If set to `false`, drives will not be produced with bottom screw mounts at the position offset from the back of the unit at A13. Default: `true`
//   bottom_mounts = If set to `false`, drives with an A1 dimension that is less than or equal to `7.00` will not have bottom mounting holes. Default: `true`
//   anchor = Translates the model so that the specified anchor point is located at origin `[0,0,0]`. Default: `CENTER`
//   spin = Rotates the model this many degrees around the Z-axis after anchoring. Default: `0`
//   orient = Repositions the model in this direction after spin is applied. Default: `UP`
// Continues:
//   SFF-8301 does not define the material or thickness that makes up A37, the diameter around the mount points. For the purposes of 
//   `sff_8301()`, it's set at `0.01` and carved away from the main drive body to show where they'd be placed on an actual device.
// Named Anchors:
//   Y1, Y2, Y3, Y4 = The four mounting points on the left and right hand sides of the drive, oriented outwards.
//   X1, X2, X3, X4, X5, X6 = The six mounting points on the bottom of the drive (if they should be present based on SFF-8301), oriented downwards.
//   CONNECTOR END = The back of the drive, oriented towards the back.
// Figure(3D,Med): Available anchor points:
//   expose_anchors() sff_8301() show_anchors(std=false);
// Example(Render,Med,ScriptUnder): a basic 3.5" disk drive:
//   sff_8301();
// Example(Render,Med,ScriptUnder): same drive, flipped upside down, without the optional mounts at A6:
//   zflip()
//     sff_8301(a6_mounts=false);
//
module sff_8301(a=undef, a6_mounts=true, a13_mounts=true, anchor=CENTER, spin=0, orient=UP) {
    A = (is_list(a)) ? a : sff_8301_dimensions();
    size = [ A[3], A[2], A[1] ];
    screw_diam = 3.505;
    screw_len = 3.8;
    anchors = _sff_8301_anchors(A, a6_mounts, a13_mounts);
    
    attachable(anchor, spin, orient, size=size, anchors=anchors) {
        difference() {
            cuboid(size, anchor=CENTER);
            for (anchor=anchors) {
                if (in_list(substr(anchor[0], 0, 1), ["X", "Y"])) {
                    move(anchor[1])
                        cyl(d=screw_diam, l=screw_len, anchor=TOP, orient=anchor[2])
                            attach(TOP, BOTTOM, overlap=screw_len)
                                cyl(d=screw_diam, l=screw_len);
                }
            }
        }
        children();
    }
}


if (MAKE)
    sff_8301();


function _sff_8301_anchors(a, a6_mounts=true, a13_mounts=true) =
    let(
        A = (is_list(a)) ? a : sff_8301_dimensions(),
        size = [ A[3], A[2], A[1] ]
    )
    concat(
        [
            named_anchor("CONNECTOR END", [0, size.y/2, 0], BACK, 0),
            //
            named_anchor("Y1", [ size.x/2,      size.y / 2 - A[8],          -1 * (size.z/2 - A[10]) ], RIGHT, 0),
            named_anchor("Y2", [ size.x/2,      size.y / 2 - (A[8] + A[9]), -1 * (size.z/2 - A[10]) ], RIGHT, 0),
            named_anchor("Y3", [ -1 * size.x/2, size.y / 2 - A[8],          -1 * (size.z/2 - A[10]) ], LEFT,  0),
            named_anchor("Y4", [ -1 * size.x/2, size.y / 2 - (A[8] + A[9]), -1 * (size.z/2 - A[10]) ], LEFT,  0),
            //
            named_anchor("X1", [ A[4]/2,      size.y/2 - A[7], -1 * (size.z/2) ], DOWN, 0),
            named_anchor("X2", [ -1 * A[4]/2, size.y/2 - A[7], -1 * (size.z/2) ], DOWN, 0),
        ],
        (a6_mounts)
            ? [
                named_anchor("X3", [ A[4]/2,      size.y/2 - (A[7] + A[6]),  -1 * (size.z/2) ], DOWN, 0),
                named_anchor("X4", [ -1 * A[4]/2, size.y/2 - (A[7] + A[6]),  -1 * (size.z/2) ], DOWN, 0),
                ]
            : [],
        (a13_mounts)
            ? [
                named_anchor("X5", [ A[4]/2,      size.y/2 - (A[7] + A[13]),  -1 * (size.z/2) ], DOWN, 0),
                named_anchor("X6", [ -1 * A[4]/2, size.y/2 - (A[7] + A[13]),  -1 * (size.z/2) ], DOWN, 0),
                ]
            : []
    );


/// sff-8323.scad
/// 3.5" Form Factor Drive with Serial Attached Connector
// Section: SFF-8323
//   3.5" disk drives with a serial attached connector per SFF-8323 rev 1.6 (2014/08/30)
//   Reference SFF-8301 dimensions from https://members.snia.org/document/dl/25864
//
// Function: sff_8323_dimensions()
// Synopsis: return a list of dimensions for a 3.5" internally mounted disk drive with a serial-attached connector
// Usage:
//   A = sff_8323_dimensions();
// Description:
//   Returns a list of 3.5" disk drive dimensions, `A`, as specified by SFF-8323.. 
//   All values are returned in millimeters (mm).
//   Reference https://members.snia.org/document/dl/25864 for SFF-8323.
//   .
//   TABLE 3-1 SERIAL CONNECTOR LOCATION
//   | Dimension | Millimeters | Inches |
//   |-----------|------------:|-------:|
//   | A 1       | 101.60      | 4.000  |
//   | A 2       | 42.73       | 1.682  |
//   | A 3       | 33.39       | 1.315  |
//   | A 4       | 0.40        | 0.016  |
//   | A 5       | 4.00        | 0.157  |
//   | A 6       | 0.76        | 0.030  |
//   | A 7       | 3.50        | 0.138  |
//   | A 8       | 36.38       | 1.432  |
//   | A 9       | 0.25        | 0.010  |
//   | A10       | 1.00        | 0.039  |
//   | A11       | 20.68       | 0.814  |
//   | A12       | 0.38        | 0.015  |
//   | A13       | 13.43       | 0.529  |
//   | A14       | 37.20       | 1.465  |
//   | A15       | 1.50        | 0.059  |
//   | A16       | 1.00        | 0.039  |
//   | A17       | 1.00        | 0.039  |
//   | A18       | 23.60       | 0.929  |
//   | A19       | 1.00        | 0.039  |
//   | A20       | 2.85        | 0.112  |
//   .
//   ![SFF-8323 Figure 3-1](images/sff-83XX/sff-8323-fig3-1.png)
//   .
//   There is no fastener specification for SFF-8323; the fasteners for SFF-8301
//   are assumed.
//
// Arguments: `sff_8323_dimensions()` takes no arguments.
//
// Continues:
//   Dimension element `0` is set as `undef`, as it does not appear in table 3-1.
//
// Example(NORENDER):
//   A = sff_8323_dimensions();
//   echo(A[13]);
//   // Yields: ECHO: 13.43
//
function sff_8323_dimensions() =
    [
        undef,   // A0 - not present
        101.60,  // A1
        42.73,   // A2
        33.39,   // A3
        0.40,    // A4
        4.00,    // A5
        0.76,    // A6
        3.50,    // A7
        36.38,   // A8
        0.25,    // A9
        1.00,    // A10
        20.68,   // A11
        0.38,    // A12
        13.43,   // A13
        37.20,   // A14
        1.50,    // A15
        1.00,    // A16
        1.00,    // A17
        23.60,   // A18
        1.00,    // A19
        2.85     // A20
    ];


// Module: sff_8323()
// Synopsis: Model a 3.5" internal disk drive with a serial-attached connector
// Usage:
//   sff_8323();
//   sff_8323(<a=undef>, <b=undef>, <a6_mounts=true>, <a13_mounts=true>, <anchor=CENTER>, <spin=0>, <orient=UP>);
//   [PARENT] sff_8323();
// Description:
//   Produces a model of a 3.5" internal disk drive, according to the dimensions of SFF-8323. There are variations allowed in some 
//   labeled dimensions detailed in SFF-8323: to use those variations you need to call `sff_8323_dimensions()` and pass the 
//   modified dimension list as an argument `a`. Offset posistioning for the SCA connector is defined by the measurements 
//   `sff_8323_dimensions()`, which can be optionally pre-provided via the argument `b`.  
//   SFF-8323 uses the same mounts as SFF-8301, and `sff_8323()` has the same mechanism for inhibiting optional bottom-mount fastener mounts. 
//   .
//   In models produced by `sff_8323()`, the connector side is oriented towards `BACK`, or in the positive Y-axis direction. 
//   .
//   The resulting model from `sff_8323()` is BOSL2-attachable; see https://github.com/BelfrySCAD/BOSL2/wiki/Tutorial-Attachments for details on how to use this.
//   .
//   **STL:** an example, pre-built STL for `sff_8323()` should be available [here](stls/sff_8323.stl).
//
// Arguments:
//   a = A list of dimensions from `sff_8301_dimensions()`. Default: `undef`, in which case `sff_8301_dimensions()` will be called and its values used directly
//   b = A list of dimensions from `sff_8323_dimensions()`. Default: `undef`, in which case `sff_8323_dimensions()` will be called and its values used directly
//   a6_mounts = If set to `false`, drives will not be produced with bottom screw mounts at the position offset from the back of the unit at A6. Default: `true`
//   a13_mounts = If set to `false`, drives will not be produced with bottom screw mounts at the position offset from the back of the unit at A13. Default: `true`
//   anchor = Translates the model so that the specified anchor point is located at origin `[0,0,0]`. Default: `CENTER`
//   spin = Rotates the model this many degrees around the Z-axis after anchoring. Default: `0`
//   orient = Repositions the model in this direction after spin is applied. Default: `UP`
// Continues:
//   .
// Named Anchors:
//   Y1, Y2, Y3, Y4 = The four mounting points on the left and right hand sides of the drive, oriented outwards.
//   X1, X2, X3, X4, X5, X6 = The six mounting points on the bottom of the drive (if they should be present based on SFF-8323), oriented downwards.
//   CONNECTOR END = The back of the drive, oriented towards the back.
// Figure(3D,Med): Available anchor points:
//   expose_anchors() sff_8323() show_anchors(std=false);
// Example(Render,Med,ScriptUnder): a basic 3.5" disk drive:
//   sff_8323();
// Example(Render,Med,ScriptUnder): same drive, rotated 180-degrees and flipped to show the connecter side, and with no optional mounts underneath:
//   zflip()
//     sff_8323(spin=180, a6_mounts=false, a13_mounts=false);
// Todo:
//   the model from _sff_8323_sas_connector() is very not at all accurate, though its placement is accurate
module sff_8323(a=undef, b=undef, a6_mounts=true, a13_mounts=true, anchor=CENTER, spin=0, orient=UP) {
    A = (is_list(a)) ? a : sff_8301_dimensions();
    B = (is_list(b)) ? b : sff_8323_dimensions();
    size = [ A[3], A[2], A[1] ];
    screw_diam = 3.505;
    screw_len = 3.8;
    anchors = _sff_8301_anchors(A, a6_mounts, a13_mounts);

    cutaway_height = A[7] - B[8];

    attachable(anchor, spin, orient, size=size, anchors=anchors) {
        diff()
            sff_8301(a=A, a6_mounts=a6_mounts, a13_mounts=a13_mounts) {
                // cutaway the back connector space
                right(B[11])
                    down(size.z/2) up(B[5]/2)
                        attach(BACK, FWD, overlap=cutaway_height)
                            tag("remove")
                                cuboid([B[2], cutaway_height, B[5]]);
                // slot the connector into that space
                right(B[11])
                    down(size.z/2) up(B[5]/2)
                        attach(BACK, BOTTOM, overlap=cutaway_height + B[18])
                            tag("keep")
                                _sff_8323_sas_connector(a=A, b=B);
            }
        children();
    }
}


/// Module: _sff_8323_sas_connector()
/// Todo: 
///  The sas connector produced here has the correct *outside* dimenions, but absolutely the wrong *inside* dimensions.
module _sff_8323_sas_connector(a=undef, b=undef, anchor=CENTER, spin=0, orient=UP) {
    A = (is_list(a)) ? a : sff_8301_dimensions();
    B = (is_list(b)) ? b : sff_8323_dimensions();
    // center along the shape's centerline. offset that with the centerline of SFF-8323 with B[11] for placement.
    // To ease this WE ASSUME:
    // * that B[2], B[3], and B[14] are centered respective to each other.
    // * 
    cutaway_height = A[7] - B[8]; // BRAK: a[50] is NOT right. figure out what 82xx thinks a[50] is, and use the right value from 83xx
    socket_height = cutaway_height + B[18];

    size = [
        B[2], 
        A[7] - B[8],
        socket_height, //B[7] + B[15]
        ];

    attachable(anchor, spin, orient, size=size) {
        up(socket_height / 2)
            union() {
                difference() {
                    rect_tube(
                        h=socket_height,
                        size=[ B[2], B[5] ],
                        isize=[ B[2] - (B[16] * 2), B[5] - (B[19] + B[17]) ],
                        anchor=TOP);
                    up(0.1)
                        cuboid([B[14], B[5] + 0.1, cutaway_height/2], 
                            rounding=-1, 
                            edges=[TOP+RIGHT, TOP+LEFT], 
                            anchor=TOP);
                    up(0.1)
                        cuboid([B[14], B[5] + 0.1, cutaway_height], 
                            rounding=1, 
                            edges=[BOTTOM+RIGHT, BOTTOM+LEFT], 
                            anchor=TOP);
                }
                cuboid([B[3], B[20] * 2, socket_height + 0.1], anchor=TOP);
            }
        children();
    }
}



/// sff-8337.scad
/// https://members.snia.org/document/dl/26143
/// 3.5" Form Factor Drive w/SCA-2 Connector
// Section: SFF-8337
//   3.5" disk drive dimensions with a SCA-2 Connector per SFF-8337 (1995/07/27)
//   Reference SFF-8337 dimensions from https://members.snia.org/document/dl/26143
//
// Function: sff_8337_dimensions()
// Synopsis: return a list of dimensions for placement of an SCA-2 connector onto a 3.5" internally mounted disk drive
// Usage:
//   A = sff_8337_dimensions();
// Description:
//   Returns a list of dimensions that define size and placement of an SCA-2 connector to an internally mounted
//   3.5" disk drive, `A`, as specified by SFF-8337. All values are returned in millimeters (mm) (however note #1, below).
//   Reference https://members.snia.org/document/dl/26143 for SFF-8337.
//   .
//   TABLE3-1 SCA-2 CONNECTOR LOCATION
//   | Dimension | Inches | Millimeters |
//   |-----------|-------:|------------:|
//   | A 1       | 4.000  | 101.60      |
//   | A 2       | 1.618  | 41.10       |
//   | A 3       | 0.040  | 1.02        |
//   | A 4       | 0.015  | 0.38        |
//   | A 5       | 0.276  | 7.00        |
//   | A 6       | 0.040  | 1.02        |
//   | A 7       | 0.181  | 4.60        |
//   | A 8       | 1.625  | 41.28       |
//   | A 9       | 0.015  | 0.38        |
//   | A10       | 0.020  | 0.50        |
//   .
//   1. Inch is the controlling dimensional unit.
//   2. No feature shall protrude more than 0.020" (0.50mm) beyond the face of the connector
//   .
//   ![SFF-8337 Figure 3-1](images/sff-83XX/sff-8337-fig3-1.png)
//   .
//   There is no fastener specification for SFF-8337; the fasteners for SFF-8301
//   are assumed.
//
// Arguments: `sff_8337_dimensions()` takes no arguments.
// Continues:
//   Dimension element `0` is set as `undef`, as it does not appear in table 3-1.
// Example(NORENDER):
//   A = sff_8337_dimensions();
//   echo(A[9]);
//   // Yields: ECHO: 0.38
function sff_8337_dimensions() = 
    [
        undef,   // A0 - not present
        101.60,  // A1
        41.10,   // A2
        1.02,    // A3
        0.38,    // A4
        7.00,    // A5
        1.02,    // A6
        4.60,    // A7
        41.28,   // A8
        0.38,    // A9
        0.50,    // A10
    ];

// Module: sff_8337()
// Synopsis: Model a 3.5" internal disk drive with a SCA-2 connector
// Usage:
//   sff_8337();
//   sff_8337(<a=undef>, <b=undef>, <a6_mounts=true>, <a13_mounts=true>, <anchor=CENTER>, <spin=0>, <orient=UP>);
//   [PARENT] sff_8337();
// Description:
//   Produces a model of a 3.5" internal disk drive, according to the dimensions of SFF-8337. There are variations allowed in some 
//   labeled dimensions detailed in SFF-8337: to use those variations you need to call `sff_8337_dimensions()` and pass the 
//   modified dimension list as an argument `a`. Offset posistioning for the SCA connector is defined by the measurements 
//   `sff_8337_dimensions()`, which can be optionally pre-provided via the argument `b`.  
//   SFF-8337 uses the same mounts as SFF-8301, and `sff_8337()` has the same mechanism for inhibiting optional bottom-mount fastener mounts. 
//   .
//   In models produced by `sff_8337()`, the connector side is oriented towards `BACK`, or in the positive Y-axis direction. 
//   .
//   The resulting model from `sff_8337()` is BOSL2-attachable; see https://github.com/BelfrySCAD/BOSL2/wiki/Tutorial-Attachments for details on how to use this.
//   .
//   **STL:** an example, pre-built STL for `sff_8337()` should be available [here](stls/sff_8337.stl).
//
// Arguments:
//   a = A list of dimensions from `sff_8301_dimensions()`. Default: `undef`, in which case `sff_8301_dimensions()` will be called and its values used directly
//   b = A list of dimensions from `sff_8337_dimensions()`. Default: `undef`, in which case `sff_8337_dimensions()` will be called and its values used directly
//   a6_mounts = If set to `false`, drives will not be produced with bottom screw mounts at the position offset from the back of the unit at A6. Default: `true`
//   a13_mounts = If set to `false`, drives will not be produced with bottom screw mounts at the position offset from the back of the unit at A13. Default: `true`
//   anchor = Translates the model so that the specified anchor point is located at origin `[0,0,0]`. Default: `CENTER`
//   spin = Rotates the model this many degrees around the Z-axis after anchoring. Default: `0`
//   orient = Repositions the model in this direction after spin is applied. Default: `UP`
// Continues:
//   .
// Named Anchors:
//   Y1, Y2, Y3, Y4 = The four mounting points on the left and right hand sides of the drive, oriented outwards.
//   X1, X2, X3, X4, X5, X6 = The six mounting points on the bottom of the drive (if they should be present based on SFF-8301), oriented downwards.
//   CONNECTOR END = The back of the drive, oriented towards the back.
// Figure(3D,Med): Available anchor points:
//   expose_anchors() sff_8337() show_anchors(std=false);
// Example(Render,Med,ScriptUnder): a basic 3.5" disk drive:
//   sff_8337();
// Example(Render,Med,ScriptUnder): same drive, rotated 180-degrees to show the connector side:
//   sff_8337(spin=180);
// Todo:
//   The modeled SCA-2 connector is not at all modeled, and could be.
module sff_8337(a=undef, b=undef, a6_mounts=true, a13_mounts=true, anchor=CENTER, spin=0, orient=UP) {
    A = (is_list(a)) ? a : sff_8301_dimensions();
    B = (is_list(b)) ? b : sff_8337_dimensions();
    size = [ A[3], A[2], A[1] ];
    screw_diam = 3.505;
    screw_len = 3.8;

    anchors = _sff_8301_anchors(A, a6_mounts, a13_mounts);
    
    attachable(anchor, spin, orient, size=size, anchors=anchors) {
        diff()
            sff_8301(a=A, a6_mounts=a6_mounts, a13_mounts=a13_mounts) {
                // carve out the clearance zone
                down(size.z/2) up(B[7])
                    attach(BACK, FWD, overlap=8.16)
                        tag("remove")
                            cuboid([69.30, 8.16, 7.23]);
                // and add the connector
                down(size.z/2) up(B[7])
                    attach(BACK, FWD, overlap=A[7])
                        tag("keep")
                            cuboid([B[2], B[8] + B[4], B[5]]);
            }
        children();
    }
}




