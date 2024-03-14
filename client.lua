
local ox_inventory = exports.ox_inventory
local locales = Config.Locales[Config.Language]

Citizen.CreateThread(function()
    local small = {}
    local large = {}

    for k,v in pairs(Config.Shops) do 
        blip = AddBlipForCoord(v.coords)
        SetBlipSprite(blip, v.blip.id)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip,  v.blip.scale)
        SetBlipColour(blip, v.blip.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(blip)

        large[k] = lib.zones.sphere({
            coords = v.coords,
            radius = 25,
            debug = false,
            inside = function()
                DrawMarker(v.marker.id, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.marker.size, v.marker.size, v.marker.size, v.marker.color.r, v.marker.color.g, v.marker.color.b, v.marker.color.a, false, true, false, false) 
            end,
        })

        local small = lib.zones.sphere({
            coords = v.coords,
            radius = 1.0,
            debug = false,
            inside = function()
                if IsControlJustReleased(0, 38) then 
                    openShop(k)
                end
            end,
            onEnter = function()
                Config.InfoBar({(locales['interact'][1]):format(v.name), locales['interact'][2]}, true)
            end,
            onExit = function()
                Config.InfoBar({(locales['interact'][1]):format(v.name), locales['interact'][2]}, false)
            end,
        })
    end 
end)

function openShop(store)
    ESX.TriggerServerCallback('fdshop:getJob', function(xJob)  
        if Config.Shops[store].job == nil or Config.Shops[store].job == xJob then 
            local options = {}
            for k,v in pairs(Config.Shops[store].items) do
                table.insert(options, {
                    title = GetLabel(v.item) .. ' - ' .. v.price .. '$',
                    metadata = {
                        {label = 'Gegenstand', value = GetLabel(v.item)},
                        {label = 'Preis', value = v.price .. '$'},
                    },
                    onSelect = function()
                        if GetCount('money') >= v.price then 
                            TriggerServerEvent('fdshop:buy', v.item, v.price)
                        else 
                            Config.Notifcation(locales['no_money'])
                        end 
                        openShop(store)
                    end,
                })
            end 

            lib.registerContext({
                id = 'f_defaultshop',
                title = Config.Shops[store].name,
                options = options
            })
            lib.showContext('f_defaultshop')
        else 
            Config.Notifcation(locales['no_access'])
        end 
    end)
end 

function GetLabel(item)
    local label = ''
    for k,v in pairs(exports.ox_inventory:Items()) do 
        if v.name == item then 
            label = v.label
            break
        end 
    end 
    return(label)
end 

function GetCount(item)
    local count = 0
    for k,v in pairs(exports.ox_inventory:GetPlayerItems()) do 
        if v.name == item then 
            count = v.count
            break
        end 
    end 
    return(count)
end 