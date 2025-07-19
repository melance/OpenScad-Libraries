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

// recolor("cyan")
skadis_peg_distribution(145);

module skadis_peg(){
		rounding_ends=(peg_width-tolerance)/2;
		tag_scope()
		attachable(size=[peg_width-tolerance,peg_depth+tolerance,peg_height-tolerance])	{
			up((peg_height-peg_width-tolerance)/2)
			cuboid([peg_width-tolerance,peg_depth+tolerance,peg_width-tolerance],rounding=rounding_ends,edges="Z"){
				attach(BOTTOM,TOP,align=BACK)
				cuboid([peg_width-tolerance,peg_height/2-tolerance,peg_height-peg_width-tolerance],rounding=rounding_ends,edges="Z");
			}
			children();
		}		
}

module skadis_peg_distribution(width, all=false){
	assert(is_num(width), "width must be a number.");
	peg_count=max(floor(width/x_spacing_to_center),1);
	pegs_width=(peg_count-1)*x_spacing_to_center+peg_width;
	extra=width-pegs_width;
	echo(str("peg_count: ",peg_count));
	echo(str("pegs_width: ", pegs_width));
	echo(str("extra: ", extra));
	echo([pegs_width,peg_height,peg_depth]);
	attachable(size=[pegs_width,peg_height,peg_depth]){
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