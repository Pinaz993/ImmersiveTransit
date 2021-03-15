#Move the placeholder .5 in the positive X direction.
execute as @e[tag=transit_placeholder] at @e[tag=transit_placeholder] run tp @s ~.5 ~ ~
#Decriment the counter by one.
scoreboard players remove immersive_transit x_counter 1
#Loop unless the counter is at or below 0.
execute unless score immersive_transit x_counter matches ..0 run function immersive_transit:move_dest_x
#Anything put after the loop line will still be done as many times as this function is fired.