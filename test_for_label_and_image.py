from tkinter import *
from PIL import Image, ImageTk


root = Tk()

image = ImageTk.PhotoImage(Image.open(r'./images/lympho_64.png'))

Label(root, text='Hello',
      image=image,
      compound='left').pack()

root.mainloop()