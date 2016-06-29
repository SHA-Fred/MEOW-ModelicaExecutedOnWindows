within Quadcopter.Tests;

model Test_Frame
	extends Modelica.Icons.Example;
  inner Modelica.Mechanics.MultiBody.World world(animateGravity = false, animateWorld = true, enableAnimation = true, gravityType = Modelica.Mechanics.MultiBody.Types.GravityTypes.UniformGravity, label1 = "x", label2 = "z", n = {0, 0, -1}) annotation(Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Modelica.Mechanics.MultiBody.Parts.Body body1(animation = true, m = 0.1, r_CM = {0, 0, 0})  annotation(Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Modelica.Mechanics.MultiBody.Joints.FreeMotion freeMotion1 annotation(Placement(visible = true, transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(freeMotion1.frame_b, body1.frame_a) annotation(Line(points = {{-40, 30}, {-20, 30}, {-20, 30}, {-20, 30}}, color = {95, 95, 95}));
  connect(freeMotion1.frame_a, world.frame_b) annotation(Line(points = {{-60, 30}, {-80, 30}, {-80, 30}, {-80, 30}}, color = {95, 95, 95}));

annotation(uses(Modelica(version = "3.2.2")));end Test_Frame;