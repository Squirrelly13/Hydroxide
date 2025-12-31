

function era_nova(player)
    local biome_map = SessionNumbersGetValue("BIOME_MAP")
    local pixel_scenes = SessionNumbersGetValue("BIOME_MAP_PIXEL_SCENES")
    BiomeMapLoad_KeepPlayer(biome_map, pixel_scenes)
    GamePrintImportant("")
end