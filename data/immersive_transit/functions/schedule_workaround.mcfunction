#This file is needed because as the schedule command makes a new function chain, it's run as the server, and at 0,0,0. Thus, our suprise tool.
execute as @e[tag=immersive_transit_current_portal] at @s run function immersive_transit:check_for_portal_at_destination
#End of workaround. End of function chain. 