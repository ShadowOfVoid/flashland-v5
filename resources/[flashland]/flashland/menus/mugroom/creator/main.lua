--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 29/08/2019 00:08
---

RegisterNetEvent('mugroom:updatePlayerData')
---@type table New player data
local createPlayer = {
    Model = nil,
    Position = nil,
    mp_f_freemode_01 = nil,
    mp_m_freemode_01 = nil,
}

local indexCharacter = {
    mp_f_freemode_01 = nil,
    mp_m_freemode_01 = nil,
}
local currentPlayerSex

local sexIndex

local updateModelActive = false

local spawnPoint = {
    data = {
        "Aeroport de los santos",
        "Aeroport de sandy shore",
    },
    index = 1,
}

AddEventHandler('mugroom:updatePlayerData', function(Content)
    createPlayer.Model = Content.Model
    createPlayer.Position = Content.Position

    createPlayer.mp_f_freemode_01 = Content.mp_f_freemode_01
    indexCharacter.mp_f_freemode_01 = Content.mp_f_freemode_01

    createPlayer.mp_m_freemode_01 = Content.mp_m_freemode_01
    indexCharacter.mp_m_freemode_01 = Content.mp_m_freemode_01

    currentPlayerSex = Content.Model

    if createPlayer.Model == "mp_f_freemode_01" then
        sexIndex = 1
    else
        sexIndex = 2
    end
end)

RMenu.Add('mugshot', 'creator', RageUI.CreateMenu("Personnage", "~b~NOUVEAUX PERSONNAGE"))
RMenu:Get('mugshot', 'creator').Closable = false

RMenu.Add('mugshot', 'heritage', RageUI.CreateSubMenu(RMenu:Get('mugshot', 'creator'), "Personnage", "~b~HÉRÉDITÉ"))


RMenu.Add('mugshot', 'faceFeature', RageUI.CreateSubMenu(RMenu:Get('mugshot', 'creator'), "Personnage", "~b~TRAITS DU VISAGE"))
RMenu:Get('mugshot', 'faceFeature').EnableMouse = true


RMenu.Add('mugshot', 'apparence', RageUI.CreateSubMenu(RMenu:Get('mugshot', 'creator'), "Personnage", "~b~APPARENCE"))
RMenu:Get('mugshot', 'apparence').EnableMouse = true


RMenu.Add('mugshot', 'clothes', RageUI.CreateSubMenu(RMenu:Get('mugshot', 'creator'), "Personnage", "~b~VÊTEMENTS"))

RMenu.Add('mugshot', 'roleplayContent', RageUI.CreateSubMenu(RMenu:Get('mugshot', 'creator'), "Personnage", "~b~INFORMATIONS PERSONNELLES"))

RMenu:Settings('mugshot', 'creator', 'Closable', false)

RMenu:Get('mugshot', 'heritage').Closed = function()
  --  CreatorZoomOut(GetCreatorCam())
   -- UpdateCreatorTick('FaceTurnEnabled', false)
end

RMenu:Get('mugshot', 'faceFeature').Closed = function()
  --   CreatorZoomOut(GetCreatorCam())
  --  UpdateCreatorTick('FaceTurnEnabled', false)
end
local function GetDictionary()
    if (GetEntityModel(GetPlayerPed(-1)) == GetHashKey('mp_m_freemode_01')) then
        return "mp_character_creation@customise@male_a"
    else
        return "mp_character_creation@customise@female_a"
    end
end

RMenu:Get('mugshot', 'apparence').Closed = function()
   -- CreatorZoomOut(GetCreatorCam())
  -- UpdateCreatorTick('FaceTurnEnabled', false)
end

RMenu:Get('mugshot', 'clothes').Closed = function()
   -- OnClothesClose()
end
TriggerEvent('instance:registerType', 'skin')
TriggerEvent('instance:registerType', 'property')
function OpenCreatorMenu()
    TriggerEvent('instance:create', 'skin')
    local playerPed = GetPlayerPed(-1)
    SetEntityCoordsNoOffset(playerPed,402.98,-996.39,-99.0,true,true,true)
    TaskPlayAnimAdvanced(0, GetDictionary(), "Intro", func_1532(), func_1531(), 8.0, -8.0, -1, 4608, 0, 2, 0)
    TaskPlayAnim(0, GetDictionary(), "Loop", 8.0, -4.0, -1, 513, 0, 0, 0, 0)
    RageUI.Visible(RMenu:Get('mugshot', 'creator'), true)
    FreezeEntityPosition(playerPed, true)
    updateModelActive = true
    onCreatorTick.LightRemote = true
end
RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
	if instance.type == 'skin' then
		TriggerEvent('instance:enter', instance)
	end
end)
function CloseCreatorMenu()
    TriggerEvent('instance:close')
    RageUI.Visible(RMenu:Get('mugshot', 'creator'), false)
    updateModelActive = false
    FreezeEntityPosition(playerPed, false)
    onCreatorTick.LightRemote = false
end
local creating = false
Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(1)

        creating = false
        
        if RageUI.Visible(RMenu:Get('mugshot', 'creator')) then
            creating = true
            RageUI.DrawContent({ header = true, instructionalButton = true }, function()
                ---Items

                RageUI.List(GetLabelText("FACE_SEX"), { GetLabelText("FACE_FEMALE"), GetLabelText("FACE_MALE") }, sexIndex, GetLabelText("FACE_MM_H2"), {}, true, function(Hovered, Active, Selected, Index)
                    if Active then
                        sexIndex = Index
                    end
                    if Selected then
                        if Index == 1 then
                            createPlayer.Model = "mp_f_freemode_01"
                        elseif Index == 2 then
                            createPlayer.Model = "mp_m_freemode_01"
                        end
                        UpdatePlayerPedFreemodeCharacter(GetPlayerPed(-1), createPlayer.Model, createPlayer[createPlayer.Model].Face, createPlayer[createPlayer.Model].Outfit, createPlayer[createPlayer.Model].Tattoo)
             --           CreatorUpdateModelAnim()
                    end
                end)

                RageUI.Button(GetLabelText("FACE_HERI"), GetLabelText("FACE_MM_H3"), {  }, true, function(Hovered, Active, Selected)
                    if Selected then
                 --       CreatorZoomIn(GetCreatorCam())
                   --     UpdateCreatorTick('FaceTurnEnabled', true)
                    end
                end, RMenu:Get('mugshot', 'heritage'))
                RageUI.Button(GetLabelText("FACE_FEAT"), GetLabelText("FACE_MM_H4"), {  }, true, function(Hovered, Active, Selected)
                    if Selected then
                     --   CreatorZoomIn(GetCreatorCam())
                       -- UpdateCreatorTick('FaceTurnEnabled', true)
                    end
                end, RMenu:Get('mugshot', 'faceFeature'))
                RageUI.Button(GetLabelText("FACE_APP"), GetLabelText("FACE_MM_H6"), { }, true, function(Hovered, Active, Selected)
                    if Selected then
                 --       CreatorZoomIn(GetCreatorCam())
                  --      UpdateCreatorTick('FaceTurnEnabled', true)
                    end
                end, RMenu:Get('mugshot', 'apparence'))

                RageUI.Button(GetLabelText("FACE_APPA"), GetLabelText("FACE_MM_H6"), {  }, true, function(Hovered, Active, Selected)
                    if Selected then
                  --      OnClothesOpen()
                    end
                end, RMenu:Get('mugshot', 'clothes'))

                RageUI.Button("Informations personnelles", "Inscrivez les informations personnelles de votre personnage. ~o~(Nom, Prénom, Âge).", { }, true, function(Hovered, Active, Selected)
                end, RMenu:Get('mugshot', 'roleplayContent'))

                RageUI.List("Point d'arrivée", spawnPoint.data, spawnPoint.index, "Le lieu sur lequel vous allez faire vos premiers pas sur l'île.", {}, true, function(Hovered, Active, Selected, Index)
                    spawnPoint.index = Index
                end)

                RageUI.Button(GetLabelText("FACE_SAVE"),nil, {
                    Color = {  }
                }, true, function(Hovered, Active, Selected)
                    if Selected then
                        creating = false
                        
                        createPlayer[createPlayer.Model].Identity.first_name = "x"
                        createPlayer[createPlayer.Model].Identity.last_name = "x"
                        createPlayer[createPlayer.Model].Identity.origine = "x"
                        createPlayer[createPlayer.Model].Identity.birth_date = "x"
                        if (createPlayer[createPlayer.Model].Identity.first_name ~= nil and createPlayer[createPlayer.Model].Identity.last_name ~= nil and createPlayer[createPlayer.Model].Identity.birth_date ~= nil and createPlayer[createPlayer.Model].Identity.origine ~= nil) then
                            CloseCreatorMenu() 
                            local ModelSelected = createPlayer[createPlayer.Model]
                            TriggerServerEvent('mugroom:RegisterNewPlayer', createPlayer.Model, ModelSelected.Face, ModelSelected.Outfit, ModelSelected.Tattoo, ModelSelected.Identity, spawnPoint)
                        --    TakePictureAndExit()
                            
                            DoScreenFadeOut(10)
                            TriggerEvent('mugroom:Finish', spawnPoint)
                        else
                            RageUI.Popup({
                                message = "Vous n'avez pas correctement rempli le formulaire d'identité",
                                colors = 130,
                                sound = {
                                    audio_name = "ERROR",
                                    audio_ref = "HUD_FRONTEND_DEFAULT_SOUNDSET"
                                }
                            })
                        end
                    end
                end)
            end, function()
                ---Panels
            end)
        end
        if RageUI.Visible(RMenu:Get('mugshot', 'heritage')) then
            CreatorMenuHeritage(indexCharacter, createPlayer)
            creating = true
        end
        if RageUI.Visible(RMenu:Get('mugshot', 'faceFeature')) then
            CreatorMenuFaceFeatures(indexCharacter, createPlayer)
            creating = true
        end
        if RageUI.Visible(RMenu:Get('mugshot', 'apparence')) then
            creating = true
            CreatorMenuAppearance(indexCharacter, createPlayer)
        end
        if RageUI.Visible(RMenu:Get('mugshot', 'clothes')) then
            creating = true
            CreatorMenuClothes(indexCharacter, createPlayer)
        end
        if RageUI.Visible(RMenu:Get('mugshot', 'roleplayContent')) then
            CreatorMenuRoleplay(indexCharacter, createPlayer)
            creating = true
        end
        if creating then
            local playerPed = GetPlayerPed(-1)
            SetEntityCoordsNoOffset(playerPed,402.98,-996.39,-99.0,true,true,true)
            TaskPlayAnimAdvanced(0, GetDictionary(), "Intro", func_1532(), func_1531(), 8.0, -8.0, -1, 4608, 0, 2, 0)
            TaskPlayAnim(0, GetDictionary(), "Loop", 8.0, -4.0, -1, 513, 0, 0, 0, 0)
        end
    end
end)

function func_1532()
    return vector3(404.834, -997.838, -98.841)
end

function func_1531()
    return vector3(0, 0, -38)
end