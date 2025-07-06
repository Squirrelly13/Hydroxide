local ps = PowderStashLib
if not ps then print("POWDER STASH LIB IS NIL, TERMINATING CC APPEND") return end

local settings = {}
settings.CC = ModSettingGet("Hydroxide.CC_ENABLED")
settings.AA = ModSettingGet("Hydroxide.AA_ENABLED")

local powders = {
    CC = {
        materials_standard = {
            {
                material="sulphur",
                cost = 175,
                probability = 8,
                origin = "chemical_curiosities",
            },
            {
                material = "cc_cobalt",
                cost = 200,
                probability = 4,
                origin = "chemical_curiosities",
            },
            {
                material = "cc_iron",
                cost = 200,
                probability = 4,
                origin = "chemical_curiosities",
            },
            {
                material = "cc_preskite",
                cost = 200,
                probability = 4,
                origin = "chemical_curiosities",
            },
            
        },
        materials_magic = {
            {
                material="cc_devouring_moss",
                cost = 900,
                probability = 4,
                origin = "chemical_curiosities",
            },
            {
                material="cc_blasting_powder",
                cost = 750,
                probability = 10,
                origin = "chemical_curiosities",
            },
            {
                material="cc_kindling",
                cost = 700,
                probability = 6,
                origin = "chemical_curiosities",
            },
            {
                material="cc_alchemy_powder",
                cost = 1200,
                probability = 2,
                origin = "chemical_curiosities",
            },
            {
                material="cc_warp_powder",
                cost = 8000,
                probability = .5,
                origin = "chemical_curiosities",
            },
            {
                material="cc_paradox_powder",
                cost = 15000,
                probability = .1,
                origin = "chemical_curiosities",
            },
            {
                material="cc_morphine",
                cost = 650,
                probability = 9,
                origin = "chemical_curiosities",
            },
            {
                material="cc_antimatter_powder",
                cost = 850,
                probability = 5,
                origin = "chemical_curiosities",
            },
            {
                material="cc_dull_fungus",
                cost = 575,
                probability = 7,
                origin = "chemical_curiosities",
            },
        },
    },
    AA = {
        materials_standard = {
            {
                material = "aa_ash",
                cost = 200,
                probability = 6,
                origin = "chemical_curiosities",
            },
            {
                material = "aa_rice",
                cost = 200,
                probability = 3,
                origin = "chemical_curiosities",
            },
        }
    },
}

for key, tables in pairs(powders) do
    if settings[key] then
        for target_table, data in pairs(tables) do
            for _, value in ipairs(data) do
                table.insert(ps[target_table], value)
            end
        end
    end
end