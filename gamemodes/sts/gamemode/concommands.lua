concommand.Add("set_team", function(ply, cmd, args)
    local inp = tonumber(args[1]) -- wtf is inp?

    if team.NumPlayers(inp) ~= 0 then
        print("The team you want to join is NOT empty.") -- clearer

        for i, x in ipairs(player.GetAll()) do
            if tonumber(x:Team()) == tonumber(inp) then
                ply:SetNWInt("researchPoints", x:GetNWInt("researchPoints"))
                break
            end
        end
    end

    if team.NumPlayers(inp) == 0 then
        print("The team you want to join IS empty.") -- clearer

        for k, v in ipairs(ents.GetAll()) do
            if v:GetName() == "beginonoff" then
                local defpnt = tonumber(v:GetInternalVariable("Case10"))

                if defpnt ~= "" then
                    ply:SetNWInt("researchPoints", defpnt)
                end
            end
        end
    end

    ply:SetTeam(inp)

    if ply:Team() == 1 then
        ply:SetKeyValue("targetname", "Blueply" .. ply:GetName())
        ply:SetKeyValue("rendercolor", "28 141 255")
        ply:SetModel("models/player/group03m/male_07.mdl")
    end

    if ply:Team() == 2 then
        ply:SetKeyValue("targetname", "Redply" .. ply:GetName())
        ply:SetKeyValue("rendercolor", "255 30 30")
        ply:SetModel("models/player/group03m/male_03.mdl")
    end

    if ply:Team() == 3 then
        ply:SetKeyValue("targetname", "Greenply" .. ply:GetName())
        ply:SetKeyValue("rendercolor", "30 255 30")
        ply:SetModel("models/player/group03m/male_09.mdl")
    end

    if ply:Team() == 4 then
        ply:SetKeyValue("targetname", "Yellowply" .. ply:GetName())
        ply:SetKeyValue("rendercolor", "255 230 0")
        ply:SetModel("models/player/group03m/male_01.mdl")
    end

    if ply:Team() == 0 then
        ply:SetKeyValue("targetname", ply:GetName())
    end

    colortest()
end)

concommand.Add("pntadd", function(ply, cmd, args)
    for i, v in ipairs(player.GetAll()) do
        v:SetNWInt("researchPoints", v:GetNWInt("researchPoints") + 100)
    end

    print("Point Boost")
end, nil, nil, FCVAR_CHEAT)

concommand.Add("deathpnt", function(ply, cmd, args)
    local amount = args[1]

    for i, x in ipairs(player.GetAll()) do
        x:SetNWInt("dmpnt", amount)
    end

    print("Each deathmatch kill will give you " .. amount .. " points")
end)

concommand.Add("stsgod", function(ply, cmd, args)
    local amount = args[1]
    ply:SetNWInt("stsgod", tonumber(amount))
end, nil, nil, FCVAR_CHEAT)

concommand.Add("newround", function(args)
    for k, v in ipairs(ents.GetAll()) do
        if v:GetName() == "newround_relay_nodelay" then
            v:Fire("Trigger")
        end
    end
end)

concommand.Add("flagspwn", function(args)
    for k, v in ipairs(ents.GetAll()) do
        if v:GetName() == "mapctf_flag_template" then
            v:Fire("ForceSpawn")
        end
    end
end)

concommand.Add("batteryspwn", function(args)
    for k, v in ipairs(ents.GetAll()) do
        if v:GetName() == "mapctf_battery_tp1" then
            v:Fire("ForceSpawn")
        end
    end
end)

concommand.Add("mob_descriptions", function(ply, cmd, args)
    local onoff = args[1]
    ply:SetNWInt("desc", tonumber(onoff))
end)

concommand.Add("bround_interval", function(ply, cmd, args)
    local amount = args[1]
    print("After every " .. amount .. " regular rounds, a bonus round will start")

    for k, v in ipairs(ents.GetAll()) do
        if v:GetName() == "newround_counter" then
            v:Fire("SetHitMax", tostring(amount))
        end
    end
end)

-- concommand.Add( "bround_toggle", function( ply, cmd, args)
-- local amount = args[1]
-- if tonumber(amount) == 0 then
-- print("Bonusrounds Disabled")
-- for k, v in ipairs(ents.GetAll()) do
-- if v:GetName() == ("newround_counter") then
-- v:Fire("Disable")
-- end
-- if v:GetName() == ("bonusround_disable_relay") then
-- v:Fire("Enable")
-- end
-- end
-- elseif tonumber(amount) == 1 then
-- print("Bonusrounds Enabled")
-- for k, v in ipairs(ents.GetAll()) do
-- if v:GetName() == ("newround_counter") then
-- v:Fire("Enable")
-- end
-- if v:GetName() == ("bonusround_disable_relay") then
-- v:Fire("Disable")
-- end
-- end
-- else
-- print("Invalid Entry")
-- end
-- end )
concommand.Add("reset_game", function(ply, cmd, args)
    gamereset()
end, nil, nil, FCVAR_CHEAT)

concommand.Add("reset_game_solo", function(ply, cmd, args)
    if tonumber(player.GetCount()) == 1 then
        print("\n\n\nYou are alone, so you can reset the map \nThanks for cleaning up the server! \n\n-Tergative\n\n\n\n")
        gamereset()
    else
        print("You are not alone")
    end
end)

concommand.Add("time_survival", function(ply, cmd, args)
    local amount = args[1]
    timeset(1, amount)
end)

concommand.Add("time_deathmatch", function(ply, cmd, args)
    local amount = args[1]
    timeset(2, amount)
end)

concommand.Add("tst", function(ply, cmd, args)
    allgonetest()
end)