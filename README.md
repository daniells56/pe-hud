# pe-hud
Essa é uma hud convertida do fivem pro mta
Só colocar no servidor e ligar.

Video de demonstração:


https://user-images.githubusercontent.com/90437030/141697704-eb9dba70-50f9-44de-ad75-4041a906da4f.mp4



Como Configurar:
```lua
-- Esse arquivo seria o config_cl.lua
Config = {}

Config.openKey      = 'f7' -- Aqui você define a bind que ira abrir o painel de configurações da hud.

Config.useESX       = true -- aqui você define se ira usar fome e sede.
Config.useStress    = false -- aqui você define se ira usar o stress ( Não tem função nenhuma na hud, fica por você dar uma função a ele )

Config.openCommand = 'hud' -- comando para abrir o painel de configurações da hud

Config.Fome = 'hunger' -- elementData da fome
Config.Sede = 'sede' -- elementData da sede
Config.id = 'ID' -- elementData do id
```
