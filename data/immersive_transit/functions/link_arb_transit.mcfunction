#Move the placeholder based on the height, width, and their respecive axes. The marker will end up such that the lodestone will be adjacent to the lower north-west corner block of the portal.
#Or alternately, "A loop! A loop! My kingdom for a for-loop!"
execute if entity @s[nbt={axisHX:1.0d}] run function immersive_transit:h_axis_x
execute if entity @s[nbt={axisHY:1.0d}] run function immersive_transit:h_axis_y
execute if entity @s[nbt={axisHZ:1.0d}] run function immersive_transit:h_axis_z
execute if entity @s[nbt={axisWX:1.0d}] run function immersive_transit:w_axis_x
execute if entity @s[nbt={axisWY:1.0d}] run function immersive_transit:w_axis_y
execute if entity @s[nbt={axisWZ:1.0d}] run function immersive_transit:w_axis_z
#Move the placeholder one more to the positive X, to make sure the lodestone is not IN the portal.
execute as @e[tag=transit_placeholder] at @s run tp @s ~1 ~ ~
#Set the portal's destination to be at our placeholder
portal set_portal_destination_to @e[tag=transit_placeholder,limit=1]
#Get rid of the placeholder.
kill @e[tag=transit_placeholder]
#Make the current portal unbreakable.
portal set_portal_nbt {unbreakable:true}
#Complete the portal cluster.
portal complete_bi_way_bi_faced_portal
#Get rid of the suprise tool.
tag @s remove immersive_transit_current_portal
#Let the player know that it worked.
tellraw @p "Portal linked successfully."