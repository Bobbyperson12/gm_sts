LoadedSounds = LoadedSounds or {}

mainTrack = mainTrack or nil
mainTrackSound = 1

function playGlobalSound( FileName, teamID )
    local sound
    local filter
    teamID = teamID or -1
    if SERVER then
        filter = RecipientFilter()
        if teamID == -1 then
            filter:AddAllPlayers()
        else
            filter:AddRecipientsByTeam( teamID )
        end
    end
    if SERVER or LoadedSounds[FileName] == nil then
        -- The sound is always re-created serverside because of the RecipientFilter.
        sound = CreateSound( game.GetWorld(), FileName, filter ) -- create the new sound, parented to the worldspawn (which always exists)
        if sound then
            sound:SetSoundLevel( 0 ) -- play everywhere
            if CLIENT then
                LoadedSounds[FileName] = { sound, filter } -- cache the CSoundPatch
            end
        end
    else
        sound = LoadedSounds[FileName][1]
        filter = LoadedSounds[FileName][2]
    end
    if sound then
        if CLIENT then
            sound:Stop() -- it won't play again otherwise
        end
        sound:Play()
    end
    return sound -- useful if you want to stop the sound yourself
end


function beginPlayingMainTrack()
    mainTrack = playGlobalSound("bm_sts_sounds/miami_sky_hq.wav")
    -- PrintMessage(HUD_PRINTTALK, "playing track")
    timer.Create("RepeatTrack", 103, 0, function()
        mainTrack = playGlobalSound("bm_sts_sounds/miami_sky_hq.wav")
        -- PrintMessage(HUD_PRINTTALK, "playing track again")
        if mainTrackSound == 0 then
            mainTrack:ChangeVolume(0, 0)
            -- PrintMessage(HUD_PRINTTALK, "zero sound")
        end
    end)
end

function muteMainTrack()
    mainTrackSound = 0
    if mainTrack then
        mainTrack:ChangeVolume(0, 2)
    end
end

function unmuteMainTrack()
    mainTrackSound = 1
    if mainTrack then
        mainTrack:ChangeVolume(1, 2)
    end
end

-- this is to tell the garbage collector that these variables are 
-- still being used, otherwise sound gets cut every time it runs
-- ! WARNING: sounds will not be freed from memory, and this will cause a memory leak. it may be 
-- ! worthwile to manually free from memory via LoadedSounds[FileName] = nil after stopping 
-- ! if sounds are big or high in quantity, as the 32 bit version of gmod will crash at 4 gb of mem used
-- TODO: Find a better solution
function keepSoundAlive()
    timer.Simple(99999999999, function()
        LoadedSounds = LoadedSounds or {}
        mainTrack = mainTrack or nil
        mainTrackSound = mainTrackSound or 1
    end)
end

keepSoundAlive()