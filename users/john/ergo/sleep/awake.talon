mode: command
-

^drowse [<phrase>]$: speech.disable()
^drowse all [<phrase>]$:
    user.switcher_hide_running()
    user.history_disable()
    user.homophones_hide()
    user.help_hide()
    speech.disable()

parrot(snap):
    user.switcher_hide_running()
    user.history_disable()
    user.homophones_hide()
    user.help_hide()
    speech.disable()
