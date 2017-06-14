local greekpos_mod = RegisterMod( "gposeidon", 1)
greekpos_mod.COLLECTIBLE_POSEIDON = Isaac.GetItemIdByName("Poseidon")
Frame = Game():GetFrameCount()

function greekpos_mod:u()
	for playerNum = 1, Game():GetNumPlayers() do
		local player = Game():GetPlayer(playerNum) -- Get player, in case of multiplayer
		if player:HasCollectible(greekpos_mod.COLLECTIBLE_POSEIDON) then
			if not greekpos_mod.HasPos then -- First pickup
				greekpos_mod.HasPos = true
			end
		end
	end
end

function greekpos_mod:onPostUpdate()
local player = Isaac.GetPlayer(0)
	if player:HasCollectible(greekpos_mod.COLLECTIBLE_POSEIDON) then
		if player:GetMovementDirection() ~= Direction.NO_DIRECTION then
			Isaac.Spawn(EntityType.ENTITY_EFFECT,EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL,0,player.Position,Vector(0,0),player):ToEffect():SetRadii(5,20)
		end
	end
end

greekpos_mod:AddCallback(ModCallbacks.MC_POST_UPDATE,greekpos_mod.onPostUpdate)
greekpos_mod:AddCallback(ModCallbacks.MC_POST_UPDATE, greekpos_mod.u)
