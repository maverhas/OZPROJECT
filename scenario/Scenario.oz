local
	NoBomb=false|NoBomb
 in
	 scenario(bombLatency:3
		  walls:true
		  step: 0 
		  spaceships: [
			   spaceship(team:blue name:perroquet 
				 positions: [pos(x:5 y:9 to:east) pos(x:4 y:9 to:east)]
				 effects: nil
				 strategy: [repeat([forward] times:10) turn(left) turn(left) turn(left)]
				 seismicCharge: true|NoBomb
				)
			   spaceship(team:red name:canari
				 positions: [pos(x:15 y:15 to:south) pos(x:14 y:15 to:south)]
				 effects: nil
				 strategy: [turn(right) turn(right)  repeat([forward] times:6) turn(left) turn(left)]
				 seismicCharge: NoBomb
				)
			   spaceship(team:green name:pigeon
				 positions: [pos(x:10 y:5 to:east) pos(x:10 y:4 to:east) pos(x:10 y:3 to:east) ]
				 effects: nil
				 strategy: [turn(right) repeat([forward] times:10) turn(right) turn(right)]
				 seismicCharge: true|NoBomb
				)
				spaceship(team:yellow name:perdrix
				positions: [pos(x:18 y:14 to:west) pos(x:18 y:15 to:west) ]
				effects: nil
				strategy: [repeat([forward] times:3) turn(left)  turn(left) forward  turn(left) ]
				seismicCharge: NoBomb
			   )
			  ]
 
 
		  bonuses: [
				bonus(position:pos(x:8 y:8) color:red effect:revert target:catcher)
				bonus(position:pos(x:17 y:12) color:red effect:revert target:catcher)
 
				bonus(position:pos(x:18 y:9) color:blue effect:dropSeismicCharge(true|true|true|false|NoBomb) target:catcher) 
				bonus(position:pos(x:7 y:7) color:yellow effect:dropSeismicCharge target:catcher)
				
				bonus(position:pos(x:21 y:7) color:blue effect:destroy target:opponents)
				bonus(position:pos(x:16 y:12) color:blue effect:wormhole(x:4 y:22) target:catcher)
 
				bonus(position:pos(x:14 y:14) color:green effect:malware(n:10) target:catcher)
				bonus(position:pos(x:6 y:6) color:green effect:malware(n:10) target:opponents)
			   ]
 
 
		  bombs: [
			  bomb(position:pos(x:18 y:18) explodesIn:3)
			  bomb(position:pos(x:10 y:15) explodesIn:6)
			 ]
	 
		 )
 end
 