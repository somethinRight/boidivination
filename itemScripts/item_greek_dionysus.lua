
local greekdion_mod = RegisterMod( "gDion", 1)
local greekdion_item = Isaac.GetItemIdByName( "Dionysus" )

local currRoom_Dion
local randBuffDebuff = 0

function greekdion_mod:roomTracker_Dion()
	local currRoom_Dion = Game():GetLevel():GetCurrentRoom()
	local player = Isaac.GetPlayer(0)

	if (player:HasCollectible(greekdion_item)) then
		if (currRoom_Dion:GetFrameCount() == 1) then
			randBuffDebuff = math.random(1,12)

			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:AddCacheFlags(CacheFlag.CACHE_LUCK)
			player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
			player:EvaluateItems()
		end
	end
end

function greekdion_mod:cacheUpdate_Dion(player, cacheFlag)
	local player = Isaac.GetPlayer(0)

	if (player:HasCollectible(greekdion_item)) then

		if (cacheFlag == CacheFlag.CACHE_DAMAGE) then
			player.Damage = player.Damage + 0.7
		end
		if (cacheFlag == CacheFlag.CACHE_SPEED) then
			player.MoveSpeed = player.MoveSpeed - 0.1
		end
	end

	if randBuffDebuff == 1 then
		if (cacheFlag == CacheFlag.CACHE_DAMAGE) then
			player.Damage = player.Damage + 1
		end
		if (cacheFlag == CacheFlag.CACHE_SPEED) then
			player.MoveSpeed = player.MoveSpeed - 0.1
		end

	elseif randBuffDebuff == 2 then
		if (cacheFlag == CacheFlag.CACHE_DAMAGE) then
			player.Damage = player.Damage + 1
		end
		if (cacheFlag == CacheFlag.CACHE_LUCK) then
			player.Luck = player.Luck - 1
		end

	elseif randBuffDebuff == 3 then
		if (cacheFlag == CacheFlag.CACHE_DAMAGE) then
			player.Damage = player.Damage + 1
		end
		if (cacheFlag == CacheFlag.CACHE_FIREDELAY) then
			player.MaxFireDelay = player.MaxFireDelay + 1
		end

	elseif randBuffDebuff == 4 then
		if (cacheFlag == CacheFlag.CACHE_SPEED) then
			player.MoveSpeed = player.MoveSpeed + 0.2
		end
		if (cacheFlag == CacheFlag.CACHE_DAMAGE) then
			player.Damage = player.Damage - 0.7
		end

	elseif randBuffDebuff == 5 then
		if (cacheFlag == CacheFlag.CACHE_SPEED) then
			player.MoveSpeed = player.MoveSpeed + 0.2
		end
		if (cacheFlag == CacheFlag.CACHE_LUCK) then
			player.Luck = player.Luck - 1
		end

	elseif randBuffDebuff == 6 then
		if (cacheFlag == CacheFlag.CACHE_SPEED) then
			player.MoveSpeed = player.MoveSpeed + 0.2
		end
		if (cacheFlag == CacheFlag.CACHE_FIREDELAY) then
			player.MaxFireDelay = player.MaxFireDelay + 1
		end

	elseif randBuffDebuff == 7 then
		if (cacheFlag == CacheFlag.CACHE_LUCK) then
			player.Luck = player.Luck + 2
		end
		if (cacheFlag == CacheFlag.CACHE_DAMAGE) then
			player.Damage = player.Damage - 0.7
		end

	elseif randBuffDebuff == 8 then
		if (cacheFlag == CacheFlag.CACHE_LUCK) then
			player.Luck = player.Luck + 2
		end
		if (cacheFlag == CacheFlag.CACHE_SPEED) then
			player.MoveSpeed = player.MoveSpeed - 0.1
		end

	elseif randBuffDebuff == 9 then
		if (cacheFlag == CacheFlag.CACHE_LUCK) then
			player.Luck = player.Luck + 2
		end
		if (cacheFlag == CacheFlag.CACHE_FIREDELAY) then
			player.MaxFireDelay = player.MaxFireDelay + 1
		end

	elseif randBuffDebuff == 10 then
		if (cacheFlag == CacheFlag.CACHE_FIREDELAY) then
			effTearsDion = player.MaxFireDelay - 5
			effTearsDion = math.min(2, effTearsDion) --to ensure it doesn't go below the tear cap
			player.MaxFireDelay = player.MaxFireDelay - effTearsDion
		end
		if (cacheFlag == CacheFlag.CACHE_DAMAGE) then
			player.Damage = player.Damage - 0.7
		end

	elseif randBuffDebuff == 11 then
		if (cacheFlag == CacheFlag.CACHE_FIREDELAY) then
			effTearsDion = player.MaxFireDelay - 5
			effTearsDion = math.min(2, effTearsDion) --to ensure it doesn't go below the tear cap
			player.MaxFireDelay = player.MaxFireDelay - effTearsDion
		end
		if (cacheFlag == CacheFlag.CACHE_SPEED) then
			player.MoveSpeed = player.MoveSpeed - 0.1
		end

	elseif randBuffDebuff == 12 then
		if (cacheFlag == CacheFlag.CACHE_FIREDELAY) then
			effTearsDion = player.MaxFireDelay - 5
			effTearsDion = math.min(2, effTearsDion) --to ensure it doesn't go below the tear cap
			player.MaxFireDelay = player.MaxFireDelay - effTearsDion
		end
		if (cacheFlag == CacheFlag.LUCK) then
			player.Luck = player.Luck - 1
		end

	end
end

greekdion_mod:AddCallback(ModCallbacks.MC_POST_UPDATE, greekdion_mod.roomTracker_Dion)
greekdion_mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, greekdion_mod.cacheUpdate_Dion)
