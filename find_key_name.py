import tkinter as tk

def key_pressed(event):
    print(f"Touche pressée : {event.keysym}")

root = tk.Tk()
root.bind('<KeyPress>', key_pressed)
root.mainloop()
