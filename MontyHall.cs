/**
 * MontyHall.cs
 *
 * Example Monty Hall problem simulation.
 * usage: csc MontyHall.cs && ./MontyHall
 *
 * @author Maxamilian Demian
 * @link https://www.maxodev.org
 * @link https://github.com/Maxoplata/MontyHall
 */
using System;

class MontyHall {
	static void Main() {
		// The number of times to run for each choice (keep and change will run numberOfRuns times EACH)
		int numberOfRuns = 1000000;

		int keepWins = 0;
		int keepLosses = 0;
		int changeWins = 0;
		int changeLosses = 0;

		// seed rng
		Random rnd = new Random();

		// loop numberOfRuns without changing our initial door selection
		for (int i = 0; i < numberOfRuns; i++) {
			// pick a winning door between 1 and 3
			int winningDoor = rnd.Next(1, 4);

			// player selects a random door between 1 and 3
			int playerDoor = rnd.Next(1, 4);

			if (playerDoor == winningDoor) {
				// player chose the winning door
				keepWins++;
			} else {
				// player chose a losing door
				keepLosses++;
			}
		}

		// loop numberOfRuns while changing our initial door selection
		for (int i = 0; i < numberOfRuns; i++) {
			// pick a winning door between 1 and 3
			int winningDoor = rnd.Next(1, 4);

			// player selects a random door between 1 and 3
			int playerDoor = rnd.Next(1, 4);

			if (playerDoor == winningDoor) {
				// player chose the winning door already, count it as a loss as the player will be changing
				changeLosses++;
			} else {
				/* if the player HAS NOT chosen the winning door already and they change, they will win
				 * example:
				 * - player chooses door 1
				 * - winning door is door 3
				 * - host opens door 2 showing a goat
				 * - player switches to door 3 and wins
				 *
				 * every variation of this will win since we have already eliminated the aspect of the player
				 * having already picked the winning door
				 */
				changeWins++;
			}
		}

		Console.WriteLine("Keep Wins/Losses: {0}/{1} ({2}% wins)", keepWins, keepLosses, (((float) keepWins / numberOfRuns) * 100));
		Console.WriteLine("Change Wins/Losses: {0}/{1} ({2}% wins)", changeWins, changeLosses, (((float) changeWins / numberOfRuns) * 100));
	}
}
