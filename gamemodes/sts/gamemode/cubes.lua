Cube = {
    mob = "",
    level = 1,
    rarity = 1,
    strength = 1,
    entity = ""
}

-- RARITY NUMBERS NOT ACCURATE. ASK TERGATIVE.
function Cube.randomize()
    Cube.mob = math.random(1, 9)

    if Cube.level == 1 then
        Cube.rarity = 1
    elseif Cube.level == 2 then
        Cube.rarity = math.random(1, 2)
    elseif Cube.level == 3 then
        Cube.rarity = math.random(2, 3)
    elseif Cube.level == 4 then
        Cube.rarity = math.random(2, 4)
    elseif Cube.level == 5 then
        Cube.rarity = math.random(3, 4)
    else
        print("Malformed cube at " .. Cube.entity .. "\nPlease screenshot and report in the discord!")

        return false
    end

    return true
end

function Cube.upgrade()
    if Cube.rarity ~= 5 then
        Cube.rarity = Cube.rarity + 1
        Cube.randomize()

        return true
    end
end

function Cube.canUpgrade(points)
    local cost = Cube.level * 6

    if points >= cost then
        return true
    else
        return false
    end
end

function Cube.changeColor()
    local ent = Cube.getEntity()

    if Cube.level == 1 then
        ent:SetColor(138, 21, 255, 255)
    elseif Cube.level == 2 then
        ent:SetColor(0, 0, 255, 255)
    elseif Cube.level == 3 then
        ent:SetColor(0, 255, 0, 255)
    elseif Cube.level == 4 then
        ent:SetColor(4, 186, 255, 255)
    elseif Cube.level == 5 then
        ent:SetColor(185, 185, 255, 255)
    else
        ent:SetColor(0, 0, 0, 255)
    end
end

function Cube.getEntity()
    for i, ent in ipairs(ents.GetAll()) do
        if ent:GetName() == Cube.entity then return ent end
    end
end

function Cube.new(o)
    o = o or {} -- create object if user does not provide one
    setmetatable(o, Cube)
    Cube.__index = Cube

    return o
end