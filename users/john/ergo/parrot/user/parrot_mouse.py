from talon import Module, Context

mod = Module()

mod.tag("parrot_mouse", desc="Tag for activating parrot mouse commands")

ctx = Context()

parrot_mouse_toggled = False

@mod.action_class
class MouseActions:
    def toggle_parrot_mouse():
        """Makes the parrot mouse tag active"""
        parrot_mouse_toggled = not parrot_mouse_toggled
        if parrot_mouse_toggled:
            ctx.tags = []
        else:
            ctx.tags = ["user.parrot_mouse"]