#Move the placeholder based on the height, width, and their respecive axes. The marker will end up such that the lodestone will be adjacent to the lower north-west corner block of the portal.
#Or alternately, "A loop! A loop! My kingdom for a for-loop!"
execute if entity @s[nbt={axisHX:1.0d}] run function immersive_transit:h_axis_x
execute if entity @s[nbt={axisHY:1.0d}] run function immersive_transit:h_axis_y
execute if entity @s[nbt={axisHZ:1.0d}] run function immersive_transit:h_axis_z
execute if entity @s[nbt={axisWX:1.0d}] run function immersive_transit:w_axis_x
execute if entity @s[nbt={axisWY:1.0d}] run function immersive_transit:w_axis_y
execute if entity @s[nbt={axisWZ:1.0d}] run function immersive_transit:w_axis_z
#Set the portal's destination to be at our placeholder
portal set_portal_destination_to @e[tag=transit_placeholder,limit=1]
#Make the current portal unbreakable.
portal set_portal_nbt {unbreakable:true}
#Complete the portal cluster.
portal complete_bi_way_bi_faced_portal
#Mark the portal entities on both sides so that they qualify for gate-bustification
tag @s add immersive_transit_gate_bustable
tag @e[type=immersive_portals:portal,dx=1,dy=1,dz=1] add immersive_transit_gate_bustable
execute at @e[tag=transit_placeholder] run tag @e[type=immersive_portals:portal,dx=1,dy=1,dz=1] add immersive_transit_gate_bustable
#Eat the nether star (unless they're in creative or spectator).
execute unless data entity @p {playerGameType:1} unless data entity @p {playerGameType:3} run clear @p minecraft:nether_star 1
#Let the player know that it worked.
tellraw @p "Portal linked successfully."
#End of linking procedure. Back to check_for_portal_at_destination