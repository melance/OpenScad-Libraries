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

// _skadis_test();

module _skadis_test(){
	cube([10,2,16])
	attach(BACK,BACK)
	skadis_peg_distribution(10);
}

// Skadis measurements
/* [Hidden] */
peg_width=5;
peg_depth=12;
peg_height=14;
board_depth=5.85;
rounding=peg_width/2;
z_spacing_to_center=40;
x_spacing_to_center=45;

$skadis_echo=false;

$fn=$preview?40:120;

// Echoes if the condition is true
module echo_if(message,condition){
	if (condition)
		echo(message);
}

// Generates a single Skadis Peg
module skadis_peg(anchor=CENTER,spin=0,orient=UP){
	tag_scope()
	attachable(size=[peg_width,peg_depth,peg_height],anchor=anchor,spin=spin,orient=orient){
		fwd(peg_depth/4)
		cuboid([peg_width,peg_depth-board_depth,peg_height],rounding=rounding)
		attach(TOP,TOP,inside=true,align=FRONT)
		cuboid([peg_width,peg_depth,peg_depth-board_depth],rounding=rounding,except=BACK);
		children();
	}
}

// Generates a number of Skadis Pegs across the width spaced according to the Skadis board spacing
// Parameters:
// 		width: the width to distribute the pegs across
//		allHooks: if true, pegs will be generated for all slots.  If false, only the first and last peg will be generated
module skadis_peg_distribution(width,allHooks=false,anchor=CENTER,spin=0,orient=UP){
	assert(is_num(width), "width must be a number.");
	peg_count=max(ceil(width/x_spacing_to_center),1);
	pegs_width=(peg_count-1)*x_spacing_to_center;
	extra=width-pegs_width;
	echo_if(str("peg_count: ",peg_count),$skadis_echo);
	echo_if(str("pegs_width: ", pegs_width),$skadis_echo);
	echo_if(str("extra: ", extra),$skadis_echo);
	echo_if([pegs_width,peg_height,peg_depth],$skadis_echo);
	attachable(size=[pegs_width-peg_width,peg_depth,peg_height],spin=spin,anchor=anchor,orient=orient){
		if (peg_count>1){		
			if (allHooks){
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