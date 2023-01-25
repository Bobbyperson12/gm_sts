AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("testhud.lua")
AddCSLuaFile("teamsetup.lua")
AddCSLuaFile("custommenu.lua")
AddCSLuaFile("concommands.lua")
AddCSLuaFile("bonusround.lua")

include("testhud.lua")
include("shared.lua")
include("teamsetup.lua")
include("custommenu.lua")
include("concommands.lua")
include("bonusround.lua")

--local beginon = 1
-- Idk what they do but glualint insists they are unused
--local open = false

function GM:PlayerLoadout(ply)
	return true
end

RunConsoleCommand("sv_gravity", "600")
RunConsoleCommand("sk_combine_s_kick", "6")

function GM:PlayerInitialSpawn(ply)
	allgonened()
	ply:SetMaxHealth(100)
	ply:SetHealth(100)
	ply:SetRunSpeed(400)
	ply:SetModel("models/player/group03m/male_07.mdl")
	ply:SetNWInt("combat", 0)
	ply:SetNWInt("stsgod", 0)
	ply:SetNWInt("dmpnt", 1)
	ply:SetNWInt("pickup", 0)
	ply:SetNWInt("desc", 1)
	ply:SetNWInt("researchPoints", 0)
	ply:ConCommand("set_team " .. 0)
end

function GM:PlayerSpawn(ply)
	checkbegin(ply)
end

function checkbegin(ply)
	for k, bib in ipairs(ents.GetAll()) do
		if bib:GetName() == "beginonoff" then
			local var = tonumber(bib:GetInternalVariable("Case16"))
			ply:SetNWInt("beginon", var)
		end
		if bib:GetName() == "waiting_startpnt_case" then
			local var = tonumber(bib:GetInternalVariable("Case16"))
			ply:SetNWInt("strtpnt", var)
		end
		if bib:GetName() == "waiting_score_case" then
			local var = tonumber(bib:GetInternalVariable("Case16"))
			ply:SetNWInt("strtround", var)
		end
	end
end

function bgin(x)
	for i, ply in ipairs(player.GetAll()) do
		ply:SetNWInt("beginon", tonumber(x))
	end
end

util.AddNetworkString("FMenu")


function scrnprint(x)
	local intype = string.sub(x,1,2)
	local inamount = string.sub(x,-2,-1)	
	if intype == "ro" then
		for i, ply in ipairs(player.GetAll()) do
			ply:SetNWInt("strtround", inamount)
		end
	end
	if intype == "sp" then
		for i, ply in ipairs(player.GetAll()) do
			ply:SetNWInt("strtpnt", inamount)
		end
	end
end

function spawnteams()
	for i, ply in ipairs(player.GetAll()) do
		ply:Spawn()
	end
end

--SCORE
function scoreadd(x)
	team.AddScore(x, 1)
end
function scorereset(x)
	team.SetScore(1, 0)
	team.SetScore(2, 0)
	team.SetScore(3, 0)
	team.SetScore(4, 0)
	for i, ply in ipairs(player.GetAll()) do
		ply:SetNWInt("researchPoints", x)
	end
end


function begin(x)
	beginon = x
end

--PLAYER USING

function GM:PlayerUse(ply, ent)
	if ent:GetName() == "waiting_blueteambutt" then
		ply:ConCommand("set_team 1")
	end
	if ent:GetName() == "waiting_redteambutt" then
		ply:ConCommand("set_team 2")
	end
	if ent:GetName() == "waiting_greenteambutt" then
		ply:ConCommand("set_team 3")
	end
	if ent:GetName() == "waiting_yellowteambutt" then
		ply:ConCommand("set_team 4")
	end
end

function GM:OnPlayerPhysicsPickup(ply, ent) 
	local enty = ent:GetName()
	
	if string.sub(enty,-4,-2) == "box" then
		ply:SetNWInt("pickup", 1)	
		local num = string.sub(enty,-1,-1)
		local length = string.len(enty) - 5
		local col = string.sub(enty,1,length)
		boxprint(ply,num,col)
	end
end

function GM:OnPlayerPhysicsDrop(ply, ent) 
	ply:SetNWInt("pickup", 0)
end


function boxprint(ply, boxnum, col)
	for k, u in ipairs(ents.GetAll()) do
		if u:GetName() == (col .. "_box" .. boxnum .. "_rarity_case") then
		local mobrarstr = u:GetInternalVariable("Case16")
		local mobrarval = u:GetInternalVariable("Case15")
			for k, v in ipairs(ents.GetAll()) do
				if v:GetName() == (col .. "_box" .. boxnum .. "_mobcase_" .. mobrarval) then
					local mobtype = v:GetInternalVariable("Case16")
					for k, x in ipairs(ents.GetAll()) do
						if x:GetName() == (col .. "_box" .. boxnum .. "_amountcounter_rand") then
							local mobnum = x:GetInternalVariable("Case16") -- Style Error: Are you egyptian? Whats with these fucking scope pyramids!?
							for k, x in ipairs(ents.GetAll()) do
								if x:GetName() == (col .. "_box" .. boxnum .. "_tech_casein") then	
									local mobtech = x:GetInternalVariable("Case16")
									ply:SetNWInt("pick_type", mobtype)
									ply:SetNWInt("pick_rar", mobrarstr)
									ply:SetNWInt("pick_tech", mobtech)
									ply:SetNWInt("pick_str", mobnum)
									ply:SetNWInt("pick_col", col)
								end
							end
						end
					end
				end
			end
		end
	end
end

function trigafford(y)
	local col = string.sub(y,1,-16)
	colnum = teamval[col]
	for i, ply in ipairs(player.GetAll()) do
		if ply:Team() == colnum then
			local points = tonumber(ply:GetNWInt("researchPoints"))
			if points >= 1 then
				for k, v in ipairs(ents.GetAll()) do
					if v:GetName() == y then
					v:Fire("Enable")
					end
				end
			else
				ply:PrintMessage(HUD_PRINTTALK, "\n\n\n\n\n\n\n\n\n\nCan\"t Afford\n-------------\n\n\n\n")
			end
		end 
	end 
end

function randomizeboxsub(box)
	-- local num = string.sub(box,-1,-1)
	local length = string.len(box) - 5
	local col = string.sub(box,1,length)
	colnum = teamval[col]
	for k, u in ipairs(ents.GetAll()) do
		if u:GetName() == (box .. "_tech_casein") then
			local subamount = (tonumber(u:GetInternalVariable("Case16"))) * 6
			if string.len(tostring(subamount)) == 1 then
				pointsub(tostring(col) .. "0" .. subamount)
			elseif string.len(tostring(subamount)) == 2 then
				pointsub(tostring(col) .. subamount)
			end
		end
	end
end


function randafford(boxname)
	-- local num = string.sub(boxname,-1,-1)
	local length = string.len(boxname) - 5
	local col = string.sub(boxname,1,length)
	colnum = teamval[col]
	for i, ply in ipairs(player.GetAll()) do
		if ply:Team() == colnum then
			local points = tonumber(ply:GetNWInt("researchPoints"))
			for k, u in ipairs(ents.GetAll()) do
				if u:GetName() == (boxname .. "_tech_casein") then
					if tonumber(u:GetInternalVariable("Case16")) < 5 then
						local mobtechcost = (u:GetInternalVariable("Case16") * 6)
						for k, i in ipairs(ents.GetAll()) do
							if i:GetName() == (boxname .. "_upgrade_case") then
								if tonumber(i:GetInternalVariable("Case01")) == 2 then
									if points >= mobtechcost then
										for k, v in ipairs(ents.GetAll()) do
											if v:GetName() == (col .. "_raradd_trig") then
												v:Fire("Enable")
											end
										end
									else
									ply:PrintMessage(HUD_PRINTTALK, "\n\n\n\n\n\n\n\n\n\nCan\"t Afford\n-------------\n\n\n\n")
									end
								elseif tonumber(i:GetInternalVariable("Case01")) == 1 then
									ply:PrintMessage(HUD_PRINTTALK, "\n\n\n\n\n\n\n\n\n\nTech Level Not Available\n-------------\n\n\n\n")
								else
									ply:PrintMessage(HUD_PRINTTALK, "Dude what did you do?")
								end
							end
						end
					else
					ply:PrintMessage(HUD_PRINTTALK, ".\n\n\n\n\n\n\n\n\n\nMax Level\n-------------\n\n\n\n")
					end
				end 
			end 
		end
	end
end




--RESEARCH POINTS EDITING
function pointsub(x)
	local amount = string.sub(x,-2,-1)
	local col = string.sub(x,1,string.len(x) - 2)
	colnum = teamval[col]
	for i, ply in ipairs(player.GetAll()) do
		if ply:Team() == colnum then
			ply:SetNWInt("researchPoints", ply:GetNWInt("researchPoints") - tonumber(amount))	
		end
	end
end

function pointadd(x)
	local amount = string.sub(x,-2,-1)
	local col = string.sub(x,1,string.len(x) - 2)
	colnum = teamval[col]
	for i, ply in ipairs(player.GetAll()) do
		if ply:Team() == colnum then
			ply:SetNWInt("researchPoints", tostring(tonumber(ply:GetNWInt("researchPoints")) + tonumber(amount)))	
		end
	end
end
function survpointadd(x)
	for i, ply in ipairs(player.GetAll()) do
		if ply:Team() == x then
			ply:SetNWInt("researchPoints", ply:GetNWInt("researchPoints") + 10)	
		end
	end
end


function broundtoggle(x)
	local amount = x
	if tonumber(amount) == 0 then
		print("Bonusrounds Disabled")
		for k, v in ipairs(ents.GetAll()) do
			if v:GetName() == "newround_counter" then
				v:Fire("Disable")
			end
			if v:GetName() == "bonusround_disable_relay" then
				v:Fire("Enable")
			end
		end
	elseif tonumber(amount) == 1 then
		print("Bonusrounds Enabled")
		for k, v in ipairs(ents.GetAll()) do
			if v:GetName() == "newround_counter" then
				v:Fire("Enable")
			end
			if v:GetName() == "bonusround_disable_relay" then
				v:Fire("Disable")
			end
		end
	else
		print("Invalid Entry")
	end
end
--TIMER STUFF

function roundend()

end

function roundbegin()
end

function colortest()
	for k, v in pairs(teamval) do
		if k ~= "empty" then
			if team.NumPlayers(v) == 0 then
				--print(k.." "..team.NumPlayers(v))
				for i, l in ipairs(ents.GetAll()) do
					if l:GetName() == (k .. "_excl_branch_round") then
						l:Fire("SetValue", "0")
					elseif l:GetName() == (k .. "_excl_branch_lobby") then
						l:Fire("SetValue", "0")
					end
				end
			end
			if team.NumPlayers(v) ~= 0 then
				--print(k.." "..team.NumPlayers(v))
				for i, l in ipairs(ents.GetAll()) do
					if l:GetName() == (k .. "_excl_branch_round") then
						l:Fire("SetValue", "1")
					elseif l:GetName() == (k .. "_excl_branch_lobby") then
						l:Fire("SetValue", "1")
					end
				end
			end	
		end
	end
	for k, v in ipairs(ents.GetAll()) do
		if v:GetName() == "colortest_relay" then
			v:Fire("Trigger")
		end
	end
end


function GM:PlayerDisconnected(ply)
	print("A player has disconnected")
	print(ply:Name() .. " has left the server.")
	colortest()
	timer.Simple(10, allgonetest)
end


function allgonetest()
	print(tonumber(player.GetCount()))
	if tonumber(player.GetCount()) == 0 then
		print("Server Empty")
		endtimerstart()
	else 
		print("Server Not Empty")
	end
end

function endtimerstart()
	timer.Create("endtimer", 50, 1, gamereset)
end

function allgonened()
	if (timer.Exists("endtimer")) then
		print("Server Reloaded")
		timer.Remove("endtimer")
	end
end

function yip()
	print("yip")
end

function gamereset()
	for i, x in ipairs(player.GetAll()) do
		x:SetHealth(100)
		x:SetNWInt("combat", 0)
		x:SetNWInt("timon", 0)
		scorereset(0)
		x:SetKeyValue("targetname", x:GetName())
		x:SetKeyValue("rendercolor", "255 255 255")
		x:SetTeam(0)
		x:ConCommand("set_team 0")
	end
	game.ConsoleCommand("gmod_admin_cleanup\n")
	game.ConsoleCommand("sv_gravity 600\n")
	for i, x in ipairs(player.GetAll()) do
		x:Spawn()
		x:SetNWInt("beginon", 1)
		x:SetNWInt("strtround", 5)
		x:SetNWInt("strtpnt", 20)
	end
	if (timer.Exists("endtimer")) then
		print("Game Restarted")
		timer.Remove("endtimer")
	end
end




