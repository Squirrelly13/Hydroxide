local entity = GetUpdatedEntityID()
local root = EntityGetRootEntity( entity )


local interactable_component = EntityGetFirstComponentIncludingDisabled(entity, "InteractableComponent")
if not interactable_component then return end
if(root == entity)then
    journal_open = false
    if(gui ~= nil)then
        GuiDestroy(gui)
        gui = nil
    end
    if(journal_open)then
        ComponentSetValue2( interactable_component, "ui_text", "Press $0 to close journal." )
    else
        ComponentSetValue2( interactable_component, "ui_text", "Press $0 to open journal." )
    end
    return
end

local inv2comp = EntityGetFirstComponentIncludingDisabled(root, "Inventory2Component")
if not inv2comp then
    journal_open = false
    return
end

local active_item = ComponentGetValue2(inv2comp, "mActiveItem")

if not active_item or active_item ~= entity then
    if(gui ~= nil)then
        GuiDestroy(gui)
        gui = nil
    end
    journal_open = false
    if(journal_open)then
        ComponentSetValue2( interactable_component, "ui_text", "Press $0 to close journal." )
    else
        ComponentSetValue2( interactable_component, "ui_text", "Press $0 to open journal." )
    end
    return
end

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    journal_open = not journal_open

    if(journal_open)then
        ComponentSetValue2( interactable_component, "ui_text", "Press $0 to close journal." )
    else
        ComponentSetValue2( interactable_component, "ui_text", "Press $0 to open journal." )
        if(gui ~= nil)then
            GuiDestroy(gui)
            gui = nil
        end
    end
end

journal_open = journal_open or false

if(not journal_open)then
    if(gui ~= nil)then
        GuiDestroy(gui)
        gui = nil
    end
    return
end

gui = gui or GuiCreate()

local id = 42124
local function new_id()
    id = id + 1
    return id
end

GuiStartFrame(gui)

dofile("mods/Hydroxide/files/mystical_mixtures/journal/entries.lua")

local background_image = "mods/Hydroxide/files/mystical_mixtures/journal/gfx/background_empty.png"

local background_image_w, background_image_h = GuiGetImageDimensions(gui, background_image)

local screen_width, screen_height = GuiGetScreenDimensions( gui )

local contents_width = 113
local contents_height = 141
local contents_offset_x = 34
local contents_offset_y = 59

local base_z = -200
GuiZSet(gui, base_z)

-- draw in center of screen
local x = screen_width * 0.5 - background_image_w * 0.5
local y = screen_height * 0.5 - background_image_h * 0.5
GuiZSetForNextWidget(gui, base_z + 1)
GuiImage(gui, new_id(), x, y, background_image, 1, 1, 1, 0)

local contents = {}
local categories = {}

for _, cat in ipairs(category_order)do
    table.insert(categories, cat)
end

for _, entry in ipairs(journal_entries) do
    if(contents[entry.category] == nil)then
        contents[entry.category] = {}
    end
    table.insert(contents[entry.category], entry)
    local has_category = false
    for _, cat in ipairs(categories)do
        if(cat == entry.category)then
            has_category = true
            break
        end
    end
    if(not has_category)then
        table.insert(categories, entry.category)
    end
end

for _, v in pairs(contents) do
    table.sort(v, function(a, b)
        local a_has_custom_flag = a.custom_unlock_flag ~= nil
        local b_has_custom_flag = b.custom_unlock_flag ~= nil
        local a_is_unlocked = a_has_custom_flag and HasFlagPersistent(a.custom_unlock_flag) or HasFlagPersistent("journal_entry_unlocked_"..a.id)
        if(a.unlocked_default)then
            a_is_unlocked = true
        end
        local b_is_unlocked = b_has_custom_flag and HasFlagPersistent(b.custom_unlock_flag) or HasFlagPersistent("journal_entry_unlocked_"..b.id)
        if(b.unlocked_default)then
            b_is_unlocked = true
        end
        -- keep unlocked entries at the top
        -- sort by title otherwise
        if(a_is_unlocked and not b_is_unlocked)then
            return true
        elseif(not a_is_unlocked and b_is_unlocked)then
            return false
        else
            return a.title < b.title
        end
    end)
end

local list_container_x = x + contents_offset_x
local list_container_y = y + contents_offset_y

active_entry = active_entry or nil
active_entry_contents = active_entry_contents or nil

GuiZSetForNextWidget(gui, base_z + 2)
GuiBeginScrollContainer(gui, new_id(), list_container_x, list_container_y, contents_width, contents_height, true)
GuiLayoutBeginVertical(gui, 0, 0, true)
for _, category in ipairs(categories) do
    local entries = contents[category]
    if(entries == nil)then
        goto continue
    end

    GuiColorSetForNextWidget(gui, 0.4, 0.4, 0.4, 1)
    GuiText(gui, 0, 0, GameTextGetTranslatedOrNot(category))
    for _, entry in ipairs(entries) do
        local has_custom_flag = entry.custom_unlock_flag ~= nil
        local is_unlocked = has_custom_flag and HasFlagPersistent(entry.custom_unlock_flag) or HasFlagPersistent("journal_entry_unlocked_"..entry.id)
        if(entry.unlocked_default or GameHasFlagRun("mm_DEBUG_unlock_all_pages"))then
            is_unlocked = true
        end
        GuiLayoutBeginHorizontal(gui, 5, 0, true)
        if(is_unlocked)then
            if(entry.icon)then
                GuiImage(gui, new_id(), 0, 0, entry.icon, 1, 1, 1, 0)
            else
                if(category == "Materials")then
                    GuiImage(gui, new_id(), 0, 0, "mods/Hydroxide/files/mystical_mixtures/journal/gfx/material_symbol.png", 1, 1, 1, 0)
                elseif(category == "Alchemy")then
                    GuiImage(gui, new_id(), 0, 0, "mods/Hydroxide/files/mystical_mixtures/journal/gfx/alchemy_symbol.png", 1, 1, 1, 0)
                else
                    GuiImage(gui, new_id(), 0, 0, "mods/Hydroxide/files/mystical_mixtures/journal/gfx/unknown_symbol.png", 1, 1, 1, 0)
                end
            end
            GuiColorSetForNextWidget(gui, 0, 0, 0, 1)
            local title = GameTextGetTranslatedOrNot(entry.title)
            if(GuiButton(gui, new_id(), 0, 0, ((active_entry == entry.id) and (">"..title.."<") or title)))then
                if(active_entry == entry.id)then
                    active_entry = nil
                    active_entry_contents = nil
                else
                    active_entry = entry.id
                    active_entry_contents = entry
                end
            end
        else
            GuiImage(gui, new_id(), 0, 0, "mods/Hydroxide/files/mystical_mixtures/journal/gfx/locked_symbol.png", 1, 1, 1, 0)
            GuiColorSetForNextWidget(gui, 0.55, 0.55, 0.55, 1)
            GuiText(gui, 0, 0, "???")
        end
        GuiLayoutEnd(gui)
    end

    ::continue::
end
GuiLayoutEnd(gui)
GuiEndScrollContainer(gui)

local page_width = 113
local page_height = 183
local page_offset_x = 169
local page_offset_y = 16

local page_x = x + page_offset_x
local page_y = y + page_offset_y

local function hex_to_rgba(hex)
    -- convert ARGB hex to rgba
    local a = tonumber("0x"..string.sub(hex, 1, 2)) / 255
    local r = tonumber("0x"..string.sub(hex, 3, 4)) / 255
    local g = tonumber("0x"..string.sub(hex, 5, 6)) / 255
    local b = tonumber("0x"..string.sub(hex, 7, 8)) / 255
    return r, g, b, a
end

GuiZSetForNextWidget(gui, base_z + 2)
GuiBeginScrollContainer(gui, new_id(), page_x, page_y, page_width, page_height, true)
GuiLayoutBeginVertical(gui, 0, 0, true)
if(active_entry ~= nil and active_entry_contents ~= nil)then
    local entry = active_entry_contents
    GuiColorSetForNextWidget(gui, 0, 0, 0, 1)
    GuiText(gui, 0, 0, GameTextGetTranslatedOrNot(GameTextGetTranslatedOrNot(entry.title)))
    GuiText(gui, 0, -5, " ")

    if entry.image then
        GuiImage(gui, new_id(), 0, 0, entry.image, 1, 1, 1, 0)
        GuiText(gui, 0, -5, " ")
    end

    local description_lines = {}
    -- split description by \n or \r
    -- include empty strings
    for line in string.gmatch(GameTextGetTranslatedOrNot(entry.description), "[^\r\n]+") do
        table.insert(description_lines, line)
    end

    local description_lines_parsed = {}
    for _, line in ipairs(description_lines) do
        local sub_lines = {}
        local start_pos = string.find(line, "<c %x+>")
        if start_pos then
            -- If there is a color tag, add the preceding text to the result table with a default color
            local initial_text = string.sub(line, 1, start_pos - 1)
            table.insert(sub_lines, {color = nil, line = initial_text})
        else
            -- If there is no color tag, add the whole line to the result table with a default color
            table.insert(sub_lines, {color = nil, line = line})
        end
        
        -- Now process the rest of the string as before
        for color, text in string.gmatch(line, "<c (%x+)>([^<]+)") do
            table.insert(sub_lines, {color = color, line = text})
        end

        table.insert (description_lines_parsed, sub_lines)
    end
    

    local description_sublines = description_lines_parsed

    -- split lines to 30 characters or less, only split at spaces
    local description_sublines = {}
    for _, sublines in ipairs(description_lines_parsed) do
        local line = ""
        local sublines_parsed = {}
        for _, subline in ipairs(sublines) do
            line = line .. subline.line
            local color = subline.color
            while #line > 30 do
                local subline = string.sub(line, 1, 30)
                local last_space = subline:match'^.*()%s'
                if last_space then
                    subline = string.sub(subline, 1, last_space - 1)
                else
                    last_space = 30
                end
                table.insert(sublines_parsed, {line = subline, color = color})
                line = string.sub(line, last_space + 1)
            end
        end
        -- insert remaining line if it's not empty
        if #line > 0 then
            table.insert(sublines_parsed, {line = line, color = sublines[#sublines].color})
        end
        table.insert(description_sublines, sublines_parsed)
    end


    -- print parsed lines
    for _, parsed_lines in ipairs(description_sublines) do
        --GuiLayoutBeginHorizontal(gui, 0, 0, true)
        for _, parsed_line in ipairs(parsed_lines) do
            -- trim line
            --parsed_line.line = string.gsub(parsed_line.line, "^%s*(.-)%s*$", "%1")
            GuiColorSetForNextWidget(gui, 0.3, 0.3, 0.3, 1)
            if(parsed_line.color ~= nil)then
                local r, g, b, a = hex_to_rgba(parsed_line.color)
                print(tostring(r), tostring(g), tostring(b))
                GuiColorSetForNextWidget(gui, r, g, b, a)
            end
            GuiText(gui, 0, 0, parsed_line.line)
        end
        --GuiLayoutEnd(gui)
    end
end
GuiLayoutEnd(gui)
GuiEndScrollContainer(gui)