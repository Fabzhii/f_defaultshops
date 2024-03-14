Config = {}

Config.Language = 'DE'
Config.Locales = {
    ['DE'] = {
        ['interact'] = {'[E] - Mit %s interagieren', nil},
        ['no_money'] = {'Du hast nicht genügend Geld dabei!', 'error'},
        ['no_access'] = {'Du hast auf diesen Shop keinen Zugriff!', 'error'},
    },
    ['EN'] = {
        ['interact'] = {'[E] - Interact with %s', nil},
        ['no_money'] = {'You dont have enough money with you!', 'error'},
        ['no_access'] = {'You do not have access to this shop!', 'error'},
    },
}

Config.Shops = {
    {
        coords = vector3(115.9098, -203.1144, 54.6749),
        name = 'Phone Shop',
        job = nil,
        blip = {
            id = 59,
            color = 26,
            scale = 0.7,
        },
        marker = {
            id = 21,
            size = 1.0,
            color = {r = 255, g = 255, b = 255, a = 180},
        },
        items = {
            {item = 'smartphone', price = 950},
            {item = 'simcard', price = 50},
        },
    },
}

Config.Notifcation = function(notify)
    local message = notify[1]
    local notify_type = notify[2]
    lib.notify({
        position = 'top-right',
        description = message,
        type = notify_type,
    })
end 

Config.InfoBar = function(info, toggle)
    local message = info[1]
    local notify_type = info[2]
    if toggle then 
        lib.showTextUI(message, {position = 'left-center'})
    else 
        lib.hideTextUI()
    end
end 