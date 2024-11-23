from talon import Module, actions, Context

mod = Module()
mod.mode("gamemode", desc="A mode to game")

gamemode_ctx = Context()
gamemode_ctx.matches = '''
mode: user.gamemode
'''
active_sticky_keys: set[str] = set()

@gamemode_ctx.action_class("gamemode")
class GameModeActions:
    def toggle(s: str):
        if s in active_sticky_keys:
            actions.key(f'{s}:up')
            active_sticky_keys.remove(s)
        else:
            actions.key(f'{s}:down')
            active_sticky_keys.add(s)
