#execute as @e[type=minecraft:experience_bottle] at @s if entity @e[distance=5,nbt={Item:{tag:{display:{Name:'{"text":"GateBuster"}'}}}}] run summon firework_rocket ~ ~ ~ {Tags:["immersive_transit_gate_buster_explosive"],LifeTime:1,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Flight:1,Explosions:[{Type:1,Flicker:0,Trail:0,Colors:[I;14602026,15435844,15790320],FadeColors:[I;11743532]}]}}}}
tellraw Pinaz993 "running"