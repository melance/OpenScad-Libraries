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
peg_width=5;
peg_depth=15;
peg_height=15;
z_spacing_to_center=40;
x_spacing_to_center=45;
tolerance=0.5;

$fn=$preview?40:120;

// Generates a single Skadis Peg
module skadis_peg(anchor=CENTER,spin=0,orient=UP){
		rounding_ends=(peg_width-tolerance)/2;
		tag_scope()
		attachable(size=[peg_width-tolerance,peg_depth+tolerance,peg_height-tolerance],spin=spin,anchor=anchor,orient=orient)	{
			up((peg_height-peg_width-tolerance)/2)
			cuboid([peg_width-tolerance,peg_depth+tolerance,peg_width-tolerance],rounding=rounding_ends,edges="Z"){
				attach(BOTTOM,TOP,align=BACK)
				cuboid([peg_width-tolerance,peg_height/2-tolerance,peg_height-peg_width-tolerance],rounding=rounding_ends,edges="Z");
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
	peg_count=max(floor(width/x_spacing_to_center),1);
	pegs_width=(peg_count-1)*x_spacing_to_center+peg_width;
	extra=width-pegs_width;
	echo(str("peg_count: ",peg_count));
	echo(str("pegs_width: ", pegs_width));
	echo(str("extra: ", extra));
	echo([pegs_width,peg_height,peg_depth]);
	attachable(size=[pegs_width,peg_height,peg_depth],spin=spin,anchor=anchor,orient=orient){
		if (peg_count>1){		
			if (all){
				left((width-peg_width)/2)
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