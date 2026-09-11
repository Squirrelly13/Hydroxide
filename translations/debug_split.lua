local path = "mods/Hydroxide/translations/"

local translations = {
	["key"] = {},

	--Standard langs
	["en"] = {},
	["ru"] = {},
	["pt-br"] = {},
	["es-es"] = {},
	["de"] = {},
	["fr-fr"] = {},
	["it"] = {},
	["pl"] = {},
	["zh-cn"] = {},
	["jp"] = {},
	["ko"] = {},

	--Non-Standard langs
	["tr-tr"] = {},
}

local standard_langs_ordered = {
	"en",
	"ru",
	"pt-br",
	"es-es",
	"de",
	"fr-fr",
	"it",
	"pl",
	"zh-cn",
	"jp",
	"ko"
}

local nonstandard_langs = {
	["tr-tr"] = "turkish"
}

local column_order = {} --core order

local core = ModTextFileGetContent(path .. "core.csv")

local index = core:gmatch("[^\n]+")()

do
	local start_index = 1
	local in_quotes = false
	for i = 1, #index do
		local char = index:sub(i, i)

		-- Handle quoted fields
		if char == '"' then
			in_quotes = not in_quotes
		elseif char == "," and not in_quotes then
			-- End of a field
			local str = index:sub(start_index, i - 1)
			if translations[str] then column_order[#column_order+1] = str end
			start_index = i + 1
		end
	end
end

local function transcribe_line(line)
	if line:sub(1,1) == ',' then return end


	local current_column = 1
	local start_index = 1
	local in_quotes = false

	for i = 1, #line do
		local char = line:sub(i, i)

		if char == '"' then
			in_quotes = not in_quotes --Handle quoted fields
		elseif char == "," and not in_quotes then
			if current_column == #column_order then return end

			local str = line:sub(start_index, i - 1)

			local target = translations[column_order[current_column]]
			if target then target[#target+1] = str end

			current_column = current_column + 1
			start_index = i + 1 --thank you lamia for the csv parsing logic
		end
	end
end

core = core:sub(#index+1, -1)
core = core:sub((#core:gmatch("[^\n]+")())+1, -1)

local n = 1
while true do
	local line = core:gmatch("[^\n]+")()
	if line == nil then break end

	transcribe_line(line)
    core = core:sub(#line+1, -1)
	n = n + 1
end

for index, value in ipairs(translations["en"]) do
	print(tostring(value))
end

local standard = ""
for i, key in ipairs(translations["key"]) do
	if translations["en"] == nil then print("MISSING EN STRING!") end

	local line = key
	for _, value in ipairs(standard_langs_ordered) do
		line = line ..","..(translations[value][i] or "")
	end
	standard = standard .. line .. ",,,\n"
end

ModTextFileSetContent(path.."standard.csv",standard)

for lang,name in pairs(nonstandard_langs) do
	local translation = ""
	for i, key in ipairs(translations["key"]) do
		local tl = translations[lang][i]
		if #tl == 0 then tl = translations["en"][i] end
		local line = key .. ","..tl
		translation = translation .. line .. ",,,,,,,,,,,,,\n"
	end


    ModTextFileSetContent(path..name..".csv",translation)
end