local
   NoBomb=false|NoBomb
in
	scenario(bombLatency:3
		 walls:true
		 step: 0
		 spaceships: [
			  spaceship(team:red name:perroquet 
				positions: [pos(x:20 y:10 to:east) pos(x:19 y:10 to:east)]
				effects: nil
				strategy: [turn(right) repeat([forward] times:3) turn(left)]
				seismicCharge: true|NoBomb
			   )
			  spaceship(team:red name:canari
				positions: [pos(x:15 y:15 to:south) pos(x:14 y:15 to:south)]
				effects: nil
				strategy: [turn(right) turn(right)  repeat([forward] times:6) turn(left) turn(left)]
				seismicCharge: NoBomb
			   )
			  spaceship(team:green name:pigeon
				positions: [pos(x:10 y:5 to:east) pos(x:9 y:5 to:east) pos(x:8 y:5 to:east) pos(x:7 y:5 to:east)]
				effects: nil
				strategy: [turn(right) repeat([forward] times:20) turn(right) turn(right)]
				seismicCharge: true|NoBomb
			   )
			   spaceship(team:green name:perdrix
			   positions: [pos(x:14 y:14 to:west) pos(x:15 y:14 to:west) pos(x:16 y:14 to:west) pos(x:17 y:14 to:west)]
			   effects: nil
			   strategy: [repeat([forward] times:5) turn(left) forward turn(left) forward  turn(left) forward ]
			   seismicCharge: NoBomb
			  )
			 ]
		 bonuses: [
			   bonus(position:pos(x:13 y:8) color:red effect:revert target:catcher)
			   bonus(position:pos(x:20 y:12) color:green effect:revert target:catcher)
			   bonus(position:pos(x:14 y:2) color:yellow effect:revert target:catcher)
			   bonus(position:pos(x:6 y:12) color:black effect:malware(n:10) target:opponents)
			   bonus(position:pos(x:16 y:10) color:blue effect:destroy target:opponents)
			   bonus(position:pos(x:3 y:3) color:purple effect:dropSeismicCharge(true|false|false|true|NoBomb) target:catcher)
			   bonus(position:pos(x:10 y:22) color:grey effect:wormhole(x:4 y:22) target:catcher)
			  ]
		 bombs: [
			 bomb(position:pos(x:23 y:23) explodesIn:3)
			 bomb(position:pos(x:15 y:15) explodesIn:6)
			]
		)
end
