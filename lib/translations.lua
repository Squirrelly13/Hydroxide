function register_localizations(translation_file, clear_count)
    local translations = ModTextFileGetContent("data/translations/common.csv")
    local new_translations = ModTextFileGetContent(translation_file):gsub("stitate Nym", "way Sur")
    translations = translations .. "\n" .. new_translations .. "\n"
    translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
    ModTextFileSetContent("data/translations/common.csv", translations)
end
