#It's a suprise tool that will help us later.
tag @s add immersive_transit_current_portal
#Summon a placeholder that we can use to position the portal correctly.
summon minecraft:armor_stand ~ ~ ~ {NoGravity:true,Tags:["transit_placeholder"]}
#Set the portal's destination to the marker, basically to its own coordinates.
portal set_portal_destination_to @e[tag=transit_placeholder,limit=1]
#Set the portal's destination to the coordinates and dimension in the compass, with the goal of loading the chunk the lodestone is in.
execute store result entity @s destinationX double 1 run data get entity @p Inventory[{Slot:-106b}].tag.LodestonePos.X
execute store result entity @s destinationY double 1 run data get entity @p Inventory[{Slot:-106b}].tag.LodestonePos.Y
execute store result entity @s destinationZ double 1 run data get entity @p Inventory[{Slot:-106b}].tag.LodestonePos.Z
#Initialize an array for storing the coordinates of the lodestone. Why, you ask? Because if we apply them to the 
#placeholder one at a time, it'll be teleported into unloaded chunks, and we'll lose it.
data modify storage immersive_transit:current_portal lodestone_position set value [0d,0d,0d]
#Load the array with the coordinates.
execute store result storage immersive_transit:current_portal lodestone_position[0] double 1 run data get entity @p Inventory[{Slot:-106b}].tag.LodestonePos.X
execute store result storage immersive_transit:current_portal lodestone_position[1] double 1 run data get entity @p Inventory[{Slot:-106b}].tag.LodestonePos.Y
execute store result storage immersive_transit:current_portal lodestone_position[2] double 1 run data get entity @p Inventory[{Slot:-106b}].tag.LodestonePos.Z
#Overite the corrdinate array in the placeholder with our constructed array, thus effectively teleporting the placeholder to the lodestone in one step. 
#This methiod is prone to client server desyncs and other buggyness, but this is all we got without resorting to scarpet or other mods.
data modify entity @e[tag=transit_placeholder,limit=1] Pos set from storage immersive_transit:current_portal lodestone_position
#After time (in ticks) has been given to load the chunks, procede to locate and link up the cluster.
schedule function immersive_transit:schedule_workaround 70t replace