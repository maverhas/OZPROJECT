

declare X Y To NewSpaceShip NoBomb NewList Next CreateNewListNTimes Next R MoveSnackForward DecodeStrategyAux
fun {MoveSnackForward ListX ListY ListTo Positions Last}
   case ListTo of nil then Positions
   [] To|TT then
      case ListX of nil then nil
      [] X|TX then
         case ListY of nil then nil
         [] Y|TY then
            case Last of nil then
               case To of east then {MoveSnackForward TX TY TT {Append Positions [pos(x:X+1 y:Y to:east)]} To}
               [] west then {MoveSnackForward TX TY TT {Append Positions [pos(x:X-1 y:Y to:west)]} To}
               [] south then {MoveSnackForward TX TY TT {Append Positions [pos(x:X y:Y+1 to:south)]} To}
               [] north then {MoveSnackForward TX TY TT {Append Positions [pos(x:X y:Y-1 to:north)]} To}
               end
            [] west then 
               case To of west then {MoveSnackForward TX TY TT {Append Positions [pos(x:X-1 y:Y to:west)]} To}
               [] north then {MoveSnackForward TX TY TT {Append Positions [pos(x:X y:Y-1 to:west)]} To}
               [] south then {MoveSnackForward TX TY TT {Append Positions [pos(x:X y:Y+1 to:west)]} To}
               end
            [] east then 
               case To of east then {MoveSnackForward TX TY TT {Append Positions [pos(x:X+1 y:Y to:east)]} To}
               [] north then {MoveSnackForward TX TY TT {Append Positions [pos(x:X y:Y-1 to:east)]} To}
               [] south then {MoveSnackForward TX TY TT {Append Positions [pos(x:X y:Y+1 to:east)]} To}
               end
            [] south then 
               case To of south then {MoveSnackForward TX TY TT {Append Positions [pos(x:X y:Y+1 to:south)]} To}
               [] east then {MoveSnackForward TX TY TT {Append Positions [pos(x:X+1 y:Y to:south)]} To}
               [] west then {MoveSnackForward TX TY TT {Append Positions [pos(x:X-1 y:Y to:south)]} To}
               end
            [] north then 
               case To of north then {MoveSnackForward TX TY TT {Append Positions [pos(x:X y:Y-1 to:north)]} To}
               [] east then {MoveSnackForward TX TY TT {Append Positions [pos(x:X+1 y:Y to:north)]} To}
               [] west then {MoveSnackForward TX TY TT {Append Positions [pos(x:X-1 y:Y to:north)]} To}
               end
            end
         end
      end
   end
end 
fun {SnackTurn ListX ListY ListTo Positions Set Direction}
   case ListTo of nil then nil
   [] To|TT then
      case ListX of nil then nil
      [] X|TX then 
         case ListY of nil then nil
         [] Y|TY then
           case Set of 2 then {MoveSnackForward ListX ListY ListTo Positions nil}
           [] 0 then 
               case Direction of nil then nil
               [] left then
                   case To of east then {SnackTurn TX TY TT {Append Positions [pos(x:X y:Y-1 to:north)]} Set+1 left}
                   [] west then {SnackTurn TX TY TT {Append Positions [pos(x:X y:Y+1 to:south)]} Set+1 left}
                   [] north then {SnackTurn TX TY TT {Append Positions [pos(x:X-1 y:Y to:west)]} Set+1 left}
                   [] south then {SnackTurn TX TY TT {Append Positions [pos(x:X+1 y:Y to:east)]} Set+1 left}
                   end
               [] right then
                  case To of east then {SnackTurn TX TY TT {Append Positions [pos(x:X y:Y+1 to:south)]} Set+1 right}
                  [] west then {SnackTurn TX TY TT {Append Positions [pos(x:X y:Y-1 to:north)]} Set+1 right}
                  [] north then {SnackTurn TX TY TT {Append Positions [pos(x:X+1 y:Y to:east)]} Set+1 right}
                  [] south then {SnackTurn TX TY TT {Append Positions [pos(x:X-1 y:Y to:west)]} Set+1 right}
                  end
              end
           [] 1 then 
               case Direction of nil then nil
               [] right then
                  case To of east then {SnackTurn TX TY TT {Append Positions [pos(x:X+1 y:Y to:south)]} Set+1 nil}
                  [] west then {SnackTurn TX TY TT {Append Positions [pos(x:X-1 y:Y to:north)]} Set+1 nil}
                  [] north then {SnackTurn TX TY TT {Append Positions [pos(x:X y:Y-1 to:east)]} Set+1 nil}
                  [] south then {SnackTurn TX TY TT {Append Positions [pos(x:X y:Y+1 to:west)]} Set+1 nil}
                  end
               [] left then
                  case To of east then {SnackTurn TX TY TT {Append Positions [pos(x:X+1 y:Y to:north)]} Set+1 nil}
                  [] west then {SnackTurn TX TY TT {Append Positions [pos(x:X-1 y:Y to:south)]} Set+1 nil}
                  [] north then {SnackTurn TX TY TT {Append Positions [pos(x:X y:Y-1 to:west)]} Set+1 nil}
                  [] south then {SnackTurn TX TY TT {Append Positions [pos(x:X y:Y+1 to:east)]} Set+1 nil}
                  end
               end
            end
         end
      end
   end
end



fun {ParseSpaceShipPositionX SpaceShipPos R}
   % Fonction qui parse spaceship et retourne une liste des coordonnées X
   case SpaceShipPos of nil then R
   [] H|T then {ParseSpaceShipPositionX T {Append R [H.x]}}
   end
end
fun {ParseSpaceShipPositionY SpaceShipPos R}
   % Fonction qui parse spaceship et retourne une liste des coordonnées Y
   case SpaceShipPos of nil then R
   [] H|T then {ParseSpaceShipPositionY T {Append R [H.y]}}
   end
end
fun {ParseSpaceShipDirection SpaceShipPos R}
   % Fonction qui parse spaceship et retourne une liste des coordonnées Y
   case SpaceShipPos of nil then R
   [] H|T then {ParseSpaceShipDirection T {Append R [H.to]}}
   end
end
 









fun {DecodeStrategy Strategy}
   case Strategy of nil then nil
   [] H|T then {DecodeStrategyAux Strategy R}
   end
end
fun {DecodeStrategyAux Strategy R}
   case Strategy of nil then R
   [] H|T then
      case {Label H} of turn then
         case H of turn(right) then
            {DecodeStrategyAux T {Append R [fun {$ Spaceship} {Next Spaceship H} end]}}
         [] turn(left) then
            {DecodeStrategyAux T {Append R [fun {$ Spaceship} {Next Spaceship H} end]}}
         end
      [] repeat then
         case H.1 of nil then nil
         [] F|S then
            NewList = {CreateNewListNTimes H.1 H.times}
            {DecodeStrategyAux NewList|T R}
         end
      [] forward then 
           {DecodeStrategyAux T {Append R [fun {$ Spaceship} {Next Spaceship H} end]}}
         
      end
   end

end
fun {Next Spaceship Instruction}
   % Spaceship is a record
   % La manière la plus évdidente est de faire des case
   % On commence les cases pour l'instruction et on va parse les records du spaceship    
   % Il faut créer un nouveau spaceship I guess
   % On commence par les case pattern sur l'instruction
   local NewSpaceShip in
      {Browse {MoveSnackForward {ParseSpaceShipPositionX Spaceship.positions nil} {ParseSpaceShipPositionY Spaceship.positions nil} {ParseSpaceShipDirection Spaceship.positions nil} nil nil}}
      case Instruction of nil then {Browse nil}
      [] turn(left) then {AdjoinList Spaceship [positions#{SnackTurn {ParseSpaceShipPositionX Spaceship.positions nil} {ParseSpaceShipPositionY Spaceship.positions nil} {ParseSpaceShipDirection Spaceship.positions nil} nil 0 left}] NewSpaceShip}

      [] turn(right) then {AdjoinList Spaceship [positions#{SnackTurn {ParseSpaceShipPositionX Spaceship.positions nil} {ParseSpaceShipPositionY Spaceship.positions nil} {ParseSpaceShipDirection Spaceship.positions nil} nil 0 right}] NewSpaceShip}

      [] forward then {AdjoinList Spaceship [positions#[{MoveSnackForward {ParseSpaceShipPositionX Spaceship.positions nil} {ParseSpaceShipPositionY Spaceship.positions nil} {ParseSpaceShipDirection Spaceship.positions nil} nil nil}]] NewSpaceShip}
      end
      % Faut faire gaffe à la direction, c'est tout
      NewSpaceShip
   end
end


{Browse {Next spaceship(team:red name:gordon
positions: [pos(x:6 y:6 to:east) pos(x:5 y:6 to:east) pos(x:4 y:6 to:east) pos(x:3 y:6 to:east)]
effects: nil
strategy: [forward forward]
seismicCharge: NoBomb
) turn(left)}}




{AdjoinList spaceship(team:red name:gordon
positions: [pos(x:6 y:6 to:east) pos(x:5 y:6 to:east) pos(x:4 y:6 to:east) pos(x:3 y:6 to:east)]
effects: nil
strategy: [forward forward]
seismicCharge: NoBomb
)  [positions#[pos(x:7 y:6 to:east) pos(x:5 y:6 to:east) pos(x:4 y:6 to:east) pos(x:3 y:6 to:east)]] Test}
{Browse Test}

declare 
Space = space([salut])
{Browse Space.1}

{Browse {Length [1 2 3]}}
declare
Listss = [1 2 3]
{Browse Listss.2}
declare
Direction = direction(left)
if Direction == direction(left) then {Browse 1} end
declare Move
fun {Move ListX ListY ListTo Positions Last Set Direction}
   case ListX of nil then Positions
   [] X|TX then
      case ListY of nil then nil
         case ListTo of nil then nil
            case Set of 0 then
               if Direction == forward then
                  case ListTo.1 of east then
                     {Move TX ListY.2 ListTo.2 {Append Positions [pos(x:X+1 y:ListY.1 to:ListTo.1)]} pos(x:X y:ListY.1 to:ListTo.1) 1 nil}
                  [] west then
                     {Move TX ListY.2 ListTo.2 {Append Positions [pos(x:X-1 y:ListY.1 to:ListTo.1)]} pos(x:X y:ListY.1 to:ListTo.1) 1 nil}
                  [] north then
                     {Move TX ListY.2 ListTo.2 {Append Positions [pos(x:X y:ListY.1-1 to:ListTo.1)]} pos(x:X y:ListY.1 to:ListTo.1) 1 nil}
                  [] south then
                     {Move TX ListY.2 ListTo.2 {Append Positions [pos(x:X y:ListY.1+1 to:ListTo.1)]} pos(x:X y:ListY.1 to:ListTo.1) 1 nil}
                  end
               end
               if Direction == turn(left) then
                  case ListTo.1 of east then
                     {Move TX ListY.2 ListTo.2 {Append Positions [pos(x:X y:ListY.1-1 to:north)]} pos(x:X y:ListY.1 to:ListTo.1) 1 nil}
                  [] west then
                     {Move TX ListY.2 ListTo.2 {Append Positions [pos(x:X y:ListY.1+1 to:south)]} pos(x:X y:ListY.1 to:ListTo.1) 1 nil}
                  [] south then
                     {Move TX ListY.2 ListTo.2 {Append Positions [pos(x:X+1 y:ListY.1 to:east)]} pos(x:X y:ListY.1 to:ListTo.1) 1 nil}
                  [] north then
                     {Move TX ListY.2 ListTo.2 {Append Positions [pos(x:X-1 y:ListY.1 to:west)]} pos(x:X y:ListY.1 to:ListTo.1) 1 nil}
                  end
               end
               if Direction == turn(right) then
                  case ListTo.1 of east then
                     {Move TX ListY.2 ListTo.2 {Append Positions [pos(x:X y:ListY.1+1 to:north)]} pos(x:X y:ListY.1 to:ListTo.1) 1 nil}
                  [] west then
                     {Move TX ListY.2 ListTo.2 {Append Positions [pos(x:X y:ListY.1-1 to:south)]} pos(x:X y:ListY.1 to:ListTo.1) 1 nil}
                  [] south then
                     {Move TX ListY.2 ListTo.2 {Append Positions [pos(x:X-1 y:ListY.1 to:east)]} pos(x:X y:ListY.1 to:ListTo.1) 1 nil}
                  [] north then
                     {Move TX ListY.2 ListTo.2 {Append Positions [pos(x:X+1 y:ListY.1 to:west)]} pos(x:X y:ListY.1 to:ListTo.1) 1 nil}
                  end
               end
            [] 1 then
               {Move TX ListY.2 ListTo.2 {Append Positions [Last]} pos(x:X y:ListY.1 to:ListTo.1) 1 nil}
            end
   end
end

{Browse {Move [1 2] [2 3] [east west] nil nil 0 turn(right)}}

declare
Listed = [1 2 3]
{Browse {List.drop Listed 1}}

declare
fun {Revert Listed R}
   case Listed of nil then R
   []H|T then
      {Revert T H|R}
   end
end
{Browse {Revert [1 2 3 4 5 6] nil}}