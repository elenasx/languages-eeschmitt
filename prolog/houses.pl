% Solves the five houses problem and returns who owns the fish

solve(FishOwner) :-
    % House: number, color, nationality, beverage, cigar, pet
    Houses = [house(1, Color1, Nationality1, Beverage1, Cigar1, Pet1), 
              house(2, Color2, Nationality2, Beverage2, Cigar2, Pet2), 
              house(3, Color3, Nationality3, Beverage3, Cigar3, Pet3), 
              house(4, Color4, Nationality4, Beverage4, Cigar4, Pet4), 
              house(5, Color5, Nationality5, Beverage5, Cigar5, Pet5)],
              % Variables have to be capitals or will not work
    
    % Clue 1-3
    member(house(_, red, englishman, _, _, _), Houses),
    member(house(_, _, swede, _, _, dogs), Houses),
    member(house(_, _, dane, tea, _, _), Houses),
    
    % Clue 4
    neighbor(house(_, green, _, _, _, _), house(_, white, _, _, _, _), Houses),
    
    % Clue 5
    member(house(_, green, _, coffee, _, _), Houses),
    
    % Clue 6-9
    member(house(_, _, _, _, pallmall, birds), Houses),
    member(house(_, yellow, _, _, dunhills, _), Houses),
    member(house(3, _, _, milk, _, _), Houses),
    member(house(1, _, norwegian, _, _, _), Houses),
    
    % Clue 10
    neighbor(house(_, _, _, _, blend, _), house(_, _, _, _, _, cats), Houses),
    
    % Clue 11
    member(house(_, _, _, beer, bluemasters, _), Houses),
    
    % Clue 12
    neighbor(house(_, _, _, _, _, horses), house(_, _, _, _, dunhills, _), Houses),
    
    % Clue 13
    member(house(_, _, german, _, prince, _), Houses),
    
    % Clue 14-15
    neighbor(house(1, _, norwegian, _, _, _), house(_, blue, _, _, _, _), Houses),
    neighbor(house(_, _, _, _, blend, _), house(_, _, _, water, _, _), Houses),

    % Find who owns the fish, should be german
    member(house(_, _, FishOwner, _, _, fish), Houses).

neighbor(House1, House2, [House1, House2 | _]).
neighbor(House1, House2, [House2, House1 | _]).
neighbor(House1, House2, [_ | Rest]) :- neighbor(House1, House2, Rest).
