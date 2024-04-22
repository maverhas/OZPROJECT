local
   NoBomb=false|NoBomb
in
%1
   scenario(
		bombLatency:3
	    walls:true
	    step: 0
	    spaceships: [
			  spaceship(team:orange name: Persan
				positions: [pos(x:4 y:1 to:east) pos(x:3 y:1 to:east) pos(x:2 y:1 to:east) pos(x:1 y:1 to:east)]
				effects: nil
				strategy: [forward turn(right) turn(right) forward]
				seismicCharge: true|NoBomb
			   )
			  spaceship(team:orange name:Siamois
				positions: [pos(x:24 y:24 to:west) pos(x:24 y:23 to:west)]
				effects: nil
				strategy: [forward turn(right) turn(right) turn(right) forward forward forward turn(right) turn(right) turn(left)
					   repeat([forward] times:30)]
				seismicCharge: true|NoBomb
			   )
			  spaceship(team:green name:Bengal
				positions: [pos(x:10 y:8 to:south) pos(x:10 y:7 to:south) pos(x:10 y:6 to:south)]
				effects: nil
				strategy: [forward turn(right) forward forward turn(right) forward  turn(right) turn(left) ]

				seismicCharge: NoBomb
			   )
			  spaceship(team:green name:Scottish
				positions: [pos(x:15 y:19 to:south) pos(x:15 y:18 to:south) pos(x:15 y:17 to:west) pos(x:15 y:16 to:west) pos(x:15 y:15 to:west)]
				effects: nil
				strategy: [repeat([forward] times:10) turn(left) turn(left) ]
				seismicCharge:true|NoBomb
			   )
			 ]
		bonuses: [ bonus(position:pos(x:5 y:1) color:green effect:scrap target:catcher)]
	    bombs: nil
	   )
%2
	scenario(bombLatency:3
		 walls:true
		 step: 0
		 spaceships: [
			  spaceship(team:red name:Perroquet 
				positions: [pos(x:20 y:10 to:east) pos(x:19 y:10 to:east)]
				effects: nil
				strategy: [repeat([forward] times:3) turn(left)]
				seismicCharge: true|NoBomb
			   )
			  spaceship(team:red name:Canari
				positions: [pos(x:15 y:15 to:south) pos(x:14 y:15 to:south)]
				effects: nil
				strategy: [turn(right) turn(right)  repeat([forward] times:6) turn(left) turn(left)]
				seismicCharge: NoBomb
			   )
			  spaceship(team:green name:Pigeon
				positions: [pos(x:10 y:5 to:east) pos(x:9 y:5 to:east) pos(x:8 y:5 to:east) pos(x:7 y:5 to:east)]
				effects: nil
				strategy: [turn(right) repeat([forward] times:20) turn(right) turn(right)]
				seismicCharge: true|NoBomb
			   )
			   spaceship(team:green name:Perdrix
			   positions: [pos(x:14 y:14 to:west) pos(x:15 y:14 to:west) pos(x:16 y:14 to:west) pos(x:17 y:14 to:west)]
			   effects: nil
			   strategy: [repeat([forward] times:5) turn(left) forward turn(left) forward  turn(left) forward ]
			   seismicCharge: NoBomb
			  )
			 spaceship(team:green name:Canard
			 positions: [pos(x:4 y:4 to:south) pos(x:5 y:4 to:south) pos(x:6 y:4 to:south) pos(x:7 y:4 to:south)]
			 effects: nil
			 strategy: [ forward forward turn(right)  ]  
			 seismicCharge: NoBomb
			)
			spaceship(team:orange name:Autruche
			positions: [pos(x:24 y:4 to:west) pos(x:23 y:14 to:west) ]
			effects: nil
			strategy: [ turn(left) forward forward  ]
			seismicCharge: true|NoBomb
		   )
			 ]
		 bonuses: [
			   bonus(position:pos(x:1 y:1) color:red effect:revert target:catcher)
			   bonus(position:pos(x:2 y:2) color:green effect:revert target:catcher)
			   bonus(position:pos(x:24 y:24) color:red effect:revert target:catcher)
			  ]
		 bombs: [
			 bomb(position:pos(x:24 y:23) explodesIn:3)
			 bomb(position:pos(x:15 y:15) explodesIn:6)
			]
		)
%3
	scenario(bombLatency:3
		 walls:true
		 step: 0
		 spaceships: [
			  spaceship(team:blue name:Chimpanzé 
				positions: [pos(x:15 y:8 to:east) pos(x:15 y:9 to:east) pos(x:15 y:10 to:east)]
				effects: nil
				strategy: [repeat([forward] times:7) turn(right)]
				seismicCharge: NoBomb
			   )
			  spaceship(team:blue name:Gorille
				positions: [pos(x:7 y:14 to:west) pos(x:6 y:13 to:west)]
				effects: nil
				strategy: [forward turn(right) repeat([forward] times:3) turn(right) turn(left) repeat([forward] times:3)]
				seismicCharge: false|false|false|false|false|false|true|NoBomb
			   )
			  spaceship(team:red name:Bonobo
				positions: [pos(x:14 y:14 to:southt) pos(x:15 y:14 to:south) pos(x:16 y:14 to:south) pos(x:17 y:14 to:south)]
				effects: nil
				strategy: [repeat([forward] times:5) turn(right) forward ]
				seismicCharge: NoBomb
			   )
			 ]
		 bonuses: [
			   bonus(position:pos(x:12 y:12) color:red effect:revert target:catcher)
			
			  ]
		 bombs: [
			 bomb(position:pos(x:17 y:17) explodesIn:3)
			 bomb(position:pos(x:7 y:7) explodesIn:6)
			]
		)
%4
   scenario(bombLatency:3
	    walls:true
	    step: 0
	    spaceships: [
		     spaceship(team:blue name:scarabées
			   positions: [pos(x:12 y:11 to:south) pos(x:11 y:11 to:south) pos(x:9 y:11 to:south) pos(x:8 y:11 to:south)]
			   effects: nil
			   strategy: [turn(right) repeat([forward] times:5) turn(left) turn(left)]
			   seismicCharge: NoBomb
			  )

			  spaceship(team:red name:abeilles
			  positions: [pos(x:20 y:14 to:west) pos(x:19 y:14 to:west)]
			  effects: nil
			  strategy: [repeat([forward forward turn(left) turn(left) forward forward]
			  seismicCharge: NoBomb
			 )
		     spaceship(team:orange name:papillons
			   positions: [pos(x:13 y:10to:east) pos(x:12 y:10 to:east) pos(x:11 y:10 to:east) pos(x:10 y:10 to:east)]
			   effects: nil
			   strategy: [repeat([forward] times:6) turn(right) forward turn(right) forward  turn(right) ]
			   seismicCharge: false|false|false|false|false|false|true|NoBomb
			  )
		    
		    ]
	    bonuses: [
		      bonus(position:pos(x:10 y:14) color:orange effect:revert target:catcher)
		      bonus(position:pos(x:14 y:13) color:green effect:revert target:catcher)
		      bonus(position:pos(x:16 y:14) color:orange effect:revert target:catcher)
			  bonus(position:pos(x:16 y:14) color:green effect:revert target:catcher)
		     ]
	    bombs: [
		    bomb(position:pos(x:24 y:24) explodesIn:3)
		    bomb(position:pos(x:4 y:4) explodesIn:3)
			bomb(position:pos(x:14 y:14) explodesIn:3)
		    bomb(position:pos(x:7 y:7) explodesIn:6)
		   ]
	   )
		])
end
