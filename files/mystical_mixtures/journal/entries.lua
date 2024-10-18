journal_entries = {
    {
        id = "book_title",
        category = "Alchemist Journal",
        title = "$title_mm_alchemist_journal",
        -- description supports color tags (ARGB) <c ffff0000>, which will color everything after it, until the next color tag or the end of a line.
        description = "$desc_mm_alchemist_journal",
        unlocked_default = true,
        generate_notes = false,
        icon = nil,
    },
    --[[{
        id = "test_entry",
        category = "Materials",
        title = "$mat_mm_ephemeral_ether",
        description = "$desc_mm_ephemeral_ether",    
        custom_unlock_flag = nil,
        unlocked_default = true,
        generate_notes = true,
        icon = nil,
        image = "mods/Hydroxide/files/mystical_mixtures/journal/gfx/ether.png",
        weight = 1, -- probabilty of note spawning, 1 is default. 
    },]]
}

category_order = {
    "Alchemist Journal",
    "Alchemy",
    "Materials",
}

dofile("mods/Hydroxide/files/mystical_mixtures/alchemy/alchemical_content.lua")

local colors = dofile("mods/Hydroxide/files/mystical_mixtures/journal/colors.lua")

local function hex_to_rgba(hex)
    -- convert ARGB hex to rgba
    local a = tonumber("0x"..string.sub(hex, 1, 2)) / 255
    local r = tonumber("0x"..string.sub(hex, 3, 4)) / 255
    local g = tonumber("0x"..string.sub(hex, 5, 6)) / 255
    local b = tonumber("0x"..string.sub(hex, 7, 8)) / 255
    return r, g, b, a
end


local function find_closest_color_name(r, g, b)
    local closest_color = nil
    local closest_distance = 99999
    for color_name, color in pairs(colors) do
        local distance = math.sqrt((color[1] - r)^2 + (color[2] - g)^2 + (color[3] - b)^2)
        if(distance < closest_distance)then
            closest_distance = distance
            closest_color = color_name
        end
    end
    return closest_color
end

for i, v in ipairs(alchemical_materials)do
    local r, g, b, a = hex_to_rgba(v.color)
    local closest_color = find_closest_color_name(r, g, b)

    if(not v.generate_notes)then
        goto continue
    end

    table.insert(journal_entries, {
        id = "mat_"..v.id,
        category = "Materials",
        title = v.name,
        description = GameTextGetTranslatedOrNot(v.description).."\n \n<c ff2b2b2b>Color: \n<c "..v.color..">"..closest_color.."\n<c ff2b2b2b>Type: \n"..v.type.."\n<c ff2b2b2b>Flammable: \n"..(v.burnable and "true" or "false"),
        unlocked_default = v.unlocked_default or false,
        generate_notes = v.generate_notes or false,
    })

    ::continue::
end 

for i, v in ipairs(alchemical_recipes)do
    if(not v.generate_notes)then
        goto continue
    end

    table.insert(journal_entries, {
        id = "recipe_"..v.id,
        category = "Alchemy",
        title = v.name,
        description = GameTextGetTranslatedOrNot(v.description),
        unlocked_default = v.unlocked_default or false,
        generate_notes = v.generate_notes or false,
    })

    ::continue::
end