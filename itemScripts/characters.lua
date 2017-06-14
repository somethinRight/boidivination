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

local curseID = Isaac.GetCurseIdByName("Curse of Haste") - 1 -- get ID of Curse of the HASTE
local count = 0;
function Mod:PostCurseEval(Curses)
  if(math.random() < 0.3) then -- Chance of 50% to get the CURSE 
    return Curses | 1 << curseID
  else
    return Curses;
  end
end

function Mod:PostUpdate()
  local jogo = Game(); -- Create the OBJECT GAME
  local p1 = Isaac.GetPlayer(0); -- GET THE PLAYER
  if jogo ~= nil then -- SEE IF THE GAME EXISTS AT LEAST
    curses = jogo:GetLevel():GetCurses(); -- GET ALL GAMES CURSES
    if(curses & 1 << curseID) ~= 0 then -- SEE IF THE CURSE ON THE FLOOR IS THE HASTE
      local room = jogo:GetRoom() -- GET EVERY ROOM ON THE FLOOR
      if(room:IsFirstVisit() or room:HasTriggerPressurePlates())then -- IF THE FIRST TIME IN THE ROOM ORHAS A BUTTON
        count = room:GetFrameCount() -- COUNT THE TIME IN EVERY ROOM
        if(room:GetAliveBossesCount()>0 or room:GetAliveEnemiesCount()>0) and (count >= 2700) then 
          p1:TakeDamage(1,DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player),0);-- DEAL DAMAGE TO THE PLAYER 1
        end
      end
    end
  end
end

function Mod:TimerScreen() -- SHOW THE TIMER ON THE SCREEN
  local game = Game();
  local room = game:GetRoom();
  curses = game:GetLevel():GetCurses(); -- GET ALL GAMES CURSES
  if(curses & 1 << curseID) ~= 0 then -- IF IS CURSE OF THE HASTE
    T = 90 - room:GetFrameCount()/30; -- GET TIME ON THE ROOM
    if T< 0 then T = 0 end -- if the time is negative only show ZERO
    Isaac.RenderText(string.format("Time: %.f",T),290,10,255,255,255,255); -- SHOW THE TIMER
  else
    Isaac.RenderText("",0,0,0,0,0,255) -- SHOWS NOTHING
  end
end

Mod:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL,Mod.PostCurseEval);
Mod:AddCallback(ModCallbacks.MC_POST_UPDATE,Mod.PostUpdate);
Mod:AddCallback(ModCallbacks.MC_POST_RENDER,Mod.TimerScreen);