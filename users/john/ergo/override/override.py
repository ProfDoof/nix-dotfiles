from talon import Module, Context

mod = Module()

mod.tag("override", desc="Tag for overriding pre-defined Talon commands")
mod.tag("parrot_mouse", desc="Tag for activating parrot mouse commands")

ctx = Context()

@mod.action_class
class MouseActions:
    def activate_parrot_mouse():
        """Makes the parrot mouse tag active"""
        ctx.tags = ["user.parrot_mouse"]

    def deactive_parrot_mouse():
        """Makes the parrot mouse tag inactive"""
        ctx.tags = []