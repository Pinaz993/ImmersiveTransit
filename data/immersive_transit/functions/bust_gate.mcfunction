#First, look for a portal entity to eradicate.
execute if entity @e[tag=immersive_transit_gate_bustable,dx=2,dy=2,dz=2,sort=nearest] run data modify storage immersive_transit:current_portal gate_needs_busting set value 1b
#I wouldn't have to do this if /portal would tell me if it succeeded or not, but then again, I can't give qouteall that much grief for such a small flaw.
#Remove the portal cluster from existance
execute if data storage immersive_transit:current_portal {gate_needs_busting:1b} as @e[tag=immersive_transit_gate_bustable,dx=2,dy=2,dz=2,limit=1,sort=nearest] at @s run portal eradicate_portal_cluster
#If it finds a portal to remove, give the player their nether star back. Reluctantly.
execute if data storage immersive_transit:current_portal {gate_needs_busting:1b} at @e[distance=0..3,limit=1,sort=nearest,nbt={Item:{id:"minecraft:tnt",tag:{display:{Name:'{"text":"GateBuster"}'}}}}] run summon minecraft:item ~ ~ ~ {Item:{id:"nether_star",Count:1}}
#Then, it kills any nearby GateBuster TNT item entities,
execute as @e[type=minecraft:firework_rocket,tag=immersive_transit_gate_buster_explosive] at @s run kill @e[distance=0..3,nbt={Item:{id:"minecraft:tnt",tag:{display:{Name:'{"text":"GateBuster"}'}}}}]
#And any nearby experience bottles. Then, since we summoned it with only one tick to live, it explodes in a shower of sparks, damaging any players too close.
execute as @e[type=minecraft:firework_rocket,tag=immersive_transit_gate_buster_explosive] at @s run kill @e[distance=0..3,type=minecraft:experience_bottle]
#Remove the data from the earlier test
data remove storage immersive_transit:current_portal gate_needs_busting 
#Now, we're left with a clean slate, no items, no experience orbs, no stray portals, and no misleading data.