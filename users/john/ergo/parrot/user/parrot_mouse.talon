tag: user.parrot_mouse
-

parrot(tik):    
	# close zoom if open
    tracking.zoom_cancel()
    mouse_click(0)
    # close the mouse grid if open
    user.grid_close()
    # End any open drags
    # Touch automatically ends left drags so this is for right drags specifically
    user.mouse_drag_end()

parrot(tok):    
	# close zoom if open
    tracking.zoom_cancel()
    mouse_click(1)
    # close the mouse grid if open
    user.grid_close()