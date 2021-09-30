# MontyHall.r
#
# Example Monty Hall problem simulation.
# usage: rscript MontyHall.r
#
# @author Maxamilian Demian
# @link https:#www.maxodev.org
# @link https:#github.com/Maxoplata/MontyHall

# The number of times to run for each choice (keep and change will run numberOfRuns times EACH)

numberOfRuns <- 1000000

keepWins <- 0
keepLosses <- 0
changeWins <- 0
changeLosses <- 0

# loop numberOfRuns without changing our initial door selection
for (i in 1:numberOfRuns) {
	# pick a winning door between 1 and 3
	winningDoor <- sample(1:3, 1)

	# player selects a random door between 1 and 3
	playerDoor <- sample(1:3, 1)

	if (playerDoor == winningDoor) {
		# player chose the winning door
		keepWins <- keepWins + 1
	} else {
		# player chose a losing door
		keepLosses <- keepLosses + 1
	}
}

# loop numberOfRuns while changing our initial door selection
for (i in 1:numberOfRuns) {
	# pick a winning door between 1 and 3
	winningDoor <- sample(1:3, 1)

	# player selects a random door between 1 and 3
	playerDoor <- sample(1:3, 1)

	if (playerDoor == winningDoor) {
		# player chose the winning door already, count it as a loss as the player will be changing
		changeLosses <- changeLosses + 1
	} else {
		# if the player HAS NOT chosen the winning door already and they change, they will win
		#
		# example:
		# - player chooses door 1
		# - winning door is door 3
		# - host opens door 2 showing a goat
		# - player switches to door 3 and wins
		#
		# every variation of this will win since we have already eliminated the aspect of the player
		# having already picked the winning door

		changeWins <- changeWins + 1
	}
}

message(paste("Keep Wins/Losses: ", keepWins, "/", keepLosses, " (", ((keepWins / numberOfRuns) * 100), "% wins)", sep = ""))
message(paste("Change Wins/Losses: ", changeWins, "/", changeLosses, " (", ((changeWins / numberOfRuns) * 100), "% wins)", sep = ""))
