#This is run every tick, so let's make this lightweight. 
#We target thrown experience bottles, as they're not generally thrown around all that much.
#If one finds an item entity for a TNT named GateBuster less than 2 blocks away, it will summon a short-lived tagged fireworks rocket
#I would have made something more special, but you can't change textures or models in a data pack, and you can't specify custom NBT in a custom recipe. Will revisit if these things change.
execute as @e[type=minecraft:experience_bottle] at @s if entity @e[distance=0..1,nbt={Item:{id:"minecraft:tnt",tag:{display:{Name:'{"text":"GateBuster"}'}}}}] run execute at @e[distance=0..1,nbt={Item:{id:"minecraft:tnt",tag:{display:{Name:'{"text":"GateBuster"}'}}}}] run summon firework_rocket ~ ~.25 ~ {Tags:["immersive_transit_gate_buster_explosive"],LifeTime:1,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Flight:1,Explosions:[{Type:0,Flicker:0,Trail:0,Colors:[I;14602026,15435844,15790320],FadeColors:[I;11743532]},{Type:0,Flicker:0,Trail:0,Colors:[I;14602026,15435844,15790320],FadeColors:[I;11743532]},{Type:0,Flicker:0,Trail:0,Colors:[I;14602026,15435844,15790320],FadeColors:[I;11743532]}]}}}}
#If a properly tagged fireworks rocket exists, it will close a single set of nearby portals, refund the player, and clean up after itself, however, only on the ticks when such an entity exists.
execute store success storage immersive_transit:remove_portal portal_was_destroyed byte 1 as @e[type=minecraft:firework_rocket,tag=immersive_transit_gate_buster_explosive] at @s run function immersive_transit:bust_gate