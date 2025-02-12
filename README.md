# starcitizen-pt-br (global.ini)

Tradução para o português brasileiro do jogo *Star Citizen* para SC Alpha 4.x.

Esta tradução não se iniciou do zero, estamos apenas complementando e adequando.

Envie sua contribuição na opção acima "Issues" para termos uma boa curadoria neste projeto, caso assim deseje.

Instruções
--------

1) Abra a pasta princial do jogo (Live ou PTU)
2) Abra a pasta data e crie uma pasta com nome: portuguese_(brazil)
3) Você deverá ter algo como: ..\LIVE\data\Localization\portuguese_(brazil)
4) Vá para a pasta Live (ou PTU, conforme o caso) e crie ou edite o arquivo com nome user.cfg
5) Neste arquivo adicione a linha: g_language = portuguese_(brazil)
6) Salve e inicie o jogo

# Ferramenta TradutorSC

![Screenshot](https://github.com/magnolima/starcitizen-pt-br/blob/main/TradutorSC/Resources/image.png)

This tool allows you import the Global.ini file from the game files translation and adapt to your own language. New additions include the use of AI (both local using Ollama, or the OpenAI) with the intention of speeding up the translation work.

For developers there few dependences:

  - Skia4Delphi: https://github.com/skia4delphi/skia4delphi
  - ~~VCL LockBox for using BlowFish cryptography algorithm: Install using Getit (no longer necessary as we are using system variables to handle the OpenAI api key)~~
  - MLOpenAI: https://github.com/magnolima/OpenAI-Delphi (this is repo is outdate, drop me a message so I could help with)

You should also install or remove (if you would like to) the theme styles.
