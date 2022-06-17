local Zones = {}
local Active = {}
local Combo = nil

local function UpdateComboZone(zone)
  if Combo == nil then

    Combo = ComboZone:Create({zone}, {name="combo", debugPoly=false})
    Active[zone["name"]] = zone
    
    Combo:onPlayerInOutExhaustive(function(isPointInside, point, insideZones, enteredZones, leftZones)

      if enteredZones then
        for i=1, #enteredZones do
          --print("Entered: " ..enteredZones[i]["name"])
          TriggerEvent("ps-zones:enter", enteredZones[i]["name"], enteredZones[i]["data"])
          TriggerServerEvent("ps-zones:enter", enteredZones[i]["name"], enteredZones[i]["data"])
        end
      end
  
      if leftZones then
        for i=1, #leftZones do
          --print("Left: " ..leftZones[i]["name"])
          TriggerEvent("ps-zones:leave", leftZones[i]["name"], leftZones[i]["data"])
          TriggerServerEvent("ps-zones:leave", leftZones[i]["name"], leftZones[i]["data"])
        end
      end
    end)

  else
    Combo:AddZone(zone)
    Active[zone["name"]] = zone
  end

end

local function ZoneExist(name)
  if Active[name] then
    return true
  else 
    return false 
  end
end

exports("CreateBoxZone", function(name, point, length, width, data)
  if ZoneExist(name) then return print("Zone with that name already exists") end
  if not data then data = {} end
  data.name = name
  local box = BoxZone:Create(point, length, width, data)
  UpdateComboZone(box)
end)

exports("CreatePolyZone", function(name, points, data)
  if ZoneExist(name) then return print("Zone with that name already exists") end
  if not data then data = {} end
  data.name = name
  local poly = PolyZone:Create(points, data)
  UpdateComboZone(poly)
end)

exports("CreateCircleZone", function(name, point, radius, data)
  if ZoneExist(name) then return print("Zone with that name already exists") end
  if not data then data = {} end
  data.name = name
  local circle = CircleZone:Create(point, radius, data)
  UpdateComboZone(circle)
end)

exports("CreateEntityZone", function(name, entity, data)
  if ZoneExist(name) then return print("Zone with that name already exists") end
  if not data then data = {} end
  data.name = name
  local entity = EntityZone:Create(entity, data)
  UpdateComboZone(entity)
end)

exports("DestroyZone", function(name)
  if not ZoneExist(name) then return print("Zone doesn't exist") end
  if Active[name] then
    Combo:RemoveZone(name)
    Active[name]:destroy()
    Active[name] = nil
  end
end)

RegisterCommand("poly", function()
    exports["ps-zones"]:CreatePolyZone("poly-test", {
      vector2(-7.88, -1058.93),
      vector2(0.03, -1058.67),
      vector2(-3.75, -1054.05),
    }, {
        debugPoly = true,
        minZ =  38.16 - 1,
        maxZ =  38.16 + 1,
    })
end)

RegisterCommand("boxd", function()
  exports["ps-zones"]:DestroyZone("test")
end)

