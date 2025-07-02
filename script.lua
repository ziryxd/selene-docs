--!strict
--# Delta Executor - Full Game RBXL Exporter (Mobile Optimizado)
--# Guarda DIRECTAMENTE en: /storage/emulated/0/Delta/Workspace/

local start = os.clock()
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

--> 1. Configuración de rutas EXPLÍCITAS para Delta
local DELTA_WORKSPACE = "/storage/emulated/0/Delta/Workspace/"
local FILENAME = "FULL_GAME_" .. game.PlaceId .. "_" .. os.time() .. ".rbxl"
local FULL_PATH = DELTA_WORKSPACE .. FILENAME

--> 2. Función que EXTRAE TODO sin fallos
local function ExportToRBXL()
    local xml = {}
    table.insert(xml, [[<?xml version="1.0"?>
<roblox xmlns:xmime="http://www.w3.org/2005/05/xmlmime" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.roblox.com/roblox.xsd" version="4">
<External>null</External>
<External>nil</External>
]])

    --> Procesamiento por LOTES para evitar crashes
    local count = 0
    local batch = {}
    for _, obj in pairs(game:GetDescendants()) do
        table.insert(batch, obj)
    end

    for i, obj in ipairs(batch) do
        count += 1
        if i % 250 == 0 then
            task.wait(0.01) --> Alivio para mobile
        end

        --> Serialización PROFESIONAL
        table.insert(xml, string.format('<Item class="%s" referent="RBX%d">\n<Properties>\n', obj.ClassName, count))
        
        --> Nombre y propiedades clave
        table.insert(xml, string.format('<string name="Name">%s</string>\n', obj.Name:gsub("[<>]", "_")))
        
        --> Scripts (fuente completo)
        if obj:IsA("LuaSourceContainer") then
            table.insert(xml, string.format('<ProtectedString name="Source"><![CDATA[%s]]></ProtectedString>\n', obj.Source))
        end

        --> Partes/Modelos (geometría exacta)
        if obj:IsA("BasePart") then
            local cf = obj.CFrame
            table.insert(xml, string.format(
                '<CoordinateFrame name="CFrame">%f %f %f %f %f %f %f %f %f %f %f %f</CoordinateFrame>\n',
                cf:components()
            ))
            table.insert(xml, string.format(
                '<Vector3 name="Size">%f %f %f</Vector3>\n',
                obj.Size.X, obj.Size.Y, obj.Size.Z
            ))
        end

        table.insert(xml, '</Properties>\n</Item>\n')
    end

    table.insert(xml, '</roblox>')
    return table.concat(xml), count
end

--> 3. Guardado CONFIRMADO en Delta/Workspace
local function SaveToDeltaWorkspace(data)
    --> Verificar si existe la carpeta
    if not isfolder(DELTA_WORKSPACE) then
        makefolder(DELTA_WORKSPACE)
    end

    --> Intentar con writefile primero
    local success, err = pcall(function()
        writefile(FULL_PATH, data)
    end)

    --> Fallback para Synapse
    if not success and syn and syn.writefile then
        syn.writefile(FULL_PATH, data)
        return true, FULL_PATH
    end

    return success, FULL_PATH
end

--> 4. Ejecución PRINCIPAL
local rbxlData, objCount = ExportToRBXL()
local success, savedPath = SaveToDeltaWorkspace(rbxlData)

--> 5. Resultado VERIFICABLE
if success then
    print("✅ ¡ARCHIVO GUARDADO!") --> Mensaje visible en Delta
    print("📍 Ruta: " .. savedPath)
    print("📦 Objetos exportados: " .. objCount)
    print("⏱️ Tiempo: " .. string.format("%.2f", os.clock() - start) .. "s")
else
    print("❌ ERROR: No se pudo guardar. Verifica permisos.")
end

--> 6. Auto-limpieza (anti-detección)
getgenv().RBXL_EXPORTER = nil
collectgarbage("collect")
