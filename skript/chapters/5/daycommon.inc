//
// daycommon.inc
//
// (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
//
#version 3.7;
#include "colors.inc"

global_settings {
	assumed_gamma 1
}

#declare imagescale = 0.12;

camera {
        location <30, 15, 60>
        look_at <2, 0.58, 0>
        right x * imagescale
        up (860/1920) * y * imagescale
}

sky_sphere {
        pigment {
                color <1,1,1>*0.5
        }
}

#declare punkttheta = 0.3 * pi;

#macro kugelpunkt(phi, theta)
        <cos(phi) * sin(theta), cos(theta), sin(phi) * sin(theta)>
#end

#macro sun(phi)
light_source {
        <0, 0, 0> color White
        looks_like {
                sphere { <0, 0, 0>, 0.5 }
                pigment { color rgb<1, 1, 0.2> }
                finish { ambient 0.8 }
        }
	translate 5 * kugelpunkt(phi, pi/2) + kugelpunkt(0, punkttheta)
}
#end

