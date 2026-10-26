function Fx = get_Fx(tire,Vertical_Wheel_Load,kappa,Slip_Angle,...
                            Inclination_Angle,phit,Velocity,Pressure)

out = mfeval(tire,[Vertical_Wheel_Load,kappa,Slip_Angle,Inclination_Angle,phit,Velocity,Pressure],111);
Fx = out(1);