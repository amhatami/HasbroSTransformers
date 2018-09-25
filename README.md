# IOS - Swift - Hasbro's Transformers
Simple Game of Battle between Autobots and the Decepticons that you have created and displays by Collection View and Winner will find based on below basics rules. 

##  The basic rules of the battle are:

● The teams should be sorted by rank and faced off one on one against each other in order to determine a victor, the loser is eliminated

● A battle between opponents uses the following rules:

	○ If any fighter is down 4 or more points of courage and 3 or more points of strength compared to their opponent, the opponent automatically wins the face-off regardless of overall rating (opponent has ran away)
	
	○ Otherwise, if one of the fighters is 3 or more points of skill above their opponent, they win the fight regardless of overall rating
	
	○ The winner is the Transformer with the highest overall rating
	
● In the event of a tie, both Transformers are considered destroyed

● Any Transformers who don’t have a fight are skipped (i.e. if it’s a team of 2 vs. a team of 1, there’s only going to be one battle)

● The team who eliminated the largest number of the opposing team is the winner 
Special rules

● Any Transformer named Optimus Prime or Predaking wins his fight automatically regardless of
any other criteria

● In the event either of the above face each other (or a duplicate of each other), the game immediately ends with all competitors destroyed

 For example, given the following input:
 
Soundwave, D, 8,9,2,6,7,5,6,10
Bluestreak, A, 6,6,7,9,5,2,9,7
Hubcap: A, 4,4,4,4,4,4,4,4

 The output should be :
 
1 battle
Winning team (Decepticons): Soundwave
Survivors from the losing team (Autobots): Hubcap

## Requirements

- iOS 10.0 , 11.4, 12.0
- Xcode 10.0
- Swift 4.2

## Usage

You'll need to Add trasformrs and then start the game

##### For additionnal info, please watch the video : [YouTube Tutorial]()

## License

Available under the MIT license. See the LICENSE file for more info.
