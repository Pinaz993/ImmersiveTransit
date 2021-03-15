#"Lieutenant! Set portal for DEATH!" "Death, sir? That's not a location." "JUST DO IT!"
portal set_portal_destination immersive_portals:alternate5 10000 -100 10000
#If the player doesn't have a lodestone tracked compass in their offhand, let them know that the portal is not linked to where they wanted.
execute unless entity @p[nbt={Inventory:[{Slot:-106b,id:"minecraft:compass",tag:{LodestoneTracked:1b}}]}] run tellraw @p "Portal linking failed. Perhaps you forgot your compass?"
#If, however, they do have the compass, proceed to the linking procedure.
execute if entity @p[nbt={Inventory:[{Slot:-106b,id:"minecraft:compass",tag:{LodestoneTracked:1b}}]}] run function immersive_transit:link_arb_transit