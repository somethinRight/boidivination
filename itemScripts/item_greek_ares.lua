
local greekares_mod = RegisterMod( "gAres", 1)
local greekares_item = Isaac.GetItemIdByName( "Ares" )

local frames_passed_Ares = 0
local seconds_passed_Ares = 0
local currRoom_Ares

function greekares_mod:countdown_Ares()
	local currRoom_Ares = Game():GetLevel():GetCurrentRoom()
	local player = Isaac.GetPlayer(0)

	if ((currRoom_Ares:IsClear() == false) and (seconds_passed_Ares ~= 40)) then
		frames_passed_Ares = frames_passed_Ares + 1
		if (frames_passed_Ares == 30) then
			seconds_passed_Ares = seconds_passed_Ares + 1
			frames_passed_Ares = 0

			player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:EvaluateItems()
		end
	end

	if ((currRoom_Ares:IsClear() == true) or (currRoom_Ares:GetFrameCount() == 1)) then
	frames_passed_Ares = 0
	seconds_passed_Ares = 0

	player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
	player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
	player:EvaluateItems()
	end
end

function greekares_mod:cacheUpdate_Ares(player, cacheFlag)
	local player = Isaac.GetPlayer(0)

	if (player:HasCollectible(greekares_item)) then
		if (cacheFlag == CacheFlag.CACHE_FIREDELAY) then
			if player.MaxFireDelay > 5 then
				player.MaxFireDelay = player.MaxFireDelay - 1
				else
				if player.MaxFireDelay <= 5 then
					player.MaxFireDelay = player.MaxFireDelay
				end
			end
		end

		if (cacheFlag == CacheFlag.CACHE_DAMAGE) then
			player.Damage = player.Damage + (seconds_passed_Ares * 0.1)
		end
	end
end

greekares_mod:AddCallback(ModCallbacks.MC_POST_UPDATE, greekares_mod.countdown_Ares)
greekares_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, greekares_mod.cacheUpdate_Ares)
