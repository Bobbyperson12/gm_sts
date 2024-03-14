mobPrefixes = {"blue_", "red_", "green_", "yellow_"}
mobSuffix = "_template"
mobs = {}
-- Define the Mob object
Mob = {}
Mob.__index = Mob
-- Constructor for the Mob
function Mob.new(name, templates, multiplier, delay)
    -- This is the table we will return
    local EmptyMob = {
        name = name or "",
        templates = templates or {},
        multiplier = multiplier or 1, -- x3
        delay = delay or 1, -- spawning delay for groups
    }

    setmetatable( EmptyMob, Mob ) -- Set the metatable of 'EmptyMob' to 'Mob'
    return EmptyMob -- Return the 'EmptyMob' table, whose metatable is 'Mob'. This is our object
end

-- deprecated
function Mob:spawn(teamID, strength)
    local amount = self.multiplier * strength
    PrintMessage(HUD_PRINTTALK, "Spawning " .. self.name .. " with a multiplier of " .. amount .. " for team " .. teamID)
    for _, template in ipairs(self.templates) do
        for _, ent in ipairs(ents.GetAll()) do
            if ent:GetName() == mobPrefixes[teamID] .. template .. mobSuffix then
                timer.Create( "spawner" .. tostring(teamID), self.delay, amount, function()
                    ent:Fire("ForceSpawn")
                end)
            end
        end
    end
end

function Mob:getSpawns(teamID, strength)
    local amount = self.multiplier * strength
    local mobsToSpawn = {}
    for _, template in ipairs(self.templates) do
        for _, ent in ipairs(ents.GetAll()) do
            if ent:GetName() == mobPrefixes[teamID] .. template .. mobSuffix then
                for i = 1, amount do
                    table.insert(mobsToSpawn, {ent, self.delay})
                end
            end
        end
    end
    return mobsToSpawn
end


mobs[1] = {
    ["headcrab"] = Mob.new("Headcrab", {"npc_headcrab"}, 1),
    ["blackheadcrab"] = Mob.new("Black Headcrab", {"npc_blackheadcrab"}, 1),
    ["fastheadcrab"] = Mob.new("Fast Headcrab", {"npc_fastheadcrab"}, 1),
    ["manhack"] = Mob.new("Manhack", {"npc_manhack"}, 1),
    ["crowbar"] = Mob.new("Crowbar Guy", {"npc_crowbar"}, 1),
    ["stun"] = Mob.new("Stop Resisting", {"npc_stun"}, 1),
    ["torso"] = Mob.new("Zombie Torso", {"npc_torso"}, 1)
}

mobs[2] = {
    ["medic"] = Mob.new("Medic", {"npc_medic"}, 1),
    ["shotgun"] = Mob.new("Shotgun", {"npc_shotgun"}, 1),
    ["combinesmg"] = Mob.new("SMG", {"npc_combinesmg"}, 1),
    ["cop"] = Mob.new("Metrocop", {"npc_cop"}, 1),
    ["zombie"] = Mob.new("Zombie", {"npc_zombie"}, 1),
    ["antlion"] = Mob.new("Antlion", {"npc_antlion"}, 1),
    ["triplefastheadcrab"] = Mob.new("Fast Headcrab (x3)", {"npc_fastheadcrab"}, 3),
    ["doublestun"] = Mob.new("Stop Resisting (x2)", {"npc_stun"}, 2),
    ["triplemanhack"] = Mob.new("Manhack (x3)", {"npc_manhack"}, 3)
}

mobs[3] = {
    ["rocket"] = Mob.new("Rocketeer", {"npc_rocket"}, 1),
    ["barney"] = Mob.new("Barney", {"npc_barney"}, 1),
    ["vort"] = Mob.new("Vortigaunt", {"npc_vort"}, 1),
    ["monk"] = Mob.new("Monk", {"npc_monk"}, 1),
    ["suicide"] = Mob.new("Suicide", {"npc_suicide"}, 1),
    ["healer"] = Mob.new("Healer", {"npc_healer"}, 1),
    ["doublezombie"] = Mob.new("Zombie (x2)", {"npc_zombie"}, 1),
    ["beefcake"] = Mob.new("Beefcake", {"npc_beefcake"}, 1)
}

mobs[4] = {
    ["doublerocket"] = Mob.new("Rocketeer (x2)", {"npc_rocket"}, 2),
    ["quinzombie"] = Mob.new("Zombie (x5)", {"npc_zombie"}, 5, 0.5),
    ["antguard"] = Mob.new("Antlion Guard", {"npc_antguard"}, 1),
    ["valkyrie"] = Mob.new("Valkyrie", {"npc_valkyrie"}, 1),
    ["antlion"] = Mob.new("Antlion (x5)", {"npc_antlion"}, 5, 0.5),
    ["healer"] = Mob.new("Healer (x3)", {"npc_healer"}, 3),
    ["bombsquad"] = Mob.new("Bombing Squad", {"npc_bombsquad"}, 5),
    ["elitesquad"] = Mob.new("Elite Squad", {"npc_elitesquad_ar", "npc_elitesquad_shotgun"}, 1, 1)
}

cvars.AddChangeCallback("sts_episodic_content", function(convarName, valueOld, valueNew)
    if valueNew == 1 then
        mobs[3]["brute"] = Mob.new("Brute", {"npc_brute"}, 1)
        mobs[1]["fasttorso"] = Mob.new("Fast Torso", {"npc_fasttorso"}, 1)
    end
    if valueNew == 0 then
        mobs[3]["brute"] = nil
        mobs[1]["fasttorso"] = nil
    end
end)

-- function createTeamIndicator(ent, teamID)
--     local indicator = ents.Create("func_brush")
-- end