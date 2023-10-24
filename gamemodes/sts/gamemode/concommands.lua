-- Define team properties
local teamProperties = {
    [1] = {
        color = Vector(0, 0, 1.0),
        namePrefix = "Blueply"
    },
    [2] = {
        color = Vector(1.0, 0, 0),
        namePrefix = "Redply"
    },
    [3] = {
        color = Vector(0.0, 1.0, 0.0),
        namePrefix = "Greenply"
    },
    [4] = {
        color = Vector(1.0, 1.0, 0.0),
        namePrefix = "Yellowply"
    },
    [0] = {
        color = Vector(0.0, 0.0, 0.0),
        namePrefix = ""
    }
}

function setTeamFull(ply, teamID)
    -- Clearer message
    local teamEmpty = team.NumPlayers(teamID) == 0
    print("The team you want to join IS" .. (teamEmpty and "" or " NOT") .. " empty.")
    -- Setting the team
    ply:SetTeam(teamID)
    -- Using team properties dictionary to reduce code repetition
    local props = teamProperties[teamID]
    ply:SetKeyValue("targetname", props.namePrefix .. ply:GetName())
    ply:SetPlayerColor(props.color)
    ply:SetModel("models/player/police.mdl")
end

concommand.Add("set_team", function(ply, cmd, args)
    local input = tonumber(args[1])

    if input == nil or (input > 4 or input < 0) then
        print("0 - No team\n1 - Blue\n2 - Red\n3 - Green\n4 - Yellow")
        return
    end

    setTeamFull(ply, input)
end)


-- broke
concommand.Add("pntadd", function(ply, cmd, args)
    for i, v in ipairs(player.GetAll()) do
        v:SetNWInt("researchPoints", v:GetNWInt("researchPoints") + 100)
    end

    print("Point Boost")
end, nil, nil, FCVAR_CHEAT)

concommand.Add("stsgod", function(ply, cmd, args)
    if not args[1] then
        print(ply:GetNWInt("stsgod"))

        return
    end

    local amount = args[1]
    ply:SetNWInt("stsgod", tonumber(amount))
    print(ply:GetNWInt("stsgod"))
end, nil, nil, FCVAR_CHEAT)

-- broke
concommand.Add("newround", function(args)
    for k, v in ipairs(ents.GetAll()) do
        if v:GetName() == "newround_relay_nodelay" then
            v:Fire("Trigger")
        end
    end
end, nil, nil, FCVAR_CHEAT)

concommand.Add("flagspwn", function(args)
    for k, v in ipairs(ents.GetAll()) do
        if v:GetName() == "mapctf_flag_template" then
            v:Fire("ForceSpawn")
        end
    end
end, nil, nil, FCVAR_CHEAT)

concommand.Add("batteryspwn", function(args)
    for k, v in ipairs(ents.GetAll()) do
        if v:GetName() == "mapctf_battery_tp1" then
            v:Fire("ForceSpawn")
        end
    end
end, nil, nil, FCVAR_CHEAT)

concommand.Add("reset_game", function(ply, cmd, args)
    gameReset()
end, nil, nil, FCVAR_CHEAT)

-- this func will make the gamemode unfriendly to dedicated servers, needs to be automated or have additional checks
concommand.Add("reset_game_solo", function(ply, cmd, args)
    if tonumber(player.GetCount()) == 1 then
        print("\n\n\nYou are alone, so you can reset the map \nThanks for cleaning up the server! \n\n-Tergative\n\n\n\n")
        gameReset()
    else
        print("You are not alone")
    end
end)