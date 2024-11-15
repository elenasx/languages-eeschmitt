# 5 Houses Logic Problem in Prolog

### Prolog program will be solving this logic problem
There are five houses lined up next to each other along a street. Each house is a different color, and each homeowner is of a different nationality, drinks a different beverage, smokes a different brand of cigar, and owns a different pet.

If these variables can never repeat from house to house, which homeowner has a pet fish? You should be able to figure out the answer based on these 15 clues:

1. The Englishman lives in the house with red walls.
2. The Swede keeps dogs.
3. The Dane drinks tea.
4. The house with green walls is just to the left of the house with white walls.
5. The owner of the house with green walls drinks coffee.
6. The man who smokes Pall Mall keeps birds.
7. The owner of the house with yellow walls smokes Dunhills.
8. The man in the center house drinks milk.
9. The Norwegian lives in the first house.
10. The Blend smoker has a neighbor who keeps cats.
11. The man who smokes Blue Masters drinks beer.
12. The man who keeps horses lives next to the Dunhill smoker.
13. The German smokes Prince.
14. The Norwegian lives next to the house with blue walls.
15. The Blend smoker has a neighbor who drinks water.

Problem from: https://www.mentalfloss.com/article/638892/can-you-solve-einstein-house-riddle

According to the article, the correct answer for who owns the fish should be the german.


### Solving:
Each house will have a number, color, nationality, beverage, cigar, and pet.

#### Current clues written:
```pl
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
    neighbor(house(_, _, _, _, blend, _), house(_, _, _, water, _, _), Houses).
```

### ChatGPT Conversation:
I am trying to solve the five houses problem in prolog and I have written down the following clues:
How should I define the neighbor and what would I need in order for the program to solve for which nationality owns the fish?

#### ChatGPT: 
To solve the Five Houses problem in Prolog, you are already on the right track by defining the necessary clues. The core idea is to use the facts and relations provided by the clues to deduce the nationality of the person who owns the fish, which is the key to this puzzle. Below, I'll explain how the neighbor/3 predicate works and describe how the program works to solve the puzzle.

#### Understanding the neighbor/3 Predicate

In the Five Houses problem, neighbor/3 is used to express the relationship between two houses that are adjacent. Here's a breakdown of how the neighbor/3 predicate works:
```pl
neighbor(House1, House2, [House1, House2 | _]).
```
This rule states that if House1 and House2 are adjacent and they appear consecutively at the start of the list (i.e., House1 is first and House2 is second), then they are neighbors. The rest of the list is ignored with the [_] part.
```pl
neighbor(House1, House2, [House2, House1 | _]).
```
This is similar to the first clause, but it checks if House1 and House2 appear in reverse order (i.e., House2 is first, and House1 is second). This allows for flexibility in how the houses are represented.
```pl
neighbor(House1, House2, [_ | Rest]) :- neighbor(House1, House2, Rest).
```
If the first two clauses don't match, this recursive rule looks through the rest of the list to find the houses that are neighbors. It checks the rest of the list after skipping the first element (using [_ | Rest]), continuing the search in Rest.

The neighbor/3 predicate allows us to establish the adjacency relationship between houses in the list, which is a crucial part of solving the puzzle.

Step-by-Step Explanation:

    Defining Houses:
```pl
Houses = [house(1, Color1, Nationality1, Beverage1, Cigar1, Pet1), 
          house(2, Color2, Nationality2, Beverage2, Cigar2, Pet2), 
          house(3, Color3, Nationality3, Beverage3, Cigar3, Pet3),
          house(4, Color4, Nationality4, Beverage4, Cigar4, Pet4), 
          house(5, Color5, Nationality5, Beverage5, Cigar5, Pet5)],
```
The Houses list contains 5 elements, each representing a house. Each house has:

    A number (1 to 5)
    A color (Color1, Color2, ..., Color5)
    A nationality (Nationality1, Nationality2, ..., Nationality5)
    A beverage (Beverage1, Beverage2, ..., Beverage5)
    A cigar (Cigar1, Cigar2, ..., Cigar5)
    A pet (Pet1, Pet2, ..., Pet5)

These variables are used to match against the clues provided in the problem.

Clues: Each of the clues (Clue 1 to Clue 15) uses the member/2 predicate to check for the presence of certain conditions in the Houses list. For example:
```pl
member(house(_, red, englishman, _, _, _), Houses),
```
This matches a house that is red and belongs to the Englishman.

Similarly, other clues establish relationships like the color of houses, the beverage they drink, their pets, cigars, and the adjacency of certain houses.

Finding the Fish Owner: At the end of the solve/1 predicate, the program looks for the house where the pet is a fish:
```pl
member(house(_, _, FishOwner, _, _, fish), Houses).
```
This finds the house where the pet is a fish, and FishOwner will be unified with the nationality of the person who owns the fish.

The Program Execution: After running all the clues, Prolog will attempt to satisfy all the constraints and will return the nationality of the person who owns the fish. Based on the logic of the problem, the answer will be german.