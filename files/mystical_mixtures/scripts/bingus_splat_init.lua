local entity = GetUpdatedEntityID()

local LiquidDisplacerComponent = EntityGetFirstComponentIncludingDisabled( entity, "LiquidDisplacerComponent" )

local x, y = EntityGetTransform( entity )

SetRandomSeed( x, y )

velocity_x = Random( -1000, 1000 )
velocity_y = Random( -1000, 1000 )

ComponentSetValue2( LiquidDisplacerComponent, "velocity_x", velocity_x )
ComponentSetValue2( LiquidDisplacerComponent, "velocity_y", velocity_y )

local velocityComp = EntityGetFirstComponentIncludingDisabled( entity, "VelocityComponent" )

ComponentSetValue2( velocityComp, "mVelocity", velocity_x, velocity_y )