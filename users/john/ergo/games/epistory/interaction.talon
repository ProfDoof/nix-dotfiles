mode: user.gamemode
title: /epistory/i
tag: user.in_game
-

<user.letter>:
    user.gamemode_key(letter)

north:
    user.gamemode_key("i")
east:
    user.gamemode_key("j")
south:
    user.gamemode_key("f")
west:
    user.gamemode_key("e")
instinct:
    user.gamemode_key("space")
sprint:
    user.gamemode_key("shift")

move:
    user.sticky("e")
    user.sticky("f")
    user.sticky("i")
    user.sticky("j")
    user.sticky("shift")
    user.sticky("space")

battle:
    user.unsticky("e")
    user.unsticky("f")
    user.unsticky("i")
    user.unsticky("j")
    user.unsticky("shift")
    user.unsticky("space")
