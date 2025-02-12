from talon import Module, Context, actions, ctrl

mod = Module()

mod.tag("parrot_mouse", desc="Tag for activating parrot mouse commands")

ctx = Context()

@mod.action_class
class MouseActions:
    def toggle_parrot_mouse():
        """Makes the parrot mouse tag active"""
        if actions.tracking.control_enabled():
            ctx.tags = ["user.parrot_mouse"]
        else:
            ctx.tags = []

    def parrot_mouse_click(button: int):
        """Clicks the mouse"""
        ctrl.mouse_click(button=button, hold=16000)