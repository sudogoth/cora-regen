RegisterNetEvent("habilidade:iniciarRegeneracao", function()
    local playerPed = PlayerPedId()
    local duration = 15 
    local interval = 1000
    local healPercent = 0.02
    local totalTicks = duration
    local regenerationActive = true

   
    AnimpostfxPlay("PlayerHealthLow", 0, true)

  
    local frontendSoundsetRef = "RDRO_Sniper_Tension_Sounds"
    local frontendSoundsetName = "Heartbeat"

  
    Citizen.InvokeNative(0x0F2A2175734926D8, frontendSoundsetName, frontendSoundsetRef)

   
    CreateThread(function()
        while regenerationActive do
            Citizen.InvokeNative(0x67C540AA08E4A6F5, frontendSoundsetName, frontendSoundsetRef, true, 0) 
            Wait(1500) 
        end
    end)

  
    CreateThread(function()
        for i = 1, totalTicks do
            if IsEntityDead(playerPed) then
                regenerationActive = false
                AnimpostfxStop("PlayerHealthLow")

                Citizen.InvokeNative(0x9D746964E0CF2C5F, frontendSoundsetName, frontendSoundsetRef)

                exports.ox_lib:notify({
                    title = 'Regeneração',
                    description = 'Você morreu e não pode mais se regenerar!',
                    type = 'error'
                })
                return
            end

            local currentHealth = GetEntityHealth(playerPed)
            local maxHealth = GetEntityMaxHealth(playerPed)
            local healAmount = math.floor(maxHealth * healPercent)
            SetEntityHealth(playerPed, math.min(currentHealth + healAmount, maxHealth))

            Wait(interval)
        end

        regenerationActive = false
        AnimpostfxStop("PlayerHealthLow")
        Citizen.InvokeNative(0x9D746964E0CF2C5F, frontendSoundsetName, frontendSoundsetRef)

        exports.ox_lib:notify({
            title = 'Regeneração',
            description = 'Você já não consegue mais se curar...',
            type = 'inform'
        })
    end)

    exports.ox_lib:notify({
        title = 'Regeneração',
        description = 'Você está se Regenerando!',
        type = 'success'
    })
end)


RegisterNetEvent("habilidade:mensagemRegeneracao", function(msg)
    if not msg or msg == "" then
        msg = "Algo deu errado."
    end

    exports.ox_lib:notify({
        title = 'Regeneração',
        description = msg,
        type = 'error'
    })
end)

RegisterCommand("regenerar1", function()
    if IsEntityDead(PlayerPedId()) then
        exports.ox_lib:notify({
            title = 'Regeneração',
            description = 'Você está morto e não pode usar isso.',
            type = 'error'
        })
        return
    end

    TriggerServerEvent("habilidade:solicitarRegeneracao")
end)

RegisterNetEvent("habilidade:abrirMenuRegenerar", function()
    if IsEntityDead(PlayerPedId()) then
        exports.ox_lib:notify({
            title = 'Regeneração',
            description = 'Você está morto e não pode usar isso.',
            type = 'error'
        })
        return
    end

    TriggerServerEvent("habilidade:solicitarRegeneracao")
end)
