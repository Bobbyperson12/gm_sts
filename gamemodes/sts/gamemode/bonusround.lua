function deathmatchKill(victim, inflictor, attacker)
    if attacker == victim then
        attacker:PrintMessage(HUD_PRINTTALK, "Quit killing yourself")
    elseif attacker:IsPlayer() then
        local teamnum = attacker:Team()

        if teamnum == victim:Team() then
            attacker:PrintMessage(HUD_PRINTTALK, "Quit Team Killing")
        else
            if teamnum == 1 then
                PrintMessage(HUD_PRINTTALK, "Blue Team Gained a Point!")
            elseif teamnum == 2 then
                PrintMessage(HUD_PRINTTALK, "Red Team Gained a Point!")
            elseif teamnum == 3 then
                PrintMessage(HUD_PRINTTALK, "Green Team Gained a Point!")
            elseif teamnum == 4 then
                PrintMessage(HUD_PRINTTALK, "Yellow Team Gained a Point!")
            end
            return teamnum
        end
    end
    return 0
end

hook.Add("PlayerDeath", "Deathmatch Add Points", deathmatchKill) -- this can be on forever cause if someone figures out a way to kill outside of a bonus round thats funny asf

function getBonusRoundBeginFunc()

    local lookupTable = {
        ["waiting_lobby_mapleverb_lake"] = beginElMatador, 
        ["waiting_lobby_mapleverb_blue"] = beginSpaceSMGs, 
        ["waiting_lobby_mapleverb_green"] = beginCrabRave, 
        ["waiting_lobby_mapleverb_boomstick"] = beginBoomstick, 
        ["waiting_lobby_mapleverb_ctf"] = beginCTF, 
        ["waiting_lobby_mapleverb_battery"] = beginBattery, 
        ["waiting_lobby_mapleverb_ravsurv"] = beginRavenholm, 
        ["waiting_lobby_mapleverb_rav"] = beginHl2dm, 
        ["waiting_lobby_mapleverb_cit"] = beginDodgeball, 
        ["waiting_lobby_mapleverb_square"] = beginLookUp
    }

    local br = lookupTable[nextBR]

    return br
end

function getBonusRoundEndFunc()

    local lookupTable = {
        ["waiting_lobby_mapleverb_lake"] = endElMatador, 
        ["waiting_lobby_mapleverb_blue"] = endSpaceSMGs, 
        ["waiting_lobby_mapleverb_green"] = endCrabRave, 
        ["waiting_lobby_mapleverb_boomstick"] = endBoomstick, 
        ["waiting_lobby_mapleverb_ctf"] = endCTF, 
        ["waiting_lobby_mapleverb_battery"] = endBattery, 
        ["waiting_lobby_mapleverb_ravsurv"] = endRavenholm, 
        ["waiting_lobby_mapleverb_rav"] = endHl2dm, 
        ["waiting_lobby_mapleverb_cit"] = endDodgeball, 
        ["waiting_lobby_mapleverb_square"] = endLookUp
    }

    local br = lookupTable[nextBR]

    return br
end

function elMatadorTeleport(ply)
    -- this function will only be run after one death in the minigame in which case they need to be teleported above
end

function beginElMatador()
    hook.add("PlayerSpawn", "ElMatadorTP", elMatadorTeleport)
end

function endElMatador()
    hook.remove("PlayerSpawn", "ElMatadorTP")
end

function SpaceSMGsTeleport()
    -- this is a dm minigame which requires random tps around the map
end

function beginSpaceSMGs()
    hook.add("PlayerSpawn", "SpaceSMGTP", SpaceSMGsTeleport)
end

function endSpaceSMGs()
    hook.remove("PlayerSpawn", "SpaceSMGTP")
end

function CTFTeleport(ply)
    -- this is a dm minigame which requires random tps around the map
end

function beginCTF()
    hook.add("PlayerSpawn", "CTFTP", CTFTeleport)
end

function endCTF()
    hook.remove("PlayerSpawn", "CTFTP")
end

function BatteryTeleport(ply)
    -- this is a dm minigame which requires random tps around the map
end

function beginBattery()
    hook.add("PlayerSpawn", "BatteryTP", BatteryTeleport)
end

function endBattery()
    hook.remove("PlayerSpawn", "BatteryTP")
end

function crabRaveTeleport(ply)
    -- survival minigame, players need to be teleported to a safe location
end

function beginCrabRave()
    hook.add("PlayerSpawn", "CrabRaveTP", crabRaveTeleport)
end

function endCrabRave()
    hook.remove("PlayerSpawn", "CrabRaveTP")
end

function boomstickTeleport()

end

function beginBoomstick()
    hook.add("PlayerSpawn", "BoomstickTP", boomstickTeleport)
end

function endBoomstick()
    hook.remove("PlayerSpawn", "BoomstickTP")
end

function ravenholmTeleport()

end

function beginRavenholm()
    hook.add("PlayerSpawn", "RavenholmTP", ravenholmTeleport)
end

function endRavenholm()
    hook.remove("PlayerSpawn", "RavenholmTP")
end

function hl2dmTeleport()

end

function beginHl2dm()
    hook.add("PlayerSpawn", "HL2TP", hl2dmTeleport)
end

function endHl2dm()
    hook.remove("PlayerSpawn", "HL2TP")
end

function dodgeballTeleport()

end

function beginDodgeball()
    hook.add("PlayerSpawn", "DodgeballTP", dodgeballTeleport)
end

function endDodgeball()
    hook.remove("PlayerSpawn", "DodgeballTP")
end

function lookUpTeleport()

end

function beginLookUp()
    hook.add("PlayerSpawn", "LookUpTP", lookUpTeleport)
end

function endLookUp()
    hook.remove("PlayerSpawn", "LookUpTP")
end