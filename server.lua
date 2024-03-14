
local ox_inventory = exports.ox_inventory

ESX.RegisterServerCallback("fdshop:getJob", function(source, cb) 
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getJob().name)
end) 

RegisterServerEvent('fdshop:buy')
AddEventHandler('fdshop:buy', function(item, price)
    if exports.ox_inventory:CanCarryItem(source, item, 1, nil) then 
        exports.ox_inventory:RemoveItem(source, 'money', price, nil)
        exports.ox_inventory:AddItem(source, item, 1, nil)
    end 
end)