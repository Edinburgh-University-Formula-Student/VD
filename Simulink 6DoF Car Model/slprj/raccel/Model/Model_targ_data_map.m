    function targMap = targDataMap(),

    ;%***********************
    ;% Create Parameter Map *
    ;%***********************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 6;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc paramMap
        ;%
        paramMap.nSections           = nTotSects;
        paramMap.sectIdxOffset       = sectIdxOffset;
            paramMap.sections(nTotSects) = dumSection; %prealloc
        paramMap.nTotData            = -1;

        ;%
        ;% Auto data (rtP)
        ;%
            section.nData     = 414;
            section.data(414)  = dumData; %prealloc

                    ;% rtP.brakePadMeanRadius
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% rtP.camber
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% rtP.cgToFrontAxle
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 2;

                    ;% rtP.cgToRearAxle
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 3;

                    ;% rtP.cgVerticalToAxlePlane
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 4;

                    ;% rtP.cornerStiffness
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 5;

                    ;% rtP.discBrakeActuatorBore
                    section.data(7).logicalSrcIdx = 6;
                    section.data(7).dtTransOffset = 6;

                    ;% rtP.kineticFriction
                    section.data(8).logicalSrcIdx = 7;
                    section.data(8).dtTransOffset = 7;

                    ;% rtP.lammux
                    section.data(9).logicalSrcIdx = 8;
                    section.data(9).dtTransOffset = 8;

                    ;% rtP.lammuy
                    section.data(10).logicalSrcIdx = 9;
                    section.data(10).dtTransOffset = 9;

                    ;% rtP.longDragArea
                    section.data(11).logicalSrcIdx = 10;
                    section.data(11).dtTransOffset = 10;

                    ;% rtP.longDragCoeff
                    section.data(12).logicalSrcIdx = 11;
                    section.data(12).dtTransOffset = 11;

                    ;% rtP.longLiftCoeff
                    section.data(13).logicalSrcIdx = 12;
                    section.data(13).dtTransOffset = 12;

                    ;% rtP.mass
                    section.data(14).logicalSrcIdx = 13;
                    section.data(14).dtTransOffset = 13;

                    ;% rtP.maxBrakePressure
                    section.data(15).logicalSrcIdx = 14;
                    section.data(15).dtTransOffset = 14;

                    ;% rtP.numBrakePads
                    section.data(16).logicalSrcIdx = 15;
                    section.data(16).dtTransOffset = 15;

                    ;% rtP.staticFriction
                    section.data(17).logicalSrcIdx = 16;
                    section.data(17).dtTransOffset = 16;

                    ;% rtP.tirePressure
                    section.data(18).logicalSrcIdx = 17;
                    section.data(18).dtTransOffset = 17;

                    ;% rtP.trackWidth
                    section.data(19).logicalSrcIdx = 18;
                    section.data(19).dtTransOffset = 18;

                    ;% rtP.wheelAngleLimit
                    section.data(20).logicalSrcIdx = 19;
                    section.data(20).dtTransOffset = 19;

                    ;% rtP.wheelBase
                    section.data(21).logicalSrcIdx = 20;
                    section.data(21).dtTransOffset = 20;

                    ;% rtP.yawPolarInertia
                    section.data(22).logicalSrcIdx = 21;
                    section.data(22).dtTransOffset = 21;

                    ;% rtP.CombinedSlipWheel2DOF_ALPMAX
                    section.data(23).logicalSrcIdx = 22;
                    section.data(23).dtTransOffset = 22;

                    ;% rtP.CombinedSlipWheel2DOF_ALPMIN
                    section.data(24).logicalSrcIdx = 23;
                    section.data(24).dtTransOffset = 23;

                    ;% rtP.CombinedSlipWheel2DOF_ASPECT_RATIO
                    section.data(25).logicalSrcIdx = 24;
                    section.data(25).dtTransOffset = 24;

                    ;% rtP.IndependentSuspensionDoubleWishbone_AxleNumVec
                    section.data(26).logicalSrcIdx = 25;
                    section.data(26).dtTransOffset = 25;

                    ;% rtP.CombinedSlipWheel2DOF_CAMMAX
                    section.data(27).logicalSrcIdx = 26;
                    section.data(27).dtTransOffset = 29;

                    ;% rtP.CombinedSlipWheel2DOF_CAMMIN
                    section.data(28).logicalSrcIdx = 27;
                    section.data(28).dtTransOffset = 30;

                    ;% rtP.IndependentSuspensionDoubleWishbone_Camber
                    section.data(29).logicalSrcIdx = 28;
                    section.data(29).dtTransOffset = 31;

                    ;% rtP.IndependentSuspensionDoubleWishbone_CamberHslp
                    section.data(30).logicalSrcIdx = 29;
                    section.data(30).dtTransOffset = 32;

                    ;% rtP.IndependentSuspensionDoubleWishbone_CamberStrgSlp
                    section.data(31).logicalSrcIdx = 30;
                    section.data(31).dtTransOffset = 33;

                    ;% rtP.IndependentSuspensionDoubleWishbone_Caster
                    section.data(32).logicalSrcIdx = 31;
                    section.data(32).dtTransOffset = 34;

                    ;% rtP.IndependentSuspensionDoubleWishbone_CasterHslp
                    section.data(33).logicalSrcIdx = 32;
                    section.data(33).dtTransOffset = 35;

                    ;% rtP.IndependentSuspensionDoubleWishbone_CasterStrgSlp
                    section.data(34).logicalSrcIdx = 33;
                    section.data(34).dtTransOffset = 36;

                    ;% rtP.VehicleBody6DOF_Cpm
                    section.data(35).logicalSrcIdx = 34;
                    section.data(35).dtTransOffset = 37;

                    ;% rtP.VehicleBody6DOF_Cs
                    section.data(36).logicalSrcIdx = 35;
                    section.data(36).dtTransOffset = 38;

                    ;% rtP.VehicleBody6DOF_Cym
                    section.data(37).logicalSrcIdx = 36;
                    section.data(37).dtTransOffset = 49;

                    ;% rtP.IndependentSuspensionDoubleWishbone_Cz
                    section.data(38).logicalSrcIdx = 37;
                    section.data(38).dtTransOffset = 60;

                    ;% rtP.KinematicSteering_Db
                    section.data(39).logicalSrcIdx = 38;
                    section.data(39).dtTransOffset = 61;

                    ;% rtP.IndependentSuspensionDoubleWishbone_F0z
                    section.data(40).logicalSrcIdx = 39;
                    section.data(40).dtTransOffset = 62;

                    ;% rtP.CombinedSlipWheel2DOF_FNOMIN
                    section.data(41).logicalSrcIdx = 40;
                    section.data(41).dtTransOffset = 63;

                    ;% rtP.CombinedSlipWheel2DOF_FZMAX
                    section.data(42).logicalSrcIdx = 41;
                    section.data(42).dtTransOffset = 64;

                    ;% rtP.CombinedSlipWheel2DOF_FZMIN
                    section.data(43).logicalSrcIdx = 42;
                    section.data(43).dtTransOffset = 65;

                    ;% rtP.CombinedSlipWheel2DOF_GRAVITY
                    section.data(44).logicalSrcIdx = 43;
                    section.data(44).dtTransOffset = 66;

                    ;% rtP.IndependentSuspensionDoubleWishbone_Hmax
                    section.data(45).logicalSrcIdx = 44;
                    section.data(45).dtTransOffset = 67;

                    ;% rtP.SignalHold_IC
                    section.data(46).logicalSrcIdx = 45;
                    section.data(46).dtTransOffset = 68;

                    ;% rtP.SignalHold_IC_ha5pwu4h2j
                    section.data(47).logicalSrcIdx = 46;
                    section.data(47).dtTransOffset = 69;

                    ;% rtP.SignalHold_IC_g0qec3hyrf
                    section.data(48).logicalSrcIdx = 47;
                    section.data(48).dtTransOffset = 70;

                    ;% rtP.CombinedSlipWheel2DOF_IYY
                    section.data(49).logicalSrcIdx = 48;
                    section.data(49).dtTransOffset = 71;

                    ;% rtP.VehicleBody6DOF_Iveh
                    section.data(50).logicalSrcIdx = 49;
                    section.data(50).dtTransOffset = 72;

                    ;% rtP.CombinedSlipWheel2DOF_KPUMAX
                    section.data(51).logicalSrcIdx = 50;
                    section.data(51).dtTransOffset = 81;

                    ;% rtP.CombinedSlipWheel2DOF_KPUMIN
                    section.data(52).logicalSrcIdx = 51;
                    section.data(52).dtTransOffset = 82;

                    ;% rtP.PredictiveDriver_Kaw
                    section.data(53).logicalSrcIdx = 52;
                    section.data(53).dtTransOffset = 83;

                    ;% rtP.PredictiveDriver_Kff
                    section.data(54).logicalSrcIdx = 53;
                    section.data(54).dtTransOffset = 84;

                    ;% rtP.PredictiveDriver_Kg
                    section.data(55).logicalSrcIdx = 54;
                    section.data(55).dtTransOffset = 85;

                    ;% rtP.PredictiveDriver_Ki
                    section.data(56).logicalSrcIdx = 55;
                    section.data(56).dtTransOffset = 86;

                    ;% rtP.PredictiveDriver_Kp
                    section.data(57).logicalSrcIdx = 56;
                    section.data(57).dtTransOffset = 87;

                    ;% rtP.IndependentSuspensionDoubleWishbone_Kz
                    section.data(58).logicalSrcIdx = 57;
                    section.data(58).dtTransOffset = 88;

                    ;% rtP.PredictiveDriver_L
                    section.data(59).logicalSrcIdx = 58;
                    section.data(59).dtTransOffset = 89;

                    ;% rtP.CombinedSlipWheel2DOF_LONGVL
                    section.data(60).logicalSrcIdx = 59;
                    section.data(60).dtTransOffset = 90;

                    ;% rtP.CombinedSlipWheel2DOF_MASS
                    section.data(61).logicalSrcIdx = 60;
                    section.data(61).dtTransOffset = 91;

                    ;% rtP.CombinedSlipWheel2DOF_NOMPRES
                    section.data(62).logicalSrcIdx = 61;
                    section.data(62).dtTransOffset = 92;

                    ;% rtP.CombinedSlipWheel2DOF_PRESMAX
                    section.data(63).logicalSrcIdx = 62;
                    section.data(63).dtTransOffset = 93;

                    ;% rtP.CombinedSlipWheel2DOF_PRESMIN
                    section.data(64).logicalSrcIdx = 63;
                    section.data(64).dtTransOffset = 94;

                    ;% rtP.VehicleBody6DOF_Pabs
                    section.data(65).logicalSrcIdx = 64;
                    section.data(65).dtTransOffset = 95;

                    ;% rtP.KinematicSteering_PctAck
                    section.data(66).logicalSrcIdx = 65;
                    section.data(66).dtTransOffset = 96;

                    ;% rtP.DragForce_R
                    section.data(67).logicalSrcIdx = 66;
                    section.data(67).dtTransOffset = 97;

                    ;% rtP.CombinedSlipWheel2DOF_RIM_RADIUS
                    section.data(68).logicalSrcIdx = 67;
                    section.data(68).dtTransOffset = 98;

                    ;% rtP.IndependentSuspensionDoubleWishbone_RollStrgSlp
                    section.data(69).logicalSrcIdx = 68;
                    section.data(69).dtTransOffset = 99;

                    ;% rtP.IndependentSuspensionDoubleWishbone_StrgHgtSlp
                    section.data(70).logicalSrcIdx = 69;
                    section.data(70).dtTransOffset = 100;

                    ;% rtP.KinematicSteering_StrgRatio
                    section.data(71).logicalSrcIdx = 70;
                    section.data(71).dtTransOffset = 101;

                    ;% rtP.VehicleBody6DOF_Tair
                    section.data(72).logicalSrcIdx = 71;
                    section.data(72).dtTransOffset = 102;

                    ;% rtP.IndependentSuspensionDoubleWishbone_Toe
                    section.data(73).logicalSrcIdx = 72;
                    section.data(73).dtTransOffset = 103;

                    ;% rtP.IndependentSuspensionDoubleWishbone_ToeStrgSlp
                    section.data(74).logicalSrcIdx = 73;
                    section.data(74).dtTransOffset = 104;

                    ;% rtP.CombinedSlipWheel2DOF_UNLOADED_RADIUS
                    section.data(75).logicalSrcIdx = 74;
                    section.data(75).dtTransOffset = 105;

                    ;% rtP.CombinedSlipWheel2DOF_VERTICAL_DAMPING
                    section.data(76).logicalSrcIdx = 75;
                    section.data(76).dtTransOffset = 106;

                    ;% rtP.CombinedSlipWheel2DOF_VXLOW
                    section.data(77).logicalSrcIdx = 76;
                    section.data(77).dtTransOffset = 107;

                    ;% rtP.CombinedSlipWheel2DOF_WIDTH
                    section.data(78).logicalSrcIdx = 77;
                    section.data(78).dtTransOffset = 108;

                    ;% rtP.IndependentSuspensionDoubleWishbone_WhlNumVec
                    section.data(79).logicalSrcIdx = 78;
                    section.data(79).dtTransOffset = 109;

                    ;% rtP.VehicleBody6DOF_Xe_o
                    section.data(80).logicalSrcIdx = 79;
                    section.data(80).dtTransOffset = 113;

                    ;% rtP.VehicleBody6DOF_beta_w
                    section.data(81).logicalSrcIdx = 80;
                    section.data(81).dtTransOffset = 116;

                    ;% rtP.CombinedSlipWheel2DOF_br
                    section.data(82).logicalSrcIdx = 81;
                    section.data(82).dtTransOffset = 127;

                    ;% rtP.CompareToConstant_const
                    section.data(83).logicalSrcIdx = 82;
                    section.data(83).dtTransOffset = 128;

                    ;% rtP.VehicleBody6DOF_d
                    section.data(84).logicalSrcIdx = 83;
                    section.data(84).dtTransOffset = 129;

                    ;% rtP.VehicleBody6DOF_eul_o
                    section.data(85).logicalSrcIdx = 84;
                    section.data(85).dtTransOffset = 130;

                    ;% rtP.VehicleBody6DOF_g
                    section.data(86).logicalSrcIdx = 85;
                    section.data(86).dtTransOffset = 133;

                    ;% rtP.VehicleBody6DOF_latOff
                    section.data(87).logicalSrcIdx = 86;
                    section.data(87).dtTransOffset = 134;

                    ;% rtP.VehicleBody6DOF_longOff
                    section.data(88).logicalSrcIdx = 87;
                    section.data(88).dtTransOffset = 135;

                    ;% rtP.CombinedSlipWheel2DOF_omegao
                    section.data(89).logicalSrcIdx = 88;
                    section.data(89).dtTransOffset = 136;

                    ;% rtP.VehicleBody6DOF_p_o
                    section.data(90).logicalSrcIdx = 89;
                    section.data(90).dtTransOffset = 137;

                    ;% rtP.PredictiveDriver_tau
                    section.data(91).logicalSrcIdx = 90;
                    section.data(91).dtTransOffset = 140;

                    ;% rtP.PredictiveDriver_tauerr
                    section.data(92).logicalSrcIdx = 91;
                    section.data(92).dtTransOffset = 141;

                    ;% rtP.div0protectabspoly_thresh
                    section.data(93).logicalSrcIdx = 92;
                    section.data(93).dtTransOffset = 142;

                    ;% rtP.div0protectabspoly3_thresh
                    section.data(94).logicalSrcIdx = 93;
                    section.data(94).dtTransOffset = 143;

                    ;% rtP.VehicleXYPlotter_tireFNorm
                    section.data(95).logicalSrcIdx = 94;
                    section.data(95).dtTransOffset = 144;

                    ;% rtP.CombinedSlipWheel2DOF_turnslip
                    section.data(96).logicalSrcIdx = 95;
                    section.data(96).dtTransOffset = 145;

                    ;% rtP.VehicleXYPlotter_velNorm
                    section.data(97).logicalSrcIdx = 96;
                    section.data(97).dtTransOffset = 146;

                    ;% rtP.VehicleBody6DOF_vertOff
                    section.data(98).logicalSrcIdx = 97;
                    section.data(98).dtTransOffset = 147;

                    ;% rtP.PredictiveDriver_vnom
                    section.data(99).logicalSrcIdx = 98;
                    section.data(99).dtTransOffset = 148;

                    ;% rtP.VehicleBody6DOF_w
                    section.data(100).logicalSrcIdx = 99;
                    section.data(100).dtTransOffset = 149;

                    ;% rtP.VehicleBody6DOF_xbdot_o
                    section.data(101).logicalSrcIdx = 100;
                    section.data(101).dtTransOffset = 151;

                    ;% rtP.VehicleBody6DOF_z1I
                    section.data(102).logicalSrcIdx = 101;
                    section.data(102).dtTransOffset = 154;

                    ;% rtP.VehicleBody6DOF_z1R
                    section.data(103).logicalSrcIdx = 102;
                    section.data(103).dtTransOffset = 163;

                    ;% rtP.VehicleBody6DOF_z1m
                    section.data(104).logicalSrcIdx = 103;
                    section.data(104).dtTransOffset = 166;

                    ;% rtP.VehicleBody6DOF_z2I
                    section.data(105).logicalSrcIdx = 104;
                    section.data(105).dtTransOffset = 167;

                    ;% rtP.VehicleBody6DOF_z2R
                    section.data(106).logicalSrcIdx = 105;
                    section.data(106).dtTransOffset = 176;

                    ;% rtP.VehicleBody6DOF_z2m
                    section.data(107).logicalSrcIdx = 106;
                    section.data(107).dtTransOffset = 179;

                    ;% rtP.VehicleBody6DOF_z3I
                    section.data(108).logicalSrcIdx = 107;
                    section.data(108).dtTransOffset = 180;

                    ;% rtP.VehicleBody6DOF_z3R
                    section.data(109).logicalSrcIdx = 108;
                    section.data(109).dtTransOffset = 189;

                    ;% rtP.VehicleBody6DOF_z3m
                    section.data(110).logicalSrcIdx = 109;
                    section.data(110).dtTransOffset = 192;

                    ;% rtP.VehicleBody6DOF_z4I
                    section.data(111).logicalSrcIdx = 110;
                    section.data(111).dtTransOffset = 193;

                    ;% rtP.VehicleBody6DOF_z4R
                    section.data(112).logicalSrcIdx = 111;
                    section.data(112).dtTransOffset = 202;

                    ;% rtP.VehicleBody6DOF_z4m
                    section.data(113).logicalSrcIdx = 112;
                    section.data(113).dtTransOffset = 205;

                    ;% rtP.VehicleBody6DOF_z5I
                    section.data(114).logicalSrcIdx = 113;
                    section.data(114).dtTransOffset = 206;

                    ;% rtP.VehicleBody6DOF_z5R
                    section.data(115).logicalSrcIdx = 114;
                    section.data(115).dtTransOffset = 215;

                    ;% rtP.VehicleBody6DOF_z5m
                    section.data(116).logicalSrcIdx = 115;
                    section.data(116).dtTransOffset = 218;

                    ;% rtP.VehicleBody6DOF_z6I
                    section.data(117).logicalSrcIdx = 116;
                    section.data(117).dtTransOffset = 219;

                    ;% rtP.VehicleBody6DOF_z6R
                    section.data(118).logicalSrcIdx = 117;
                    section.data(118).dtTransOffset = 228;

                    ;% rtP.VehicleBody6DOF_z6m
                    section.data(119).logicalSrcIdx = 118;
                    section.data(119).dtTransOffset = 231;

                    ;% rtP.VehicleBody6DOF_z7I
                    section.data(120).logicalSrcIdx = 119;
                    section.data(120).dtTransOffset = 232;

                    ;% rtP.VehicleBody6DOF_z7R
                    section.data(121).logicalSrcIdx = 120;
                    section.data(121).dtTransOffset = 241;

                    ;% rtP.VehicleBody6DOF_z7m
                    section.data(122).logicalSrcIdx = 121;
                    section.data(122).dtTransOffset = 244;

                    ;% rtP.CombinedSlipWheel2DOF_zdoto
                    section.data(123).logicalSrcIdx = 122;
                    section.data(123).dtTransOffset = 245;

                    ;% rtP.CombinedSlipWheel2DOF_zo
                    section.data(124).logicalSrcIdx = 123;
                    section.data(124).dtTransOffset = 246;

                    ;% rtP.Gain2_Gain
                    section.data(125).logicalSrcIdx = 124;
                    section.data(125).dtTransOffset = 247;

                    ;% rtP.Out1_Y0
                    section.data(126).logicalSrcIdx = 125;
                    section.data(126).dtTransOffset = 248;

                    ;% rtP.UnitDelay_InitialCondition
                    section.data(127).logicalSrcIdx = 126;
                    section.data(127).dtTransOffset = 249;

                    ;% rtP.Constant_Value
                    section.data(128).logicalSrcIdx = 127;
                    section.data(128).dtTransOffset = 250;

                    ;% rtP.u1_UpperSat
                    section.data(129).logicalSrcIdx = 128;
                    section.data(129).dtTransOffset = 251;

                    ;% rtP.u1_LowerSat
                    section.data(130).logicalSrcIdx = 129;
                    section.data(130).dtTransOffset = 252;

                    ;% rtP.u1_UpperSat_ktphrh25ym
                    section.data(131).logicalSrcIdx = 130;
                    section.data(131).dtTransOffset = 253;

                    ;% rtP.u1_LowerSat_kyjd4o3lsn
                    section.data(132).logicalSrcIdx = 131;
                    section.data(132).dtTransOffset = 254;

                    ;% rtP.u0_UpperSat
                    section.data(133).logicalSrcIdx = 132;
                    section.data(133).dtTransOffset = 255;

                    ;% rtP.u0_LowerSat
                    section.data(134).logicalSrcIdx = 133;
                    section.data(134).dtTransOffset = 256;

                    ;% rtP.MagicTireConstInput_BOTTOM_OFFST
                    section.data(135).logicalSrcIdx = 134;
                    section.data(135).dtTransOffset = 257;

                    ;% rtP.MagicTireConstInput_BOTTOM_STIFF
                    section.data(136).logicalSrcIdx = 135;
                    section.data(136).dtTransOffset = 258;

                    ;% rtP.MagicTireConstInput_BREFF
                    section.data(137).logicalSrcIdx = 136;
                    section.data(137).dtTransOffset = 259;

                    ;% rtP.MagicTireConstInput_DREFF
                    section.data(138).logicalSrcIdx = 137;
                    section.data(138).dtTransOffset = 260;

                    ;% rtP.MagicTireConstInput_FREFF
                    section.data(139).logicalSrcIdx = 138;
                    section.data(139).dtTransOffset = 261;

                    ;% rtP.MagicTireConstInput_LATERAL_STIFFNESS
                    section.data(140).logicalSrcIdx = 139;
                    section.data(140).dtTransOffset = 262;

                    ;% rtP.MagicTireConstInput_LONGITUDINAL_STIFFNESS
                    section.data(141).logicalSrcIdx = 140;
                    section.data(141).dtTransOffset = 263;

                    ;% rtP.MagicTireConstInput_PCFX1
                    section.data(142).logicalSrcIdx = 141;
                    section.data(142).dtTransOffset = 264;

                    ;% rtP.MagicTireConstInput_PCFX2
                    section.data(143).logicalSrcIdx = 142;
                    section.data(143).dtTransOffset = 265;

                    ;% rtP.MagicTireConstInput_PCFX3
                    section.data(144).logicalSrcIdx = 143;
                    section.data(144).dtTransOffset = 266;

                    ;% rtP.MagicTireConstInput_PCFY1
                    section.data(145).logicalSrcIdx = 144;
                    section.data(145).dtTransOffset = 267;

                    ;% rtP.MagicTireConstInput_PCFY2
                    section.data(146).logicalSrcIdx = 145;
                    section.data(146).dtTransOffset = 268;

                    ;% rtP.MagicTireConstInput_PCFY3
                    section.data(147).logicalSrcIdx = 146;
                    section.data(147).dtTransOffset = 269;

                    ;% rtP.MagicTireConstInput_PCX1
                    section.data(148).logicalSrcIdx = 147;
                    section.data(148).dtTransOffset = 270;

                    ;% rtP.MagicTireConstInput_PCY1
                    section.data(149).logicalSrcIdx = 148;
                    section.data(149).dtTransOffset = 271;

                    ;% rtP.MagicTireConstInput_PDX1
                    section.data(150).logicalSrcIdx = 149;
                    section.data(150).dtTransOffset = 272;

                    ;% rtP.MagicTireConstInput_PDX2
                    section.data(151).logicalSrcIdx = 150;
                    section.data(151).dtTransOffset = 273;

                    ;% rtP.MagicTireConstInput_PDX3
                    section.data(152).logicalSrcIdx = 151;
                    section.data(152).dtTransOffset = 274;

                    ;% rtP.MagicTireConstInput_PDXP1
                    section.data(153).logicalSrcIdx = 152;
                    section.data(153).dtTransOffset = 275;

                    ;% rtP.MagicTireConstInput_PDXP2
                    section.data(154).logicalSrcIdx = 153;
                    section.data(154).dtTransOffset = 276;

                    ;% rtP.MagicTireConstInput_PDXP3
                    section.data(155).logicalSrcIdx = 154;
                    section.data(155).dtTransOffset = 277;

                    ;% rtP.MagicTireConstInput_PDY1
                    section.data(156).logicalSrcIdx = 155;
                    section.data(156).dtTransOffset = 278;

                    ;% rtP.MagicTireConstInput_PDY2
                    section.data(157).logicalSrcIdx = 156;
                    section.data(157).dtTransOffset = 279;

                    ;% rtP.MagicTireConstInput_PDY3
                    section.data(158).logicalSrcIdx = 157;
                    section.data(158).dtTransOffset = 280;

                    ;% rtP.MagicTireConstInput_PDYP1
                    section.data(159).logicalSrcIdx = 158;
                    section.data(159).dtTransOffset = 281;

                    ;% rtP.MagicTireConstInput_PDYP2
                    section.data(160).logicalSrcIdx = 159;
                    section.data(160).dtTransOffset = 282;

                    ;% rtP.MagicTireConstInput_PDYP3
                    section.data(161).logicalSrcIdx = 160;
                    section.data(161).dtTransOffset = 283;

                    ;% rtP.MagicTireConstInput_PDYP4
                    section.data(162).logicalSrcIdx = 161;
                    section.data(162).dtTransOffset = 284;

                    ;% rtP.MagicTireConstInput_PECP1
                    section.data(163).logicalSrcIdx = 162;
                    section.data(163).dtTransOffset = 285;

                    ;% rtP.MagicTireConstInput_PECP2
                    section.data(164).logicalSrcIdx = 163;
                    section.data(164).dtTransOffset = 286;

                    ;% rtP.MagicTireConstInput_PEX1
                    section.data(165).logicalSrcIdx = 164;
                    section.data(165).dtTransOffset = 287;

                    ;% rtP.MagicTireConstInput_PEX2
                    section.data(166).logicalSrcIdx = 165;
                    section.data(166).dtTransOffset = 288;

                    ;% rtP.MagicTireConstInput_PEX3
                    section.data(167).logicalSrcIdx = 166;
                    section.data(167).dtTransOffset = 289;

                    ;% rtP.MagicTireConstInput_PEX4
                    section.data(168).logicalSrcIdx = 167;
                    section.data(168).dtTransOffset = 290;

                    ;% rtP.MagicTireConstInput_PEY1
                    section.data(169).logicalSrcIdx = 168;
                    section.data(169).dtTransOffset = 291;

                    ;% rtP.MagicTireConstInput_PEY2
                    section.data(170).logicalSrcIdx = 169;
                    section.data(170).dtTransOffset = 292;

                    ;% rtP.MagicTireConstInput_PEY3
                    section.data(171).logicalSrcIdx = 170;
                    section.data(171).dtTransOffset = 293;

                    ;% rtP.MagicTireConstInput_PEY4
                    section.data(172).logicalSrcIdx = 171;
                    section.data(172).dtTransOffset = 294;

                    ;% rtP.MagicTireConstInput_PEY5
                    section.data(173).logicalSrcIdx = 172;
                    section.data(173).dtTransOffset = 295;

                    ;% rtP.MagicTireConstInput_PFZ1
                    section.data(174).logicalSrcIdx = 173;
                    section.data(174).dtTransOffset = 296;

                    ;% rtP.MagicTireConstInput_PHX1
                    section.data(175).logicalSrcIdx = 174;
                    section.data(175).dtTransOffset = 297;

                    ;% rtP.MagicTireConstInput_PHX2
                    section.data(176).logicalSrcIdx = 175;
                    section.data(176).dtTransOffset = 298;

                    ;% rtP.MagicTireConstInput_PHY1
                    section.data(177).logicalSrcIdx = 176;
                    section.data(177).dtTransOffset = 299;

                    ;% rtP.MagicTireConstInput_PHY2
                    section.data(178).logicalSrcIdx = 177;
                    section.data(178).dtTransOffset = 300;

                    ;% rtP.MagicTireConstInput_PHYP1
                    section.data(179).logicalSrcIdx = 178;
                    section.data(179).dtTransOffset = 301;

                    ;% rtP.MagicTireConstInput_PHYP2
                    section.data(180).logicalSrcIdx = 179;
                    section.data(180).dtTransOffset = 302;

                    ;% rtP.MagicTireConstInput_PHYP3
                    section.data(181).logicalSrcIdx = 180;
                    section.data(181).dtTransOffset = 303;

                    ;% rtP.MagicTireConstInput_PHYP4
                    section.data(182).logicalSrcIdx = 181;
                    section.data(182).dtTransOffset = 304;

                    ;% rtP.MagicTireConstInput_PKX1
                    section.data(183).logicalSrcIdx = 182;
                    section.data(183).dtTransOffset = 305;

                    ;% rtP.MagicTireConstInput_PKX2
                    section.data(184).logicalSrcIdx = 183;
                    section.data(184).dtTransOffset = 306;

                    ;% rtP.MagicTireConstInput_PKX3
                    section.data(185).logicalSrcIdx = 184;
                    section.data(185).dtTransOffset = 307;

                    ;% rtP.MagicTireConstInput_PKY1
                    section.data(186).logicalSrcIdx = 185;
                    section.data(186).dtTransOffset = 308;

                    ;% rtP.MagicTireConstInput_PKY2
                    section.data(187).logicalSrcIdx = 186;
                    section.data(187).dtTransOffset = 309;

                    ;% rtP.MagicTireConstInput_PKY3
                    section.data(188).logicalSrcIdx = 187;
                    section.data(188).dtTransOffset = 310;

                    ;% rtP.MagicTireConstInput_PKY4
                    section.data(189).logicalSrcIdx = 188;
                    section.data(189).dtTransOffset = 311;

                    ;% rtP.MagicTireConstInput_PKY5
                    section.data(190).logicalSrcIdx = 189;
                    section.data(190).dtTransOffset = 312;

                    ;% rtP.MagicTireConstInput_PKY6
                    section.data(191).logicalSrcIdx = 190;
                    section.data(191).dtTransOffset = 313;

                    ;% rtP.MagicTireConstInput_PKY7
                    section.data(192).logicalSrcIdx = 191;
                    section.data(192).dtTransOffset = 314;

                    ;% rtP.MagicTireConstInput_PKYP1
                    section.data(193).logicalSrcIdx = 192;
                    section.data(193).dtTransOffset = 315;

                    ;% rtP.MagicTireConstInput_PPMX1
                    section.data(194).logicalSrcIdx = 193;
                    section.data(194).dtTransOffset = 316;

                    ;% rtP.MagicTireConstInput_PPX1
                    section.data(195).logicalSrcIdx = 194;
                    section.data(195).dtTransOffset = 317;

                    ;% rtP.MagicTireConstInput_PPX2
                    section.data(196).logicalSrcIdx = 195;
                    section.data(196).dtTransOffset = 318;

                    ;% rtP.MagicTireConstInput_PPX3
                    section.data(197).logicalSrcIdx = 196;
                    section.data(197).dtTransOffset = 319;

                    ;% rtP.MagicTireConstInput_PPX4
                    section.data(198).logicalSrcIdx = 197;
                    section.data(198).dtTransOffset = 320;

                    ;% rtP.MagicTireConstInput_PPY1
                    section.data(199).logicalSrcIdx = 198;
                    section.data(199).dtTransOffset = 321;

                    ;% rtP.MagicTireConstInput_PPY2
                    section.data(200).logicalSrcIdx = 199;
                    section.data(200).dtTransOffset = 322;

                    ;% rtP.MagicTireConstInput_PPY3
                    section.data(201).logicalSrcIdx = 200;
                    section.data(201).dtTransOffset = 323;

                    ;% rtP.MagicTireConstInput_PPY4
                    section.data(202).logicalSrcIdx = 201;
                    section.data(202).dtTransOffset = 324;

                    ;% rtP.MagicTireConstInput_PPY5
                    section.data(203).logicalSrcIdx = 202;
                    section.data(203).dtTransOffset = 325;

                    ;% rtP.MagicTireConstInput_PPZ1
                    section.data(204).logicalSrcIdx = 203;
                    section.data(204).dtTransOffset = 326;

                    ;% rtP.MagicTireConstInput_PPZ2
                    section.data(205).logicalSrcIdx = 204;
                    section.data(205).dtTransOffset = 327;

                    ;% rtP.MagicTireConstInput_PVX1
                    section.data(206).logicalSrcIdx = 205;
                    section.data(206).dtTransOffset = 328;

                    ;% rtP.MagicTireConstInput_PVX2
                    section.data(207).logicalSrcIdx = 206;
                    section.data(207).dtTransOffset = 329;

                    ;% rtP.MagicTireConstInput_PVY1
                    section.data(208).logicalSrcIdx = 207;
                    section.data(208).dtTransOffset = 330;

                    ;% rtP.MagicTireConstInput_PVY2
                    section.data(209).logicalSrcIdx = 208;
                    section.data(209).dtTransOffset = 331;

                    ;% rtP.MagicTireConstInput_PVY3
                    section.data(210).logicalSrcIdx = 209;
                    section.data(210).dtTransOffset = 332;

                    ;% rtP.MagicTireConstInput_PVY4
                    section.data(211).logicalSrcIdx = 210;
                    section.data(211).dtTransOffset = 333;

                    ;% rtP.MagicTireConstInput_QBRP1
                    section.data(212).logicalSrcIdx = 211;
                    section.data(212).dtTransOffset = 334;

                    ;% rtP.MagicTireConstInput_QBZ1
                    section.data(213).logicalSrcIdx = 212;
                    section.data(213).dtTransOffset = 335;

                    ;% rtP.MagicTireConstInput_QBZ10
                    section.data(214).logicalSrcIdx = 213;
                    section.data(214).dtTransOffset = 336;

                    ;% rtP.MagicTireConstInput_QBZ2
                    section.data(215).logicalSrcIdx = 214;
                    section.data(215).dtTransOffset = 337;

                    ;% rtP.MagicTireConstInput_QBZ3
                    section.data(216).logicalSrcIdx = 215;
                    section.data(216).dtTransOffset = 338;

                    ;% rtP.MagicTireConstInput_QBZ4
                    section.data(217).logicalSrcIdx = 216;
                    section.data(217).dtTransOffset = 339;

                    ;% rtP.MagicTireConstInput_QBZ5
                    section.data(218).logicalSrcIdx = 217;
                    section.data(218).dtTransOffset = 340;

                    ;% rtP.MagicTireConstInput_QBZ6
                    section.data(219).logicalSrcIdx = 218;
                    section.data(219).dtTransOffset = 341;

                    ;% rtP.MagicTireConstInput_QBZ9
                    section.data(220).logicalSrcIdx = 219;
                    section.data(220).dtTransOffset = 342;

                    ;% rtP.MagicTireConstInput_QCRP1
                    section.data(221).logicalSrcIdx = 220;
                    section.data(221).dtTransOffset = 343;

                    ;% rtP.MagicTireConstInput_QCRP2
                    section.data(222).logicalSrcIdx = 221;
                    section.data(222).dtTransOffset = 344;

                    ;% rtP.MagicTireConstInput_QCZ1
                    section.data(223).logicalSrcIdx = 222;
                    section.data(223).dtTransOffset = 345;

                    ;% rtP.MagicTireConstInput_QDRP1
                    section.data(224).logicalSrcIdx = 223;
                    section.data(224).dtTransOffset = 346;

                    ;% rtP.MagicTireConstInput_QDRP2
                    section.data(225).logicalSrcIdx = 224;
                    section.data(225).dtTransOffset = 347;

                    ;% rtP.MagicTireConstInput_QDTP1
                    section.data(226).logicalSrcIdx = 225;
                    section.data(226).dtTransOffset = 348;

                    ;% rtP.MagicTireConstInput_QDZ1
                    section.data(227).logicalSrcIdx = 226;
                    section.data(227).dtTransOffset = 349;

                    ;% rtP.MagicTireConstInput_QDZ10
                    section.data(228).logicalSrcIdx = 227;
                    section.data(228).dtTransOffset = 350;

                    ;% rtP.MagicTireConstInput_QDZ11
                    section.data(229).logicalSrcIdx = 228;
                    section.data(229).dtTransOffset = 351;

                    ;% rtP.MagicTireConstInput_QDZ2
                    section.data(230).logicalSrcIdx = 229;
                    section.data(230).dtTransOffset = 352;

                    ;% rtP.MagicTireConstInput_QDZ3
                    section.data(231).logicalSrcIdx = 230;
                    section.data(231).dtTransOffset = 353;

                    ;% rtP.MagicTireConstInput_QDZ4
                    section.data(232).logicalSrcIdx = 231;
                    section.data(232).dtTransOffset = 354;

                    ;% rtP.MagicTireConstInput_QDZ6
                    section.data(233).logicalSrcIdx = 232;
                    section.data(233).dtTransOffset = 355;

                    ;% rtP.MagicTireConstInput_QDZ7
                    section.data(234).logicalSrcIdx = 233;
                    section.data(234).dtTransOffset = 356;

                    ;% rtP.MagicTireConstInput_QDZ8
                    section.data(235).logicalSrcIdx = 234;
                    section.data(235).dtTransOffset = 357;

                    ;% rtP.MagicTireConstInput_QDZ9
                    section.data(236).logicalSrcIdx = 235;
                    section.data(236).dtTransOffset = 358;

                    ;% rtP.MagicTireConstInput_QEZ1
                    section.data(237).logicalSrcIdx = 236;
                    section.data(237).dtTransOffset = 359;

                    ;% rtP.MagicTireConstInput_QEZ2
                    section.data(238).logicalSrcIdx = 237;
                    section.data(238).dtTransOffset = 360;

                    ;% rtP.MagicTireConstInput_QEZ3
                    section.data(239).logicalSrcIdx = 238;
                    section.data(239).dtTransOffset = 361;

                    ;% rtP.MagicTireConstInput_QEZ4
                    section.data(240).logicalSrcIdx = 239;
                    section.data(240).dtTransOffset = 362;

                    ;% rtP.MagicTireConstInput_QEZ5
                    section.data(241).logicalSrcIdx = 240;
                    section.data(241).dtTransOffset = 363;

                    ;% rtP.MagicTireConstInput_QHZ1
                    section.data(242).logicalSrcIdx = 241;
                    section.data(242).dtTransOffset = 364;

                    ;% rtP.MagicTireConstInput_QHZ2
                    section.data(243).logicalSrcIdx = 242;
                    section.data(243).dtTransOffset = 365;

                    ;% rtP.MagicTireConstInput_QHZ3
                    section.data(244).logicalSrcIdx = 243;
                    section.data(244).dtTransOffset = 366;

                    ;% rtP.MagicTireConstInput_QHZ4
                    section.data(245).logicalSrcIdx = 244;
                    section.data(245).dtTransOffset = 367;

                    ;% rtP.MagicTireConstInput_QSX1
                    section.data(246).logicalSrcIdx = 245;
                    section.data(246).dtTransOffset = 368;

                    ;% rtP.MagicTireConstInput_QSX10
                    section.data(247).logicalSrcIdx = 246;
                    section.data(247).dtTransOffset = 369;

                    ;% rtP.MagicTireConstInput_QSX11
                    section.data(248).logicalSrcIdx = 247;
                    section.data(248).dtTransOffset = 370;

                    ;% rtP.MagicTireConstInput_QSX12
                    section.data(249).logicalSrcIdx = 248;
                    section.data(249).dtTransOffset = 371;

                    ;% rtP.MagicTireConstInput_QSX13
                    section.data(250).logicalSrcIdx = 249;
                    section.data(250).dtTransOffset = 372;

                    ;% rtP.MagicTireConstInput_QSX14
                    section.data(251).logicalSrcIdx = 250;
                    section.data(251).dtTransOffset = 373;

                    ;% rtP.MagicTireConstInput_QSX2
                    section.data(252).logicalSrcIdx = 251;
                    section.data(252).dtTransOffset = 374;

                    ;% rtP.MagicTireConstInput_QSX3
                    section.data(253).logicalSrcIdx = 252;
                    section.data(253).dtTransOffset = 375;

                    ;% rtP.MagicTireConstInput_QSX4
                    section.data(254).logicalSrcIdx = 253;
                    section.data(254).dtTransOffset = 376;

                    ;% rtP.MagicTireConstInput_QSX5
                    section.data(255).logicalSrcIdx = 254;
                    section.data(255).dtTransOffset = 377;

                    ;% rtP.MagicTireConstInput_QSX6
                    section.data(256).logicalSrcIdx = 255;
                    section.data(256).dtTransOffset = 378;

                    ;% rtP.MagicTireConstInput_QSX7
                    section.data(257).logicalSrcIdx = 256;
                    section.data(257).dtTransOffset = 379;

                    ;% rtP.MagicTireConstInput_QSX8
                    section.data(258).logicalSrcIdx = 257;
                    section.data(258).dtTransOffset = 380;

                    ;% rtP.MagicTireConstInput_QSX9
                    section.data(259).logicalSrcIdx = 258;
                    section.data(259).dtTransOffset = 381;

                    ;% rtP.MagicTireConstInput_QSY1
                    section.data(260).logicalSrcIdx = 259;
                    section.data(260).dtTransOffset = 382;

                    ;% rtP.MagicTireConstInput_QSY2
                    section.data(261).logicalSrcIdx = 260;
                    section.data(261).dtTransOffset = 383;

                    ;% rtP.MagicTireConstInput_QSY3
                    section.data(262).logicalSrcIdx = 261;
                    section.data(262).dtTransOffset = 384;

                    ;% rtP.MagicTireConstInput_QSY4
                    section.data(263).logicalSrcIdx = 262;
                    section.data(263).dtTransOffset = 385;

                    ;% rtP.MagicTireConstInput_QSY5
                    section.data(264).logicalSrcIdx = 263;
                    section.data(264).dtTransOffset = 386;

                    ;% rtP.MagicTireConstInput_QSY6
                    section.data(265).logicalSrcIdx = 264;
                    section.data(265).dtTransOffset = 387;

                    ;% rtP.MagicTireConstInput_QSY7
                    section.data(266).logicalSrcIdx = 265;
                    section.data(266).dtTransOffset = 388;

                    ;% rtP.MagicTireConstInput_QSY8
                    section.data(267).logicalSrcIdx = 266;
                    section.data(267).dtTransOffset = 389;

                    ;% rtP.MagicTireConstInput_Q_CAM1
                    section.data(268).logicalSrcIdx = 267;
                    section.data(268).dtTransOffset = 390;

                    ;% rtP.MagicTireConstInput_Q_CAM2
                    section.data(269).logicalSrcIdx = 268;
                    section.data(269).dtTransOffset = 391;

                    ;% rtP.MagicTireConstInput_Q_CAM3
                    section.data(270).logicalSrcIdx = 269;
                    section.data(270).dtTransOffset = 392;

                    ;% rtP.MagicTireConstInput_Q_FCX
                    section.data(271).logicalSrcIdx = 270;
                    section.data(271).dtTransOffset = 393;

                    ;% rtP.MagicTireConstInput_Q_FCY
                    section.data(272).logicalSrcIdx = 271;
                    section.data(272).dtTransOffset = 394;

                    ;% rtP.MagicTireConstInput_Q_FCY2
                    section.data(273).logicalSrcIdx = 272;
                    section.data(273).dtTransOffset = 395;

                    ;% rtP.MagicTireConstInput_Q_FYS1
                    section.data(274).logicalSrcIdx = 273;
                    section.data(274).dtTransOffset = 396;

                    ;% rtP.MagicTireConstInput_Q_FYS2
                    section.data(275).logicalSrcIdx = 274;
                    section.data(275).dtTransOffset = 397;

                    ;% rtP.MagicTireConstInput_Q_FYS3
                    section.data(276).logicalSrcIdx = 275;
                    section.data(276).dtTransOffset = 398;

                    ;% rtP.MagicTireConstInput_Q_FZ1
                    section.data(277).logicalSrcIdx = 276;
                    section.data(277).dtTransOffset = 399;

                    ;% rtP.MagicTireConstInput_Q_FZ2
                    section.data(278).logicalSrcIdx = 277;
                    section.data(278).dtTransOffset = 400;

                    ;% rtP.MagicTireConstInput_Q_FZ3
                    section.data(279).logicalSrcIdx = 278;
                    section.data(279).dtTransOffset = 401;

                    ;% rtP.MagicTireConstInput_Q_RA1
                    section.data(280).logicalSrcIdx = 279;
                    section.data(280).dtTransOffset = 402;

                    ;% rtP.MagicTireConstInput_Q_RA2
                    section.data(281).logicalSrcIdx = 280;
                    section.data(281).dtTransOffset = 403;

                    ;% rtP.MagicTireConstInput_Q_RB1
                    section.data(282).logicalSrcIdx = 281;
                    section.data(282).dtTransOffset = 404;

                    ;% rtP.MagicTireConstInput_Q_RB2
                    section.data(283).logicalSrcIdx = 282;
                    section.data(283).dtTransOffset = 405;

                    ;% rtP.MagicTireConstInput_Q_RE0
                    section.data(284).logicalSrcIdx = 283;
                    section.data(284).dtTransOffset = 406;

                    ;% rtP.MagicTireConstInput_Q_V1
                    section.data(285).logicalSrcIdx = 284;
                    section.data(285).dtTransOffset = 407;

                    ;% rtP.MagicTireConstInput_Q_V2
                    section.data(286).logicalSrcIdx = 285;
                    section.data(286).dtTransOffset = 408;

                    ;% rtP.MagicTireConstInput_RBX1
                    section.data(287).logicalSrcIdx = 286;
                    section.data(287).dtTransOffset = 409;

                    ;% rtP.MagicTireConstInput_RBX2
                    section.data(288).logicalSrcIdx = 287;
                    section.data(288).dtTransOffset = 410;

                    ;% rtP.MagicTireConstInput_RBX3
                    section.data(289).logicalSrcIdx = 288;
                    section.data(289).dtTransOffset = 411;

                    ;% rtP.MagicTireConstInput_RBY1
                    section.data(290).logicalSrcIdx = 289;
                    section.data(290).dtTransOffset = 412;

                    ;% rtP.MagicTireConstInput_RBY2
                    section.data(291).logicalSrcIdx = 290;
                    section.data(291).dtTransOffset = 413;

                    ;% rtP.MagicTireConstInput_RBY3
                    section.data(292).logicalSrcIdx = 291;
                    section.data(292).dtTransOffset = 414;

                    ;% rtP.MagicTireConstInput_RBY4
                    section.data(293).logicalSrcIdx = 292;
                    section.data(293).dtTransOffset = 415;

                    ;% rtP.MagicTireConstInput_RCX1
                    section.data(294).logicalSrcIdx = 293;
                    section.data(294).dtTransOffset = 416;

                    ;% rtP.MagicTireConstInput_RCY1
                    section.data(295).logicalSrcIdx = 294;
                    section.data(295).dtTransOffset = 417;

                    ;% rtP.MagicTireConstInput_REX1
                    section.data(296).logicalSrcIdx = 295;
                    section.data(296).dtTransOffset = 418;

                    ;% rtP.MagicTireConstInput_REX2
                    section.data(297).logicalSrcIdx = 296;
                    section.data(297).dtTransOffset = 419;

                    ;% rtP.MagicTireConstInput_REY1
                    section.data(298).logicalSrcIdx = 297;
                    section.data(298).dtTransOffset = 420;

                    ;% rtP.MagicTireConstInput_REY2
                    section.data(299).logicalSrcIdx = 298;
                    section.data(299).dtTransOffset = 421;

                    ;% rtP.MagicTireConstInput_RHX1
                    section.data(300).logicalSrcIdx = 299;
                    section.data(300).dtTransOffset = 422;

                    ;% rtP.MagicTireConstInput_RHY1
                    section.data(301).logicalSrcIdx = 300;
                    section.data(301).dtTransOffset = 423;

                    ;% rtP.MagicTireConstInput_RHY2
                    section.data(302).logicalSrcIdx = 301;
                    section.data(302).dtTransOffset = 424;

                    ;% rtP.MagicTireConstInput_RVY1
                    section.data(303).logicalSrcIdx = 302;
                    section.data(303).dtTransOffset = 425;

                    ;% rtP.MagicTireConstInput_RVY2
                    section.data(304).logicalSrcIdx = 303;
                    section.data(304).dtTransOffset = 426;

                    ;% rtP.MagicTireConstInput_RVY3
                    section.data(305).logicalSrcIdx = 304;
                    section.data(305).dtTransOffset = 427;

                    ;% rtP.MagicTireConstInput_RVY4
                    section.data(306).logicalSrcIdx = 305;
                    section.data(306).dtTransOffset = 428;

                    ;% rtP.MagicTireConstInput_RVY5
                    section.data(307).logicalSrcIdx = 306;
                    section.data(307).dtTransOffset = 429;

                    ;% rtP.MagicTireConstInput_RVY6
                    section.data(308).logicalSrcIdx = 307;
                    section.data(308).dtTransOffset = 430;

                    ;% rtP.MagicTireConstInput_SSZ1
                    section.data(309).logicalSrcIdx = 308;
                    section.data(309).dtTransOffset = 431;

                    ;% rtP.MagicTireConstInput_SSZ2
                    section.data(310).logicalSrcIdx = 309;
                    section.data(310).dtTransOffset = 432;

                    ;% rtP.MagicTireConstInput_SSZ3
                    section.data(311).logicalSrcIdx = 310;
                    section.data(311).dtTransOffset = 433;

                    ;% rtP.MagicTireConstInput_SSZ4
                    section.data(312).logicalSrcIdx = 311;
                    section.data(312).dtTransOffset = 434;

                    ;% rtP.MagicTireConstInput_VERTICAL_STIFFNESS
                    section.data(313).logicalSrcIdx = 312;
                    section.data(313).dtTransOffset = 435;

                    ;% rtP.MagicTireConstInput_vdynMF
                    section.data(314).logicalSrcIdx = 313;
                    section.data(314).dtTransOffset = 436;

                    ;% rtP.InternalVehicleXYPlotter_extRef
                    section.data(315).logicalSrcIdx = 314;
                    section.data(315).dtTransOffset = 715;

                    ;% rtP.InternalVehicleXYPlotter_extStats
                    section.data(316).logicalSrcIdx = 315;
                    section.data(316).dtTransOffset = 716;

                    ;% rtP.InternalVehicleXYPlotter_extTireF
                    section.data(317).logicalSrcIdx = 316;
                    section.data(317).dtTransOffset = 717;

                    ;% rtP.Integrator1_IC
                    section.data(318).logicalSrcIdx = 317;
                    section.data(318).dtTransOffset = 718;

                    ;% rtP.Integrator1_AbsoluteTolerance
                    section.data(319).logicalSrcIdx = 318;
                    section.data(319).dtTransOffset = 719;

                    ;% rtP.Switch_Threshold
                    section.data(320).logicalSrcIdx = 319;
                    section.data(320).dtTransOffset = 720;

                    ;% rtP.Backlash_InitialOutput
                    section.data(321).logicalSrcIdx = 320;
                    section.data(321).dtTransOffset = 721;

                    ;% rtP.Switch_Threshold_jujvwwykeh
                    section.data(322).logicalSrcIdx = 321;
                    section.data(322).dtTransOffset = 722;

                    ;% rtP.Switch1_Threshold
                    section.data(323).logicalSrcIdx = 322;
                    section.data(323).dtTransOffset = 723;

                    ;% rtP.Switch_Threshold_az3vcbbzxw
                    section.data(324).logicalSrcIdx = 323;
                    section.data(324).dtTransOffset = 724;

                    ;% rtP.Switch1_Threshold_abcoyyeui2
                    section.data(325).logicalSrcIdx = 324;
                    section.data(325).dtTransOffset = 725;

                    ;% rtP.Integrator_IC
                    section.data(326).logicalSrcIdx = 325;
                    section.data(326).dtTransOffset = 726;

                    ;% rtP.Integrator_AbsoluteTolerance
                    section.data(327).logicalSrcIdx = 326;
                    section.data(327).dtTransOffset = 727;

                    ;% rtP.Integrator_IC_pqre0d4b11
                    section.data(328).logicalSrcIdx = 327;
                    section.data(328).dtTransOffset = 728;

                    ;% rtP.Integrator_AbsoluteTolerance_cy2pnd2c5m
                    section.data(329).logicalSrcIdx = 328;
                    section.data(329).dtTransOffset = 729;

                    ;% rtP.u_Gain
                    section.data(330).logicalSrcIdx = 329;
                    section.data(330).dtTransOffset = 730;

                    ;% rtP.Crm_tableData
                    section.data(331).logicalSrcIdx = 330;
                    section.data(331).dtTransOffset = 733;

                    ;% rtP.Crm_bp01Data
                    section.data(332).logicalSrcIdx = 331;
                    section.data(332).dtTransOffset = 735;

                    ;% rtP.Integrator1_IC_k5k4c2qhgr
                    section.data(333).logicalSrcIdx = 332;
                    section.data(333).dtTransOffset = 737;

                    ;% rtP.Saturation_UpperSat
                    section.data(334).logicalSrcIdx = 333;
                    section.data(334).dtTransOffset = 738;

                    ;% rtP.Saturation_LowerSat
                    section.data(335).logicalSrcIdx = 334;
                    section.data(335).dtTransOffset = 739;

                    ;% rtP.Integrator_IC_ereaclltod
                    section.data(336).logicalSrcIdx = 335;
                    section.data(336).dtTransOffset = 740;

                    ;% rtP.Memory1_InitialCondition
                    section.data(337).logicalSrcIdx = 336;
                    section.data(337).dtTransOffset = 741;

                    ;% rtP.Integrator2_IC
                    section.data(338).logicalSrcIdx = 337;
                    section.data(338).dtTransOffset = 742;

                    ;% rtP.Integrator2_AbsoluteTolerance
                    section.data(339).logicalSrcIdx = 338;
                    section.data(339).dtTransOffset = 743;

                    ;% rtP.UnitDelay_InitialCondition_otnmjf0q3j
                    section.data(340).logicalSrcIdx = 339;
                    section.data(340).dtTransOffset = 744;

                    ;% rtP.Integrator1_IC_l3hid1knke
                    section.data(341).logicalSrcIdx = 340;
                    section.data(341).dtTransOffset = 746;

                    ;% rtP.Integrator1_UpperSat
                    section.data(342).logicalSrcIdx = 341;
                    section.data(342).dtTransOffset = 747;

                    ;% rtP.Integrator1_LowerSat
                    section.data(343).logicalSrcIdx = 342;
                    section.data(343).dtTransOffset = 748;

                    ;% rtP.uto1_UpperSat
                    section.data(344).logicalSrcIdx = 343;
                    section.data(344).dtTransOffset = 749;

                    ;% rtP.uto1_LowerSat
                    section.data(345).logicalSrcIdx = 344;
                    section.data(345).dtTransOffset = 750;

                    ;% rtP.Integrator1_IC_nspsznejiv
                    section.data(346).logicalSrcIdx = 345;
                    section.data(346).dtTransOffset = 751;

                    ;% rtP.Saturation_UpperSat_kmdxhgxi54
                    section.data(347).logicalSrcIdx = 346;
                    section.data(347).dtTransOffset = 752;

                    ;% rtP.Saturation_LowerSat_emwy1bpgop
                    section.data(348).logicalSrcIdx = 347;
                    section.data(348).dtTransOffset = 753;

                    ;% rtP.Integrator2_IC_b0ll4d3vcw
                    section.data(349).logicalSrcIdx = 348;
                    section.data(349).dtTransOffset = 754;

                    ;% rtP.Integrator2_AbsoluteTolerance_jpry0t4pb0
                    section.data(350).logicalSrcIdx = 349;
                    section.data(350).dtTransOffset = 755;

                    ;% rtP.Memory_InitialCondition
                    section.data(351).logicalSrcIdx = 350;
                    section.data(351).dtTransOffset = 756;

                    ;% rtP.Integrator_IC_l55lj3ait5
                    section.data(352).logicalSrcIdx = 351;
                    section.data(352).dtTransOffset = 758;

                    ;% rtP.Integrator_AbsoluteTolerance_fp10kdx3ts
                    section.data(353).logicalSrcIdx = 352;
                    section.data(353).dtTransOffset = 759;

                    ;% rtP.Saturation_UpperSat_ifai5qs0ii
                    section.data(354).logicalSrcIdx = 353;
                    section.data(354).dtTransOffset = 760;

                    ;% rtP.Saturation_LowerSat_mlu5gk3ggw
                    section.data(355).logicalSrcIdx = 354;
                    section.data(355).dtTransOffset = 761;

                    ;% rtP.Saturation_UpperSat_neu311z5mm
                    section.data(356).logicalSrcIdx = 355;
                    section.data(356).dtTransOffset = 762;

                    ;% rtP.Saturation_LowerSat_hjvqbqjafe
                    section.data(357).logicalSrcIdx = 356;
                    section.data(357).dtTransOffset = 763;

                    ;% rtP.Saturation_UpperSat_mslagysw1h
                    section.data(358).logicalSrcIdx = 357;
                    section.data(358).dtTransOffset = 764;

                    ;% rtP.Saturation_LowerSat_btyvgbsiqq
                    section.data(359).logicalSrcIdx = 358;
                    section.data(359).dtTransOffset = 765;

                    ;% rtP.DisallowNegativeBrakeTorque_UpperSat
                    section.data(360).logicalSrcIdx = 359;
                    section.data(360).dtTransOffset = 766;

                    ;% rtP.DisallowNegativeBrakeTorque_LowerSat
                    section.data(361).logicalSrcIdx = 360;
                    section.data(361).dtTransOffset = 767;

                    ;% rtP.Gain_Gain
                    section.data(362).logicalSrcIdx = 361;
                    section.data(362).dtTransOffset = 768;

                    ;% rtP.Saturation1_UpperSat
                    section.data(363).logicalSrcIdx = 362;
                    section.data(363).dtTransOffset = 769;

                    ;% rtP.Saturation1_LowerSat
                    section.data(364).logicalSrcIdx = 363;
                    section.data(364).dtTransOffset = 770;

                    ;% rtP.Saturation_UpperSat_iu12m5pvqn
                    section.data(365).logicalSrcIdx = 364;
                    section.data(365).dtTransOffset = 771;

                    ;% rtP.Saturation_LowerSat_n2mhmgk14l
                    section.data(366).logicalSrcIdx = 365;
                    section.data(366).dtTransOffset = 772;

                    ;% rtP.Saturation1_UpperSat_nca1zpqikx
                    section.data(367).logicalSrcIdx = 366;
                    section.data(367).dtTransOffset = 773;

                    ;% rtP.Saturation1_LowerSat_av0hu4nwnp
                    section.data(368).logicalSrcIdx = 367;
                    section.data(368).dtTransOffset = 774;

                    ;% rtP.Saturation_UpperSat_addj3whuzg
                    section.data(369).logicalSrcIdx = 368;
                    section.data(369).dtTransOffset = 775;

                    ;% rtP.Saturation_LowerSat_lejok2hlrr
                    section.data(370).logicalSrcIdx = 369;
                    section.data(370).dtTransOffset = 776;

                    ;% rtP.Saturation1_UpperSat_ewjkrotpz3
                    section.data(371).logicalSrcIdx = 370;
                    section.data(371).dtTransOffset = 777;

                    ;% rtP.Saturation1_LowerSat_gu1hx53qlc
                    section.data(372).logicalSrcIdx = 371;
                    section.data(372).dtTransOffset = 778;

                    ;% rtP.Saturation_UpperSat_akdusr1nca
                    section.data(373).logicalSrcIdx = 372;
                    section.data(373).dtTransOffset = 779;

                    ;% rtP.Saturation_LowerSat_mhlm1x4kgd
                    section.data(374).logicalSrcIdx = 373;
                    section.data(374).dtTransOffset = 780;

                    ;% rtP.Integrator_IC_lba0v231io
                    section.data(375).logicalSrcIdx = 374;
                    section.data(375).dtTransOffset = 781;

                    ;% rtP.Integrator_AbsoluteTolerance_meusfs1eni
                    section.data(376).logicalSrcIdx = 375;
                    section.data(376).dtTransOffset = 782;

                    ;% rtP.Saturation1_UpperSat_pr0qfpxda4
                    section.data(377).logicalSrcIdx = 376;
                    section.data(377).dtTransOffset = 783;

                    ;% rtP.Saturation1_LowerSat_o5kkqlla1u
                    section.data(378).logicalSrcIdx = 377;
                    section.data(378).dtTransOffset = 784;

                    ;% rtP.Saturation_UpperSat_l412u2t0sf
                    section.data(379).logicalSrcIdx = 378;
                    section.data(379).dtTransOffset = 785;

                    ;% rtP.Saturation_LowerSat_kfxufjmols
                    section.data(380).logicalSrcIdx = 379;
                    section.data(380).dtTransOffset = 786;

                    ;% rtP.Switch_Threshold_iwmujfpe4s
                    section.data(381).logicalSrcIdx = 380;
                    section.data(381).dtTransOffset = 787;

                    ;% rtP.Integrator_IC_h2tsckar0l
                    section.data(382).logicalSrcIdx = 381;
                    section.data(382).dtTransOffset = 788;

                    ;% rtP.Constant_Value_f5sizwfggl
                    section.data(383).logicalSrcIdx = 382;
                    section.data(383).dtTransOffset = 789;

                    ;% rtP.Constant_Value_oqyl4nphju
                    section.data(384).logicalSrcIdx = 383;
                    section.data(384).dtTransOffset = 801;

                    ;% rtP.MotorTorque_Value
                    section.data(385).logicalSrcIdx = 384;
                    section.data(385).dtTransOffset = 804;

                    ;% rtP.Zero_Value
                    section.data(386).logicalSrcIdx = 385;
                    section.data(386).dtTransOffset = 805;

                    ;% rtP.One_Value
                    section.data(387).logicalSrcIdx = 386;
                    section.data(387).dtTransOffset = 806;

                    ;% rtP.Constant_Value_c54rembgih
                    section.data(388).logicalSrcIdx = 387;
                    section.data(388).dtTransOffset = 807;

                    ;% rtP.Gain1_Gain
                    section.data(389).logicalSrcIdx = 388;
                    section.data(389).dtTransOffset = 808;

                    ;% rtP.steerOut_Value
                    section.data(390).logicalSrcIdx = 389;
                    section.data(390).dtTransOffset = 809;

                    ;% rtP.Switch3_Threshold
                    section.data(391).logicalSrcIdx = 390;
                    section.data(391).dtTransOffset = 810;

                    ;% rtP.steerOut_Value_dsforhi52t
                    section.data(392).logicalSrcIdx = 391;
                    section.data(392).dtTransOffset = 811;

                    ;% rtP.Constant_Value_azwfc1rw55
                    section.data(393).logicalSrcIdx = 392;
                    section.data(393).dtTransOffset = 812;

                    ;% rtP.Constant_Value_lqe2vx0uu0
                    section.data(394).logicalSrcIdx = 393;
                    section.data(394).dtTransOffset = 813;

                    ;% rtP.Zero_Value_nvufxvzwje
                    section.data(395).logicalSrcIdx = 394;
                    section.data(395).dtTransOffset = 814;

                    ;% rtP.theta_Value
                    section.data(396).logicalSrcIdx = 395;
                    section.data(396).dtTransOffset = 815;

                    ;% rtP.phi_Value
                    section.data(397).logicalSrcIdx = 396;
                    section.data(397).dtTransOffset = 816;

                    ;% rtP.index_Value
                    section.data(398).logicalSrcIdx = 397;
                    section.data(398).dtTransOffset = 817;

                    ;% rtP.Zero_Value_pejk1vy3ts
                    section.data(399).logicalSrcIdx = 398;
                    section.data(399).dtTransOffset = 818;

                    ;% rtP.Gain_Gain_avfcthoedx
                    section.data(400).logicalSrcIdx = 399;
                    section.data(400).dtTransOffset = 819;

                    ;% rtP.Gain1_Gain_brgbyay1mx
                    section.data(401).logicalSrcIdx = 400;
                    section.data(401).dtTransOffset = 820;

                    ;% rtP.Gain1_Gain_b44cjdquhs
                    section.data(402).logicalSrcIdx = 401;
                    section.data(402).dtTransOffset = 821;

                    ;% rtP.Zero_Value_bweh1erc23
                    section.data(403).logicalSrcIdx = 402;
                    section.data(403).dtTransOffset = 822;

                    ;% rtP.ones2_Value
                    section.data(404).logicalSrcIdx = 403;
                    section.data(404).dtTransOffset = 826;

                    ;% rtP.u_Value
                    section.data(405).logicalSrcIdx = 404;
                    section.data(405).dtTransOffset = 830;

                    ;% rtP.ones_Value
                    section.data(406).logicalSrcIdx = 405;
                    section.data(406).dtTransOffset = 834;

                    ;% rtP.vertType_Value
                    section.data(407).logicalSrcIdx = 406;
                    section.data(407).dtTransOffset = 926;

                    ;% rtP.Constant_Value_p33r4txk3q
                    section.data(408).logicalSrcIdx = 407;
                    section.data(408).dtTransOffset = 927;

                    ;% rtP.Constant1_Value
                    section.data(409).logicalSrcIdx = 408;
                    section.data(409).dtTransOffset = 928;

                    ;% rtP.TorqueConversion1_Gain
                    section.data(410).logicalSrcIdx = 409;
                    section.data(410).dtTransOffset = 929;

                    ;% rtP.TireRadius_Value
                    section.data(411).logicalSrcIdx = 410;
                    section.data(411).dtTransOffset = 930;

                    ;% rtP.Constant4_Value
                    section.data(412).logicalSrcIdx = 411;
                    section.data(412).dtTransOffset = 934;

                    ;% rtP.Constant1_Value_asxmciwgbn
                    section.data(413).logicalSrcIdx = 412;
                    section.data(413).dtTransOffset = 937;

                    ;% rtP.u_Value_fblrgwg5ds
                    section.data(414).logicalSrcIdx = 413;
                    section.data(414).dtTransOffset = 946;

            nTotData = nTotData + section.nData;
            paramMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtP.One1_Value
                    section.data(1).logicalSrcIdx = 414;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(2) = section;
            clear section

            section.nData     = 40;
            section.data(40)  = dumData; %prealloc

                    ;% rtP.gkgoch4i20.SelectCamberHeightSlope_AxleNums
                    section.data(1).logicalSrcIdx = 415;
                    section.data(1).dtTransOffset = 0;

                    ;% rtP.gkgoch4i20.SelectCamberSteeringCenter_AxleNums
                    section.data(2).logicalSrcIdx = 416;
                    section.data(2).dtTransOffset = 2;

                    ;% rtP.gkgoch4i20.SelectCamberSteeringSlope_AxleNums
                    section.data(3).logicalSrcIdx = 417;
                    section.data(3).dtTransOffset = 4;

                    ;% rtP.gkgoch4i20.SelectCasterHeightSlope_AxleNums
                    section.data(4).logicalSrcIdx = 418;
                    section.data(4).dtTransOffset = 5;

                    ;% rtP.gkgoch4i20.SelectCasterSteeringCenter_AxleNums
                    section.data(5).logicalSrcIdx = 419;
                    section.data(5).dtTransOffset = 7;

                    ;% rtP.gkgoch4i20.SelectCasterSteeringSlope_AxleNums
                    section.data(6).logicalSrcIdx = 420;
                    section.data(6).dtTransOffset = 9;

                    ;% rtP.gkgoch4i20.SelectRollSteerSlope_AxleNums
                    section.data(7).logicalSrcIdx = 421;
                    section.data(7).dtTransOffset = 10;

                    ;% rtP.gkgoch4i20.SelectToeSteeringCenter_AxleNums
                    section.data(8).logicalSrcIdx = 422;
                    section.data(8).dtTransOffset = 12;

                    ;% rtP.gkgoch4i20.SelectToeSteeringSlope_AxleNums
                    section.data(9).logicalSrcIdx = 423;
                    section.data(9).dtTransOffset = 14;

                    ;% rtP.gkgoch4i20.Constrainedspringdampercombination_AxleNums
                    section.data(10).logicalSrcIdx = 424;
                    section.data(10).dtTransOffset = 15;

                    ;% rtP.gkgoch4i20.SteeringHeightSlopeBySteeredAxle_AxleNums
                    section.data(11).logicalSrcIdx = 425;
                    section.data(11).dtTransOffset = 17;

                    ;% rtP.gkgoch4i20.Gain5_Gain
                    section.data(12).logicalSrcIdx = 426;
                    section.data(12).dtTransOffset = 18;

                    ;% rtP.gkgoch4i20.Gain4_Gain
                    section.data(13).logicalSrcIdx = 427;
                    section.data(13).dtTransOffset = 19;

                    ;% rtP.gkgoch4i20.Saturation_UpperSat
                    section.data(14).logicalSrcIdx = 428;
                    section.data(14).dtTransOffset = 20;

                    ;% rtP.gkgoch4i20.Saturation_LowerSat
                    section.data(15).logicalSrcIdx = 429;
                    section.data(15).dtTransOffset = 21;

                    ;% rtP.gkgoch4i20.Gain_Gain
                    section.data(16).logicalSrcIdx = 430;
                    section.data(16).dtTransOffset = 22;

                    ;% rtP.gkgoch4i20.LowerHardStopBlendMult_tableData
                    section.data(17).logicalSrcIdx = 431;
                    section.data(17).dtTransOffset = 23;

                    ;% rtP.gkgoch4i20.LowerHardStopBlendMult_bp01Data
                    section.data(18).logicalSrcIdx = 432;
                    section.data(18).dtTransOffset = 26;

                    ;% rtP.gkgoch4i20.Constant_Value
                    section.data(19).logicalSrcIdx = 433;
                    section.data(19).dtTransOffset = 29;

                    ;% rtP.gkgoch4i20.Gain5_Gain_jkxoakmxpu
                    section.data(20).logicalSrcIdx = 434;
                    section.data(20).dtTransOffset = 30;

                    ;% rtP.gkgoch4i20.Gain4_Gain_irkyjhh3iw
                    section.data(21).logicalSrcIdx = 435;
                    section.data(21).dtTransOffset = 31;

                    ;% rtP.gkgoch4i20.Saturation_UpperSat_n4aw3icftg
                    section.data(22).logicalSrcIdx = 436;
                    section.data(22).dtTransOffset = 32;

                    ;% rtP.gkgoch4i20.Saturation_LowerSat_k0nt0to2jq
                    section.data(23).logicalSrcIdx = 437;
                    section.data(23).dtTransOffset = 33;

                    ;% rtP.gkgoch4i20.Gain_Gain_hiz1i5vapd
                    section.data(24).logicalSrcIdx = 438;
                    section.data(24).dtTransOffset = 34;

                    ;% rtP.gkgoch4i20.UpperHardStopBlendMult_tableData
                    section.data(25).logicalSrcIdx = 439;
                    section.data(25).dtTransOffset = 35;

                    ;% rtP.gkgoch4i20.UpperHardStopBlendMult_bp01Data
                    section.data(26).logicalSrcIdx = 440;
                    section.data(26).dtTransOffset = 38;

                    ;% rtP.gkgoch4i20.Constant_Value_cxh1c5u1d3
                    section.data(27).logicalSrcIdx = 441;
                    section.data(27).dtTransOffset = 41;

                    ;% rtP.gkgoch4i20.HeightSignConvention_Gain
                    section.data(28).logicalSrcIdx = 442;
                    section.data(28).dtTransOffset = 42;

                    ;% rtP.gkgoch4i20.Gain_Gain_jvgldouiuy
                    section.data(29).logicalSrcIdx = 443;
                    section.data(29).dtTransOffset = 43;

                    ;% rtP.gkgoch4i20.Gain_Gain_ccuizykiq5
                    section.data(30).logicalSrcIdx = 444;
                    section.data(30).dtTransOffset = 44;

                    ;% rtP.gkgoch4i20.VehicleForceSign_Gain
                    section.data(31).logicalSrcIdx = 445;
                    section.data(31).dtTransOffset = 45;

                    ;% rtP.gkgoch4i20.Signconvention_Gain
                    section.data(32).logicalSrcIdx = 446;
                    section.data(32).dtTransOffset = 46;

                    ;% rtP.gkgoch4i20.Constant_Value_jm5jx31jcv
                    section.data(33).logicalSrcIdx = 447;
                    section.data(33).dtTransOffset = 47;

                    ;% rtP.gkgoch4i20.VehicleVehicleWheelOffset1_Value
                    section.data(34).logicalSrcIdx = 448;
                    section.data(34).dtTransOffset = 48;

                    ;% rtP.gkgoch4i20.Constant_Value_iptongm5vx
                    section.data(35).logicalSrcIdx = 449;
                    section.data(35).dtTransOffset = 50;

                    ;% rtP.gkgoch4i20.VehicleVehicleWheelOffset3_Value
                    section.data(36).logicalSrcIdx = 450;
                    section.data(36).dtTransOffset = 51;

                    ;% rtP.gkgoch4i20.Constant_Value_j3m5zpkqvc
                    section.data(37).logicalSrcIdx = 451;
                    section.data(37).dtTransOffset = 53;

                    ;% rtP.gkgoch4i20.VehicleVehicleWheelOffset3_Value_i0vcxju0dq
                    section.data(38).logicalSrcIdx = 452;
                    section.data(38).dtTransOffset = 54;

                    ;% rtP.gkgoch4i20.Constant_Value_p5zpth4tum
                    section.data(39).logicalSrcIdx = 453;
                    section.data(39).dtTransOffset = 56;

                    ;% rtP.gkgoch4i20.VehicleVehicleWheelOffset3_Value_i1utw51xb4
                    section.data(40).logicalSrcIdx = 454;
                    section.data(40).dtTransOffset = 57;

            nTotData = nTotData + section.nData;
            paramMap.sections(3) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtP.fujf10vfd2.Clutch_OmegaTol
                    section.data(1).logicalSrcIdx = 455;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(4) = section;
            clear section

            section.nData     = 5;
            section.data(5)  = dumData; %prealloc

                    ;% rtP.fujf10vfd2.lgqwjimiob.Constant_Value
                    section.data(1).logicalSrcIdx = 456;
                    section.data(1).dtTransOffset = 0;

                    ;% rtP.fujf10vfd2.lgqwjimiob.Constant_Value_p0urwfcsp0
                    section.data(2).logicalSrcIdx = 457;
                    section.data(2).dtTransOffset = 1;

                    ;% rtP.fujf10vfd2.lgqwjimiob.Constant1_Value
                    section.data(3).logicalSrcIdx = 458;
                    section.data(3).dtTransOffset = 2;

                    ;% rtP.fujf10vfd2.lgqwjimiob.Constant2_Value
                    section.data(4).logicalSrcIdx = 459;
                    section.data(4).dtTransOffset = 3;

                    ;% rtP.fujf10vfd2.lgqwjimiob.u_Gain
                    section.data(5).logicalSrcIdx = 460;
                    section.data(5).dtTransOffset = 4;

            nTotData = nTotData + section.nData;
            paramMap.sections(5) = section;
            clear section

            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% rtP.fujf10vfd2.lgqwjimiob.yn_Y0
                    section.data(1).logicalSrcIdx = 461;
                    section.data(1).dtTransOffset = 0;

                    ;% rtP.fujf10vfd2.lgqwjimiob.yn_Y0_avhfjm4x2r
                    section.data(2).logicalSrcIdx = 462;
                    section.data(2).dtTransOffset = 1;

                    ;% rtP.fujf10vfd2.lgqwjimiob.UnitDelay_InitialCondition
                    section.data(3).logicalSrcIdx = 463;
                    section.data(3).dtTransOffset = 2;

                    ;% rtP.fujf10vfd2.lgqwjimiob.CombinatorialLogic_table
                    section.data(4).logicalSrcIdx = 464;
                    section.data(4).dtTransOffset = 3;

            nTotData = nTotData + section.nData;
            paramMap.sections(6) = section;
            clear section


            ;%
            ;% Non-auto Data (parameter)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        paramMap.nTotData = nTotData;



    ;%**************************
    ;% Create Block Output Map *
    ;%**************************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 8;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc sigMap
        ;%
        sigMap.nSections           = nTotSects;
        sigMap.sectIdxOffset       = sectIdxOffset;
            sigMap.sections(nTotSects) = dumSection; %prealloc
        sigMap.nTotData            = -1;

        ;%
        ;% Auto data (rtB)
        ;%
            section.nData     = 299;
            section.data(299)  = dumData; %prealloc

                    ;% rtB.pvjhi3gso2
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% rtB.eonpu2pzrq
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 3;

                    ;% rtB.e5yawxd1j2
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 6;

                    ;% rtB.hfxjvwh0u5
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 9;

                    ;% rtB.k3f1nmgjls
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 12;

                    ;% rtB.mapyulasb3
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 16;

                    ;% rtB.inu4wg3gkf
                    section.data(7).logicalSrcIdx = 6;
                    section.data(7).dtTransOffset = 19;

                    ;% rtB.cl2x5nwgfv
                    section.data(8).logicalSrcIdx = 7;
                    section.data(8).dtTransOffset = 20;

                    ;% rtB.hqwenfc21o
                    section.data(9).logicalSrcIdx = 8;
                    section.data(9).dtTransOffset = 21;

                    ;% rtB.m3vmvpj3ot
                    section.data(10).logicalSrcIdx = 9;
                    section.data(10).dtTransOffset = 22;

                    ;% rtB.br3uuhw3mi
                    section.data(11).logicalSrcIdx = 10;
                    section.data(11).dtTransOffset = 23;

                    ;% rtB.ifko42xofi
                    section.data(12).logicalSrcIdx = 11;
                    section.data(12).dtTransOffset = 24;

                    ;% rtB.ghrwv4d402
                    section.data(13).logicalSrcIdx = 12;
                    section.data(13).dtTransOffset = 25;

                    ;% rtB.bpl3444wrc
                    section.data(14).logicalSrcIdx = 13;
                    section.data(14).dtTransOffset = 28;

                    ;% rtB.okxkyrq2js
                    section.data(15).logicalSrcIdx = 14;
                    section.data(15).dtTransOffset = 31;

                    ;% rtB.gt22hfzcl1
                    section.data(16).logicalSrcIdx = 15;
                    section.data(16).dtTransOffset = 34;

                    ;% rtB.enut0kaogg
                    section.data(17).logicalSrcIdx = 16;
                    section.data(17).dtTransOffset = 35;

                    ;% rtB.d2ujoty01h
                    section.data(18).logicalSrcIdx = 17;
                    section.data(18).dtTransOffset = 36;

                    ;% rtB.cbrd20uurz
                    section.data(19).logicalSrcIdx = 18;
                    section.data(19).dtTransOffset = 37;

                    ;% rtB.er4vlcpwbi
                    section.data(20).logicalSrcIdx = 19;
                    section.data(20).dtTransOffset = 38;

                    ;% rtB.bgi052y3br
                    section.data(21).logicalSrcIdx = 20;
                    section.data(21).dtTransOffset = 39;

                    ;% rtB.hvp1gradwz
                    section.data(22).logicalSrcIdx = 21;
                    section.data(22).dtTransOffset = 40;

                    ;% rtB.nvjb1zyeot
                    section.data(23).logicalSrcIdx = 22;
                    section.data(23).dtTransOffset = 43;

                    ;% rtB.g1t0guecqc
                    section.data(24).logicalSrcIdx = 23;
                    section.data(24).dtTransOffset = 46;

                    ;% rtB.eqvjmsguid
                    section.data(25).logicalSrcIdx = 24;
                    section.data(25).dtTransOffset = 47;

                    ;% rtB.o32plelcvd
                    section.data(26).logicalSrcIdx = 25;
                    section.data(26).dtTransOffset = 48;

                    ;% rtB.enypiuwsb2
                    section.data(27).logicalSrcIdx = 26;
                    section.data(27).dtTransOffset = 49;

                    ;% rtB.nbktpp0lvg
                    section.data(28).logicalSrcIdx = 27;
                    section.data(28).dtTransOffset = 50;

                    ;% rtB.hinsfhp2dr
                    section.data(29).logicalSrcIdx = 28;
                    section.data(29).dtTransOffset = 51;

                    ;% rtB.k4weon4f5m
                    section.data(30).logicalSrcIdx = 29;
                    section.data(30).dtTransOffset = 52;

                    ;% rtB.mw2nodpda2
                    section.data(31).logicalSrcIdx = 30;
                    section.data(31).dtTransOffset = 55;

                    ;% rtB.o3e0i34poo
                    section.data(32).logicalSrcIdx = 31;
                    section.data(32).dtTransOffset = 58;

                    ;% rtB.ousopy1tw2
                    section.data(33).logicalSrcIdx = 32;
                    section.data(33).dtTransOffset = 59;

                    ;% rtB.hexx0034mu
                    section.data(34).logicalSrcIdx = 33;
                    section.data(34).dtTransOffset = 60;

                    ;% rtB.kfme0qbiru
                    section.data(35).logicalSrcIdx = 34;
                    section.data(35).dtTransOffset = 61;

                    ;% rtB.md5cgoknb4
                    section.data(36).logicalSrcIdx = 35;
                    section.data(36).dtTransOffset = 62;

                    ;% rtB.eqvtpko42o
                    section.data(37).logicalSrcIdx = 36;
                    section.data(37).dtTransOffset = 63;

                    ;% rtB.jf0zpbcmly
                    section.data(38).logicalSrcIdx = 37;
                    section.data(38).dtTransOffset = 64;

                    ;% rtB.bmmfunwslz
                    section.data(39).logicalSrcIdx = 38;
                    section.data(39).dtTransOffset = 67;

                    ;% rtB.myorl52jnj
                    section.data(40).logicalSrcIdx = 39;
                    section.data(40).dtTransOffset = 70;

                    ;% rtB.nth32z51hj
                    section.data(41).logicalSrcIdx = 40;
                    section.data(41).dtTransOffset = 74;

                    ;% rtB.cfvprygh5m
                    section.data(42).logicalSrcIdx = 41;
                    section.data(42).dtTransOffset = 82;

                    ;% rtB.myxoa4skdj
                    section.data(43).logicalSrcIdx = 42;
                    section.data(43).dtTransOffset = 83;

                    ;% rtB.nt2ryilz5c
                    section.data(44).logicalSrcIdx = 43;
                    section.data(44).dtTransOffset = 84;

                    ;% rtB.hbj0g2qx41
                    section.data(45).logicalSrcIdx = 44;
                    section.data(45).dtTransOffset = 85;

                    ;% rtB.gqo2weaylc
                    section.data(46).logicalSrcIdx = 45;
                    section.data(46).dtTransOffset = 86;

                    ;% rtB.efr5csvtgc
                    section.data(47).logicalSrcIdx = 46;
                    section.data(47).dtTransOffset = 87;

                    ;% rtB.hvemaufdzy
                    section.data(48).logicalSrcIdx = 47;
                    section.data(48).dtTransOffset = 88;

                    ;% rtB.oyeefute3n
                    section.data(49).logicalSrcIdx = 48;
                    section.data(49).dtTransOffset = 89;

                    ;% rtB.k030h031nf
                    section.data(50).logicalSrcIdx = 49;
                    section.data(50).dtTransOffset = 90;

                    ;% rtB.nvbpb0fbqt
                    section.data(51).logicalSrcIdx = 50;
                    section.data(51).dtTransOffset = 91;

                    ;% rtB.iisxvwtmm2
                    section.data(52).logicalSrcIdx = 51;
                    section.data(52).dtTransOffset = 92;

                    ;% rtB.bqidvpwhxi
                    section.data(53).logicalSrcIdx = 52;
                    section.data(53).dtTransOffset = 93;

                    ;% rtB.axsxbymdx3
                    section.data(54).logicalSrcIdx = 53;
                    section.data(54).dtTransOffset = 94;

                    ;% rtB.fvowvm54bi
                    section.data(55).logicalSrcIdx = 54;
                    section.data(55).dtTransOffset = 95;

                    ;% rtB.lzqcktyc0f
                    section.data(56).logicalSrcIdx = 55;
                    section.data(56).dtTransOffset = 96;

                    ;% rtB.ddateqty1m
                    section.data(57).logicalSrcIdx = 56;
                    section.data(57).dtTransOffset = 97;

                    ;% rtB.e0msuhqurx
                    section.data(58).logicalSrcIdx = 57;
                    section.data(58).dtTransOffset = 98;

                    ;% rtB.extij4nz5j
                    section.data(59).logicalSrcIdx = 58;
                    section.data(59).dtTransOffset = 100;

                    ;% rtB.oz0mcdshb0
                    section.data(60).logicalSrcIdx = 59;
                    section.data(60).dtTransOffset = 101;

                    ;% rtB.pqjxrmmbat
                    section.data(61).logicalSrcIdx = 60;
                    section.data(61).dtTransOffset = 102;

                    ;% rtB.cris3zhr4s
                    section.data(62).logicalSrcIdx = 61;
                    section.data(62).dtTransOffset = 103;

                    ;% rtB.m3hstgkwc5
                    section.data(63).logicalSrcIdx = 62;
                    section.data(63).dtTransOffset = 105;

                    ;% rtB.oba0asmstv
                    section.data(64).logicalSrcIdx = 63;
                    section.data(64).dtTransOffset = 106;

                    ;% rtB.pd5ztsknbz
                    section.data(65).logicalSrcIdx = 64;
                    section.data(65).dtTransOffset = 107;

                    ;% rtB.b1iayfkcgr
                    section.data(66).logicalSrcIdx = 65;
                    section.data(66).dtTransOffset = 111;

                    ;% rtB.h5gyggntv0
                    section.data(67).logicalSrcIdx = 66;
                    section.data(67).dtTransOffset = 115;

                    ;% rtB.g0qyryf22t
                    section.data(68).logicalSrcIdx = 67;
                    section.data(68).dtTransOffset = 119;

                    ;% rtB.ewcbi1oba5
                    section.data(69).logicalSrcIdx = 68;
                    section.data(69).dtTransOffset = 123;

                    ;% rtB.ldkm0ugudz
                    section.data(70).logicalSrcIdx = 69;
                    section.data(70).dtTransOffset = 127;

                    ;% rtB.ozdtzbgkdf
                    section.data(71).logicalSrcIdx = 70;
                    section.data(71).dtTransOffset = 130;

                    ;% rtB.ceczdiyylj
                    section.data(72).logicalSrcIdx = 71;
                    section.data(72).dtTransOffset = 133;

                    ;% rtB.ecf2qd5ow1
                    section.data(73).logicalSrcIdx = 72;
                    section.data(73).dtTransOffset = 142;

                    ;% rtB.p0b3gh0cse
                    section.data(74).logicalSrcIdx = 73;
                    section.data(74).dtTransOffset = 145;

                    ;% rtB.oia1zvoodo
                    section.data(75).logicalSrcIdx = 74;
                    section.data(75).dtTransOffset = 148;

                    ;% rtB.oappmecbv2
                    section.data(76).logicalSrcIdx = 75;
                    section.data(76).dtTransOffset = 151;

                    ;% rtB.eu2t41mxrx
                    section.data(77).logicalSrcIdx = 76;
                    section.data(77).dtTransOffset = 154;

                    ;% rtB.prefah5pzr
                    section.data(78).logicalSrcIdx = 77;
                    section.data(78).dtTransOffset = 157;

                    ;% rtB.efk4s0oolc
                    section.data(79).logicalSrcIdx = 78;
                    section.data(79).dtTransOffset = 160;

                    ;% rtB.ftvqe0uh13
                    section.data(80).logicalSrcIdx = 79;
                    section.data(80).dtTransOffset = 163;

                    ;% rtB.idbx2v5ps4
                    section.data(81).logicalSrcIdx = 80;
                    section.data(81).dtTransOffset = 164;

                    ;% rtB.al0pbuhcyj
                    section.data(82).logicalSrcIdx = 81;
                    section.data(82).dtTransOffset = 165;

                    ;% rtB.d1dcbrujn4
                    section.data(83).logicalSrcIdx = 82;
                    section.data(83).dtTransOffset = 171;

                    ;% rtB.gzifpcqg5d
                    section.data(84).logicalSrcIdx = 83;
                    section.data(84).dtTransOffset = 177;

                    ;% rtB.pd1oti1plh
                    section.data(85).logicalSrcIdx = 84;
                    section.data(85).dtTransOffset = 183;

                    ;% rtB.nqiffs1hlu
                    section.data(86).logicalSrcIdx = 85;
                    section.data(86).dtTransOffset = 186;

                    ;% rtB.bqubxxxv14
                    section.data(87).logicalSrcIdx = 86;
                    section.data(87).dtTransOffset = 194;

                    ;% rtB.bnwfgokmmt
                    section.data(88).logicalSrcIdx = 87;
                    section.data(88).dtTransOffset = 206;

                    ;% rtB.n0r4vtjekz
                    section.data(89).logicalSrcIdx = 88;
                    section.data(89).dtTransOffset = 210;

                    ;% rtB.plzzxupveq
                    section.data(90).logicalSrcIdx = 89;
                    section.data(90).dtTransOffset = 214;

                    ;% rtB.el52g0n13h
                    section.data(91).logicalSrcIdx = 90;
                    section.data(91).dtTransOffset = 218;

                    ;% rtB.c15chslzvc
                    section.data(92).logicalSrcIdx = 91;
                    section.data(92).dtTransOffset = 221;

                    ;% rtB.dlgwil20qx
                    section.data(93).logicalSrcIdx = 92;
                    section.data(93).dtTransOffset = 224;

                    ;% rtB.g5yrwwvkv1
                    section.data(94).logicalSrcIdx = 93;
                    section.data(94).dtTransOffset = 227;

                    ;% rtB.gv4ljvygnc
                    section.data(95).logicalSrcIdx = 94;
                    section.data(95).dtTransOffset = 230;

                    ;% rtB.jfpjqjbnfk
                    section.data(96).logicalSrcIdx = 95;
                    section.data(96).dtTransOffset = 233;

                    ;% rtB.aldrwqfxb5
                    section.data(97).logicalSrcIdx = 96;
                    section.data(97).dtTransOffset = 234;

                    ;% rtB.kvvvha14yc
                    section.data(98).logicalSrcIdx = 97;
                    section.data(98).dtTransOffset = 235;

                    ;% rtB.ngtjbxcnqu
                    section.data(99).logicalSrcIdx = 98;
                    section.data(99).dtTransOffset = 236;

                    ;% rtB.ay0ay2voln
                    section.data(100).logicalSrcIdx = 99;
                    section.data(100).dtTransOffset = 237;

                    ;% rtB.ensg1nkiqt
                    section.data(101).logicalSrcIdx = 100;
                    section.data(101).dtTransOffset = 238;

                    ;% rtB.dtpwdh1voh
                    section.data(102).logicalSrcIdx = 101;
                    section.data(102).dtTransOffset = 239;

                    ;% rtB.c5pc1vmllo
                    section.data(103).logicalSrcIdx = 102;
                    section.data(103).dtTransOffset = 242;

                    ;% rtB.i0vpl0gksi
                    section.data(104).logicalSrcIdx = 103;
                    section.data(104).dtTransOffset = 245;

                    ;% rtB.mmtmwbyyhg
                    section.data(105).logicalSrcIdx = 104;
                    section.data(105).dtTransOffset = 248;

                    ;% rtB.kp1v5n4k2y
                    section.data(106).logicalSrcIdx = 105;
                    section.data(106).dtTransOffset = 251;

                    ;% rtB.mjbl2dr5ua
                    section.data(107).logicalSrcIdx = 106;
                    section.data(107).dtTransOffset = 260;

                    ;% rtB.kd5rxz3n4m
                    section.data(108).logicalSrcIdx = 107;
                    section.data(108).dtTransOffset = 263;

                    ;% rtB.mimfibnxwe
                    section.data(109).logicalSrcIdx = 108;
                    section.data(109).dtTransOffset = 264;

                    ;% rtB.p2gyzduiig
                    section.data(110).logicalSrcIdx = 109;
                    section.data(110).dtTransOffset = 265;

                    ;% rtB.k4p4h5u04r
                    section.data(111).logicalSrcIdx = 110;
                    section.data(111).dtTransOffset = 266;

                    ;% rtB.ipemmxxmhr
                    section.data(112).logicalSrcIdx = 111;
                    section.data(112).dtTransOffset = 267;

                    ;% rtB.jxhhmegcan
                    section.data(113).logicalSrcIdx = 112;
                    section.data(113).dtTransOffset = 268;

                    ;% rtB.k0ebpoiqkg
                    section.data(114).logicalSrcIdx = 113;
                    section.data(114).dtTransOffset = 269;

                    ;% rtB.fl40zleksa
                    section.data(115).logicalSrcIdx = 114;
                    section.data(115).dtTransOffset = 270;

                    ;% rtB.al152hkt20
                    section.data(116).logicalSrcIdx = 115;
                    section.data(116).dtTransOffset = 271;

                    ;% rtB.oexjeoh0kn
                    section.data(117).logicalSrcIdx = 116;
                    section.data(117).dtTransOffset = 272;

                    ;% rtB.pkre1q5ccp
                    section.data(118).logicalSrcIdx = 117;
                    section.data(118).dtTransOffset = 274;

                    ;% rtB.lve105k41a
                    section.data(119).logicalSrcIdx = 118;
                    section.data(119).dtTransOffset = 276;

                    ;% rtB.o3jujmlget
                    section.data(120).logicalSrcIdx = 119;
                    section.data(120).dtTransOffset = 277;

                    ;% rtB.kgjdjym33q
                    section.data(121).logicalSrcIdx = 120;
                    section.data(121).dtTransOffset = 278;

                    ;% rtB.cdgznlmrzw
                    section.data(122).logicalSrcIdx = 121;
                    section.data(122).dtTransOffset = 279;

                    ;% rtB.o3ekgqmtty
                    section.data(123).logicalSrcIdx = 122;
                    section.data(123).dtTransOffset = 280;

                    ;% rtB.fhxl0z4jn0
                    section.data(124).logicalSrcIdx = 123;
                    section.data(124).dtTransOffset = 281;

                    ;% rtB.doaf1eebn2
                    section.data(125).logicalSrcIdx = 124;
                    section.data(125).dtTransOffset = 282;

                    ;% rtB.bweity5rg3
                    section.data(126).logicalSrcIdx = 125;
                    section.data(126).dtTransOffset = 283;

                    ;% rtB.f5m0tkgk4u
                    section.data(127).logicalSrcIdx = 126;
                    section.data(127).dtTransOffset = 284;

                    ;% rtB.o4ll2g351p
                    section.data(128).logicalSrcIdx = 127;
                    section.data(128).dtTransOffset = 285;

                    ;% rtB.grbc2stsl0
                    section.data(129).logicalSrcIdx = 128;
                    section.data(129).dtTransOffset = 286;

                    ;% rtB.glqtquwrw3
                    section.data(130).logicalSrcIdx = 129;
                    section.data(130).dtTransOffset = 287;

                    ;% rtB.e5m4rkfscq
                    section.data(131).logicalSrcIdx = 130;
                    section.data(131).dtTransOffset = 288;

                    ;% rtB.pwcwi0alqf
                    section.data(132).logicalSrcIdx = 131;
                    section.data(132).dtTransOffset = 289;

                    ;% rtB.l3vdrko1xz
                    section.data(133).logicalSrcIdx = 132;
                    section.data(133).dtTransOffset = 290;

                    ;% rtB.ovbsf0smul
                    section.data(134).logicalSrcIdx = 133;
                    section.data(134).dtTransOffset = 291;

                    ;% rtB.mbwe5nwyiz
                    section.data(135).logicalSrcIdx = 134;
                    section.data(135).dtTransOffset = 292;

                    ;% rtB.bguvxvujpl
                    section.data(136).logicalSrcIdx = 135;
                    section.data(136).dtTransOffset = 293;

                    ;% rtB.kx5mq1a1ng
                    section.data(137).logicalSrcIdx = 136;
                    section.data(137).dtTransOffset = 294;

                    ;% rtB.aaq3hskxlr
                    section.data(138).logicalSrcIdx = 137;
                    section.data(138).dtTransOffset = 296;

                    ;% rtB.o4ytosv2yj
                    section.data(139).logicalSrcIdx = 138;
                    section.data(139).dtTransOffset = 300;

                    ;% rtB.kbkrhbh10c
                    section.data(140).logicalSrcIdx = 139;
                    section.data(140).dtTransOffset = 304;

                    ;% rtB.iusccz1j4q
                    section.data(141).logicalSrcIdx = 140;
                    section.data(141).dtTransOffset = 308;

                    ;% rtB.egjymoiv5o
                    section.data(142).logicalSrcIdx = 141;
                    section.data(142).dtTransOffset = 312;

                    ;% rtB.garjoqrobb
                    section.data(143).logicalSrcIdx = 142;
                    section.data(143).dtTransOffset = 316;

                    ;% rtB.j4i2i1skgv
                    section.data(144).logicalSrcIdx = 143;
                    section.data(144).dtTransOffset = 320;

                    ;% rtB.pzkudpj4th
                    section.data(145).logicalSrcIdx = 144;
                    section.data(145).dtTransOffset = 324;

                    ;% rtB.mkmnzijy1o
                    section.data(146).logicalSrcIdx = 145;
                    section.data(146).dtTransOffset = 328;

                    ;% rtB.i3mwv3ggy2
                    section.data(147).logicalSrcIdx = 146;
                    section.data(147).dtTransOffset = 332;

                    ;% rtB.cj4lu3qex5
                    section.data(148).logicalSrcIdx = 147;
                    section.data(148).dtTransOffset = 336;

                    ;% rtB.jvrjdv0gt2
                    section.data(149).logicalSrcIdx = 148;
                    section.data(149).dtTransOffset = 340;

                    ;% rtB.dp2x55ypuh
                    section.data(150).logicalSrcIdx = 149;
                    section.data(150).dtTransOffset = 344;

                    ;% rtB.ev2nfkeyjo
                    section.data(151).logicalSrcIdx = 150;
                    section.data(151).dtTransOffset = 348;

                    ;% rtB.an2kcxrem4
                    section.data(152).logicalSrcIdx = 151;
                    section.data(152).dtTransOffset = 352;

                    ;% rtB.k4jplumuyp
                    section.data(153).logicalSrcIdx = 152;
                    section.data(153).dtTransOffset = 356;

                    ;% rtB.dlh1z2zci5
                    section.data(154).logicalSrcIdx = 153;
                    section.data(154).dtTransOffset = 360;

                    ;% rtB.hnkpbw0wov
                    section.data(155).logicalSrcIdx = 154;
                    section.data(155).dtTransOffset = 364;

                    ;% rtB.f1qb1hnz3i
                    section.data(156).logicalSrcIdx = 155;
                    section.data(156).dtTransOffset = 368;

                    ;% rtB.hz54hbyemh
                    section.data(157).logicalSrcIdx = 156;
                    section.data(157).dtTransOffset = 372;

                    ;% rtB.l1evogaaxo
                    section.data(158).logicalSrcIdx = 157;
                    section.data(158).dtTransOffset = 384;

                    ;% rtB.agt5xhqmf3
                    section.data(159).logicalSrcIdx = 158;
                    section.data(159).dtTransOffset = 388;

                    ;% rtB.b3ad5onoa2
                    section.data(160).logicalSrcIdx = 159;
                    section.data(160).dtTransOffset = 392;

                    ;% rtB.f4vukswwlg
                    section.data(161).logicalSrcIdx = 160;
                    section.data(161).dtTransOffset = 396;

                    ;% rtB.bpprb5ntmd
                    section.data(162).logicalSrcIdx = 161;
                    section.data(162).dtTransOffset = 400;

                    ;% rtB.aisb5lyqpj
                    section.data(163).logicalSrcIdx = 162;
                    section.data(163).dtTransOffset = 404;

                    ;% rtB.bnbg2hntde
                    section.data(164).logicalSrcIdx = 163;
                    section.data(164).dtTransOffset = 408;

                    ;% rtB.p1bqupwwiw
                    section.data(165).logicalSrcIdx = 164;
                    section.data(165).dtTransOffset = 412;

                    ;% rtB.k4slvi523r
                    section.data(166).logicalSrcIdx = 165;
                    section.data(166).dtTransOffset = 416;

                    ;% rtB.esa1rq1xoq
                    section.data(167).logicalSrcIdx = 166;
                    section.data(167).dtTransOffset = 420;

                    ;% rtB.flkpa5hjuv
                    section.data(168).logicalSrcIdx = 167;
                    section.data(168).dtTransOffset = 424;

                    ;% rtB.ljyorje2ji
                    section.data(169).logicalSrcIdx = 168;
                    section.data(169).dtTransOffset = 428;

                    ;% rtB.bc5sajmswo
                    section.data(170).logicalSrcIdx = 169;
                    section.data(170).dtTransOffset = 432;

                    ;% rtB.cnug3c1shv
                    section.data(171).logicalSrcIdx = 170;
                    section.data(171).dtTransOffset = 436;

                    ;% rtB.jru5adg1p2
                    section.data(172).logicalSrcIdx = 171;
                    section.data(172).dtTransOffset = 440;

                    ;% rtB.gdk10y22mg
                    section.data(173).logicalSrcIdx = 172;
                    section.data(173).dtTransOffset = 444;

                    ;% rtB.f0mlqnkazj
                    section.data(174).logicalSrcIdx = 173;
                    section.data(174).dtTransOffset = 448;

                    ;% rtB.c50lgcraik
                    section.data(175).logicalSrcIdx = 174;
                    section.data(175).dtTransOffset = 452;

                    ;% rtB.c4ul0d30bq
                    section.data(176).logicalSrcIdx = 175;
                    section.data(176).dtTransOffset = 456;

                    ;% rtB.esxbjo5rfs
                    section.data(177).logicalSrcIdx = 176;
                    section.data(177).dtTransOffset = 460;

                    ;% rtB.jei4iuevnd
                    section.data(178).logicalSrcIdx = 177;
                    section.data(178).dtTransOffset = 464;

                    ;% rtB.ht2jvdobfx
                    section.data(179).logicalSrcIdx = 178;
                    section.data(179).dtTransOffset = 468;

                    ;% rtB.pnqzy35tae
                    section.data(180).logicalSrcIdx = 179;
                    section.data(180).dtTransOffset = 472;

                    ;% rtB.dxmdwb0cac
                    section.data(181).logicalSrcIdx = 180;
                    section.data(181).dtTransOffset = 476;

                    ;% rtB.ff3mliat0s
                    section.data(182).logicalSrcIdx = 181;
                    section.data(182).dtTransOffset = 480;

                    ;% rtB.fx5ty00crh
                    section.data(183).logicalSrcIdx = 182;
                    section.data(183).dtTransOffset = 484;

                    ;% rtB.burfuqcff1
                    section.data(184).logicalSrcIdx = 183;
                    section.data(184).dtTransOffset = 488;

                    ;% rtB.obnarmvehq
                    section.data(185).logicalSrcIdx = 184;
                    section.data(185).dtTransOffset = 492;

                    ;% rtB.iql32m0ypo
                    section.data(186).logicalSrcIdx = 185;
                    section.data(186).dtTransOffset = 496;

                    ;% rtB.hv122mnogo
                    section.data(187).logicalSrcIdx = 186;
                    section.data(187).dtTransOffset = 500;

                    ;% rtB.dgmzmjtoih
                    section.data(188).logicalSrcIdx = 187;
                    section.data(188).dtTransOffset = 504;

                    ;% rtB.ipnesjdtwm
                    section.data(189).logicalSrcIdx = 188;
                    section.data(189).dtTransOffset = 508;

                    ;% rtB.fvxvkgre4w
                    section.data(190).logicalSrcIdx = 189;
                    section.data(190).dtTransOffset = 512;

                    ;% rtB.l4nqaq2c1p
                    section.data(191).logicalSrcIdx = 190;
                    section.data(191).dtTransOffset = 516;

                    ;% rtB.kxch15zhkk
                    section.data(192).logicalSrcIdx = 191;
                    section.data(192).dtTransOffset = 520;

                    ;% rtB.oz2d10hqkl
                    section.data(193).logicalSrcIdx = 192;
                    section.data(193).dtTransOffset = 524;

                    ;% rtB.otjy4we14b
                    section.data(194).logicalSrcIdx = 193;
                    section.data(194).dtTransOffset = 528;

                    ;% rtB.lgubl0fdy2
                    section.data(195).logicalSrcIdx = 194;
                    section.data(195).dtTransOffset = 532;

                    ;% rtB.m1qjkcw32m
                    section.data(196).logicalSrcIdx = 195;
                    section.data(196).dtTransOffset = 536;

                    ;% rtB.ecy2pr0mzx
                    section.data(197).logicalSrcIdx = 196;
                    section.data(197).dtTransOffset = 540;

                    ;% rtB.hkypdod5l3
                    section.data(198).logicalSrcIdx = 197;
                    section.data(198).dtTransOffset = 544;

                    ;% rtB.mkpc0lab23
                    section.data(199).logicalSrcIdx = 198;
                    section.data(199).dtTransOffset = 548;

                    ;% rtB.arwssyvqck
                    section.data(200).logicalSrcIdx = 199;
                    section.data(200).dtTransOffset = 552;

                    ;% rtB.i0u010obrq
                    section.data(201).logicalSrcIdx = 200;
                    section.data(201).dtTransOffset = 555;

                    ;% rtB.fpymxddbs2
                    section.data(202).logicalSrcIdx = 201;
                    section.data(202).dtTransOffset = 564;

                    ;% rtB.musliantq1
                    section.data(203).logicalSrcIdx = 202;
                    section.data(203).dtTransOffset = 567;

                    ;% rtB.lbewm2jsx1
                    section.data(204).logicalSrcIdx = 203;
                    section.data(204).dtTransOffset = 568;

                    ;% rtB.l2s0tqh3te
                    section.data(205).logicalSrcIdx = 204;
                    section.data(205).dtTransOffset = 569;

                    ;% rtB.iriit3n5bo
                    section.data(206).logicalSrcIdx = 205;
                    section.data(206).dtTransOffset = 570;

                    ;% rtB.cd2hroncxm
                    section.data(207).logicalSrcIdx = 206;
                    section.data(207).dtTransOffset = 571;

                    ;% rtB.jzuucjp0dz
                    section.data(208).logicalSrcIdx = 207;
                    section.data(208).dtTransOffset = 572;

                    ;% rtB.mungqcmpvi
                    section.data(209).logicalSrcIdx = 208;
                    section.data(209).dtTransOffset = 573;

                    ;% rtB.df3a24nxgi
                    section.data(210).logicalSrcIdx = 209;
                    section.data(210).dtTransOffset = 576;

                    ;% rtB.gm1wafv4ux
                    section.data(211).logicalSrcIdx = 210;
                    section.data(211).dtTransOffset = 585;

                    ;% rtB.avxpohsdpu
                    section.data(212).logicalSrcIdx = 211;
                    section.data(212).dtTransOffset = 588;

                    ;% rtB.cpjz3g40yo
                    section.data(213).logicalSrcIdx = 212;
                    section.data(213).dtTransOffset = 592;

                    ;% rtB.lumd2qzswa
                    section.data(214).logicalSrcIdx = 213;
                    section.data(214).dtTransOffset = 593;

                    ;% rtB.dti3f2mbo5
                    section.data(215).logicalSrcIdx = 214;
                    section.data(215).dtTransOffset = 597;

                    ;% rtB.ofoyzad0qy
                    section.data(216).logicalSrcIdx = 215;
                    section.data(216).dtTransOffset = 598;

                    ;% rtB.lpuzvoki4l
                    section.data(217).logicalSrcIdx = 216;
                    section.data(217).dtTransOffset = 599;

                    ;% rtB.lwmye31lm3
                    section.data(218).logicalSrcIdx = 217;
                    section.data(218).dtTransOffset = 600;

                    ;% rtB.kfnovxlgtm
                    section.data(219).logicalSrcIdx = 218;
                    section.data(219).dtTransOffset = 601;

                    ;% rtB.elx424ncss
                    section.data(220).logicalSrcIdx = 219;
                    section.data(220).dtTransOffset = 602;

                    ;% rtB.ndzkyesiln
                    section.data(221).logicalSrcIdx = 220;
                    section.data(221).dtTransOffset = 603;

                    ;% rtB.g3f35gdt3z
                    section.data(222).logicalSrcIdx = 221;
                    section.data(222).dtTransOffset = 604;

                    ;% rtB.k53ri4b13w
                    section.data(223).logicalSrcIdx = 222;
                    section.data(223).dtTransOffset = 608;

                    ;% rtB.krdblgex4s
                    section.data(224).logicalSrcIdx = 223;
                    section.data(224).dtTransOffset = 609;

                    ;% rtB.kvdpteykgw
                    section.data(225).logicalSrcIdx = 224;
                    section.data(225).dtTransOffset = 610;

                    ;% rtB.jdgn4cp0cr
                    section.data(226).logicalSrcIdx = 225;
                    section.data(226).dtTransOffset = 611;

                    ;% rtB.mzz0ezlzdx
                    section.data(227).logicalSrcIdx = 226;
                    section.data(227).dtTransOffset = 612;

                    ;% rtB.dxsdjkqicv
                    section.data(228).logicalSrcIdx = 227;
                    section.data(228).dtTransOffset = 613;

                    ;% rtB.nitv3ooaid
                    section.data(229).logicalSrcIdx = 228;
                    section.data(229).dtTransOffset = 614;

                    ;% rtB.p2gpdkhmex
                    section.data(230).logicalSrcIdx = 229;
                    section.data(230).dtTransOffset = 615;

                    ;% rtB.omist3fzp5
                    section.data(231).logicalSrcIdx = 230;
                    section.data(231).dtTransOffset = 619;

                    ;% rtB.c0u4csx3fv
                    section.data(232).logicalSrcIdx = 231;
                    section.data(232).dtTransOffset = 620;

                    ;% rtB.f2msdtbamo
                    section.data(233).logicalSrcIdx = 232;
                    section.data(233).dtTransOffset = 621;

                    ;% rtB.hvwbnq1lmh
                    section.data(234).logicalSrcIdx = 233;
                    section.data(234).dtTransOffset = 624;

                    ;% rtB.egcghkzrir
                    section.data(235).logicalSrcIdx = 234;
                    section.data(235).dtTransOffset = 628;

                    ;% rtB.mzkwwpss3u
                    section.data(236).logicalSrcIdx = 235;
                    section.data(236).dtTransOffset = 632;

                    ;% rtB.bzgmcfjntk
                    section.data(237).logicalSrcIdx = 236;
                    section.data(237).dtTransOffset = 636;

                    ;% rtB.a4e2na1xrj
                    section.data(238).logicalSrcIdx = 237;
                    section.data(238).dtTransOffset = 639;

                    ;% rtB.bfswimvzqn
                    section.data(239).logicalSrcIdx = 238;
                    section.data(239).dtTransOffset = 642;

                    ;% rtB.lpl4gfsgpc
                    section.data(240).logicalSrcIdx = 239;
                    section.data(240).dtTransOffset = 645;

                    ;% rtB.l5cmmu0mfq
                    section.data(241).logicalSrcIdx = 240;
                    section.data(241).dtTransOffset = 648;

                    ;% rtB.jsfwkegsvm
                    section.data(242).logicalSrcIdx = 241;
                    section.data(242).dtTransOffset = 657;

                    ;% rtB.miox5ugopx
                    section.data(243).logicalSrcIdx = 242;
                    section.data(243).dtTransOffset = 660;

                    ;% rtB.fxn4hwoc2i
                    section.data(244).logicalSrcIdx = 243;
                    section.data(244).dtTransOffset = 668;

                    ;% rtB.h0nyvmdejr
                    section.data(245).logicalSrcIdx = 244;
                    section.data(245).dtTransOffset = 669;

                    ;% rtB.jtmoolkjyi
                    section.data(246).logicalSrcIdx = 245;
                    section.data(246).dtTransOffset = 670;

                    ;% rtB.c1qcc3keu0
                    section.data(247).logicalSrcIdx = 246;
                    section.data(247).dtTransOffset = 672;

                    ;% rtB.ew0tdzejaw
                    section.data(248).logicalSrcIdx = 247;
                    section.data(248).dtTransOffset = 673;

                    ;% rtB.jgrlwz0emm
                    section.data(249).logicalSrcIdx = 248;
                    section.data(249).dtTransOffset = 674;

                    ;% rtB.mianffndr0
                    section.data(250).logicalSrcIdx = 249;
                    section.data(250).dtTransOffset = 675;

                    ;% rtB.bsfchtjtbj
                    section.data(251).logicalSrcIdx = 250;
                    section.data(251).dtTransOffset = 676;

                    ;% rtB.hd50erlqk4
                    section.data(252).logicalSrcIdx = 251;
                    section.data(252).dtTransOffset = 677;

                    ;% rtB.lwsi3mbjjr
                    section.data(253).logicalSrcIdx = 252;
                    section.data(253).dtTransOffset = 678;

                    ;% rtB.ffzywqhgth
                    section.data(254).logicalSrcIdx = 253;
                    section.data(254).dtTransOffset = 680;

                    ;% rtB.ixahpfbqkq
                    section.data(255).logicalSrcIdx = 254;
                    section.data(255).dtTransOffset = 684;

                    ;% rtB.mbcdjmj54o
                    section.data(256).logicalSrcIdx = 255;
                    section.data(256).dtTransOffset = 688;

                    ;% rtB.mljhld5dxz
                    section.data(257).logicalSrcIdx = 256;
                    section.data(257).dtTransOffset = 692;

                    ;% rtB.ooa4chzyum
                    section.data(258).logicalSrcIdx = 257;
                    section.data(258).dtTransOffset = 800;

                    ;% rtB.n2cddoxzwg
                    section.data(259).logicalSrcIdx = 258;
                    section.data(259).dtTransOffset = 801;

                    ;% rtB.gj5z2iross
                    section.data(260).logicalSrcIdx = 259;
                    section.data(260).dtTransOffset = 805;

                    ;% rtB.em5brxpqgm
                    section.data(261).logicalSrcIdx = 260;
                    section.data(261).dtTransOffset = 813;

                    ;% rtB.f1cnc05vms
                    section.data(262).logicalSrcIdx = 261;
                    section.data(262).dtTransOffset = 816;

                    ;% rtB.htaqt01foc
                    section.data(263).logicalSrcIdx = 262;
                    section.data(263).dtTransOffset = 819;

                    ;% rtB.c3nepxie4q
                    section.data(264).logicalSrcIdx = 265;
                    section.data(264).dtTransOffset = 823;

                    ;% rtB.ktlnuv14xq
                    section.data(265).logicalSrcIdx = 266;
                    section.data(265).dtTransOffset = 824;

                    ;% rtB.gb53a3kvqb
                    section.data(266).logicalSrcIdx = 267;
                    section.data(266).dtTransOffset = 833;

                    ;% rtB.f1m4urt4hd
                    section.data(267).logicalSrcIdx = 268;
                    section.data(267).dtTransOffset = 836;

                    ;% rtB.baxaby202f
                    section.data(268).logicalSrcIdx = 269;
                    section.data(268).dtTransOffset = 839;

                    ;% rtB.b1vgcfjvga
                    section.data(269).logicalSrcIdx = 270;
                    section.data(269).dtTransOffset = 843;

                    ;% rtB.ntmx4shpi3
                    section.data(270).logicalSrcIdx = 271;
                    section.data(270).dtTransOffset = 855;

                    ;% rtB.lwvhqqex0u
                    section.data(271).logicalSrcIdx = 272;
                    section.data(271).dtTransOffset = 859;

                    ;% rtB.nsdx0z0fdx
                    section.data(272).logicalSrcIdx = 273;
                    section.data(272).dtTransOffset = 871;

                    ;% rtB.m5m2qoc5iw
                    section.data(273).logicalSrcIdx = 274;
                    section.data(273).dtTransOffset = 874;

                    ;% rtB.hqueo1nq2e
                    section.data(274).logicalSrcIdx = 275;
                    section.data(274).dtTransOffset = 878;

                    ;% rtB.hnkqyjlwrd
                    section.data(275).logicalSrcIdx = 276;
                    section.data(275).dtTransOffset = 879;

                    ;% rtB.cmzqeqee30
                    section.data(276).logicalSrcIdx = 277;
                    section.data(276).dtTransOffset = 911;

                    ;% rtB.g0hhdb2fh5
                    section.data(277).logicalSrcIdx = 280;
                    section.data(277).dtTransOffset = 915;

                    ;% rtB.kochremxdv
                    section.data(278).logicalSrcIdx = 289;
                    section.data(278).dtTransOffset = 919;

                    ;% rtB.le0gl2m1lj
                    section.data(279).logicalSrcIdx = 292;
                    section.data(279).dtTransOffset = 923;

                    ;% rtB.ffigzhjzcw
                    section.data(280).logicalSrcIdx = 294;
                    section.data(280).dtTransOffset = 927;

                    ;% rtB.nun3vg2blr
                    section.data(281).logicalSrcIdx = 295;
                    section.data(281).dtTransOffset = 928;

                    ;% rtB.bk252kmhzu
                    section.data(282).logicalSrcIdx = 296;
                    section.data(282).dtTransOffset = 929;

                    ;% rtB.fvugwfgfc0
                    section.data(283).logicalSrcIdx = 297;
                    section.data(283).dtTransOffset = 930;

                    ;% rtB.pnqaqfhm5j
                    section.data(284).logicalSrcIdx = 298;
                    section.data(284).dtTransOffset = 931;

                    ;% rtB.cdvhvjbi3x
                    section.data(285).logicalSrcIdx = 299;
                    section.data(285).dtTransOffset = 932;

                    ;% rtB.moac0guhpm
                    section.data(286).logicalSrcIdx = 301;
                    section.data(286).dtTransOffset = 936;

                    ;% rtB.fuk2whiqqw
                    section.data(287).logicalSrcIdx = 302;
                    section.data(287).dtTransOffset = 937;

                    ;% rtB.adfxhy5k0u
                    section.data(288).logicalSrcIdx = 303;
                    section.data(288).dtTransOffset = 938;

                    ;% rtB.bj34u5bdc4
                    section.data(289).logicalSrcIdx = 304;
                    section.data(289).dtTransOffset = 939;

                    ;% rtB.kh1ejfn54y
                    section.data(290).logicalSrcIdx = 305;
                    section.data(290).dtTransOffset = 940;

                    ;% rtB.mztqppqqmq
                    section.data(291).logicalSrcIdx = 306;
                    section.data(291).dtTransOffset = 941;

                    ;% rtB.elhlhe03kq
                    section.data(292).logicalSrcIdx = 307;
                    section.data(292).dtTransOffset = 942;

                    ;% rtB.bswnq24mn4
                    section.data(293).logicalSrcIdx = 308;
                    section.data(293).dtTransOffset = 943;

                    ;% rtB.dq4rsrfstk
                    section.data(294).logicalSrcIdx = 309;
                    section.data(294).dtTransOffset = 944;

                    ;% rtB.hbrpbs4330
                    section.data(295).logicalSrcIdx = 310;
                    section.data(295).dtTransOffset = 945;

                    ;% rtB.aw5bam55tj
                    section.data(296).logicalSrcIdx = 311;
                    section.data(296).dtTransOffset = 946;

                    ;% rtB.jna2ldaqwh
                    section.data(297).logicalSrcIdx = 312;
                    section.data(297).dtTransOffset = 962;

                    ;% rtB.bui5cajeyn
                    section.data(298).logicalSrcIdx = 313;
                    section.data(298).dtTransOffset = 966;

                    ;% rtB.boo33qsxey
                    section.data(299).logicalSrcIdx = 314;
                    section.data(299).dtTransOffset = 967;

            nTotData = nTotData + section.nData;
            sigMap.sections(1) = section;
            clear section

            section.nData     = 7;
            section.data(7)  = dumData; %prealloc

                    ;% rtB.axu4jgrmk2
                    section.data(1).logicalSrcIdx = 315;
                    section.data(1).dtTransOffset = 0;

                    ;% rtB.k0ra04c3s3
                    section.data(2).logicalSrcIdx = 316;
                    section.data(2).dtTransOffset = 2;

                    ;% rtB.eyosgetzu1
                    section.data(3).logicalSrcIdx = 317;
                    section.data(3).dtTransOffset = 3;

                    ;% rtB.faz1qe4gr4
                    section.data(4).logicalSrcIdx = 318;
                    section.data(4).dtTransOffset = 4;

                    ;% rtB.al2rogaqs5
                    section.data(5).logicalSrcIdx = 319;
                    section.data(5).dtTransOffset = 5;

                    ;% rtB.hufn0fr353
                    section.data(6).logicalSrcIdx = 320;
                    section.data(6).dtTransOffset = 6;

                    ;% rtB.cvyj00103j
                    section.data(7).logicalSrcIdx = 321;
                    section.data(7).dtTransOffset = 7;

            nTotData = nTotData + section.nData;
            sigMap.sections(2) = section;
            clear section

            section.nData     = 85;
            section.data(85)  = dumData; %prealloc

                    ;% rtB.gkgoch4i20[3].ega11xpxic
                    section.data(1).logicalSrcIdx = 322;
                    section.data(1).dtTransOffset = 0;

                    ;% rtB.gkgoch4i20[3].mt3lyv2dke
                    section.data(2).logicalSrcIdx = 323;
                    section.data(2).dtTransOffset = 3;

                    ;% rtB.gkgoch4i20[3].o2nd42dcbc
                    section.data(3).logicalSrcIdx = 324;
                    section.data(3).dtTransOffset = 4;

                    ;% rtB.gkgoch4i20[3].dzppqsc04g
                    section.data(4).logicalSrcIdx = 325;
                    section.data(4).dtTransOffset = 5;

                    ;% rtB.gkgoch4i20[3].hd0m1sty4c
                    section.data(5).logicalSrcIdx = 326;
                    section.data(5).dtTransOffset = 6;

                    ;% rtB.gkgoch4i20[3].lypsywwdql
                    section.data(6).logicalSrcIdx = 327;
                    section.data(6).dtTransOffset = 7;

                    ;% rtB.gkgoch4i20[3].ediqg42n3j
                    section.data(7).logicalSrcIdx = 328;
                    section.data(7).dtTransOffset = 8;

                    ;% rtB.gkgoch4i20[3].eoaosvy4po
                    section.data(8).logicalSrcIdx = 329;
                    section.data(8).dtTransOffset = 9;

                    ;% rtB.gkgoch4i20[3].e0vh3agpk2
                    section.data(9).logicalSrcIdx = 330;
                    section.data(9).dtTransOffset = 10;

                    ;% rtB.gkgoch4i20[3].ljultwvx3r
                    section.data(10).logicalSrcIdx = 331;
                    section.data(10).dtTransOffset = 11;

                    ;% rtB.gkgoch4i20[3].l05zepmggl
                    section.data(11).logicalSrcIdx = 332;
                    section.data(11).dtTransOffset = 12;

                    ;% rtB.gkgoch4i20[3].b34erucq15
                    section.data(12).logicalSrcIdx = 333;
                    section.data(12).dtTransOffset = 13;

                    ;% rtB.gkgoch4i20[3].amugc0ynbk
                    section.data(13).logicalSrcIdx = 334;
                    section.data(13).dtTransOffset = 14;

                    ;% rtB.gkgoch4i20[3].pxwixouqhe
                    section.data(14).logicalSrcIdx = 335;
                    section.data(14).dtTransOffset = 16;

                    ;% rtB.gkgoch4i20[3].l1otoog3jz
                    section.data(15).logicalSrcIdx = 336;
                    section.data(15).dtTransOffset = 18;

                    ;% rtB.gkgoch4i20[3].h04burdemz
                    section.data(16).logicalSrcIdx = 337;
                    section.data(16).dtTransOffset = 19;

                    ;% rtB.gkgoch4i20[3].gs2lwb03pq
                    section.data(17).logicalSrcIdx = 338;
                    section.data(17).dtTransOffset = 20;

                    ;% rtB.gkgoch4i20[3].ndkwerwcuj
                    section.data(18).logicalSrcIdx = 339;
                    section.data(18).dtTransOffset = 21;

                    ;% rtB.gkgoch4i20[3].c3n5ntdbcb
                    section.data(19).logicalSrcIdx = 340;
                    section.data(19).dtTransOffset = 22;

                    ;% rtB.gkgoch4i20[3].ngsnipojdi
                    section.data(20).logicalSrcIdx = 341;
                    section.data(20).dtTransOffset = 23;

                    ;% rtB.gkgoch4i20[3].g50nquwiuh
                    section.data(21).logicalSrcIdx = 342;
                    section.data(21).dtTransOffset = 24;

                    ;% rtB.gkgoch4i20[3].ezfviqmxce
                    section.data(22).logicalSrcIdx = 343;
                    section.data(22).dtTransOffset = 25;

                    ;% rtB.gkgoch4i20[3].bkwxlw0wjw
                    section.data(23).logicalSrcIdx = 344;
                    section.data(23).dtTransOffset = 26;

                    ;% rtB.gkgoch4i20[3].fpv1uaqdmk
                    section.data(24).logicalSrcIdx = 345;
                    section.data(24).dtTransOffset = 27;

                    ;% rtB.gkgoch4i20[3].bptxnepez0
                    section.data(25).logicalSrcIdx = 346;
                    section.data(25).dtTransOffset = 28;

                    ;% rtB.gkgoch4i20[3].li0vjxh4lt
                    section.data(26).logicalSrcIdx = 347;
                    section.data(26).dtTransOffset = 29;

                    ;% rtB.gkgoch4i20[3].l5pvziepx3
                    section.data(27).logicalSrcIdx = 348;
                    section.data(27).dtTransOffset = 30;

                    ;% rtB.gkgoch4i20[3].lvbwp21bcl
                    section.data(28).logicalSrcIdx = 349;
                    section.data(28).dtTransOffset = 31;

                    ;% rtB.gkgoch4i20[3].p42i4dgtis
                    section.data(29).logicalSrcIdx = 350;
                    section.data(29).dtTransOffset = 32;

                    ;% rtB.gkgoch4i20[3].hglyt0kpm2
                    section.data(30).logicalSrcIdx = 351;
                    section.data(30).dtTransOffset = 33;

                    ;% rtB.gkgoch4i20[3].kbyhnksaml
                    section.data(31).logicalSrcIdx = 352;
                    section.data(31).dtTransOffset = 34;

                    ;% rtB.gkgoch4i20[3].khqmsyhcdb
                    section.data(32).logicalSrcIdx = 353;
                    section.data(32).dtTransOffset = 35;

                    ;% rtB.gkgoch4i20[3].nfeq1dd5lz
                    section.data(33).logicalSrcIdx = 354;
                    section.data(33).dtTransOffset = 36;

                    ;% rtB.gkgoch4i20[3].hvk5imnlsc
                    section.data(34).logicalSrcIdx = 355;
                    section.data(34).dtTransOffset = 37;

                    ;% rtB.gkgoch4i20[3].oeqm2oypnl
                    section.data(35).logicalSrcIdx = 356;
                    section.data(35).dtTransOffset = 38;

                    ;% rtB.gkgoch4i20[3].ok14bc0gqv
                    section.data(36).logicalSrcIdx = 357;
                    section.data(36).dtTransOffset = 39;

                    ;% rtB.gkgoch4i20[3].fpf1wo4mtw
                    section.data(37).logicalSrcIdx = 358;
                    section.data(37).dtTransOffset = 40;

                    ;% rtB.gkgoch4i20[3].ir1zlpliou
                    section.data(38).logicalSrcIdx = 359;
                    section.data(38).dtTransOffset = 41;

                    ;% rtB.gkgoch4i20[3].jggj5dry5y
                    section.data(39).logicalSrcIdx = 360;
                    section.data(39).dtTransOffset = 42;

                    ;% rtB.gkgoch4i20[3].dsw2veynvo
                    section.data(40).logicalSrcIdx = 361;
                    section.data(40).dtTransOffset = 43;

                    ;% rtB.gkgoch4i20[3].amhcdzxxks
                    section.data(41).logicalSrcIdx = 362;
                    section.data(41).dtTransOffset = 44;

                    ;% rtB.gkgoch4i20[3].jweaxsqco2
                    section.data(42).logicalSrcIdx = 363;
                    section.data(42).dtTransOffset = 45;

                    ;% rtB.gkgoch4i20[3].bnyapv3vad
                    section.data(43).logicalSrcIdx = 364;
                    section.data(43).dtTransOffset = 46;

                    ;% rtB.gkgoch4i20[3].ahf14xi1fk
                    section.data(44).logicalSrcIdx = 365;
                    section.data(44).dtTransOffset = 47;

                    ;% rtB.gkgoch4i20[3].mmcf12ll20
                    section.data(45).logicalSrcIdx = 366;
                    section.data(45).dtTransOffset = 48;

                    ;% rtB.gkgoch4i20[3].p4bu3dj1sr
                    section.data(46).logicalSrcIdx = 367;
                    section.data(46).dtTransOffset = 49;

                    ;% rtB.gkgoch4i20[3].cijrn5hbnv
                    section.data(47).logicalSrcIdx = 368;
                    section.data(47).dtTransOffset = 50;

                    ;% rtB.gkgoch4i20[3].h4wiazhtvz
                    section.data(48).logicalSrcIdx = 369;
                    section.data(48).dtTransOffset = 51;

                    ;% rtB.gkgoch4i20[3].pzel3x00n1
                    section.data(49).logicalSrcIdx = 370;
                    section.data(49).dtTransOffset = 52;

                    ;% rtB.gkgoch4i20[3].c1wn45myag
                    section.data(50).logicalSrcIdx = 371;
                    section.data(50).dtTransOffset = 60;

                    ;% rtB.gkgoch4i20[3].lfexvogcny
                    section.data(51).logicalSrcIdx = 372;
                    section.data(51).dtTransOffset = 61;

                    ;% rtB.gkgoch4i20[3].fwjapkcrgo
                    section.data(52).logicalSrcIdx = 373;
                    section.data(52).dtTransOffset = 62;

                    ;% rtB.gkgoch4i20[3].axzhla2nkv
                    section.data(53).logicalSrcIdx = 374;
                    section.data(53).dtTransOffset = 63;

                    ;% rtB.gkgoch4i20[3].jovls20zhs
                    section.data(54).logicalSrcIdx = 375;
                    section.data(54).dtTransOffset = 64;

                    ;% rtB.gkgoch4i20[3].a2bxxl4hbb
                    section.data(55).logicalSrcIdx = 376;
                    section.data(55).dtTransOffset = 65;

                    ;% rtB.gkgoch4i20[3].jjloyle3hk
                    section.data(56).logicalSrcIdx = 377;
                    section.data(56).dtTransOffset = 66;

                    ;% rtB.gkgoch4i20[3].c0xhavjdt2
                    section.data(57).logicalSrcIdx = 378;
                    section.data(57).dtTransOffset = 67;

                    ;% rtB.gkgoch4i20[3].mgiumib5h4
                    section.data(58).logicalSrcIdx = 379;
                    section.data(58).dtTransOffset = 68;

                    ;% rtB.gkgoch4i20[3].adchq4mqkt
                    section.data(59).logicalSrcIdx = 380;
                    section.data(59).dtTransOffset = 69;

                    ;% rtB.gkgoch4i20[3].em0jfsw10j
                    section.data(60).logicalSrcIdx = 381;
                    section.data(60).dtTransOffset = 70;

                    ;% rtB.gkgoch4i20[3].fafkwxl1sr
                    section.data(61).logicalSrcIdx = 382;
                    section.data(61).dtTransOffset = 71;

                    ;% rtB.gkgoch4i20[3].l21ame21te
                    section.data(62).logicalSrcIdx = 383;
                    section.data(62).dtTransOffset = 72;

                    ;% rtB.gkgoch4i20[3].pjoud41a1f
                    section.data(63).logicalSrcIdx = 384;
                    section.data(63).dtTransOffset = 73;

                    ;% rtB.gkgoch4i20[3].myypyvd2il
                    section.data(64).logicalSrcIdx = 385;
                    section.data(64).dtTransOffset = 74;

                    ;% rtB.gkgoch4i20[3].fjn0tkmr5w
                    section.data(65).logicalSrcIdx = 386;
                    section.data(65).dtTransOffset = 75;

                    ;% rtB.gkgoch4i20[3].cdvcps5b3u
                    section.data(66).logicalSrcIdx = 387;
                    section.data(66).dtTransOffset = 76;

                    ;% rtB.gkgoch4i20[3].nvuznpptst
                    section.data(67).logicalSrcIdx = 388;
                    section.data(67).dtTransOffset = 77;

                    ;% rtB.gkgoch4i20[3].i0fmnfhozl
                    section.data(68).logicalSrcIdx = 389;
                    section.data(68).dtTransOffset = 78;

                    ;% rtB.gkgoch4i20[3].oedunmj2xq
                    section.data(69).logicalSrcIdx = 390;
                    section.data(69).dtTransOffset = 79;

                    ;% rtB.gkgoch4i20[3].ahashvzyly
                    section.data(70).logicalSrcIdx = 391;
                    section.data(70).dtTransOffset = 80;

                    ;% rtB.gkgoch4i20[3].odazlr1up0
                    section.data(71).logicalSrcIdx = 392;
                    section.data(71).dtTransOffset = 81;

                    ;% rtB.gkgoch4i20[3].ph4mpojtp3
                    section.data(72).logicalSrcIdx = 393;
                    section.data(72).dtTransOffset = 82;

                    ;% rtB.gkgoch4i20[3].cdekyl1gvq
                    section.data(73).logicalSrcIdx = 394;
                    section.data(73).dtTransOffset = 83;

                    ;% rtB.gkgoch4i20[3].hivo2zq5zu
                    section.data(74).logicalSrcIdx = 395;
                    section.data(74).dtTransOffset = 84;

                    ;% rtB.gkgoch4i20[3].p5mm1rqiht
                    section.data(75).logicalSrcIdx = 396;
                    section.data(75).dtTransOffset = 85;

                    ;% rtB.gkgoch4i20[3].c1prvgd2my
                    section.data(76).logicalSrcIdx = 397;
                    section.data(76).dtTransOffset = 86;

                    ;% rtB.gkgoch4i20[3].anzqdc4l14
                    section.data(77).logicalSrcIdx = 398;
                    section.data(77).dtTransOffset = 87;

                    ;% rtB.gkgoch4i20[3].huxjbcvglm
                    section.data(78).logicalSrcIdx = 399;
                    section.data(78).dtTransOffset = 88;

                    ;% rtB.gkgoch4i20[3].a0rhlxsm00
                    section.data(79).logicalSrcIdx = 400;
                    section.data(79).dtTransOffset = 89;

                    ;% rtB.gkgoch4i20[3].nw0mvpivty
                    section.data(80).logicalSrcIdx = 401;
                    section.data(80).dtTransOffset = 90;

                    ;% rtB.gkgoch4i20[3].d2ovrnfxki
                    section.data(81).logicalSrcIdx = 402;
                    section.data(81).dtTransOffset = 91;

                    ;% rtB.gkgoch4i20[3].aknzqdxnri
                    section.data(82).logicalSrcIdx = 403;
                    section.data(82).dtTransOffset = 92;

                    ;% rtB.gkgoch4i20[3].gaktijxane
                    section.data(83).logicalSrcIdx = 404;
                    section.data(83).dtTransOffset = 93;

                    ;% rtB.gkgoch4i20[3].gf5ktnuaim
                    section.data(84).logicalSrcIdx = 405;
                    section.data(84).dtTransOffset = 94;

                    ;% rtB.gkgoch4i20[3].lrnbheyva5
                    section.data(85).logicalSrcIdx = 406;
                    section.data(85).dtTransOffset = 95;

            nTotData = nTotData + section.nData;
            sigMap.sections(3) = section;
            clear section

            section.nData     = 17;
            section.data(17)  = dumData; %prealloc

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.fzg4v4bzwb
                    section.data(1).logicalSrcIdx = 407;
                    section.data(1).dtTransOffset = 0;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.kdp2bpteqj
                    section.data(2).logicalSrcIdx = 408;
                    section.data(2).dtTransOffset = 1;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.izwfmykdmg
                    section.data(3).logicalSrcIdx = 409;
                    section.data(3).dtTransOffset = 2;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.o4nwybraef
                    section.data(4).logicalSrcIdx = 410;
                    section.data(4).dtTransOffset = 3;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.ionaytj1hi
                    section.data(5).logicalSrcIdx = 411;
                    section.data(5).dtTransOffset = 4;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.ot0ruhn3ec
                    section.data(6).logicalSrcIdx = 412;
                    section.data(6).dtTransOffset = 5;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.pugnwqsqon
                    section.data(7).logicalSrcIdx = 413;
                    section.data(7).dtTransOffset = 6;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.j03k0bsid4
                    section.data(8).logicalSrcIdx = 414;
                    section.data(8).dtTransOffset = 7;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.fhmqmavvw5
                    section.data(9).logicalSrcIdx = 415;
                    section.data(9).dtTransOffset = 8;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.kvmm52yte0
                    section.data(10).logicalSrcIdx = 416;
                    section.data(10).dtTransOffset = 9;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.f4al2st3ta
                    section.data(11).logicalSrcIdx = 417;
                    section.data(11).dtTransOffset = 10;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.pfkr31kenf
                    section.data(12).logicalSrcIdx = 418;
                    section.data(12).dtTransOffset = 11;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.mgppe3w0fg
                    section.data(13).logicalSrcIdx = 419;
                    section.data(13).dtTransOffset = 12;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.jzqvfuxtym
                    section.data(14).logicalSrcIdx = 420;
                    section.data(14).dtTransOffset = 13;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.mlqwxzdrtd
                    section.data(15).logicalSrcIdx = 421;
                    section.data(15).dtTransOffset = 14;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.cid3dcdtea
                    section.data(16).logicalSrcIdx = 422;
                    section.data(16).dtTransOffset = 15;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.get5vb1e2d
                    section.data(17).logicalSrcIdx = 423;
                    section.data(17).dtTransOffset = 16;

            nTotData = nTotData + section.nData;
            sigMap.sections(4) = section;
            clear section

            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.g3znxgnbb5
                    section.data(1).logicalSrcIdx = 424;
                    section.data(1).dtTransOffset = 0;

                    ;% rtB.fujf10vfd2[3].lgqwjimiob.our5du5hr1
                    section.data(2).logicalSrcIdx = 425;
                    section.data(2).dtTransOffset = 1;

            nTotData = nTotData + section.nData;
            sigMap.sections(5) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtB.c5nsirmoeg.needjvu4vj
                    section.data(1).logicalSrcIdx = 426;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            sigMap.sections(6) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtB.ivr0vxwdxm.needjvu4vj
                    section.data(1).logicalSrcIdx = 427;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            sigMap.sections(7) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtB.cman0zlcfck.needjvu4vj
                    section.data(1).logicalSrcIdx = 428;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            sigMap.sections(8) = section;
            clear section


            ;%
            ;% Non-auto Data (signal)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        sigMap.nTotData = nTotData;



    ;%*******************
    ;% Create DWork Map *
    ;%*******************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 20;
        sectIdxOffset = 8;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc dworkMap
        ;%
        dworkMap.nSections           = nTotSects;
        dworkMap.sectIdxOffset       = sectIdxOffset;
            dworkMap.sections(nTotSects) = dumSection; %prealloc
        dworkMap.nTotData            = -1;

        ;%
        ;% Auto data (rtDW)
        ;%
            section.nData     = 17;
            section.data(17)  = dumData; %prealloc

                    ;% rtDW.k2m5zl3m3k
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.n5fe15tlck
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 2;

                    ;% rtDW.awunvg0cnh
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 3;

                    ;% rtDW.dx1fdgtesf
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 4;

                    ;% rtDW.m1qp52cqky
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 5;

                    ;% rtDW.anevwupbcq
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 6;

                    ;% rtDW.dimpwebbfq
                    section.data(7).logicalSrcIdx = 6;
                    section.data(7).dtTransOffset = 7;

                    ;% rtDW.hwbajfhqup
                    section.data(8).logicalSrcIdx = 7;
                    section.data(8).dtTransOffset = 10;

                    ;% rtDW.mntyqwxfjm
                    section.data(9).logicalSrcIdx = 8;
                    section.data(9).dtTransOffset = 13;

                    ;% rtDW.bxavz5ufk2
                    section.data(10).logicalSrcIdx = 9;
                    section.data(10).dtTransOffset = 16;

                    ;% rtDW.dme1ph5qgn
                    section.data(11).logicalSrcIdx = 10;
                    section.data(11).dtTransOffset = 19;

                    ;% rtDW.hqllcojfb4
                    section.data(12).logicalSrcIdx = 11;
                    section.data(12).dtTransOffset = 23;

                    ;% rtDW.iq1lkigcxm
                    section.data(13).logicalSrcIdx = 12;
                    section.data(13).dtTransOffset = 26;

                    ;% rtDW.ckvuwlhl0x
                    section.data(14).logicalSrcIdx = 13;
                    section.data(14).dtTransOffset = 28;

                    ;% rtDW.e5vvl2gul3
                    section.data(15).logicalSrcIdx = 14;
                    section.data(15).dtTransOffset = 36;

                    ;% rtDW.dh4jx1mjpn
                    section.data(16).logicalSrcIdx = 15;
                    section.data(16).dtTransOffset = 37;

                    ;% rtDW.bytt2ctgen
                    section.data(17).logicalSrcIdx = 16;
                    section.data(17).dtTransOffset = 39;

            nTotData = nTotData + section.nData;
            dworkMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtDW.aq2mpmltq0.AQHandles
                    section.data(1).logicalSrcIdx = 17;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(2) = section;
            clear section

            section.nData     = 7;
            section.data(7)  = dumData; %prealloc

                    ;% rtDW.moca11x12g
                    section.data(1).logicalSrcIdx = 18;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.debzszrka4
                    section.data(2).logicalSrcIdx = 19;
                    section.data(2).dtTransOffset = 1;

                    ;% rtDW.brfzaqsrdh
                    section.data(3).logicalSrcIdx = 20;
                    section.data(3).dtTransOffset = 2;

                    ;% rtDW.fwxgq21t2k
                    section.data(4).logicalSrcIdx = 21;
                    section.data(4).dtTransOffset = 3;

                    ;% rtDW.m4e3e0josj
                    section.data(5).logicalSrcIdx = 22;
                    section.data(5).dtTransOffset = 4;

                    ;% rtDW.kzy2wc0fue
                    section.data(6).logicalSrcIdx = 23;
                    section.data(6).dtTransOffset = 5;

                    ;% rtDW.guh5vo03zz
                    section.data(7).logicalSrcIdx = 24;
                    section.data(7).dtTransOffset = 6;

            nTotData = nTotData + section.nData;
            dworkMap.sections(3) = section;
            clear section

            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% rtDW.mfqj40hrza
                    section.data(1).logicalSrcIdx = 25;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.nc30geqzj5
                    section.data(2).logicalSrcIdx = 26;
                    section.data(2).dtTransOffset = 1;

                    ;% rtDW.flujkqdezc
                    section.data(3).logicalSrcIdx = 27;
                    section.data(3).dtTransOffset = 2;

                    ;% rtDW.osol1uyisn
                    section.data(4).logicalSrcIdx = 28;
                    section.data(4).dtTransOffset = 6;

            nTotData = nTotData + section.nData;
            dworkMap.sections(4) = section;
            clear section

            section.nData     = 9;
            section.data(9)  = dumData; %prealloc

                    ;% rtDW.miqxwdf310
                    section.data(1).logicalSrcIdx = 29;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.cxmfeqly1b
                    section.data(2).logicalSrcIdx = 30;
                    section.data(2).dtTransOffset = 1;

                    ;% rtDW.nede5duig5
                    section.data(3).logicalSrcIdx = 31;
                    section.data(3).dtTransOffset = 2;

                    ;% rtDW.o5ics2iabk
                    section.data(4).logicalSrcIdx = 32;
                    section.data(4).dtTransOffset = 3;

                    ;% rtDW.joc1mpntor
                    section.data(5).logicalSrcIdx = 33;
                    section.data(5).dtTransOffset = 4;

                    ;% rtDW.prlp0sdren
                    section.data(6).logicalSrcIdx = 34;
                    section.data(6).dtTransOffset = 5;

                    ;% rtDW.djxulpnosq
                    section.data(7).logicalSrcIdx = 35;
                    section.data(7).dtTransOffset = 6;

                    ;% rtDW.ha2w00udvs
                    section.data(8).logicalSrcIdx = 36;
                    section.data(8).dtTransOffset = 7;

                    ;% rtDW.jnio4myedw
                    section.data(9).logicalSrcIdx = 37;
                    section.data(9).dtTransOffset = 8;

            nTotData = nTotData + section.nData;
            dworkMap.sections(5) = section;
            clear section

            section.nData     = 8;
            section.data(8)  = dumData; %prealloc

                    ;% rtDW.nw1voagdka
                    section.data(1).logicalSrcIdx = 38;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.palzix4p11
                    section.data(2).logicalSrcIdx = 39;
                    section.data(2).dtTransOffset = 1;

                    ;% rtDW.ogutke5kay
                    section.data(3).logicalSrcIdx = 40;
                    section.data(3).dtTransOffset = 2;

                    ;% rtDW.jozbo3aidm
                    section.data(4).logicalSrcIdx = 41;
                    section.data(4).dtTransOffset = 3;

                    ;% rtDW.ovsorff0ds
                    section.data(5).logicalSrcIdx = 42;
                    section.data(5).dtTransOffset = 4;

                    ;% rtDW.a3l4wmvruy
                    section.data(6).logicalSrcIdx = 43;
                    section.data(6).dtTransOffset = 5;

                    ;% rtDW.h3or5uadol
                    section.data(7).logicalSrcIdx = 44;
                    section.data(7).dtTransOffset = 6;

                    ;% rtDW.i4rhuztuun
                    section.data(8).logicalSrcIdx = 45;
                    section.data(8).dtTransOffset = 7;

            nTotData = nTotData + section.nData;
            dworkMap.sections(6) = section;
            clear section

            section.nData     = 3;
            section.data(3)  = dumData; %prealloc

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.muiigb5xri
                    section.data(1).logicalSrcIdx = 46;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.bzrqwbzpb4
                    section.data(2).logicalSrcIdx = 47;
                    section.data(2).dtTransOffset = 1;

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.hrc0vurc1u
                    section.data(3).logicalSrcIdx = 48;
                    section.data(3).dtTransOffset = 2;

            nTotData = nTotData + section.nData;
            dworkMap.sections(7) = section;
            clear section

            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.dnrshwncok
                    section.data(1).logicalSrcIdx = 49;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.hxplkrkt2u
                    section.data(2).logicalSrcIdx = 50;
                    section.data(2).dtTransOffset = 1;

            nTotData = nTotData + section.nData;
            dworkMap.sections(8) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.ebbd012ewa
                    section.data(1).logicalSrcIdx = 51;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(9) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.k3b0fqaqga
                    section.data(1).logicalSrcIdx = 52;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(10) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.lvqn1qip1a
                    section.data(1).logicalSrcIdx = 53;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(11) = section;
            clear section

            section.nData     = 6;
            section.data(6)  = dumData; %prealloc

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.g54kk2ivts
                    section.data(1).logicalSrcIdx = 54;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.j0jqiw0nyj
                    section.data(2).logicalSrcIdx = 55;
                    section.data(2).dtTransOffset = 1;

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.ilc5d3xbfy
                    section.data(3).logicalSrcIdx = 56;
                    section.data(3).dtTransOffset = 2;

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.mpkqh5re2d
                    section.data(4).logicalSrcIdx = 57;
                    section.data(4).dtTransOffset = 3;

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.pwf3gdl12m
                    section.data(5).logicalSrcIdx = 58;
                    section.data(5).dtTransOffset = 4;

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.kcmulbg3wy
                    section.data(6).logicalSrcIdx = 59;
                    section.data(6).dtTransOffset = 5;

            nTotData = nTotData + section.nData;
            dworkMap.sections(12) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.ni3y0b434e
                    section.data(1).logicalSrcIdx = 60;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(13) = section;
            clear section

            section.nData     = 3;
            section.data(3)  = dumData; %prealloc

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.l1bcue4ppa
                    section.data(1).logicalSrcIdx = 61;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.nsdnrronhv
                    section.data(2).logicalSrcIdx = 62;
                    section.data(2).dtTransOffset = 1;

                    ;% rtDW.fujf10vfd2[3].lgqwjimiob.abpsizvzll
                    section.data(3).logicalSrcIdx = 63;
                    section.data(3).dtTransOffset = 2;

            nTotData = nTotData + section.nData;
            dworkMap.sections(14) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtDW.c5nsirmoeg.pg1zdxqs4m
                    section.data(1).logicalSrcIdx = 64;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(15) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtDW.c5nsirmoeg.ekybzxpjz2
                    section.data(1).logicalSrcIdx = 65;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(16) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtDW.ivr0vxwdxm.pg1zdxqs4m
                    section.data(1).logicalSrcIdx = 66;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(17) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtDW.ivr0vxwdxm.ekybzxpjz2
                    section.data(1).logicalSrcIdx = 67;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(18) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtDW.cman0zlcfck.pg1zdxqs4m
                    section.data(1).logicalSrcIdx = 68;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(19) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtDW.cman0zlcfck.ekybzxpjz2
                    section.data(1).logicalSrcIdx = 69;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(20) = section;
            clear section


            ;%
            ;% Non-auto Data (dwork)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        dworkMap.nTotData = nTotData;



    ;%
    ;% Add individual maps to base struct.
    ;%

    targMap.paramMap  = paramMap;
    targMap.signalMap = sigMap;
    targMap.dworkMap  = dworkMap;

    ;%
    ;% Add checksums to base struct.
    ;%


    targMap.checksum0 = 3303656151;
    targMap.checksum1 = 3564819367;
    targMap.checksum2 = 231686199;
    targMap.checksum3 = 1451396653;

