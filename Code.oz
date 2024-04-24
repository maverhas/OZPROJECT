
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
      ParseSpaceShipDirection
      ParseSpaceShipPositionY
      ParseSpaceShipPositionX
      CreateNewListNTimes
      DecodeStrategyAux
      Move
      Revert
      Scrap
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



      fun {Scrap Positions R Last}
         case Positions of nil then
            case Last.to of east then
               {Append R [pos(x:Last.x-1 y:Last.y to:east)]}
            [] north then
               {Append R [pos(x:Last.x y:Last.y+1 to:east)]}
            [] south then
               {Append R [pos(x:Last.x-1 y:Last.y-1 to:east)]}
            [] west then
               {Append R [pos(x:Last.x+1 y:Last.y to:east)]}
            end
         []H|T then {Scrap T {Append R H} H}
         end
      end

      fun {Revert Positions R}
         case Positions of nil then R
         [] H|T then 
            case H.to of east then
               {Revert T pos(x:H.x y:H.y to:west)|R}
            [] west then
               {Revert T pos(x:H.x y:H.y to:east)|R}
            [] north then
               {Revert T pos(x:H.x y:H.y to:south)|R}
            [] south then
               {Revert T pos(x:H.x y:H.y to:north)|R}
            end
         end
      end



      fun {Move ListX ListY ListTo Positions Last Set Direction Spaceship}
         {Browse 1}
         case ListX of nil then Positions
         [] X|TX then
            case ListY of nil then Positions
            [] Y|TY then
               case ListTo of nil then Positions
               []To|TT then
                  case Set of 0 then
                     case Spaceship.effects of nil then
                        case Direction of forward then
                           case To of east then
                              {Move TX TY TT {Append Positions [pos(x:X+1 y:Y to:To)]} pos(x:X y:Y to:To) 1 nil nil}
                           [] west then
                              {Browse salut}
                              {Move TX TY TT {Append Positions [pos(x:X-1 y:Y to:To)]} pos(x:X y:Y to:To) 1 nil nil}
                           [] north then
                              {Move TX TY TT {Append Positions [pos(x:X y:Y-1 to:To)]} pos(x:X y:Y to:To) 1 nil nil}
                           [] south then
                              {Move TX TY TT {Append Positions [pos(x:X y:Y+1 to:To)]} pos(x:X y:Y to:To) 1 nil nil}
                           end
                        
                        [] turn(left) then
                           case To of east then
                              {Move TX TY TT {Append Positions [pos(x:X y:Y-1 to:north)]} pos(x:X y:Y to:To) 1 nil nil}
                           [] west then
                              {Move TX TY TT {Append Positions [pos(x:X y:Y+1 to:south)]} pos(x:X y:Y to:To) 1 nil nil}
                           [] south then
                              {Move TX TY TT {Append Positions [pos(x:X+1 y:Y to:east)]} pos(x:X y:Y to:To) 1 nil nil}
                           [] north then
                              {Move TX TY TT {Append Positions [pos(x:X-1 y:Y to:west)]} pos(x:X y:Y to:To) 1 nil nil}
                           end
                        [] turn(right) then
                           {Browse Spaceship.positions}
                           case To of east then
                              {Move TX TY TT {Append Positions [pos(x:X y:Y+1 to:south)]} pos(x:X y:Y to:To) 1 nil nil}
                           [] west then
                              {Move TX TY TT {Append Positions [pos(x:X y:Y-1 to:north)]} pos(x:X y:Y to:To) 1 nil nil}
                           [] south then
                              {Move TX TY TT {Append Positions [pos(x:X-1 y:Y to:west)]} pos(x:X y:Y to:To) 1 nil nil}
                           [] north then
                              {Move TX TY TT {Append Positions [pos(x:X+1 y:Y to:east)]} pos(x:X y:Y to:To) 1 nil nil}
                           end
                        end
                     []H|T then
                        case {Label H} of wormhole then
                           local NewX NewY in 
                              NewX = H.x
                              NewY = H.y
                              {Browse Spaceship.effects}
                              {Browse salut}
                              case Direction of forward then
                                 case To of east then
                                    {Move TX TY TT {Append Positions [pos(x:NewX+1 y:NewY to:To)]} pos(x:X y:Y to:To) 1 nil nil}
                                 [] west then
                                    {Move TX TY TT {Append Positions [pos(x:NewX-1 y:NewY to:To)]} pos(x:X y:Y to:To) 1 nil nil}
                                 [] north then
                                    {Move TX TY TT {Append Positions [pos(x:NewX y:NewY-1 to:To)]} pos(x:X y:Y to:To) 1 nil nil}
                                 [] south then
                                    {Move TX TY TT {Append Positions [pos(x:NewX y:NewY+1 to:To)]} pos(x:X y:Y to:To) 1 nil nil}
                                 end
                              
                              [] turn(left) then
                                 case To of east then
                                    {Move TX TY TT {Append Positions [pos(x:NewX+1 y:NewY to:north)]} pos(x:X y:Y to:To) 1 nil nil}
                                 [] west then
                                    {Move TX TY TT {Append Positions [pos(x:NewX-1 y:NewY to:south)]} pos(x:X y:Y to:To) 1 nil nil}
                                 [] south then
                                    {Move TX TY TT {Append Positions [pos(x:NewX y:NewY+1 to:east)]} pos(x:X y:Y to:To) 1 nil nil}
                                 [] north then
                                    {Move TX TY TT {Append Positions [pos(x:NewX y:NewY-1 to:west)]} pos(x:X y:Y to:To) 1 nil nil}
                                 end
                              [] turn(right) then
                                 case To of east then
                                    {Move TX TY TT {Append Positions [pos(x:NewX+1 y:NewY to:south)]} pos(x:X y:Y to:To) 1 nil nil}
                                 [] west then
                                    {Move TX TY TT {Append Positions [pos(x:NewX-1 y:NewY to:north)]} pos(x:X y:Y to:To) 1 nil nil}
                                 [] south then
                                    {Move TX TY TT {Append Positions [pos(x:NewX y:NewY+1 to:west)]} pos(x:X y:Y to:To) 1 nil nil}
                                 [] north then
                                    {Move TX TY TT {Append Positions [pos(x:NewX y:NewY-1 to:east)]} pos(x:X y:Y to:To) 1 nil nil}
                                 end
                              end
                           end
                        [] revert then
                           local FirstTemp SecondTemp in
                              %On reverse et clear l'effet dans le spaceship temporaire
                              {AdjoinList Spaceship [positions#{Revert Spaceship.positions nil}] FirstTemp}
                              {AdjoinList FirstTemp [effects#{List.drop FirstTemp.effects 1}] SecondTemp}
                              {Move {ParseSpaceShipPositionX SecondTemp.positions nil} {ParseSpaceShipPositionY SecondTemp.positions nil} {ParseSpaceShipDirection SecondTemp.positions nil} nil nil 0 Direction SecondTemp}
                           end
                        [] scrap then
                           local FirstTemp SecondTemp in 
                              {AdjoinList Spaceship [positions#{Scrap Spaceship.positions nil nil}] FirstTemp}
                              {AdjoinList FirstTemp [effects#{List.drop FirstTemp.effects 1}] SecondTemp}
                              {Move {ParseSpaceShipPositionX SecondTemp.positions nil} {ParseSpaceShipPositionY SecondTemp.positions nil} {ParseSpaceShipDirection SecondTemp.positions nil} nil nil 0 Direction FirstTemp}
                           end
                        end
                     end
                  [] 1 then
                     {Move TX TY TT {Append Positions [Last]} pos(x:X y:Y to:To) 1 nil nil}
                  end
               end
            end
         end
      end



      
      
      fun {CreateNewListNTimes Lst Count R}
         if Count =< 0 then R else {CreateNewListNTimes Lst Count-1 {Append R Lst}} end
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
                  {DecodeStrategyAux {Append {CreateNewListNTimes H.1 H.times nil} T} R}
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
                     

      fun {Next Spaceship Instruction}
         {Browse Spaceship.positions}
         {Browse Spaceship.effects}
         % Spaceship is a record
         % La manière la plus évdidente est de faire des case
         % On commence les cases pour l'instruction et on va parse les records du spaceship    
         % Il faut créer un nouveau spaceship I guess
         % On commence par les case pattern sur l'instruction
         local NewSpaceShip FinalSpaceship in
            case Spaceship.effects of nil then 
               {AdjoinList Spaceship [positions#{Move {ParseSpaceShipPositionX Spaceship.positions nil} {ParseSpaceShipPositionY Spaceship.positions nil} {ParseSpaceShipDirection Spaceship.positions nil} nil nil 0 Instruction Spaceship}] FinalSpaceship}
               {Browse FinalSpaceship.effects}
            []H|T then
               case {Label H} of wormhole then
                  {AdjoinList Spaceship [positions#{Move {ParseSpaceShipPositionX Spaceship.positions nil} {ParseSpaceShipPositionY Spaceship.positions nil} {ParseSpaceShipDirection Spaceship.positions nil} nil nil 0 Instruction Spaceship}] NewSpaceShip}
                  {AdjoinList NewSpaceShip [effects#{List.drop Spaceship.effects 1}] FinalSpaceship}
               [] revert then
                  {AdjoinList Spaceship [positions#{Move {ParseSpaceShipPositionX Spaceship.positions nil} {ParseSpaceShipPositionY Spaceship.positions nil} {ParseSpaceShipDirection Spaceship.positions nil} nil nil 0 Instruction Spaceship}] NewSpaceShip}
                  {Browse NewSpaceShip.effects}
                  %On clear l'effet dans le spaceship de retour
                  {AdjoinList NewSpaceShip [effects#{List.drop NewSpaceShip.effects 1}] FinalSpaceship}
               [] scrap then
                  {AdjoinList Spaceship [positions#{Move {ParseSpaceShipPositionX Spaceship.positions nil} {ParseSpaceShipPositionY Spaceship.positions nil} {ParseSpaceShipDirection Spaceship.positions nil} nil nil 0 Instruction Spaceship}] FinalSpaceship}
               end
            end
            FinalSpaceship
         end
            % Faut faire gaffe à la direction, c'est tout
         
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
		   scenario:'scenario/scenario_test_grow.oz'
		   % Utilisez cette touche pour quitter la fenêtre
		   % Use this key to leave the graphical mode
		   closeKey:'Escape'
		   % Visualisation de la partie
		   % Graphical mode
		   debug: true
		   % Instants par seconde, 0 spécifie une exécution pas à pas. (appuyer sur 'Espace' fait avancer le jeu d'un pas)
		   % Steps per second, 0 for step by step. (press 'Space' to go one step further)
		   frameRate: 0
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