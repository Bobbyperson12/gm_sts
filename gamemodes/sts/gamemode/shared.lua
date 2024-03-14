GM.Name = "sts"
GM.Author = "Tergative & Austin"
GM.Email = "N/A"
GM.Website = "N/A"
DeriveGamemode("sandbox")
team.SetUp(1, "Blue", Color(20, 20, 255))
team.SetUp(2, "Red", Color(255, 0, 0))
team.SetUp(3, "Green", Color(0, 255, 0))
team.SetUp(4, "Yellow", Color(255, 255, 0))
team.SetUp(0, "Empty", Color(50, 50, 50))
team.SetUp(5, "Spectator", Color(0, 0, 0))
teamval = {}
teamval["blue"] = 1
teamval["red"] = 2
teamval["green"] = 3
teamval["yellow"] = 4
teamval["empty"] = 0
teamval["spectator"] = 5
teamnums = {}
teamnums[1] = "blue"
teamnums[2] = "red"
teamnums[3] = "green"
teamnums[4] = "yellow"
teamnums[0] = "empty"
teamnums[5] = "spectator"

function GM:Initialize()
end
--dostuff
--yaaaaay