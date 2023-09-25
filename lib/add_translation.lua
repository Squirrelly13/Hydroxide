function register_translation(key, en, ru, ptbr, eses, de, frfr, it, pl, zhch, jp, ko)
    local translation_file = "data/translations/common.csv";
    local translations = ModTextFileGetContent( translation_file );

    if(key ~= nil)then
        en = en or ""
        ru = ru or ""
        ptbr = prbr or ""
        eses = eses or ""
        de = de or ""
        frfr = frfr or ""
        it = it or ""
        pl = pl or ""
        zhch = zhch or ""
        jp = jp or ""
        ko = ko or ""
        if translations ~= nil then
            while translations:find("\r\n\r\n") do
                translations = translations:gsub("\r\n\r\n","\r\n");
            end
            local new_translations = key..","..en..","..ru..","..ptbr..","..eses..","..de..","..frfr..","..it..","..pl..","..zhch..","..jp..","..ko..",,";
            translations = translations .. new_translations;
            print("Registered translation key: "..key)
            ModTextFileSetContent( translation_file, translations );
        end
    end
end