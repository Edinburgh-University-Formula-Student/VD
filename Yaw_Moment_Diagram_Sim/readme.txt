Edinburgh University Formula Student
Setup Tuning and Load Transfer Program
Summer 2026
Ubaida Freikh, Vehicle Dynamics

This is a program designed for the purpose of evaluating the expected performance of different suspension setups through the generation of Yaw Moment Diagrams for different operating velocities. The program consists of several modules:

Compute_Vertical_Wheel_Loads_Aero.m calculates lateral and longitudinal load transfer based on the specified suspension parameters
compute_Roll_Centre.m calculates the instantaneous and roll centres of a suspension axle at each iteration
define_Roll_Axis_Distance.m computes the distance between the roll axis and the sprung centre of gravity at each iteration
Geometry_to_Acceleration.m creates a direct translation between roll & pitch (kinematics) and lateral & longitudinal accelerations through stiffnesses.
EUFS_Tyre_Force_Calculator.m  is the main script of the program, which calculates lateral tyre forces and then generates the resultant yaw moment diagrams

This program integrates with the Suspension Geometry Model produced by Paul Wang. The Parametres.m script is used to generate the important vehicle parameters needed to run the setup tuning and load transfer simulation. Therefore, Parametres.m should always be run prior to running this program.

The program EUFS_Tyre_Force_Calculator_V2.m is a work in progress, aiming at incorporating longitudinal acceleration effects into the suspension tuning model. The current next steps are to incorporate a module for computing tyre slip ratio for a given operating condition, and modifying the Geometry_to_Acceleration.m function to include side-view suspension geometry (anti-geometry).


