dofile("mods/Hydroxide/files/mystical_mixtures/journal/entries.lua")

local journal = GetUpdatedEntityID()

local player = EntityGetRootEntity(journal)

if(player == journal)then
    return
end

local x, y = EntityGetTransform(player)

local chunk_x, chunk_y = math.floor(x / 512), math.floor(y / 512)

SetRandomSeed(x, y + GameGetFrameNum())

-- create a unique id for this chunk
last_chunk_id = last_chunk_id or 0
local chunk_id = chunk_x + chunk_y * 10000

local discovery_chance = 8

local is_entry_unlocked = function(entry)
    if(GameHasFlagRun("mm_unlock_all_notes"))then
        return true
    end
    local has_custom_flag = entry.custom_unlock_flag ~= nil
    local is_unlocked = has_custom_flag and HasFlagPersistent(entry.custom_unlock_flag) or HasFlagPersistent("journal_entry_unlocked_"..entry.id)
    if(entry.unlocked_default)then
        is_unlocked = true
    end
    return is_unlocked
end


local weighted_random = function(t, only_locked)
    -- weighted random
    local total_weight = 0
    for _, v in ipairs(t) do
        if(v.generate_notes and (not only_locked or not is_entry_unlocked(v)))then
            total_weight = total_weight + (v.weight or 1)
        end
    end
    local rnd = Random(0, total_weight)
    local current_weight = 0
    for i, v in ipairs(t) do
        if(v.generate_notes and (not only_locked or not is_entry_unlocked(v)))then
            current_weight = current_weight + (v.weight or 1)
            if(current_weight >= rnd)then
                return v, i
            end
        end
    end
end

local spawn_range = 512

if(chunk_id ~= last_chunk_id)then
    last_chunk_id = chunk_id
    local has_visited_chunk = GameHasFlagRun("mm_visited_chunk_" .. chunk_id)

    if(not has_visited_chunk)then
        --GamePrint("New chunk entered: " .. chunk_x .. ", " .. chunk_y)
        GameAddFlagRun("mm_visited_chunk_" .. chunk_id)

        if(Random(0, 100) <= discovery_chance)then
            local entry, entry_index = weighted_random(journal_entries, true)
            if(entry ~= nil)then
                local points = {}
                local angle_step = math.pi * 2 / 32
                for i = 0, 31 do
                    local angle = angle_step * i
                    local add_x = math.cos(angle) * spawn_range
                    local add_y = math.sin(angle) * spawn_range

                    local new_x = x + add_x
                    local new_y = y + add_y

                    local hit = RaytraceSurfaces(new_x, new_y, new_x, new_y + 0.5)
                    if(hit == false)then
                        local hit2, hit_x, hit_y = RaytraceSurfaces(new_x, new_y, new_x, new_y + 256)
                        if(hit2)then
                            --GameCreateSpriteForXFrames("mods/Hydroxide/files/mystical_mixtures/gfx/debug.png", hit_x, hit_y, true, nil, nil, 60, true)
                            table.insert(points, {hit_x, hit_y - 10})
                        end
                    end
                end

                if #points > 0 then
                    -- pick random point
                    local point = points[Random(1, #points)]
                    local x = point[1]
                    local y = point[2]

                    -- spawn a note
                    local note = EntityLoad("mods/Hydroxide/files/mystical_mixtures/journal/lab_note.xml", x, y)
                    
                    local variable_storage = nil
                    local variable_storage_components = EntityGetComponentIncludingDisabled(note, "VariableStorageComponent") or {}
                
                    for k, v in ipairs(variable_storage_components)do
                        local name = ComponentGetValue2(v, "name")
                        if(name == "entry_id")then
                            variable_storage = v
                            break
                        end
                    end

                    local entry_name = GameTextGet("$note_mm_labnote_entry", tostring(entry_index), GameTextGetTranslatedOrNot(entry.title))

                    if(variable_storage ~= nil)then
                        ComponentSetValue2(variable_storage, "value_string", entry.id)
                    end

                    local ability_comp = EntityGetFirstComponentIncludingDisabled(note, "AbilityComponent")
                    if(ability_comp ~= nil)then
                        ComponentSetValue2(ability_comp, "ui_name", entry_name)
                    end

                    local item_comp = EntityGetFirstComponentIncludingDisabled(note, "ItemComponent")
                    if(item_comp ~= nil)then
                        ComponentSetValue2(item_comp, "item_name", entry_name)
                        ComponentSetValue2(item_comp, "ui_description", entry.description)
                    end

                    local ui_info_comp = EntityGetFirstComponentIncludingDisabled(note, "UIInfoComponent")
                    if(ui_info_comp ~= nil)then
                        ComponentSetValue2(ui_info_comp, "name", entry_name)
                    end
                end
            end
        end
    end
end



