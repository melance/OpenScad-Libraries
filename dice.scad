include <BOSL2/std.scad>

_demo=true;

if (_demo){
	back(15){
		color("red")
		left(30)
		D4(10);

		color("orange")
		D6(10);

		color("yellow")
		right(30)
		D8(10);
	}
	fwd(15){
		color("green")
		left(30)
		D10(10);

		color("deepskyblue")
		D12(10);

		color("violet")
		right(30)
		D20(10);
	}
}

// Dice
function D4(r) = 
	let (
		d=r*2,
		side = fwd(d/2,[[0,0],[0,d],[d/2,d/4]])
	)
	[side,xflip(side)];

module D4(r,stroke_width=1){
	stroke(D4(r),width=stroke_width);
}

function D6(r) = 
	let (
		d=r*2
	)
	fwd(d/2,[[0,0],[0,d/2],[d/-2,d/2+d/4],[0,d],[d/2,d/2+d/4],[d/2,d/4],[0,0],[d/-2,d/4],[d/-2,d/2+d/4],[0,d/2],[d/2,d/2+d/4]]);

module D6(r,stroke_width=1){
	stroke(D6(r),stroke_width);
}

function D8(r) = 
	let(
		d=r*2
	)
	fwd(d/2,[[0,0],[d/-2.5,d/2],[0,d],[d/2.5,d/2],[0,0],[d/-2.5,d/2],[d/2.5,d/2]]);

module D8(r,stroke_width=1){
	stroke(D8(r),stroke_width);
}

function D10(r) =
	let(
		d=r*2,
		offset=r/20
	)
	fwd(d/2,[
		[0,0], [d/-2,d/2], [0,d], [d/2,d/2], [0,0], [0,d/2-offset], [d/-4,d/2+offset],[d/-2,d/2],
		[0,d],[d/-4,d/2+offset],[0,d/2-offset],[d/4,d/2+offset],[d/2,d/2],[0,d],[d/4,d/2+offset]
	]);

module D10(r,stroke_width=1){
	stroke(D10(r), stroke_width);
}

function D12(r) =
	let(
		decagon=regular_ngon(r = r, n = 10, align_tip=BACK),
		pentagon=regular_ngon(r = r/2, n = 5, align_side=FRONT),
		spoke0=concat([decagon[0], pentagon[3]]),
		spoke1=concat([decagon[2], pentagon[4]]),
		spoke2=concat([decagon[4], pentagon[0]]),
		spoke3=concat([decagon[6], pentagon[1]]),
		spoke4=concat([decagon[8], pentagon[2]]),
	)
	[spoke0,spoke1,spoke2,spoke3,spoke4,decagon,pentagon];

module D12(r,stroke_width=1){
	stroke(D12(r), stroke_width);
}

function D20(r) =
	let(
		hexagon=regular_ngon(r=r,n=6,align_tip=BACK),
		center=regular_ngon(r=r/1.5,n=3,align_tip=BACK)
	)
	[
		hexagon,
		center,
		concat([hexagon[0],center[0]]),
		concat([hexagon[1],center[0]]),
		concat([hexagon[1],center[1]]),
		concat([hexagon[2],center[1]]),
		concat([hexagon[3],center[1]]),
		concat([hexagon[3],center[2]]),
		concat([hexagon[4],center[2]]),
		concat([hexagon[5],center[2]]),
		concat([hexagon[5],center[0]])
	];

module D20(r,stroke_width=1){	
	stroke(D20(r), stroke_width);
}
