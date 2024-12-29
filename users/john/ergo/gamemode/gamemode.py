from talon import Module, actions, Context, settings, noise
from pprint import pprint
from collections import defaultdict
from enum import Enum, auto


class GameSetting(Enum):
    ActiveStickyKeys = auto()
    StickyKeys = auto()


mod = Module()
mod.mode("gamemode", desc="A mode to game")
mod.tag("in_game", desc="Commands and behaviors associated with a game are available")
mod.setting(
    "active_game_name",
    type=str,
    default="",
    desc="Set the active game's name for use in loading settings from previous play "
    "(currently only works during continuous sessions of talon)",
)


gamemode_ctx = Context()
gamemode_ctx.matches = """
mode: user.gamemode
tag: user.in_game
"""

game_settings: dict[str, dict[GameSetting, set[str]]] = defaultdict(
    lambda: defaultdict(set)
)
current_game_settings: dict[GameSetting, set[str]] = defaultdict(set)


def load_active_game_data(*args):
    (game_name,) = args

    global current_game_settings
    current_game_settings = game_settings[game_name]


settings.register("user.active_game_name", load_active_game_data)


def on_hiss(active: bool):
    if len(current_game_settings[GameSetting.ActiveStickyKeys]) > 0:
        actions.user.gamemode_stop()


noise.register("hiss", on_hiss)


@mod.action_class
class GameModeActions:
    def gamemode_key(s: str) -> None:
        "Presses a key respecting stickied keys"

    def toggle(s: str) -> None:
        "Toggle a key from up to down or down to up"

    def gamemode_stop() -> None:
        "Stop all gamemode related actions"

    def sticky(s: str) -> None:
        "Add a key to the sticky keys"

    def unsticky(s: str) -> None:
        "Remove a key from the sticky keys"


@gamemode_ctx.action_class("user")
class InGameGameModeActions:
    def gamemode_key(s: str) -> None:
        "Presses a key respecting stickied keys"
        if s in current_game_settings[GameSetting.StickyKeys]:
            actions.user.toggle(s)
            return

        actions.key(s)

    def toggle(s: str) -> None:
        "Toggle a key from up to down or down to up"
        active_sticky_keys = current_game_settings[GameSetting.ActiveStickyKeys]
        if s in active_sticky_keys:
            actions.key(f"{s}:up")
            active_sticky_keys.remove(s)
        else:
            actions.key(f"{s}:down")
            active_sticky_keys.add(s)

    def gamemode_stop() -> None:
        "Stop all actions"
        active_sticky_keys = current_game_settings[GameSetting.ActiveStickyKeys]
        for k in active_sticky_keys:
            actions.user.toggle(k)

    def sticky(s: str) -> None:
        "Add a key to the sticky keys"
        current_game_settings[GameSetting.StickyKeys].add(s)

    def unsticky(s: str) -> None:
        "Remove a key from the sticky keys"
        if s in current_game_settings[GameSetting.StickyKeys]:
            current_game_settings[GameSetting.StickyKeys].remove(s)
