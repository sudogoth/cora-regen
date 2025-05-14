local RSGCore = exports['rsg-core']:GetCoreObject()
local cooldowns = {}

RegisterServerEvent("habilidade:solicitarRegeneracao")
AddEventHandler("habilidade:solicitarRegeneracao", function()
    local src = source
    local player = RSGCore.Functions.GetPlayer(src)
    if not player then return end

    local cooldownTime = 135
    local currentTime = os.time()

    if cooldowns[src] and currentTime - cooldowns[src] < cooldownTime then
        local secondsLeft = cooldownTime - (currentTime - cooldowns[src])
        TriggerClientEvent("habilidade:mensagemRegeneracao", src, "Aguarde " .. secondsLeft .. "s para usar novamente.")
        return
    end

    cooldowns[src] = currentTime
    TriggerClientEvent("habilidade:iniciarRegeneracao", src)
end)


RegisterServerEvent("habilidade:efeitoRegeneracaoSync")
AddEventHandler("habilidade:efeitoRegeneracaoSync", function()
    local src = source
    TriggerClientEvent("habilidade:exibirParticulaEmOutroJogador", -1, src)
end)

