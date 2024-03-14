CreateConVar("sts_starting_points", "20", {FCVAR_GAMEDLL, FCVAR_REPLICATED}, "Starting points, no effect after game start.", 1, 80)
CreateConVar("sts_total_rounds", "5", {FCVAR_GAMEDLL, FCVAR_REPLICATED}, "Amount of rounds to play. No effect after game start.", 1, 24)
CreateConVar("sts_minimum_players", "2", {FCVAR_GAMEDLL}, "Minimum players required before game can start.", 0, 16)
CreateConVar("sts_outfitter_support", "0", {FCVAR_GAMEDLL}, "Change how team recognition is handled if using outfitter.", 0, 1)
CreateConVar("sts_forbid_dev_room", "1", {FCVAR_GAMEDLL}, "Whether or not to forbid access to the secret dev room.", 0, 1)
CreateConVar("sts_disable_settings_buttons", "0", {FCVAR_GAMEDLL}, "Whether or not the lobby buttons should do anything.", 0, 1)
CreateConVar("sts_episodic_content", "0", {FCVAR_GAMEDLL, FCVAR_REPLICATED}, "Whether or not to add episodic mobs to the mob pool.", 0, 1)
CreateConVar("sts_force_bonus_rounds", "-1", {FCVAR_GAMEDLL}, "1 - Force bonus rounds on\n0 - Force Nothing\n-1 - Force bonus rounds off.", -1, 1)
CreateConVar("sts_random_teams", "0", {FCVAR_GAMEDLL}, "0 - Allow players to choose teams\n1 - Random two teams\n2 - Random Four teams\n3 - Random\nIf this is set to anything besides 0, the team selection will be locked. No effect after game start.", 0, 3)
-- CreateConVar("sts_classic", "0", {FCVAR_GAMEDLL, FCVAR_REPLICATED}, "0 - Use new announcer\n1 - Use old announcer", 0, 1)
CreateConVar("sts_allow_team_swapping", "0", {FCVAR_GAMEDLL}, "0 - Do not allow swapping teams midgame\n 1 - Allow swapping teams mid game", 0, 1)
CreateConVar("sts_deathmatch_points", "1", {FCVAR_GAMEDLL}, "Determine point reward for kills in bonus rounds.")
RunConsoleCommand("sv_gravity", "600") -- reset gravity
RunConsoleCommand("sk_combine_s_kick", "6") -- change combine melee damage
RunConsoleCommand("sbox_noclip", "0") -- ! disable ability to noclip. remember to change me  to 0 before release
RunConsoleCommand("sv_noclipspeed", "50")
RunConsoleCommand("sk_citizen_heal_player_min_pct", "100")
RunConsoleCommand("sk_citizen_heal_player_min_forced", "1")
RunConsoleCommand("sk_citizen_heal_ally", "40")
RunConsoleCommand("sk_citizen_heal_ally_delay", "0.5") -- this might've not been set correctly prior and may cause a buff to medics

function GM:PlayerSpawnProp(ply, model)
    return false
end

function GM:PlayerSpawnEffect(ply, model)
    return false
end

function GM:PlayerSpawnNPC(ply, npc_type, weapon)
    return false
end

function GM:PlayerSpawnObject(ply, model, skin)
    return false
end

function GM:PlayerSpawnRagdoll(ply, model)
    return false
end

function GM:PlayerSpawnSENT(ply, class)
    return false
end

function GM:PlayerSpawnSWEP(ply, weapon, swep)
    return false
end

function GM:PlayerSpawnVehicle(ply, model, name, table)
    return false
end

function getMapSpawners(mapName)
    local teamNames = {"blue", "red", "green", "yellow"}
    local mapSpawners = {
        ["blue"] = {},
        ["red"] = {},
        ["green"] = {},
        ["yellow"] = {}
    }

    for _, ent in ipairs(ents.FindByClass("info_teleport_destination")) do
        for _, teamName in ipairs(teamNames) do
            -- mapciv_bluespawn1
            if string.find(ent:GetName(), "map" .. mapName .. "_" .. teamName .. "spawn") then
                table.insert(mapSpawners[teamName], ent)
            end
        end
    end

    return mapSpawners
end

function fillNextSpawns()
    nextMapSpawnLocations = {
        ["blue"] = {},
        ["red"] = {},
        ["green"] = {},
        ["yellow"] = {}
    }

    local mapSpawners = getMapSpawners(nextMap)
    PrintTable(mapSpawners)
    local teamNames = {"blue", "red", "green", "yellow"}
    for _, teamName in ipairs(teamNames) do
        for _, spawner in ipairs(mapSpawners[teamName]) do
            table.insert(nextMapSpawnLocations[teamName], {spawner:GetPos(), spawner:GetAngles()})
        end
    end
end

-- https://stackoverflow.com/a/15278426
function TableConcat(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]
    end

    return t1
end

-- https://stackoverflow.com/a/641993
function table.shallow_copy(t)
    local t2 = {}
    for k, v in pairs(t) do
        t2[k] = v
    end

    return t2
end


-- Starting to think that maybe the garbage collector is to blame for init.lua:542 being nil sometimes, so I'm going to try to keep the variables alive
function testKeepVariablesAlive()
    timer.Simple(999999999999, function()
        nextMapSpawnLocations = nextMapSpawnLocations or {}
        nextMap = nextMap or ""
        nextBR = nextBR or ""
    end)
end

testKeepVariablesAlive()