
local 
   % Vous pouvez remplacer ce chemin par celui du dossier qui contient LethOzLib.ozf
   % Please replace this path with your own working directory that contains LethOzLib.ozf

   % Dossier = {Property.condGet cwdir '/home/max/FSAB1402/Projet-2017'} % Unix example
   Dossier = {Property.condGet cwdir '/home/martin/Desktop/OZPROJECT/'}
   % Dossier = {Property.condGet cwdir 'C:\\Users\Thomas\Documents\UCL\Oz\Projet'} % Windows example.
   LethOzLib

   % Les deux fonctions que vous devez implémenter
   % The two function you have to implement
   Next
   DecodeStrategy
   
   % Hauteur et largeur de la grille
   % Width and height of the grid
   % (1 <= x <= W=24, 1 <= y <= H=24)
   W = 24
   H = 24

   Options
in
   % Merci de conserver cette ligne telle qu'elle.
   % Please do NOT change this line.
   [LethOzLib] = {Link [Dossier#'/'#'LethOzLib.ozf']}
   {Browse LethOzLib.play}

%%%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here  %
% Votre code vient ici %
%%%%%%%%%%%%%%%%%%%%%%%%

   local
      % Déclarez vos functions ici
      % Declare your functions here
      X
      Y
      To
      SnackTurn
      MoveSnackForward
      ParseSpaceShipDirection
      ParseSpaceShipPositionY
      ParseSpaceShipPositionX
      NewSpaceShip
      CreateNewListNTimes
      F
      NewList
      DecodeStrategyAux
      Name
      RVALUE
   in
      % La fonction qui renvoit les nouveaux attributs du serpent après prise
      % en compte des effets qui l'affectent et de son instruction
      % The function that computes the next attributes of the spaceship given the effects
      % affecting him as well as the instruction
      % 
      % instruction ::= forward | turn(left) | turn(right)
      % P ::= <integer x such that 1 <= x <= 24>
      % direction ::= north | south | west | east
      % spaceship ::=  spaceship(
      %               positions: [
      %                  pos(x:<P> y:<P> to:<direction>) % Head
      %                  ...
      %                  pos(x:<P> y:<P> to:<direction>) % Tail
      %               ]
      %               effects: [scrap|revert|wormhole(x:<P> y:<P>)|... ...]
      %            )
      % Auxiliary function under

      % Auxiliary function for DecodeStrategy
         
      fun {CreateNewListNTimes Lst Count}
         if Count =< 0 then Lst else {CreateNewListNTimes {Append Lst Lst} Count-1} end
      end
      fun {DecodeStrategyAux Strategy R}
         case Strategy of nil then nil
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
      %  3 fonctions de parsing

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
                     

      fun {Next Spaceship Instruction}
         % Spaceship is a record
         % La manière la plus évdidente est de faire des case
         % On commence les cases pour l'instruction et on va parse les records du spaceship    
         % Il faut créer un nouveau spaceship I guess
         % On commence par les case pattern sur l'instruction
         X = {ParseSpaceShipPositionX Spaceship.positions nil}
         Y = {ParseSpaceShipPositionY Spaceship.positions nil}
         To = {ParseSpaceShipDirection Spaceship.positions nil}
         case Instruction of nil then {Browse nil}
         [] turn(left) then 
            {AdjoinList Spaceship [positions#{SnackTurn X Y To nil 0 left}] NewSpaceShip}
      
         [] turn(right) then  
            {AdjoinList Spaceship  [positions#{SnackTurn X Y To nil 0 right}] NewSpaceShip }
      
         [] forward then 
            {AdjoinList Spaceship [positions#{MoveSnackForward X Y To nil nil}] NewSpaceShip}
         end
            % Faut faire gaffe à la direction, c'est tout
         NewSpaceShip
      end

      
      % La fonction qui décode la stratégie d'un serpent en une liste de fonctions. Chacune correspond
      % à un instant du jeu et applique l'instruction devant être exécutée à cet instant au spaceship
      % passé en argument
      % The function that decodes the strategy of a spaceship into a list of functions. Each corresponds
      % to an instant in the game and should apply the instruction of that instant to the spaceship
      % passed as argument
      %
      % strategy ::= <instruction> '|' <strategy>
      %            | repeat(<strategy> times:<integer>) '|' <strategy>
      %            | nil
      fun {DecodeStrategy Strategy}
         case Strategy of nil then nil
         [] H|T then {DecodeStrategyAux Strategy nil}
         end
      end

      % Options
      Options = options(
		   % Fichier contenant le scénario (depuis Dossier)
		   % Path of the scenario (relative to Dossier)
		   scenario:'scenario/scenario_test_moves.oz'
		   % Utilisez cette touche pour quitter la fenêtre
		   % Use this key to leave the graphical mode
		   closeKey:'Escape'
		   % Visualisation de la partie
		   % Graphical mode
		   debug: true
		   % Instants par seconde, 0 spécifie une exécution pas à pas. (appuyer sur 'Espace' fait avancer le jeu d'un pas)
		   % Steps per second, 0 for step by step. (press 'Space' to go one step further)
		   frameRate: 5
		)
   end

%%%%%%%%%%%
% The end %
%%%%%%%%%%%
   
   local 
      R = {LethOzLib.play Dossier#'/'#Options.scenario Next DecodeStrategy Options}
   in
      {Browse R}
      {Browse Dossier#'/'#Options.scenario}
   end
end

