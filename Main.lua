local Zones = {}
local Active = {}
local Combo = nil


local function UpdateComboZone(zone)
  if Combo == nil then
    Combo = ComboZone:Create({zone}, {name="combo", debugPoly=false})
    Active[zone.name] = Combo
  else
    Active[zone.name] = Combo:AddZone(zone)
  end

  Combo:onPlayerInOutExhaustive(function(isPointInside, point, insideZones, enteredZones, leftZones)
        -- print("combo: isPointInside is", isPointInside, " for point", point)
        -- if insideZones then
        --   print("Inside Zones")
        --   for i=1, #insideZones do
        --     print("    data.foo=" .. tostring(insideZones[i].data.foo))
        --   end
        -- end
    if enteredZones then
      for i=1, #enteredZones do
        --print("Entered: " ..enteredZones[i].name)
        TriggerEvent("ps-zones:enter", enteredZones[i].name, enteredZones[i].data)
        TriggerServerEvent("ps-zones:enter", enteredZones[i].name, enteredZones[i].data)
      end
    end

    if leftZones then
      for i=1, #leftZones do
        --print("Left: " ..leftZones[i].name)
        TriggerEvent("ps-zones:leave", leftZones[i].name, leftZones[i].data)
        TriggerServerEvent("ps-zones:leave", leftZones[i].name, leftZones[i].data)
      end
    end
  end)
end

exports("CreateBoxZone", function(name, point, length, width, data)
    if not data then data = {} end
    data.name = name
    local box = BoxZone:Create(point, length, width, data)
    UpdateComboZone(box)
end)

exports("CreatePolyZone", function(name, points, data)
    if not data then data = {} end
    data.name = name
    local poly = PolyZone:Create(points, data)
    UpdateComboZone(poly)
end)

exports("CreateCircleZone", function(name, point, radius, data)
  if not data then data = {} end
  data.name = name
  local circle = CircleZone:Create(point, radius, data)
  UpdateComboZone(circle)
end)

exports("CreateEntityZone", function(name, entity, data)
  if not data then data = {} end
  data.name = name
  local entity = EntityZone:Create(entity, data)
  UpdateComboZone(entity)
end)

exports("DestroyZone", function(name)
  if Active[name] then
    Combo:RemoveZone(name)
    Active[name]:destroy()
    Active[name] = nil
  end
end)

RegisterCommand("box", function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    exports["ps-zones"]:CreateBoxZone("test", coords, 2.0, 2.0, {
        debugPoly = true,
        minZ = coords.z - 1,
        maxZ = coords.z + 1,
        debugColors = {
            walls = {0, 0, 255}
        }
    })
end)

