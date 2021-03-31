#First, look for a portal entity to eradicate. First to the positive x, y, and z...
execute store success storage immersive_transit:current_portal gate_needs_busting byte 1 run tag @e[tag=immersive_transit_gate_bustable,dx=2,dy=2,dz=2,limit=1,sort=nearest] add gate_to_bust
#...then to the negative x, y, and z, but only if we haven't alredy found one.
execute unless data storage immersive_transit:current_portal {gate_needs_busting:1b} store success storage immersive_transit:current_portal gate_needs_busting byte 1 run tag @e[tag=immersive_transit_gate_bustable,dx=-2,dy=-2,dz=-2,limit=1,sort=nearest] add gate_to_bust
#Remove the portal cluster from existance
execute if data storage immersive_transit:current_portal {gate_needs_busting:1b} as @e[tag=gate_to_bust,limit=1,sort=nearest] at @s run portal eradicate_portal_cluster
#If it finds a portal to remove, give the player their nether star back. Reluctantly.
execute if data storage immersive_transit:current_portal {gate_needs_busting:1b} at @e[distance=0..3,limit=1,sort=nearest,nbt={Item:{id:"minecraft:tnt",tag:{display:{Name:'{"text":"GateBuster"}'}}}}] run summon minecraft:item ~ ~ ~ {Item:{id:"nether_star",Count:1}}
#Then, it kills any nearby GateBuster TNT item entities,
execute run kill @e[distance=0..3,nbt={Item:{id:"minecraft:tnt",tag:{display:{Name:'{"text":"GateBuster"}'}}}}]
#And any nearby experience bottles. Then, since we summoned it with only one tick to live, it explodes in a shower of sparks, damaging any players too close.
execute run kill @e[distance=0..3,type=minecraft:experience_bottle]
#Remove the data from the earlier test
data remove storage immersive_transit:current_portal gate_needs_busting 
#Now, we're left with a clean slate, no items, no experience orbs, no stray portals, and no misleading data.