
import tkinter as tk
from tkinter import messagebox

class CellCounter:
    def __init__(self, master, total_cells=100):
        self.master = master
        self.total_cells = total_cells
        self.current_total = 0

        self.cell_counts = {
            'lymphocytes': 0,
            'polynucleaires': 0,
            'monocytes': 0,
            'basophiles': 0,
            'eosinophiles': 0,
            'cell1': 0,
            'cell2': 0,
            'cell3': 0
        }

        self.label_total = tk.Label(master, text=f"Total de cellules comptées: {self.current_total}/{self.total_cells}", font=('Arial', 14))
        self.label_total.grid(row=0, column=1, columnspan=3, pady=10)

        self.create_grid()

        # Assigner les touches du pavé numérique aux cellules spécifiques (La méthode suivant ne fonctionne pas
        # bien sous Linux : le pavé numérique n'était pas reconnu.
        # master.bind('5', lambda event: self.increment_count('eosinophiles'))
        # master.bind('KP_1', lambda event: self.increment_count('cell1'))
        # master.bind('3', lambda event: self.increment_count('cell3'))

        # La solution est de capturer tous les événements de touches
        master.bind('<Key>', self.handle_key_press)

    def handle_key_press(self, event):
        """Gérer tous les événements de touches, y compris ceux du pavé numérique."""
        # Vérifier la touche pressée
        key = event.keysym
        print(f"la touche est {key}")

        # Mapper les touches aux types de cellules
        key_mapping = {
            '7': 'lymphocytes', 'KP_7': 'lymphocytes',
            '8': 'polynucleaires', 'KP_8': 'polynucleaires',
            '9': 'monocytes', 'KP_9': 'monocytes',
            '6': 'basophiles', 'KP_6': 'basophiles',
            '5': 'eosinophiles', 'KP_5': 'eosinophiles',
            '1': 'cell1', '1': 'cell1',
            '2': 'cell2', 'KP_2': 'cell2',
            '3': 'cell3', 'KP_3': 'cell3'
        }

        # Incrémenter le compteur si la touche est mappée
        if key in key_mapping:
            self.increment_count(key_mapping[key])

    def create_grid(self):
        """Créer une grille de carrés pour chaque type de cellule."""
        self.cell_labels = {
            'lymphocytes': (1, 0),
            'polynucleaires': (1, 1),
            'monocytes': (1, 2),
            'eosinophiles': (2, 1),
            'basophiles': (2, 2),
            'cell1': (3, 0),
            'cell2': (3, 1),
            'cell3': (3, 2)
        }

        self.buttons = {}
        for cell_type, pos in self.cell_labels.items():
            frame = tk.Frame(self.master, width=100, height=100, bg='lightgray', highlightbackground="black", highlightthickness=1)
            frame.grid(row=pos[0], column=pos[1], padx=10, pady=10)
            label = tk.Label(frame, text=f"{cell_type.capitalize()}: {self.cell_counts[cell_type]}", font=('Arial', 12), bg='lightgray')
            label.pack(expand=True)
            # Associer un clic sur le label à la méthode increment_count
            label.bind('<Button-1>', lambda event, ct=cell_type: self.increment_count(ct))

            self.buttons[cell_type] = label

    def increment_count(self, cell_type):
        if self.current_total < self.total_cells:
            self.cell_counts[cell_type] += 1
            self.current_total += 1
            self.update_display(cell_type)
        else:
            messagebox.showinfo("Fin du comptage", f"Vous avez atteint {self.total_cells} cellules.")

    def update_display(self, cell_type):
        self.label_total.config(text=f"Total de cellules comptées: {self.current_total}/{self.total_cells}")
        self.buttons[cell_type].config(text=f"{cell_type.capitalize()}: {self.cell_counts[cell_type]}")

# Interface Tkinter
root = tk.Tk()
root.title("Compteur de cellules sanguines")
app = CellCounter(root, total_cells=50)  # Choisissez le nombre de cellules à compter.
root.mainloop()

