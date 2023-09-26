local postfx = {
    append = function(code, insert_after_string)
        if insert_after_string == nil then
            error("no insert line given!")
        end
        
        if type(code) ~= "string" then
            error("append argument has to be a string!")
        end
        
        local post_final = ModTextFileGetContent("data/shaders/post_final.frag")
        if post_final == nil then
            error("could not read post_final.frag")
        end

        local index = string.find(post_final, insert_after_string)
        if index == nil then
            error("could not find insert_after_string")
        end
        
        local new_content = string.sub(post_final, 1, index + #insert_after_string) .. "\n" .. code .. "\n" .. string.sub(post_final, index + #insert_after_string + 1)
        ModTextFileSetContent("data/shaders/post_final.frag", new_content)
    end,
    prepend = function(code, insert_before_string)
        if insert_before_string == nil then
            error("no insert line given!")
        end
        
        if type(code) ~= "string" then
            error("prepend argument has to be a string!")
        end
        
        local post_final = ModTextFileGetContent("data/shaders/post_final.frag")
        if post_final == nil then
            error("could not read post_final.frag")
        end

        local index = string.find(post_final, insert_before_string)
        if index == nil then
            error("could not find insert_before_string")
        end
        
        local new_content = string.sub(post_final, 1, index - 1) .. "\n" .. code .. "\n" .. string.sub(post_final, index)
        ModTextFileSetContent("data/shaders/post_final.frag", new_content)
    end
}

return postfx