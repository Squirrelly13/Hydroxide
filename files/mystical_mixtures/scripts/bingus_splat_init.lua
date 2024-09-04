local entity = GetUpdatedEntityID()

local x, y = EntityGetTransform( entity )


local mortals = EntityGetInRadiusWithTag(x, y, 100, "mortal" ) or {}

if(#mortals > 0)then


    local LiquidDisplacerComponent = EntityGetFirstComponentIncludingDisabled( entity, "LiquidDisplacerComponent" )
    if not LiquidDisplacerComponent then return end
    SetRandomSeed( x, y )

    velocity_x = Random( -1000, 1000 )
    velocity_y = Random( -1000, 1000 )

    ComponentSetValue2( LiquidDisplacerComponent, "velocity_x", velocity_x )
    ComponentSetValue2( LiquidDisplacerComponent, "velocity_y", velocity_y )

    local velocityComp = EntityGetFirstComponentIncludingDisabled( entity, "VelocityComponent" )
    if not velocityComp then return end
    ComponentSetValue2( velocityComp, "mVelocity", velocity_x, velocity_y )    

else
    EntityKill(entity)
end