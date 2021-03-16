#"Lieutenant! Set portal for DEATH!" "Death, sir? That's not a location." "JUST DO IT!"
portal set_portal_destination immersive_portals:alternate5 10000 -100 10000
#"Portal set for DEATH, sir." "Very good, lieutenant."
#The above command has had the unexpected, yet quite welcome effect of making the portal inpassible until the chunks at the target have been loaded. We take those.
execute store success storage immersive_transit:current_portal link_success.has_compass byte 1 run execute if data entity @p {Inventory:[{Slot:-106b,id:"minecraft:compass"}]}
#If they don't have a compass, let them know.
execute if data storage immersive_transit:current_portal {link_success:{has_compass:0b}} run tellraw @p "Portal linking failed. Compass not found."
#Is the compass locked to a lodestone?
execute if data storage immersive_transit:current_portal {link_success:{has_compass:1b}} store success storage immersive_transit:current_portal link_success.has_lock byte 1 run execute if data entity @p {Inventory:[{Slot:-106b,tag:{LodestoneTracked:1b}}]}
#If the compass isn't lodestone linked, let them know.
execute if data storage immersive_transit:current_portal {link_success:{has_compass:1b,has_lock:0b}} run tellraw @p "Portal linking failed. Compass not linked."
#Is the compass pointing toward the same dimension as the portal? (Test for difference, then invert success)
execute if data storage immersive_transit:current_portal {link_success:{has_compass:1b,has_lock:1b}} run data modify storage immersive_transit:current_portal link_success.target_dimension set from entity @p Inventory[{Slot:-106b}].tag.LodestoneDimension
execute if data storage immersive_transit:current_portal {link_success:{has_compass:1b,has_lock:1b}} store success storage immersive_transit:current_portal link_success.different_dimensions byte 1 run data modify storage immersive_transit:current_portal link_success.target_dimension set from entity @p Dimension
#If the player and the lodestone aren't in the same dimension, let them know.
execute if data storage immersive_transit:current_portal {link_success:{has_compass:1b,has_lock:1b,different_dimensions:1b}} run tellraw @p "Portal linking failed. Not enough energy in a nether star to link between arbratrary points across dimensions."
#Is the lodestone still present? (Compass will not have a tracked position if the lodestone has been broken.)
execute if data storage immersive_transit:current_portal {link_success:{has_compass:1b,has_lock:1b,different_dimensions:0b}} store success storage immersive_transit:current_portal link_success.lodestone_linked byte 1 run execute if data entity @p {Inventory:[{Slot:-106b,tag:{LodestonePos:{}}}]}
#If the lodestone isn't present, let them know.
execute if data storage immersive_transit:current_portal {link_success:{has_compass:1b,has_lock:1b,different_dimensions:0b,lodestone_linked:0b}} run tellraw @p "Portal linking failed. Compass was present, but no lodestone was found."
#If they aren't ready, we're done here. Remove the portal and clean up.
execute unless data storage immersive_transit:current_portal {link_success:{has_compass:1b,has_lock:1b,different_dimensions:0b,lodestone_linked:1b}} run portal eradicate_portal_cluster
#If, however, they have followed instructions, eat the nether star (unless they're in creative or spectator) ...
execute if data storage immersive_transit:current_portal {link_success:{has_compass:1b,has_lock:1b,different_dimensions:0b,lodestone_linked:1b}} unless data entity @p {playerGameType:1} unless data entity @p {playerGameType:3} run clear @p minecraft:nether_star 1
#... let them know...
tellraw @p "Portal linking commenced. Please stand by."
#... and proceed to chunk-load the lodestone.
execute if data storage immersive_transit:current_portal {link_success:{has_compass:1b,has_lock:1b,different_dimensions:0b,lodestone_linked:1b}} run function immersive_transit:load_lodestone
#Clean up our stored data.
data remove storage immersive_transit:current_portal link_success