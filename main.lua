local Mod = RegisterMod("Afterlife - Chars", 1)
 
local attributes = { 
    -- Attributes are added on top of Isaacs normal stats
	DAMAGE = 2, 
    SPEED = -0.3,
    SHOTSPEED = -1,
    TEARHEIGHT = 2,
    TEARFALLINGSPEED = 0,
    LUCK = 1,
    FLYING = true,                                 
    TEARFLAG = 0, -- 0 is default
    TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0)  -- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}
 
function Mod:onCache(player, cacheFlag) -- I do mean everywhere!
    if player:GetName() == "ruby" then -- Especially here!I
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + attributes.DAMAGE
        end
        if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
            player.ShotSpeed = player.ShotSpeed + attributes.SHOTSPEED
        end
        if cacheFlag == CacheFlag.CACHE_RANGE then
            player.TearHeight = player.TearHeight - attributes.TEARHEIGHT
            player.TearFallingSpeed = player.TearFallingSpeed + attributes.TEARFALLINGSPEED
        end
        if cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed + attributes.SPEED
        end
        if cacheFlag == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck + attributes.LUCK
        end
        if cacheFlag == CacheFlag.CACHE_FLYING and attributes.FLYING then
            player.CanFly = true
        end
        if cacheFlag == CacheFlag.CACHE_TEARFLAG then
            player.TearFlags = player.TearFlags | attributes.TEARFLAG
        end
        if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
            player.TearColor = attributes.TEARCOLOR
        end
    end
end
 
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.onCache)
