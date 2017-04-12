
local greekdeme_mod = RegisterMod( "gdeme", 1)
local greekdeme_item = Isaac.GetItemIdByName( "Demeter" )

local prevIsCleared_deme = false
local heartChance_deme = 0
local devilDealHeartChance_deme = 0
local prevItems_deme = 0
local prevHearts_deme = 24
local prevActive_deme = 0

function greekdeme_mod:clearRoomDetection_deme()
	sfxManager = SFXManager()
	local player = Isaac.GetPlayer(0)
	if (player:HasCollectible(greekdeme_item)) then
		if (Game():GetLevel():GetCurrentRoom():IsClear() and prevIsCleared == false) then
			heartChance_deme = math.random(1,6)
			if heartChance_deme == 1 then
				player:AddHearts(1)
				sfxManager:Play(SoundEffect.SOUND_VAMP_GULP,1.0,0,false,1.0)
			end
		end
	end
	prevIsCleared = Game():GetLevel():GetCurrentRoom():IsClear()
end

function greekdeme_mod:ifTakenDevilDeal_deme()
	local player = Isaac.GetPlayer(0)

	if (player:HasCollectible(greekdeme_item)) then
		if (player:GetCollectibleCount() > prevItems_deme or player:GetActiveItem() ~= prevActive_deme) then
			if player:GetMaxHearts() < prevHearts_deme then
				if (Game():GetLevel():GetCurrentRoom():GetType() == RoomType.ROOM_DEVIL) then
					devilDealHeartChance_deme = math.random(1,4)
				end
			end

		prevItems_deme = player:GetCollectibleCount()
		prevHearts_deme = player:GetMaxHearts()
		prevActive_deme = player:GetActiveItem()
		end
	end
end

function greekdeme_mod:givingHealthContainer_deme()
	local player = Isaac.GetPlayer(0)
	sfxManager = SFXManager()

	if devilDealHeartChance_deme == 1 then
		sfxManager:Play(SoundEffect.SOUND_POWERUP2,1.0,0,false,1.1)
		player:AddMaxHearts(2)
		player:AddHearts(2)
		devilDealHeartChance_deme = 0
	else devilDealHeartChance_deme = 0
	end
end

greekdeme_mod:AddCallback(ModCallbacks.MC_POST_UPDATE, greekdeme_mod.clearRoomDetection_deme)
greekdeme_mod:AddCallback(ModCallbacks.MC_POST_UPDATE, greekdeme_mod.ifTakenDevilDeal_deme)
greekdeme_mod:AddCallback(ModCallbacks.MC_POST_UPDATE, greekdeme_mod.givingHealthContainer_deme)
