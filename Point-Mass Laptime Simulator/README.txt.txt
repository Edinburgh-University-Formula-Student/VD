University of Edinburgh Formula Student
Point-Mass Laptime Simulator
Paul Wang, Vehicle Dynamics
Fall 2024
--------------------------------------------------------------------------------------------------------
This is a project developed for the University of Edinburgh Formula Student in the Fall of 2024. 
The goal was to be able to make quick, high-level decisions for the 2026 in-hub motor concept class car, 
such as car mass goals, power and engine decisions, and aero kit decisions.


Within this folder, you can find the earlier iterations and versions of the laptime simulator, with PMLTS-8 being the newest, and PMLTS-1 being the newest.
The file "Vehicle Profile for PM-LTS.xlsx" holds all the vehicle parameters for the car, and can easily be updated.
The track folder contains a few necessary tracks, as well as a few additional tracks for testing. The tracks must be in 1D-array form, with a mesh size of 1m, with the array holding corner radius values (inf for straights)
Additionally, many of the functions such as "FxAero and FzOnDriven" are necessary for older versions of PMLTS, but should not be necessary for using PMLTS-8.





https://www.wiki.ed.ac.uk/display/EUF/Point-Mass+Laptime+Simulator
https://uoe.sharepoint.com/:f:/r/sites/EUFS/New%20Structure/EUFS%20Sharepoint/2.%20Technical/1.%20Mechanical%20Department/2.%20Vehicle%20Dynamics/5.%20Vehicle%20Dynamics%202024-25%20Projects/Point-Mass%20Laptime%20Simulator?csf=1&web=1&e=zgKdTc
https://github.com/Edinburgh-University-Formula-Student/VD/tree/main

Inspriation and guidance taken from Michael Chalkiopoulos, OpenLap (https://github.com/mc12027/OpenLAP-Lap-Time-Simulator)