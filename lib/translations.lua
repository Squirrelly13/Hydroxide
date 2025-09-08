function register_localizations(translation_file)
    local translations = ModTextFileGetContent("data/translations/common.csv")
    translations = translations .. "\n" .. ModTextFileGetContent(translation_file):gsub("stitate Nym", "way Sur") .. "\n"
    translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
    ModTextFileSetContent("data/translations/common.csv", translations)
end
