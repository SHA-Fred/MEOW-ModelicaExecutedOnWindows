within Quadcopter.Components.Mechanics;

model Frame
	extends Quadcopter.Icons.QuadBody;

	outer MB.World world;

	parameter SI.Mass m(min=0) "Mass of the quadcopter";
	parameter SI.Inertia I[3](min={0,0,0}) "Inertial matrix diagonal";
	parameter SI.Length r_CM[3] "Distance of the CM and geometrical center"; // TODO guardare la direzione del vettore
	parameter Integer nArms(start=0) "Number of arms";
	parameter SI.Position rArms[3,nArms](start=fill(0,3,nArms)) "Position of the arms joints";
	parameter NSI.Angle_deg x_angle[nArms](start=fill(0,nArms)) "Angle between the x-axis of the arm-frame and the x-axis of the quad-frame around common z-axis";
	final parameter MB.Types.Axis n = {0,0,1};  //Axis of rotation for the direction of Arms

	//Definition of the Body Frame
	MB.Parts.Body body(I_11 = I[1], I_21 = 0, I_22 = I[2], I_31 = 0, I_32 = 0, I_33 = I[3], angles_fixed = true, angles_start(displayUnit = "rad"), animation = false, m = m, r_CM = r_CM, w_0_fixed = true, z_0_fixed = true) annotation(Placement(visible = true, transformation(origin = {-18, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
	//Translation and rotation of the axis, pointing with the x axis along the Arm ( the angle of rotation is a parameter)
	MB.Parts.FixedRotation fixedRotation[nArms](angle = {x_angle[i] for i in 1:nArms}, each animation = false, each n = n, r = {rArms[:, i] for i in 1:nArms}, each rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis) annotation(Placement(visible = true, transformation(origin = {-28, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
	//Revolution of the frame of the Arm, along x axis
	MB.Joints.Revolute revolute[nArms](each animation = false, each n = {1, 0, 0},each phi(displayUnit = "rad"))  annotation(Placement(visible = true, transformation(origin = {2, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
	//Frames of the rotated Arms, they need to be connected with a model of the Arms
	MB.Interfaces.Frame_b frame_b[nArms] annotation(Placement(visible = true, transformation(origin = {38, 10}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
	//Input signal for the rotation of the arms (in radiant)
	ROT.Sources.Position position[nArms] annotation(Placement(visible = true, transformation(origin = {-68, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

	equation
		//Connection between the body frame and the frame of Translation
		for i in 1:nArms loop
			connect(body.frame_a, fixedRotation[i].frame_a);
			connect(fixedRotation[i].frame_b, revolute[i].frame_a);
			connect(revolute[i].frame_b,frame_b[nArms]);
			revolute[i].phi=position[i].phi_ref;
		end for

	annotation(uses(Modelica(version = "3.2.1")));
end Frame;