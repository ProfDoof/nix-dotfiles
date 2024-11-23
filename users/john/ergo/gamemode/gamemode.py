from talon import Module, actions, Context

mod = Module()
mod.mode("gamemode", desc="A mode to game")

gamemode_ctx = Context()
gamemode_ctx.matches = '''
mode: user.gamemode
'''
active_sticky_keys: set[str] = set()
sticky_keys: set[str] = set()

@mod.action_class
class GameModeActions:
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