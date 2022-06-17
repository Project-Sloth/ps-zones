# REQUIRED: https://github.com/mkafrin/PolyZone

## The data passed into the exports is optional and not required.
## Each polyzone needs to have a UNIQUE NAME otherwise it will get triggered each time there is a zone.

## Events
### Client
```
RegisterNetEvent("ps-zones:enter", function(ZoneName, ZoneData)
    -- Code here
end)

RegisterNetEvent("ps-zones:leave", function(ZoneName, ZoneData)
    -- Code here
end)
```
### Server
```
RegisterNetEvent("ps-zones:enter", function(ZoneName, ZoneData)
    -- Code here
end)

RegisterNetEvent("ps-zones:leave", function(ZoneName, ZoneData)
    -- Code here
end)
```
## Client Exports:
```
exports["ps-zone"]:CreatePolyZone(name, points, data)

exports["ps-zone"]:CreateBoxZone(name, point, length, width, data)

exports["ps-zone"]:CreateCircleZone(name, point, radius, data)

exports["ps-zone"]:CreateEntityZone(name, entity, data)
```


## Examples:

```
-- Create Polyzone
exports["ps-zones"]:CreatePolyZone("poly-test", {
      vector2(-7.88, -1058.93),
      vector2(0.03, -1058.67),
      vector2(-3.75, -1054.05),
    }, {
        debugPoly = true,
        minZ =  38.16 - 1,
        maxZ =  38.16 + 1,
})

-- Create Box Zone
RegisterCommand("box", function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    exports["ps-zones"]:CreateBoxZone("box-test", coords, 2.0, 2.0, {
        debugPoly = true,
        minZ = coords.z - 1,
        maxZ = coords.z + 1,
    })
end)

-- Create Circle Zone
RegisterCommand("circle", function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    exports["ps-zones"]:CreateCircleZone("circle-test", coords, 5.0, {
        debugPoly = true,
        minZ = coords.z - 1,
        maxZ = coords.z + 1,
    })
end)

-- Create Entity Zone
RegisterCommand("entity", function()
    local ped = PlayerPedId()
    exports["ps-zones"]:CreateEntityZone("entity-test", ped, {
        debugPoly = true,
        useZ = false,
    })
end)

```
