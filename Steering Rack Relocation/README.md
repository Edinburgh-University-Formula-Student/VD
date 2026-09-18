# Steering Rack Relocation Project

## Description

This project relocates the steering rack longitudinally within the car to reduce the risk of steering rack failure caused by high off-axis forces.

The project contains three main MATLAB scripts:

- `Max_Off_Axis_Rack_f` calculates off-axis steering-rack force for a given steering geometry. This allows for a comparison of the force before and after relocating the rack, helping justify the proposed change.

- `Bump_steer` finds an outboard tie rod joint coordinate that minimises bump steer by moving the joint vertically. This counteracts potential bump steer increase caused by the change in tie rod length during rack relocation.

- `Ackermann_Geometry` finds tie rod and steering arm lengths, as well as the angle between them, to keep Ackermann geometry as close as possible to the original configuration. This too helps counteract the effects of the changed tie-rod length.

> [!NOTE]
> To run all files, download `Car_Data`. `Max_Off_Axis_Rack_f` also requires `B1706run2`, an FSAE TTC tyre-data set.
