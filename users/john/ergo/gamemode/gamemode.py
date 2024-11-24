from talon import Module, actions, Context, settings
from pprint import pprint

mod = Module()
mod.mode("gamemode", desc="A mode to game")
mod.tag("in_game", desc="Commands and behaviors associated with a game are available")
mod.setting("active_game_name", type=str, default="", 
    desc="Set the active game's name for use in loading settings from previous play "
         "(currently only works during continuous sessions of talon)")

gamemode_ctx = Context()
gamemode_ctx.matches = '''
mode: user.gamemode
tag: user.in_game
'''
game_settings: dict[str, set[str]] = {}
active_sticky_keys: set[str] = set()
sticky_keys: set[str] = set()

def load_active_game_data(*args):
    print("Active game changed")
    pprint(args)

settings.register("user.active_game_name", load_active_game_data)

@mod.action_class
class GameModeActions:
    def gamemode_key(s: str) -> None: "Presses a key respecting stickied keys"
    def toggle(s: str) -> None: "Toggle a key from up to down or down to up"
    def sticky(s: str) -> None: "Add a key to the sticky keys"
    def unsticky(s: str) -> None: "Remove a key from the sticky keys"


@gamemode_ctx.action_class("user")
class InGameGameModeActions:
    def gamemode_key(s: str) -> None:
        "Presses a key respecting stickied keys"
        if s in sticky_keys:
            actions.user.toggle(s)

        actions.key(s)

    def toggle(s: str) -> None:
        "Toggle a key from up to down or down to up"
        if s in active_sticky_keys:
            actions.key(f'{s}:up')
            active_sticky_keys.remove(s)
        else:
            actions.key(f'{s}:down')
            active_sticky_keys.add(s)

    def sticky(s: str) -> None:
        "Add a key to the sticky keys"
        sticky_keys.add(s)

    def unsticky(s: str) -> None:
        "Remove a key from the sticky keys"
        if s in sticky_keys:
            sticky_keys.remove(s)
