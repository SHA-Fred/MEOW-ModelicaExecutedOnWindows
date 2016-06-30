within Quadcopter.Tests;

model Test_3D
  extends Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum;
  inner ModelicaServices.Modelica3D.Controller m3d_control;
end Test_3D;