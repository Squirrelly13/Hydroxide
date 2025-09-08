
local function GenerateUserSeed()
    local time = {GameGetDateAndTimeUTC()}
    
    math.randomseed(time[5] * time[6], time[3] * time[4])
    -- SetRandomSeed(time[5] * time[6], time[3] * time[4])
end


if ModSettingGet("fairmod.user_seed") == nil then
    print(GenerateUserSeed())
    --ModSettingSet("", GenerateUserSeed())
end


local function GenerateRandomNumber(iterations)
	local number = ""
	for i = 1, iterations do
		number = number .. math.random(0, 9)
	end
	return number
end

local user_seed = ModSettingGet("fairmod.user_seed")

--user_seed = "123456789012345678901234567890" --use this to spoof user_seeds

if not user_seed then
	user_seed = GenerateRandomNumber(30)
	ModSettingSet("fairmod.user_seed", user_seed)
	print("GENERATED USER SEED IS [" .. ModSettingGet("fairmod.user_seed") .. "]")
end

print("USER SEED IS [" .. user_seed .. "]")