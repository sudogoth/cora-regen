# cora-regen

🍃 Poder de Regeneração — RedM (RSGCore + ox_lib)

Este recurso adiciona uma habilidade especial de **regeneração de vida** para jogadores no RedM, utilizando a framework **RSGCore** e a biblioteca **ox_lib**. Ele inclui cooldown, efeitos visuais, áudio de batimentos cardíacos e sincronização da animação para outros jogadores.

---

📦 Requisitos

- [rsg-core](https://github.com/rsg-core)
- [ox_lib](https://overextended.github.io/ox_lib/)
- [rsg-radialmenu](https://github.com/Rexshack-RedM/rsg-radialmenu) (Opcional)

---

⚙️ Instalação

1. Coloque a pasta do recurso dentro de resources do seu RedM.
2. Adicione a linha abaixo ao seu `server.cfg`:
```
   ensure cora-regen 
```

--- 

✅ A ativação pode ser feita via comando **/regenerar1** ou via **TriggerEvent** (TriggerEvent("habilidade:abrirMenuRegenerar")

---

🔧 Configurando o Radial Menu

1️⃣ Abra o arquivo de configuração do menu radial:
Normalmente é o config.lua dentro do recurso `rsg-radialmenu`.


2️⃣ Adicione o seguinte bloco dentro da estrutura de menus:

    [6] = {
    id = 'habilidades',
    title = 'Habilidades',
    icon = 'bolt',
    items = {
        {
            id = 'regenerar',
            title = 'Regenerar',
            icon = 'heart-pulse',
            type = 'client',
            event = 'habilidade:abrirMenuRegenerar',
            shouldClose = true
        },

---

🛠️ Personalização

Você pode editar o comportamento no *client.lua*:
```
local duration = 15           -- duração total em segundos

local interval = 1000         -- intervalo entre ticks (ms)

local healPercent = 0.02      -- % de cura por tick
```
E também no *server.lua*:
```
local cooldownTime = 135      -- tempo de espera em segundos
```
---

📌 Observações

**Se o jogador morrer durante a regeneração, o efeito é cancelado.**

**A regeneração não pode ser ativada se o jogador estiver morto.**

**Todo o sistema depende do uso correto de PlayerPedId() e dos natives para áudio e efeitos.**

