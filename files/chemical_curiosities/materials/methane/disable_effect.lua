local owner = EntityGetParent(GetUpdatedEntityID())
if not IsPlayer(owner) then return end

GameSetPostFxParameter("greyscale", 0, 0, 0, 0)