# Matlab/Octave Rotations Library

**Author:** Philipp Allgeuer

**Version:** 1.4.0

**Date:** 22/01/18

## General Overview
The Matlab/Octave rotations library is a collection of functions, bundled as
m-scripts, that address computations and numerical handling of rotations in 3D
Euclidean space. The rotation representations that are supported are rotation
matrices (`Rotmat`), Quaternions (`Quat`), intrinsic ZYX Euler angles (`Euler`),
fused angles (`Fused`) and tilt angles (`Tilt`). Operations such as composition,
inversion, ZYX yaw extraction, fused yaw extraction, random generation, equality
detection, vector rotation and much more have been implemented for each rotation
representation. Tilt vector addition and the relative and absolute tilt phase
spaces are also supported. Unit tests for each function are provided to ensure
that the library is performant. For more information on fused angles and tilt
angles, please refer to
http://www.ais.uni-bonn.de/~pallgeuer/papers/IROS_2015_fused.pdf. The *fused
angles* and *tilt angles* rotation representations are the invention of the
author, as with the tilt phase space.

## Getting Started
Clone the rotations library into the required local target directory. Usually
when working with Matlab/Octave the `RotationsLib` directory will not be your
working directory. Refer to `help LoadRotations` to see how to best add the
`RotationsLib` directory to your path for a working session. It may be a good
idea to initially run the unit tests of the library when getting started. Refer
to `help LoadRotationsTest` to see how to best add the `Test` directory to your
path for a working session, and refer to `help RunAllTests` for running of the
unit tests. For example:

    >> run ../Libraries/RotationsLib/LoadRotationsTest.m
    >> RunAllTests('Normal')

There is an element of randomisation in the unit tests in order to make them
more encompassing. As such, there is a very minor chance that one of the tests
fails because a single test case (one of often several tens of thousands) has an
error above the prescribed allowable threshold. Although as much as possible has
been done to try to avoid the possibility of such scenarios, the extent to which
this is possible is limited by the presence of singularities in the rotation
representations, floating point errors, and the use of (unavoidable and required)
functions of high numerical sensitivity. For example:

    >> acos(1 - eps) % Expect acos(1) = 0
    ans =
      2.1073e-08
    >> sqrt(0 + eps) % Expect sqrt(0) = 0
    ans =
      1.4901e-08

This means that very tiny floating point errors in required expressions such as

    >> alpha = acos(2*(Quat(1)*Quat(1) + Quat(4)*Quat(4)) - 1)
    >> calpha = sqrt(1 - sth*sth - sphi*sphi)

can quickly turn into comparatively larger errors in the output variables, for
certain *highly specific* input scenarios.

## Quick Help
Every function of the library is documented and well-commented, so a good
starting point on how to use a particular function is the `help` command. A good
starting point in understanding the conventions and formats used for the five
rotation representations is `help Ensure*` and `help *Equal`, where `*`
is any of `Euler`, `Fused`, `Quat`, `Rotmat` and `Tilt`. A summary of the five
rotation representations is shown in the following table.

**Representation** | **Code** | **Format** | **Universal set**
--- |:---:| --- | ---
ZYX Euler angles | `Euler` | `[psi theta phi] =`<br>`(yaw, pitch, roll)` | (-&pi;,&pi;] &times; [-&pi;/2,&pi;/2] &times; (-&pi;,&pi;]
Fused angles | `Fused` | `[psi theta phi h] =`<br>`(fused yaw, fused pitch, fused roll)` | (-&pi;,&pi;] &times; [-&pi;/2,&pi;/2] &times; [-&pi;/2,&pi;/2] &times; {-1,1}
Quaternion | `Quat` | `[w x y z]` | &#x211a;
Rotation matrix | `Rotmat` | `3x3 matrix` | SO(3)
Tilt angles | `Tilt` | `[psi gamma alpha] =`<br>`(fused yaw, tilt axis angle, tilt angle)` | (-&pi;,&pi;] &times; (-&pi;,&pi;] &times; [0,&pi;]

Note that in the library, `ZVec` refers to the bottom row of the rotation matrix
representation. This corresponds to the global z-axis, expressed in terms of the
rotated coordinate frame. `Axis` refers to the representation of a rotation by
its axis and angle of rotation.

## Where To Get More Help?
If a look into the source code does not resolve an issue you have with the
library, then you can open a GitHub issue.

## Bugs and Improvements
I welcome all feedback, suggestions and bug reports (by opening a GitHub issue).
If you improve or fix anything about the library then I encourage you to let me
know so that the library can be improved for everyone!
