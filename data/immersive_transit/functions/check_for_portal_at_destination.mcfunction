#Move the placeholder one more to the positive X, to make sure the portal doesnt generate on top of the lodestone.
execute as @e[tag=transit_placeholder] at @s run tp @s ~1 ~ ~
#Check to see if there's already a portal entity on the other side of the potential link.
execute as @e[tag=transit_placeholder] at @s store success storage immersive_transit:current_portal already_portal_at_destination byte 1 run execute if entity @e[type=immersive_portals:portal,dx=0,dy=0,dz=0]
#FAILURE CONDITION
execute if data storage immersive_transit:current_portal {already_portal_at_destination:1b} run tellraw @p "Conflicting portal detected at destination lodestone. Linking procedure aborted."
execute if data storage immersive_transit:current_portal {already_portal_at_destination:1b} run kill @s
#SUCCESS CONDITION
#Continue with linking protocal.
execute if data storage immersive_transit:current_portal {already_portal_at_destination:0b} run function immersive_transit:link_arb_transit
#Regardless of the result, clean up the data we used.
data remove storage immersive_transit:current_portal already_portal_at_destination
#Get rid of the suprise tool. Will fail silently if the portal has already been destroyed, but that's not worth caring about.
tag @s remove immersive_transit_current_portal
#Get rid of the placeholder.
kill @e[tag=transit_placeholder]
#End of check. Back to schedule_workaround