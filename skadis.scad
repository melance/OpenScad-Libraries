/*
	Description: 
	A library to help with designing items for the Ikea Skadis pegboard 
	
	Including:
	Only works with 'include'

	Requirements:
	Requires the BOSL2 library found at https://github.com/BelfrySCAD/BOSL2

	Details:
	The modules are all attachable using the BOSL2 attachment methodology
*/

include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

// Skadis measurements
/* [Hidden] */
peg_width=4.25;
peg_depth=14-peg_width;
peg_height=14;
z_spacing_to_center=40;
x_spacing_to_center=45;

$fn=$preview?40:120;

// Generates a single Skadis Peg
module skadis_peg(anchor=CENTER,spin=0,orient=UP){
	rounding_ends=(peg_width)/2;
	tag_scope()
	attachable(size=[peg_width,peg_depth,peg_height],spin=spin,anchor=anchor,orient=orient){
		xrot(90)
		up((peg_depth-peg_width)/2)
		cuboid([peg_width,peg_height,peg_width],rounding=rounding_ends,edges="Z"){
			attach(TOP,TOP,align=BACK,inside=true)
			cuboid([peg_width,peg_height/2,peg_depth],rounding=rounding_ends,edges="Z");
		}
		children();
	}
}

// Generates a number of Skadis Pegs across the width spaced according to the Skadis board spacing
// Parameters:
// 		width: the width to distribute the pegs across
//		all: if true, pegs will be generated for all slots.  If false, only the first and last peg will be generated
module skadis_peg_distribution(width, all=false,anchor=CENTER,spin=0,orient=UP){
	assert(is_num(width), "width must be a number.");
	peg_count=max(round(width/x_spacing_to_center),1);
	pegs_width=(peg_count-1)*x_spacing_to_center;
	extra=width-pegs_width;
	echo(str("peg_count: ",peg_count));
	echo(str("pegs_width: ", pegs_width));
	echo(str("extra: ", extra));
	echo([pegs_width,peg_height,peg_depth]);
	attachable(size=[pegs_width-peg_width,peg_depth,peg_height],spin=spin,anchor=anchor,orient=orient){
		if (peg_count>1){		
			if (all){
				left((width)/2)
				right(extra/2)
				for(x=[0:peg_count-1]){
					right(x_spacing_to_center*x)
					skadis_peg();
				}
			}
			else{
				xflip_copy()
				left((pegs_width-peg_width)/2)
				skadis_peg();
			}
		}
		else{
			skadis_peg();
		}
		children();
	}
}