#tellraw @p {"storage":"immersive_transit:current_portal","nbt":"{}"}
#Check to see if there's a portal already in the frame, as the mod doesn't do that with unbreakable portals.
execute store success storage immersive_transit:current_portal portal_in_frame_already byte 1 run execute if entity @e[type=immersive_portals:portal,dx=0,dy=0,dz=0]
#SUCCESS CONDITION
#Silently delete the portal, and skip the rest of the process. 
execute if data storage immersive_transit:current_portal {portal_in_frame_already:1b} run portal delete_portal
#execute if data storage immersive_transit:current_portal {portal_in_frame_already:1b} run tellraw @p "I CAN BE SILENT! I JUST CHOOSE NOT TO BE!"
#FAILURE CONDITION
#Continue to lodestone validation.
execute unless data storage immersive_transit:current_portal {portal_in_frame_already:1b} run function immersive_transit:validate_lodestone
#Regardless of the result, clean up.
data remove storage immersive_transit:current_portal portal_in_frame_already
#End of check. End of command function chain.