#"Lieutenant! Set portal for DEATH!" "Death, sir? That's not a location." "JUST DO IT!"
portal set_portal_destination immersive_portals:alternate5 10000 -100 10000
#"Portal set for DEATH, sir." "Very good, lieutenant."
#Does the closest player have a LodestoneTracked compass WITH a tracked position? (Compass will not have a tracked position if the lodestone has been broken.)
execute store success storage immersive_transit:current_portal link_success.has_compass byte 1 run execute if data entity @p {Inventory:[{Slot:-106b,tag:{LodestonePos:{}}}]}
#If they don't have the compass, let them know. TODO: Change system to tell player whether they're not holding a compass, or if the lodestone has been broken.
execute unless data storage immersive_transit:current_portal {link_success:{has_compass:1b}} run tellraw @p "Portal linking failed. No lodestone-linked compass found in off-hand."
#If they aren't ready, we're done here. Finish the portal to DEATH and clean up.
execute unless data storage immersive_transit:current_portal {link_success:{has_compass:1b}} run portal complete_bi_faced_portal
#If, however, they do have the right compass, proceed to chunk-load the lodestone.
execute if data storage immersive_transit:current_portal {link_success:{has_compass:1b}} run function immersive_transit:locate_lodestone
#Clean up our stored data
data remove storage immersive_transit:current_portal link_success