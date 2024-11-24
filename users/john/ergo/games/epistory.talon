mode: user.gamemode
title: /epistory/i
-
settings():
    user.active_game_name = "Epistory"

tag(): user.in_game

<user.letter>: user.gamemode_key(letter)

move:
    user.sticky("e")
    user.sticky("f")
    user.sticky("i")
    user.sticky("j")

battle:
    user.unsticky("e")
    user.unsticky("f")
    user.unsticky("i")
    user.unsticky("j")
