#Context: script is to be run at and as a newly generated immersive_portals.general_breakable_portal. Thus, @s is the current portal.
#Summon a marker out of the way, and put a tag on it as a callback.
summon minecraft:armor_stand ~ ~15 ~ {Marker:true,Tags:["transit_placeholder"]}
#Get the coordinates of a lodestone from the compass in the offhand of the nearest player, and set the locating NBT in our marker to that location.
execute store result entity @e[tag=transit_placeholder,limit=1] Pos[0] double 1 run data get entity @p Inventory[{Slot:-106b}].tag.LodestonePos.X
execute store result entity @e[tag=transit_placeholder,limit=1] Pos[1] double 1 run data get entity @p Inventory[{Slot:-106b}].tag.LodestonePos.Y
execute store result entity @e[tag=transit_placeholder,limit=1] Pos[2] double 1 run data get entity @p Inventory[{Slot:-106b}].tag.LodestonePos.Z
#Move the placeholder based on the height, width, and their respecive axes. The destination will end up such that the lodestone will be adjacent to the lower north-west corner block of the portal.
#Or alternately, "A loop! A loop! My kingdom for a for-loop!"
execute if entity @s[nbt={axisHX:1.0d}] run function immersive_transit:h_axis_x
execute if entity @s[nbt={axisHY:1.0d}] run function immersive_transit:h_axis_y
execute if entity @s[nbt={axisHZ:1.0d}] run function immersive_transit:h_axis_z
execute if entity @s[nbt={axisWX:1.0d}] run function immersive_transit:w_axis_x
execute if entity @s[nbt={axisWY:1.0d}] run function immersive_transit:w_axis_y
execute if entity @s[nbt={axisWZ:1.0d}] run function immersive_transit:w_axis_z
#Move the placeholder one more to the positive X, to make sure the lodestone is not IN the portal.
execute as @e[tag=transit_placeholder] at @e[tag=transit_placeholder] run tp @s ~1 ~ ~
#Set the portal's destination to be at our placeholder
portal set_portal_destination_to @e[tag=transit_placeholder,limit=1]
#Get rid of the placeholder.
kill @e[tag=transit_placeholder]
#Make the current portal unbreakable.
portal set_portal_nbt {unbreakable:true}
#Complete the portal cluster.
portal complete_bi_way_bi_faced_portal
#Get rid of all the fake blocks placed by the original portal generation.
fill ~15 ~15 ~15 ~-15 ~-15 ~-15 air replace immersive_portals:nether_portal_block