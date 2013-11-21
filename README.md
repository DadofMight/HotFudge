HotFudge
========

A lightweight script to enable scripting commands on 
"vanilla" Minecraft SMP servers.

Commands recognized in the current version are:
  * ban
  * ban-ip
  * pardon
  * pardon-ip
  * kick
  * jail
  * unjail
  * spawn

All commands are issued in the in-game chat, and read from the
server log.  Only players who are designated on teams (using
the scoreboard system) are able to run commands.  This
provides in-game control of the staff list.  You can easily 
modify this script to accept only a subset of teams, by 
using the color code for the team.  Add that check to the regexp
for the players and you can enable access only for some teams.

Set the install directory and coords for spawn and jail, 
and you're done configuring this script. 

I recommend running this script every minute, to ensure no memory leaks, 
and provide reasonably quick response time for the players.

This script assumes you have an init.d style script for your
server, which will handle running the commands.
