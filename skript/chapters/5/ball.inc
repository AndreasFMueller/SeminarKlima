//
// ball.inc
//
// (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
//

sphere {
	<0, 0, 0>, 1
	pigment {
		color rgb<1,1,0.8>
	}
}


#declare circlesteps = 200;
#declare linediameter = 0.01;

#macro laengenkreis(phi)
union {
	#declare thetamax = pi;
	#declare thetastep = thetamax / circlesteps;
	#declare theta = 0;
	#while (theta < (thetamax - thetastep/2))
		sphere { kugelpunkt(phi, theta), linediameter }
		cylinder {
			kugelpunkt(phi, theta),
			kugelpunkt(phi, theta + thetastep),
			linediameter 
		}
		#declare theta = theta + thetastep;
	#end
}
#end

#macro breitenkreis(theta)
union {
	#declare phimax = 2 * pi;
	#declare phistep = phimax / circlesteps;
	#declare phi = 0;
	#while (phi < (phimax - phistep/2))
		sphere { kugelpunkt(phi, theta), linediameter }
		cylinder {
			kugelpunkt(phi, theta),
			kugelpunkt(phi + phistep, theta),
			linediameter 
		}
		#declare phi = phi + phistep;
	#end
}
#end

union {

#declare phimax = 2 * pi;
#declare phistep = pi / 18;
#declare phi = 0;
#while (phi < (phimax - phistep/2))
	laengenkreis(phi)
	#declare phi = phi + phistep;
#end

#declare thetamax = pi;
#declare thetastep = pi / 18;
#declare theta = thetastep;
#while (theta < thetamax - (thetastep/2))
	breitenkreis(theta)
	#declare theta = theta + thetastep;
#end

	pigment {
		color rgb<1,0,0>
	}
}

sphere {
	kugelpunkt(0, punkttheta), 0.1
	pigment {
		color rgb<0,0.8,0>
	}
}

intersection {
	plane { kugelpunkt(0, punkttheta), 1.01 }
	plane { -kugelpunkt(0, punkttheta), -1 }
	box { <-1.3,-1.3,-5.5>, <1.3, 1.3, 5.5> }
	pigment {
		color rgbf<0.8,0.8,1,0.8>
	}
}



