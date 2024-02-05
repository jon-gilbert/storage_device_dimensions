// LibFile: sff-8200.scad
// 
// Includes:
//   include <sff-8200.scad>
//

include <BOSL2/std.scad>


// Function: sff_8200_dimensions()
// Synopsis: return a list of dimensions for a 2.5" internally mounted disk drive
// Usage:
//   A = sff_8200_dimensions();
//   A = sff_8200_dimensions(<a1=19.06>, <a6=100.45>);
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
//   ![SFF-8200 Figure 3-1](images/sff-8200/sff-8200-fig3-1.png)
//   .
//   ![SFF-8200 Figure 3-2](images/sff-8200/sff-8200-fig3-2-detailB.png)
// Arguments:
//   a1 = Specify an explicit dimension for measurement A1. Default: `19.05`
//   a6 = Specify an explicit dimension for measurement A6. Default: `100.45`
// Continues:
//   It is an error to specify a value for A1 that is not listed in SFF-8200. It is an error 
//   to specify a value for A6 that exceeds its listed maximum, or that is not greater than zero.
//   SFF-8200 defines A26 as `M3`, which is interpreted by `sff_8200_dimensions()` as the diameter 
//   of an M3 metric screw, or `3.00`.
//   Note that A2, A3, and A38 will change based on the value selected for A1 in accordance with 
//   table 3-1, above.
//
// Todo: 
//   A38 and A42 are minimum values, and can concievably be as great as the dimension to which they are applied. 
//
// Example(NORENDER):
//   A = sff_8200_dimensions();
//   echo(A[28]);
//   // Yields: ECHO: 4.07
//
function sff_8200_dimensions(a1=19.05, a6=100.45) =
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




// SFF-8200 indicates a connector slot but does not provide dimensions for it.
module sff_8200(a=undef, anchor=CENTER, spin=0, orient=UP) {
    A = (is_list(a)) ? a : sff_8200_dimensions();
    size = [
        A[4],
        A[6],
        A[1] + A[2] - A[3]
    ];
    attachable(anchor, spin, orient, size=size) {
        difference() {
            cuboid(size, anchor=CENTER);

            xflip_copy() {
                move_copies([
                        [ size.x/2, size.y / 2 - A[53], -1 * (size.z/2 - A[23]) ],  // Y2
                        [ size.x/2, size.y / 2 - A[52], -1 * (size.z/2 - A[23]) ],  // Y1
                    ])
                    cyl(d=A[38], l=A[38] + 1, anchor=BOTTOM, orient=LEFT);
                move_copies([
                        [ A[29]/2, size.y/2 - A[51], -1 * (size.z/2) ],  // X2
                        [ A[29]/2, size.y/2 - A[50], -1 * (size.z/2) ],  // X1
                    ])
                    cyl(d=A[38], l=A[41] + 1, anchor=BOTTOM, orient=UP);
            }
        }
        children();
    }
}

if (MAKE)
    sff_8200();

