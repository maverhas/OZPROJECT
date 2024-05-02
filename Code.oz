
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
      Destroy
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


   %    fun {Bomb Spaceship DropLst}
   %       {AdjoinAt Spaceship seismicCharge {List.append DropLst Spaceship.seismicCharge}}
   %   end

     fun {Destroy Positions R}
      % Fonction appliquant le pouvoir suivant
      % -> Destruction de la queue des vaisseaux adverses (ne peut se produire que si la taille du vaisseau >= 2)
      {Browse Positions}
      case Positions of H|T then
         if T == nil then
            R
         else
            {Destroy T {Append R [H]}}
         end
      end
     end

      fun {Scrap Positions R Last}
         %Fonction permettant d'appliquer le pouvoir suivant
         % -> Ajout d'un wagon à la fin du vaisseau qui arrive sur la case contenant le pouvoir
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
         [] H|T then 
            {Scrap T {Append R [H]} H}
         end
      end

      fun {Revert Positions R}
         % Fonction appliquant le pouvoir suivant
         % -> Inverse la tête et la queue du vaisseau, en inversant également la direction de la tête
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

      fun {Move ListX ListY ListTo Positions Last Set Direction Spaceship Effects UpdatedEffect}
         % Fonctionnement général de la fonction : Nous regardons si des effets sont présents; si oui, nous les appliquons.
         % Autrement, nous appliquons l'instruction Direction à la tête, et à chaque itération i, le wagon i prend l'ancienne position du wagon i-1

         % ListX : Coordonnées X des positions de chaque wagon du vaisseau, créé grâce à ParseSpaceshipX
         % ListY : Coordonnées Y des positions de chaque wagon du vaisseau, créé grâce à ParseSpaceshipY
         % ListTo : Liste des orientations de chaque wagon du vaisseau, créé grâce à ParseSpaceshipDirection
         % Positions : Paramètre stockant après chaque itération i de la fonction move, la nouvelle position du wagon i du vaisseau
         % Last : Paramètre permettant de stocker la position du wagon précédemment visité, afin de bouger à l'itération i le wagon i à l'ancienne position du wagon i-1
         % Set : Un flag qui permet de déterminer si on travaille sur la tête du vaisseau ou sur les wagons
         % Direction : La direction donnée pour ce tour (forward, turn(left) ou turn(right))
         % Spaceship : Le Spaceship sur lequel nous travaillons
         % Effects : La liste d'effets associée au Spaceship
         % UpdatedEffect : Paramètre permettant de stocker la liste des effets du vaisseau actualisée après application des pouvoirs 
         % Fonction qui gère les déplacements du vaisseau
         case ListX of nil then % Si la liste des positions est vide alors on a fait bouger chaque partie du vaisseau et appliqué tous les effets,
                                % on update la position du vaisseau ainsi que ses effets et on retourne le nouveau vaisseau
            local FirstTemp SecondTemp in
               {AdjoinList Spaceship [positions#Positions] FirstTemp}
               {AdjoinList FirstTemp [effects#UpdatedEffect] SecondTemp}
               SecondTemp
            end 
         [] X|TX then
            case ListY of nil then 1
            [] Y|TY then
               case ListTo of nil then  1
               []To|TT then
                  case Set of 0 then % On travaill sur la tête
                     case Effects of nil then % Cas dans lequel tous les effets ont été appliqués, on applique juste l'instruction
                        case Direction of forward then
                           case To of east then
                              {Move TX TY TT {Append Positions [pos(x:X+1 y:Y to:To)]} pos(x:X y:Y to:To) 1 nil Spaceship Effects UpdatedEffect}
                           [] west then
                              {Move TX TY TT {Append Positions [pos(x:X-1 y:Y to:To)]} pos(x:X y:Y to:To) 1 nil Spaceship Effects UpdatedEffect}
                           [] north then
                              {Move TX TY TT {Append Positions [pos(x:X y:Y-1 to:To)]} pos(x:X y:Y to:To) 1 nil Spaceship Effects UpdatedEffect}
                           [] south then
                              {Move TX TY TT {Append Positions [pos(x:X y:Y+1 to:To)]} pos(x:X y:Y to:To) 1 nil Spaceship Effects UpdatedEffect}
                           end
                        
                        [] turn(left) then
                           case To of east then
                              {Move TX TY TT {Append Positions [pos(x:X y:Y-1 to:north)]} pos(x:X y:Y to:To) 1 nil Spaceship Effects UpdatedEffect}
                           [] west then
                              {Move TX TY TT {Append Positions [pos(x:X y:Y+1 to:south)]} pos(x:X y:Y to:To) 1 nil Spaceship Effects UpdatedEffect}
                           [] south then
                              {Move TX TY TT {Append Positions [pos(x:X+1 y:Y to:east)]} pos(x:X y:Y to:To) 1 nil Spaceship Effects UpdatedEffect}
                           [] north then
                              {Move TX TY TT {Append Positions [pos(x:X-1 y:Y to:west)]} pos(x:X y:Y to:To) 1 nil Spaceship Effects UpdatedEffect}
                           end
                        [] turn(right) then
                           {Browse Spaceship.positions}
                           case To of east then
                              {Move TX TY TT {Append Positions [pos(x:X y:Y+1 to:south)]} pos(x:X y:Y to:To) 1 nil Spaceship Effects UpdatedEffect}
                           [] west then
                              {Move TX TY TT {Append Positions [pos(x:X y:Y-1 to:north)]} pos(x:X y:Y to:To) 1 nil Spaceship Effects UpdatedEffect}
                           [] south then
                              {Move TX TY TT {Append Positions [pos(x:X-1 y:Y to:west)]} pos(x:X y:Y to:To) 1 nil Spaceship Effects UpdatedEffect}
                           [] north then
                              {Move TX TY TT {Append Positions [pos(x:X+1 y:Y to:east)]} pos(x:X y:Y to:To) 1 nil Spaceship Effects UpdatedEffect}
                           end
                        end
                     []H|T then % Il y'a des effets à appliquer, on les applique puis on commence à se charger des instructions
                                % Dans chaque case on s'occupe d'un effet, puis on relance move avec l'effets suivant s'il existe, sinon on fait comme ci-dessus
                        case {Label H} of wormhole then
                           local NewX NewY in 
                              NewX = H.x
                              NewY = H.y
                              case Direction of forward then
                                 case To of east then
                                    {Move TX TY TT {Append Positions [pos(x:NewX+1 y:NewY to:To)]} pos(x:X y:Y to:To) 1 nil Spaceship T UpdatedEffect} 
                                 [] west then
                                    {Move TX TY TT {Append Positions [pos(x:NewX-1 y:NewY to:To)]} pos(x:X y:Y to:To) 1 nil Spaceship T UpdatedEffect}
                                 [] north then
                                    {Move TX TY TT {Append Positions [pos(x:NewX y:NewY-1 to:To)]} pos(x:X y:Y to:To) 1 nil Spaceship T UpdatedEffect}
                                 [] south then
                                    {Move TX TY TT {Append Positions [pos(x:NewX y:NewY+1 to:To)]} pos(x:X y:Y to:To) 1 nil Spaceship T UpdatedEffect}
                                 end
                              
                              [] turn(left) then
                                 case To of east then
                                    {Move TX TY TT {Append Positions [pos(x:NewX+1 y:NewY to:north)]} pos(x:X y:Y to:To) 1 nil Spaceship T UpdatedEffect}
                                 [] west then
                                    {Move TX TY TT {Append Positions [pos(x:NewX-1 y:NewY to:south)]} pos(x:X y:Y to:To) 1 nil Spaceship T UpdatedEffect}
                                 [] south then
                                    {Move TX TY TT {Append Positions [pos(x:NewX y:NewY+1 to:east)]} pos(x:X y:Y to:To) 1 nil Spaceship T UpdatedEffect}
                                 [] north then
                                    {Move TX TY TT {Append Positions [pos(x:NewX y:NewY-1 to:west)]} pos(x:X y:Y to:To) 1 nil Spaceship T UpdatedEffect}
                                 end
                              [] turn(right) then
                                 case To of east then
                                    {Move TX TY TT {Append Positions [pos(x:NewX+1 y:NewY to:south)]} pos(x:X y:Y to:To) 1 nil Spaceship T UpdatedEffect}
                                 [] west then
                                    {Move TX TY TT {Append Positions [pos(x:NewX-1 y:NewY to:north)]} pos(x:X y:Y to:To) 1 nil Spaceship T UpdatedEffect}
                                 [] south then
                                    {Move TX TY TT {Append Positions [pos(x:NewX y:NewY+1 to:west)]} pos(x:X y:Y to:To) 1 nil Spaceship T UpdatedEffect}
                                 [] north then
                                    {Move TX TY TT {Append Positions [pos(x:NewX y:NewY-1 to:east)]} pos(x:X y:Y to:To) 1 nil Spaceship T UpdatedEffect}
                                 end
                              end
                           end
                        [] revert then
                           local FirstTemp in
                              %On reverse et clear l'effet dans le spaceship temporaire
                              {AdjoinList Spaceship [positions#{Revert Spaceship.positions nil}] FirstTemp}
                              % {AdjoinList FirstTemp [effects#{List.drop FirstTemp.effects 1}] SecondTemp}
                              {Move {ParseSpaceShipPositionX FirstTemp.positions nil} {ParseSpaceShipPositionY FirstTemp.positions nil} {ParseSpaceShipDirection FirstTemp.positions nil} nil nil 0 Direction FirstTemp T UpdatedEffect}
                           end
                        [] scrap then
                           local FirstTemp in 
                              {AdjoinList Spaceship [positions#{Scrap Spaceship.positions nil nil}] FirstTemp}
                              % {AdjoinList FirstTemp [effects#{List.drop FirstTemp.effects 1}] SecondTemp}
                              {Move {ParseSpaceShipPositionX FirstTemp.positions nil} {ParseSpaceShipPositionY FirstTemp.positions nil} {ParseSpaceShipDirection FirstTemp.positions nil} nil nil 0 Direction FirstTemp T UpdatedEffect}
                           end
                        [] malware then
                           % ca viendra ici
                           % {AdjoinList Spaceship [effects#H.] FirstTemp}
                           local NewMalware in
                              if H.n > 0 then
                                 NewMalware = malware(n:H.n-1)
                                 case Direction of turn(left) then
                                    {Move {ParseSpaceShipPositionX Spaceship.positions nil} {ParseSpaceShipPositionY Spaceship.positions nil} {ParseSpaceShipDirection Spaceship.positions nil} nil nil 0 turn(right) Spaceship T {Append UpdatedEffect [NewMalware]}}
                                 [] turn(right) then
                                    {Move {ParseSpaceShipPositionX Spaceship.positions nil} {ParseSpaceShipPositionY Spaceship.positions nil} {ParseSpaceShipDirection Spaceship.positions nil} nil nil 0 turn(left) Spaceship T {Append UpdatedEffect [NewMalware]}}
                                 [] forward then
                                    {Move {ParseSpaceShipPositionX Spaceship.positions nil} {ParseSpaceShipPositionY Spaceship.positions nil} {ParseSpaceShipDirection Spaceship.positions nil} nil nil 0 Direction Spaceship T {Append UpdatedEffect [NewMalware]}}
                                 end
                              else
                                 {Move {ParseSpaceShipPositionX Spaceship.positions nil} {ParseSpaceShipPositionY Spaceship.positions nil} {ParseSpaceShipDirection Spaceship.positions nil} nil nil 0 Direction Spaceship T UpdatedEffect}
                              end
                           end
                        [] dropSeismicCharge then
                           local FirstTemp in 
                              {Browse H.1}
                              {AdjoinList Spaceship [seismicCharge#H.1] FirstTemp}
                              {Move {ParseSpaceShipPositionX FirstTemp.positions nil} {ParseSpaceShipPositionY FirstTemp.positions nil} {ParseSpaceShipDirection FirstTemp.positions nil} nil nil 0 Direction FirstTemp T UpdatedEffect}
                           end
                        [] destroy then % c'est ma copine qui y a pensé (Anaïs (la plus belle de toutes les femmes))
                           if {Length Spaceship.positions} > 2 then
                              local FirstTemp in
                                 {AdjoinList Spaceship [positions#{Destroy Spaceship.positions nil}] FirstTemp}
                                 {Browse FirstTemp.positions}
                                 {Move {ParseSpaceShipPositionX FirstTemp.positions nil} {ParseSpaceShipPositionY FirstTemp.positions nil} {ParseSpaceShipDirection FirstTemp.positions nil} nil nil 0 Direction FirstTemp T UpdatedEffect}
                              end
                           else
                              {Move {ParseSpaceShipPositionX Spaceship.positions nil} {ParseSpaceShipPositionY Spaceship.positions nil} {ParseSpaceShipDirection Spaceship.positions nil} nil nil 0 Direction Spaceship T UpdatedEffect}
                           end
                        end
                     end
                  [] 1 then
                     {Move TX TY TT {Append Positions [Last]} pos(x:X y:Y to:To) 1 nil Spaceship Effects UpdatedEffect}
                  end
               end
            end
         end
      end



      
      
      fun {CreateNewListNTimes Lst Count R}
         % Fonction pour créer une liste qui est n fois la list Lst copiée
         if Count =< 0 then R else {CreateNewListNTimes Lst Count-1 {Append R Lst}} end
      end
      fun {DecodeStrategyAux Strategy R} 
         % Fonction auxiliaire à décode strategy
         % Retourne dans R une liste de fonctions appelant Next, avec l'instruction voulue
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

      %  3 fonctions de parsing qui retournent des listes des cooronnées x, y des positions de chaque wagon ainsi que leur orientation

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
                     

      fun {Next Spaceship Instruction} % Fonction Next qui retourne le nouveau SpaceShip, qui fait appelle à la fonction Move et le SpaceShip qu'elle retourne
         local NewSpaceShip in
            NewSpaceShip = {Move {ParseSpaceShipPositionX Spaceship.positions nil} {ParseSpaceShipPositionY Spaceship.positions nil} {ParseSpaceShipDirection Spaceship.positions nil} nil nil 0 Instruction Spaceship Spaceship.effects nil}
            NewSpaceShip
         end
         
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
      fun {DecodeStrategy Strategy} % Appelle la fonction auxiliaire de DecodeStrategy
         case Strategy of nil then nil
         [] H|T then {DecodeStrategyAux Strategy nil}
         end
      end

      % Options
      Options = options(
		   % Fichier contenant le scénario (depuis Dossier)
		   % Path of the scenario (relative to Dossier)
		   scenario:'scenario/scenario_crazy.oz'
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