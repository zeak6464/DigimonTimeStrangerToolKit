"""
MVGL Tools GUI
A graphical interface for MVGLToolsCLI.exe
Supports Digimon Story: Cyber Sleuth, Time Stranger, and The Hundred Line
"""

import tkinter as tk
from tkinter import ttk, filedialog, messagebox, scrolledtext
import subprocess
import os
import threading
from pathlib import Path


class MVGLToolsGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("MVGL Tools GUI")
        self.root.geometry("800x700")
        self.root.resizable(True, True)
        
        # Find the CLI executable
        self.cli_path = self.find_cli_executable()
        
        # Create main container
        main_frame = ttk.Frame(root, padding="10")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # Configure grid weights
        root.columnconfigure(0, weight=1)
        root.rowconfigure(0, weight=1)
        main_frame.columnconfigure(1, weight=1)
        
        # Game Selection
        row = 0
        ttk.Label(main_frame, text="Game:", font=('Arial', 10, 'bold')).grid(row=row, column=0, sticky=tk.W, pady=5)
        self.game_var = tk.StringVar(value="dsts")
        game_frame = ttk.Frame(main_frame)
        game_frame.grid(row=row, column=1, sticky=(tk.W, tk.E), pady=5)
        
        games = [
            ("DSCS (PC)", "dscs"),
            ("DSCS (Console/Decrypted)", "dscs-console"),
            ("Time Stranger", "dsts"),
            ("The Hundred Line", "thl")
        ]
        
        for i, (label, value) in enumerate(games):
            ttk.Radiobutton(game_frame, text=label, variable=self.game_var, 
                          value=value).grid(row=0, column=i, padx=5, sticky=tk.W)
        
        # Mode Selection
        row += 1
        ttk.Separator(main_frame, orient='horizontal').grid(row=row, column=0, columnspan=2, sticky=(tk.W, tk.E), pady=10)
        
        row += 1
        ttk.Label(main_frame, text="Operation:", font=('Arial', 10, 'bold')).grid(row=row, column=0, sticky=tk.W, pady=5)
        self.mode_var = tk.StringVar(value="unpack-mvgl")
        mode_combo = ttk.Combobox(main_frame, textvariable=self.mode_var, width=30, state='readonly')
        mode_combo['values'] = (
            'unpack-mvgl',
            'pack-mvgl',
            'unpack-mbe',
            'pack-mbe',
            'unpack-mbe-dir',
            'pack-mbe-dir',
            'dump-structures',
            'pack-afs2',
            'unpack-afs2',
            'file-encrypt',
            'file-decrypt',
            'save-encrypt',
            'save-decrypt'
        )
        mode_combo.grid(row=row, column=1, sticky=(tk.W, tk.E), pady=5)
        mode_combo.bind('<<ComboboxSelected>>', self.on_mode_change)
        
        # Source Selection
        row += 1
        ttk.Separator(main_frame, orient='horizontal').grid(row=row, column=0, columnspan=2, sticky=(tk.W, tk.E), pady=10)
        
        row += 1
        ttk.Label(main_frame, text="Source:", font=('Arial', 10, 'bold')).grid(row=row, column=0, sticky=tk.W, pady=5)
        source_frame = ttk.Frame(main_frame)
        source_frame.grid(row=row, column=1, sticky=(tk.W, tk.E), pady=5)
        source_frame.columnconfigure(0, weight=1)
        
        self.source_var = tk.StringVar()
        source_entry = ttk.Entry(source_frame, textvariable=self.source_var)
        source_entry.grid(row=0, column=0, sticky=(tk.W, tk.E), padx=(0, 5))
        
        self.source_btn = ttk.Button(source_frame, text="Browse File", command=self.browse_source_file)
        self.source_btn.grid(row=0, column=1)
        
        self.source_dir_btn = ttk.Button(source_frame, text="Browse Folder", command=self.browse_source_folder)
        self.source_dir_btn.grid(row=0, column=2, padx=(5, 0))
        
        # Target Selection
        row += 1
        ttk.Label(main_frame, text="Target:", font=('Arial', 10, 'bold')).grid(row=row, column=0, sticky=tk.W, pady=5)
        target_frame = ttk.Frame(main_frame)
        target_frame.grid(row=row, column=1, sticky=(tk.W, tk.E), pady=5)
        target_frame.columnconfigure(0, weight=1)
        
        self.target_var = tk.StringVar()
        target_entry = ttk.Entry(target_frame, textvariable=self.target_var)
        target_entry.grid(row=0, column=0, sticky=(tk.W, tk.E), padx=(0, 5))
        
        self.target_btn = ttk.Button(target_frame, text="Browse File", command=self.browse_target_file)
        self.target_btn.grid(row=0, column=1)
        
        self.target_dir_btn = ttk.Button(target_frame, text="Browse Folder", command=self.browse_target_folder)
        self.target_dir_btn.grid(row=0, column=2, padx=(5, 0))
        
        # Options
        row += 1
        ttk.Separator(main_frame, orient='horizontal').grid(row=row, column=0, columnspan=2, sticky=(tk.W, tk.E), pady=10)
        
        row += 1
        ttk.Label(main_frame, text="Options:", font=('Arial', 10, 'bold')).grid(row=row, column=0, sticky=tk.W, pady=5)
        
        options_frame = ttk.Frame(main_frame)
        options_frame.grid(row=row, column=1, sticky=(tk.W, tk.E), pady=5)
        
        # Compression level (only for pack-mvgl)
        ttk.Label(options_frame, text="Compression:").grid(row=0, column=0, sticky=tk.W, padx=(0, 5))
        self.compress_var = tk.StringVar(value="normal")
        compress_combo = ttk.Combobox(options_frame, textvariable=self.compress_var, width=15, state='readonly')
        compress_combo['values'] = ('normal', 'none', 'advanced')
        compress_combo.grid(row=0, column=1, sticky=tk.W)
        
        self.compress_label = options_frame.winfo_children()[0]
        self.compress_combo = compress_combo

        # Batch processing for MVGL files
        self.batch_var = tk.BooleanVar(value=False)
        self.batch_check = ttk.Checkbutton(
            options_frame,
            text="Batch process MVGL folder (unpack each .mvgl to target)",
            variable=self.batch_var,
            command=self.on_mode_change
        )
        self.batch_check.grid(row=1, column=0, columnspan=2, sticky=tk.W, pady=(5, 0))
        
        # Execute Button
        row += 1
        ttk.Separator(main_frame, orient='horizontal').grid(row=row, column=0, columnspan=2, sticky=(tk.W, tk.E), pady=10)
        
        row += 1
        button_frame = ttk.Frame(main_frame)
        button_frame.grid(row=row, column=0, columnspan=2, pady=10)
        
        self.execute_btn = ttk.Button(button_frame, text="Execute", command=self.execute_command, 
                                      style='Accent.TButton', width=20)
        self.execute_btn.pack(side=tk.LEFT, padx=5)
        
        ttk.Button(button_frame, text="Clear Output", command=self.clear_output, width=15).pack(side=tk.LEFT, padx=5)
        
        # Output Log
        row += 1
        ttk.Label(main_frame, text="Output:", font=('Arial', 10, 'bold')).grid(row=row, column=0, sticky=tk.W, pady=5)
        
        row += 1
        output_frame = ttk.Frame(main_frame)
        output_frame.grid(row=row, column=0, columnspan=2, sticky=(tk.W, tk.E, tk.N, tk.S), pady=5)
        output_frame.columnconfigure(0, weight=1)
        output_frame.rowconfigure(0, weight=1)
        main_frame.rowconfigure(row, weight=1)
        
        self.output_text = scrolledtext.ScrolledText(output_frame, height=15, wrap=tk.WORD, 
                                                     font=('Consolas', 9))
        self.output_text.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # CLI Path info
        row += 1
        cli_info = ttk.Label(main_frame, text=f"CLI Tool: {self.cli_path}", 
                            foreground='gray', font=('Arial', 8))
        cli_info.grid(row=row, column=0, columnspan=2, sticky=tk.W, pady=(5, 0))
        
        # Initial mode setup
        self.on_mode_change()
        
        # Log initial message
        self.log_output("MVGL Tools GUI Initialized\n")
        self.log_output(f"CLI Tool Location: {self.cli_path}\n\n")
        self.log_output("Select game, operation, source, and target, then click Execute.\n")
        self.log_output("=" * 80 + "\n\n")
    
    def find_cli_executable(self):
        """Find the MVGLToolsCLI.exe executable"""
        # Check in _internal folder
        internal_path = Path("_internal/MVGLToolsCLI.exe")
        if internal_path.exists():
            return str(internal_path.absolute())
        
        # Check in current directory
        current_path = Path("MVGLToolsCLI.exe")
        if current_path.exists():
            return str(current_path.absolute())
        
        # Check in parent directory
        parent_path = Path("../MVGLToolsCLI.exe")
        if parent_path.exists():
            return str(parent_path.absolute())
        
        return "MVGLToolsCLI.exe"  # Default, will fail if not found
    
    def on_mode_change(self, event=None):
        """Update UI based on selected mode"""
        mode = self.mode_var.get()
        
        # Show/hide compression options based on mode
        if mode == "pack-mvgl":
            self.compress_label.grid()
            self.compress_combo.grid()
        else:
            self.compress_label.grid_remove()
            self.compress_combo.grid_remove()

        # Batch option only makes sense for unpack-mvgl
        batch_supported = mode == "unpack-mvgl"
        if not batch_supported:
            self.batch_var.set(False)
            self.batch_check.state(['disabled'])
        else:
            self.batch_check.state(['!disabled'])
        batch_mode = self.batch_var.get() and batch_supported
        
        # Update button labels based on mode
        if mode.endswith('-dir') or batch_mode:
            self.source_btn.config(state='disabled')
            self.target_btn.config(state='disabled')
        else:
            self.source_btn.config(state='normal')
            self.target_btn.config(state='normal')
    
    def browse_source_file(self):
        """Browse for source file"""
        filename = filedialog.askopenfilename(
            title="Select Source File",
            filetypes=[
                ("All Files", "*.*"),
                ("MVGL Files", "*.mvgl"),
                ("MBE Files", "*.mbe"),
                ("AFS2 Files", "*.afs2"),
                ("BIN Files", "*.bin")
            ]
        )
        if filename:
            self.source_var.set(filename)
    
    def browse_source_folder(self):
        """Browse for source folder"""
        foldername = filedialog.askdirectory(title="Select Source Folder")
        if foldername:
            self.source_var.set(foldername)
    
    def browse_target_file(self):
        """Browse for target file"""
        mode = self.mode_var.get()
        
        if mode.startswith('pack'):
            # For packing operations, save as file
            filename = filedialog.asksaveasfilename(
                title="Select Target File",
                filetypes=[
                    ("All Files", "*.*"),
                    ("MVGL Files", "*.mvgl"),
                    ("MBE Files", "*.mbe"),
                    ("AFS2 Files", "*.afs2"),
                    ("BIN Files", "*.bin")
                ]
            )
        else:
            # For unpacking operations, select existing file
            filename = filedialog.askopenfilename(
                title="Select Target File",
                filetypes=[("All Files", "*.*")]
            )
        
        if filename:
            self.target_var.set(filename)
    
    def browse_target_folder(self):
        """Browse for target folder"""
        foldername = filedialog.askdirectory(title="Select Target Folder")
        if foldername:
            self.target_var.set(foldername)
    
    def log_output(self, text):
        """Add text to output log"""
        self.output_text.insert(tk.END, text)
        self.output_text.see(tk.END)
        self.output_text.update_idletasks()
    
    def clear_output(self):
        """Clear the output log"""
        self.output_text.delete(1.0, tk.END)
    
    def execute_command(self):
        """Execute the MVGLToolsCLI command"""
        # Validate inputs
        if not self.source_var.get():
            messagebox.showerror("Error", "Please select a source file or folder.")
            return
        
        if not self.target_var.get():
            messagebox.showerror("Error", "Please select a target file or folder.")
            return
        
        # Check if CLI exists
        if not os.path.exists(self.cli_path):
            messagebox.showerror("Error", f"MVGLToolsCLI.exe not found at:\n{self.cli_path}\n\nPlease ensure the executable is in the _internal folder or current directory.")
            return
        
        # Build command
        game = self.game_var.get()
        mode = self.mode_var.get()
        source = self.source_var.get()
        target = self.target_var.get()

        # Batch mode (only for unpack-mvgl)
        if self.batch_var.get():
            if mode != "unpack-mvgl":
                messagebox.showerror("Error", "Batch processing is available only for 'unpack-mvgl'.")
                return
            
            source_path = Path(source)
            target_path = Path(target)
            
            if not source_path.is_dir():
                messagebox.showerror("Error", "Batch mode requires the source to be a folder containing .mvgl files.")
                return
            
            if target_path.exists() and not target_path.is_dir():
                messagebox.showerror("Error", "Batch mode requires the target to be a folder.")
                return
            
            target_path.mkdir(parents=True, exist_ok=True)
            mvgl_files = sorted(source_path.glob("*.mvgl"))
            
            if not mvgl_files:
                messagebox.showerror("Error", f"No .mvgl files found in:\n{source_path}")
                return
            
            commands = []
            for mvgl_file in mvgl_files:
                output_folder = target_path / mvgl_file.stem
                commands.append([
                    self.cli_path,
                    f"--game={game}",
                    f"--mode={mode}",
                    str(mvgl_file),
                    str(output_folder)
                ])
            
            self.log_output("\n" + "=" * 80 + "\n")
            self.log_output(f"Batch: preparing to unpack {len(commands)} MVGL files from {source_path} to {target_path}\n")
            self.log_output("=" * 80 + "\n\n")
            
            self.execute_btn.config(state='disabled', text='Running...')
            thread = threading.Thread(target=self.run_batch_commands, args=(commands,))
            thread.daemon = True
            thread.start()
            return
        
        cmd = [self.cli_path, f"--game={game}", f"--mode={mode}", source, target]
        
        # Add compression option for pack-mvgl
        if mode == "pack-mvgl":
            compress_level = self.compress_var.get()
            cmd.append(f"--compress={compress_level}")
        
        # Log command
        self.log_output("\n" + "=" * 80 + "\n")
        self.log_output(f"Executing: {' '.join(cmd)}\n")
        self.log_output("=" * 80 + "\n\n")
        
        # Disable execute button
        self.execute_btn.config(state='disabled', text='Running...')
        
        # Run command in thread
        thread = threading.Thread(target=self.run_command, args=(cmd,))
        thread.daemon = True
        thread.start()
    
    def _run_cli_command(self, cmd):
        """Run a CLI command and stream output; returns the return code"""
        process = subprocess.Popen(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            bufsize=1,
            universal_newlines=True,
            creationflags=subprocess.CREATE_NO_WINDOW if os.name == 'nt' else 0
        )
        
        for line in process.stdout:
            self.root.after(0, self.log_output, line)
        
        process.wait()
        return process.returncode

    def run_command(self, cmd):
        """Run the command in a separate thread"""
        try:
            returncode = self._run_cli_command(cmd)
            
            if returncode == 0:
                self.root.after(0, self.log_output, "\n✓ Operation completed successfully!\n")
            else:
                self.root.after(0, self.log_output, f"\n✗ Operation failed with return code {returncode}\n")
        
        except Exception as e:
            self.root.after(0, self.log_output, f"\n✗ Error: {str(e)}\n")
        
        finally:
            # Re-enable execute button
            self.root.after(0, self.execute_btn.config, {'state': 'normal', 'text': 'Execute'})

    def run_batch_commands(self, commands):
        """Run multiple CLI commands sequentially for batch MVGL processing"""
        try:
            total = len(commands)
            for idx, cmd in enumerate(commands, start=1):
                source_label = Path(cmd[3]).name if len(cmd) > 3 else Path(cmd[-2]).name
                target_label = cmd[4] if len(cmd) > 4 else cmd[-1]
                self.root.after(0, self.log_output, f"\n[{idx}/{total}] {source_label} -> {target_label}\n")
                
                returncode = self._run_cli_command(cmd)
                if returncode == 0:
                    self.root.after(0, self.log_output, "✓ Completed\n")
                else:
                    self.root.after(0, self.log_output, f"✗ Failed with return code {returncode}\n")
            
            self.root.after(0, self.log_output, "\nBatch processing finished.\n")
        
        except Exception as e:
            self.root.after(0, self.log_output, f"\n✗ Error: {str(e)}\n")
        
        finally:
            self.root.after(0, self.execute_btn.config, {'state': 'normal', 'text': 'Execute'})


def main():
    root = tk.Tk()
    app = MVGLToolsGUI(root)
    root.mainloop()


if __name__ == "__main__":
    main()

