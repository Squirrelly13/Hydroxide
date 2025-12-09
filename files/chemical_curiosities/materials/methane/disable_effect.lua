local owner = EntityGetParent(GetUpdatedEntityID())
if not IsPlayer(owner) then return end
if EntityHasTag(owner, "player_unit") or EntityHasTag(owner, "player_polymorphed") then
	GameSetPostFxParameter("greyscale", 0, 0, 0, 0)
end