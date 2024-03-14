function startLobbySpawn()
    hook.Add("PlayerSpawn", "LobbySpawn", function(ply)
        if ply:Team() ~= 0 then
            local teams = {"waiting_bluetp", "waiting_redtp", "waiting_greentp", "waiting_yellowtp"}
            local spawnPoint = teams[ply:Team()]
            for _, ent in ipairs(ents.GetAll()) do
                if ent:GetName() == spawnPoint then
                    ply:SetPos(ent:GetPos())
                    ply:SetEyeAngles(ent:GetAngles())
                    break
                end
            end
        end
    end)
end

function stopLobbySpawn()
    hook.Remove("PlayerSpawn", "LobbySpawn")
end

function startGameSpawn()
    hook.Add("PlayerSpawn", "GameSpawn", function(ply)
        local chosen = math.random(1, 4)
        for _, ent in ipairs(ents.FindByClass("info_teleport_destination")) do
            if ent:GetName() == ("map" .. nextMap .. "_player_" .. getTeamNameFromID(ply:Team()) .. "tpdest" .. tostring(chosen)) then
                ply:SetPos(ent:GetPos())
                ply:SetEyeAngles(ent:GetAngles())
                -- print("map" .. nextMap .. "_player_" .. getTeamNameFromID(ply:Team()) .. "tpdest" .. tostring(chosen))
                break
            end
        end
    end)
end

function stopGameSpawn()
    hook.Remove("PlayerSpawn", "GameSpawn")
end

function startSurvivalBonusRoundSpawn(bonusRound)
    hook.Add("PlayerSpawn", "SurvivalBonusRoundSpawn", function(ply)
        -- do stuff
    end)
end

function stopSurvivalBonusRoundSpawn()
    hook.Remove("PlayerSpawn", "SurvivalBonusRoundSpawn")
end