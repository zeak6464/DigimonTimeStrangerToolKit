#!/usr/bin/env python3
"""
DTS Creator Launcher - Main Hub
Unified launcher for all DTS Creator tools
"""

import sys
import subprocess
import webbrowser
from pathlib import Path
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
    QPushButton, QLabel, QGroupBox, QMessageBox, QTextEdit
)
from PyQt6.QtCore import Qt, QProcess
from PyQt6.QtGui import QFont, QIcon


class DTSCreatorLauncher(QMainWindow):
    """Main launcher window for all DTS Creator tools"""
    
    def __init__(self):
        super().__init__()
        self.processes = {}  # Track running processes
        self.init_ui()
        
    def init_ui(self):
        """Initialize the user interface"""
        self.setWindowTitle("DTS Creator - Ultimate Toolkit Launcher")
        self.setMinimumSize(1100, 800)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout()
        main_layout.setSpacing(15)
        main_layout.setContentsMargins(20, 20, 20, 20)
        central_widget.setLayout(main_layout)
        
        # Header
        header = QLabel("🎮 DTS Creator - Ultimate Toolkit")
        header_font = QFont()
        header_font.setPointSize(20)
        header_font.setBold(True)
        header.setFont(header_font)
        header.setAlignment(Qt.AlignmentFlag.AlignCenter)
        header.setStyleSheet("color: #2196F3; padding: 20px;")
        main_layout.addWidget(header)
        
        subtitle = QLabel("DTS - Complete Modding Suite")
        subtitle.setAlignment(Qt.AlignmentFlag.AlignCenter)
        subtitle.setStyleSheet("color: #666; font-size: 12pt; font-style: italic; padding-bottom: 10px;")
        main_layout.addWidget(subtitle)
        
        # ===== GRID LAYOUT FOR SECTIONS (2 columns) =====
        from PyQt6.QtWidgets import QGridLayout
        grid_layout = QGridLayout()
        grid_layout.setSpacing(15)
        grid_layout.setContentsMargins(0, 0, 0, 0)
        main_layout.addLayout(grid_layout)
        
        # ===== EDITORS SECTION =====
        editors_group = QGroupBox("📝 EDITORS")
        editors_group.setStyleSheet("""
            QGroupBox {
                font-size: 14pt;
                font-weight: bold;
                color: #FF9800;
                border: 2px solid #FF9800;
                border-radius: 5px;
                margin-top: 10px;
                padding: 15px;
            }
            QGroupBox::title {
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 5px;
            }
        """)
        editors_layout = QVBoxLayout()
        editors_group.setLayout(editors_layout)
        
        # Digimon Editor button
        self.digimon_editor_btn = self.create_tool_button(
            "🦖 Digimon Editor",
            "Complete Digimon creator and editor\n• Create custom Digimon from templates\n• Edit stats, skills, evolutions\n• Export to DLC or CSV",
            "#FF6F00"
        )
        self.digimon_editor_btn.clicked.connect(lambda: self.launch_exe("digimon_editor.exe", "Digimon Editor"))
        editors_layout.addWidget(self.digimon_editor_btn)
        
        # MBE Editor button
        self.mbe_editor_btn = self.create_tool_button(
            "📄 MBE Editor",
            "Edit .mbe files directly with table view\n• Open and modify game data tables\n• Insert/delete rows\n• Save changes back to .mbe format",
            "#4CAF50"
        )
        self.mbe_editor_btn.clicked.connect(lambda: self.launch_exe("MBE_Editor.exe", "MBE Editor"))
        editors_layout.addWidget(self.mbe_editor_btn)
        
        grid_layout.addWidget(editors_group, 0, 0)  # Row 0, Column 0
        
        # ===== RANDOMIZERS SECTION =====
        randomizers_group = QGroupBox("🎲 RANDOMIZERS")
        randomizers_group.setStyleSheet("""
            QGroupBox {
                font-size: 14pt;
                font-weight: bold;
                color: #9C27B0;
                border: 2px solid #9C27B0;
                border-radius: 5px;
                margin-top: 10px;
                padding: 15px;
            }
            QGroupBox::title {
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 5px;
            }
        """)
        randomizers_layout = QVBoxLayout()
        randomizers_group.setLayout(randomizers_layout)
        
        # Game Randomizer button
        self.randomizer_btn = self.create_tool_button(
            "🎲 Game Randomizer",
            "Comprehensive randomizer with 11+ options\n• Encounters, Evolutions, Stats, Skills\n• Treasure, Shops, Personalities\n• Includes MBE repacking",
            "#E91E63"
        )
        self.randomizer_btn.clicked.connect(lambda: self.launch_exe("field_battle_randomizer_gui.exe", "Game Randomizer"))
        randomizers_layout.addWidget(self.randomizer_btn)
       
        
        grid_layout.addWidget(randomizers_group, 0, 1)  # Row 0, Column 1
        
        # ===== TOOLS SECTION =====
        tools_group = QGroupBox("🔧 TOOLS")
        tools_group.setStyleSheet("""
            QGroupBox {
                font-size: 14pt;
                font-weight: bold;
                color: #2196F3;
                border: 2px solid #2196F3;
                border-radius: 5px;
                margin-top: 10px;
                padding: 15px;
            }
            QGroupBox::title {
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 5px;
            }
        """)
        tools_layout = QVBoxLayout()
        tools_group.setLayout(tools_layout)
        
        # DSCS Tools button
        self.dscs_tools_btn = self.create_tool_button(
            "📦 DSCS Tools",
            "Complete DSCSToolsCLI GUI wrapper\n• Extract/Pack MBE, Archive, AFS2\n• En/Decrypt files and saves\n• All DSCSToolsCLI features in one place",
            "#00BCD4"
        )
        self.dscs_tools_btn.clicked.connect(lambda: self.launch_exe("MVGLToolsGUI.exe", "DSCS Tools"))
        tools_layout.addWidget(self.dscs_tools_btn)
        
        # Lua Decompiler button
        self.lua_decompile_btn = self.create_tool_button(
            "📜 Lua Decompiler",
            "Decompile game Lua scripts\n• Batch decompile .lua files\n• Folder selection with progress tracking\n• View and modify game logic",
            "#795548"
        )
        self.lua_decompile_btn.clicked.connect(lambda: self.launch_exe("lua_decompiler_gui.exe", "Lua Decompiler"))
        tools_layout.addWidget(self.lua_decompile_btn)
        
        # CPK Browser button
        self.cpk_browser_btn = self.create_tool_button(
            "📂 CPK Browser",
            "Browse and extract CPK archives\n• View game archive contents\n• Extract files from .cpk\n• Explore game assets",
            "#607D8B"
        )
        self.cpk_browser_btn.clicked.connect(lambda: self.launch_exe("CPKBrowser.exe", "CPK Browser"))
        tools_layout.addWidget(self.cpk_browser_btn)
        
        grid_layout.addWidget(tools_group, 1, 0)  # Row 1, Column 0
        
        # ===== DOCUMENTATION SECTION =====
        docs_group = QGroupBox("📚 DOCUMENTATION")
        docs_group.setStyleSheet("""
            QGroupBox {
                font-size: 14pt;
                font-weight: bold;
                color: #607D8B;
                border: 2px solid #607D8B;
                border-radius: 5px;
                margin-top: 10px;
                padding: 15px;
            }
            QGroupBox::title {
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 5px;
            }
        """)
        docs_layout = QVBoxLayout()
        docs_group.setLayout(docs_layout)
        
        # Lua Reference Guide button
        self.lua_guide_btn = self.create_tool_button(
            "📖 Lua Scripts Reference Guide",
            "Complete reference for game Lua scripting\n• Function documentation\n• Examples and usage\n• Opens in your default browser",
            "#FF5722"
        )
        self.lua_guide_btn.clicked.connect(lambda: self.open_html_guide("Digimon Time Stealer Lua Scripts - Complete Reference Guide.html"))
        docs_layout.addWidget(self.lua_guide_btn)
        
        grid_layout.addWidget(docs_group, 1, 1)  # Row 1, Column 1
        
        # ===== GAME LAUNCHER SECTION =====
        game_group = QGroupBox("🎮 GAME LAUNCHER")
        game_group.setStyleSheet("""
            QGroupBox {
                font-size: 14pt;
                font-weight: bold;
                color: #E91E63;
                border: 2px solid #E91E63;
                border-radius: 5px;
                margin-top: 10px;
                padding: 15px;
            }
            QGroupBox::title {
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 5px;
            }
        """)
        game_layout = QVBoxLayout()
        game_group.setLayout(game_layout)
        
        # Reloaded-II button
        self.reloaded_btn = self.create_tool_button(
            "🚀 Launch Reloaded-II",
            "Launch the game with Reloaded-II mod loader\n• Start DSCS with all mods enabled\n• Manage game modifications\n• Debug and test your changes",
            "#C2185B"
        )
        self.reloaded_btn.clicked.connect(lambda: self.launch_reloaded_ii())
        game_layout.addWidget(self.reloaded_btn)
        
        grid_layout.addWidget(game_group, 2, 0, 1, 2)  # Row 2, Columns 0-1 (span 2 columns)
        
        # ===== STATUS LOG =====
        log_group = QGroupBox("📋 Activity Log")
        log_layout = QVBoxLayout()
        log_group.setLayout(log_layout)
        
        self.log_output = QTextEdit()
        self.log_output.setReadOnly(True)
        self.log_output.setMaximumHeight(120)
        self.log_output.setMinimumHeight(100)
        self.log_output.setStyleSheet("""
            QTextEdit {
                background-color: #1e1e1e;
                color: #d4d4d4;
                font-family: 'Consolas', 'Courier New', monospace;
                font-size: 9pt;
                border: 1px solid #444;
            }
        """)
        log_layout.addWidget(self.log_output)
        
        main_layout.addWidget(log_group)
        
        # Footer
        footer = QLabel("DTS Creator © 2024 - All tools in one place")
        footer.setAlignment(Qt.AlignmentFlag.AlignCenter)
        footer.setStyleSheet("color: #999; font-size: 9pt; padding: 10px;")
        main_layout.addWidget(footer)
        
        # Status bar
        self.statusBar().showMessage("Ready - Select a tool to launch")
        
        # Initial log
        self.log("✨ DTS Creator Launcher initialized")
        self.log("🎮 Select a tool from above to get started")
        self.check_tools()
    
    def create_tool_button(self, text, tooltip, color):
        """Create a styled tool button"""
        btn = QPushButton(text)
        btn.setMinimumHeight(60)
        btn.setMaximumHeight(80)
        btn.setToolTip(tooltip)
        btn.setStyleSheet(f"""
            QPushButton {{
                background-color: {color};
                color: white;
                font-size: 13pt;
                font-weight: bold;
                border: none;
                border-radius: 5px;
                padding: 12px;
                text-align: left;
            }}
            QPushButton:hover {{
                background-color: {self.darken_color(color)};
                border: 2px solid white;
            }}
            QPushButton:pressed {{
                background-color: {self.darken_color(color, 0.8)};
            }}
            QPushButton:disabled {{
                background-color: #cccccc;
                color: #666666;
            }}
        """)
        return btn
    
    def darken_color(self, hex_color, factor=0.85):
        """Darken a hex color"""
        hex_color = hex_color.lstrip('#')
        r, g, b = tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))
        r, g, b = int(r * factor), int(g * factor), int(b * factor)
        return f'#{r:02x}{g:02x}{b:02x}'
    
    def check_tools(self):
        """Check if all tools exist"""
        tools = {
            "digimon_editor.py": "Digimon Editor",
            "MBE_Editor.py": "MBE Editor",
            "field_battle_randomizer_gui.py": "Game Randomizer",
            "dscs_tools_gui.py": "DSCS Tools",
            "lua_decompiler_gui.py": "Lua Decompiler",
            "CPKBrowser.exe": "CPK Browser",
            "Digimon Time Stealer Lua Scripts - Complete Reference Guide.html": "Lua Reference Guide",
            "Reloaded-II/Reloaded-II.exe": "Reloaded-II"
        }
        
        missing = []
        for file, name in tools.items():
            if not Path(file).exists():
                missing.append(f"  ⚠️ {name} ({file})")
        
        if missing:
            self.log("⚠️ Some tools are missing:")
            for item in missing:
                self.log(item)
        else:
            self.log("✅ All tools found and ready to use!")
    
    def launch_exe(self, script_name, tool_name):
        """Launch a Python GUI tool"""
        script_path = Path(script_name)
        
        if not script_path.exists():
            QMessageBox.critical(
                self,
                "Tool Not Found",
                f"{tool_name} not found!\n\nExpected location: {script_path.absolute()}"
            )
            self.log(f"❌ {tool_name} not found: {script_path}")
            return
        
        try:
            self.log(f"🚀 Launching {tool_name}...")
            self.statusBar().showMessage(f"Launching {tool_name}...")
            
            # Use QProcess to launch without blocking
            process = QProcess(self)
            process.setProgram("python")
            process.setArguments([str(script_path)])
            
            # Connect signals for logging
            process.started.connect(lambda: self.on_process_started(tool_name))
            process.errorOccurred.connect(lambda error: self.on_process_error(tool_name, error))
            process.finished.connect(lambda exit_code, exit_status: self.on_process_finished(tool_name, exit_code))
            
            # Start the process
            process.start()
            
            # Store process reference
            self.processes[tool_name] = process
            
        except Exception as e:
            QMessageBox.critical(
                self,
                "Launch Error",
                f"Failed to launch {tool_name}:\n\n{str(e)}"
            )
            self.log(f"❌ Failed to launch {tool_name}: {e}")
    
    def launch_batch_file(self, batch_name, tool_name):
        """Launch a batch file"""
        batch_path = Path(batch_name)
        
        if not batch_path.exists():
            QMessageBox.critical(
                self,
                "Tool Not Found",
                f"{tool_name} not found!\n\nExpected location: {batch_path.absolute()}"
            )
            self.log(f"❌ {tool_name} not found: {batch_path}")
            return
        
        try:
            self.log(f"🚀 Launching {tool_name}...")
            self.statusBar().showMessage(f"Launching {tool_name}...")
            
            # Launch batch file in new window
            subprocess.Popen(['cmd', '/c', 'start', 'cmd', '/k', str(batch_path)], shell=True)
            
            self.log(f"✅ {tool_name} launched in new window")
            self.statusBar().showMessage(f"{tool_name} running in separate window")
            
        except Exception as e:
            QMessageBox.critical(
                self,
                "Launch Error",
                f"Failed to launch {tool_name}:\n\n{str(e)}"
            )
            self.log(f"❌ Failed to launch {tool_name}: {e}")
    
    def open_html_guide(self, html_name):
        """Open HTML documentation in browser"""
        html_path = Path(html_name)
        
        if not html_path.exists():
            QMessageBox.critical(
                self,
                "Documentation Not Found",
                f"Documentation file not found!\n\nExpected location: {html_path.absolute()}"
            )
            self.log(f"❌ Documentation not found: {html_path}")
            return
        
        try:
            self.log(f"📖 Opening documentation: {html_name}")
            self.statusBar().showMessage(f"Opening documentation in browser...")
            
            # Open in default browser
            webbrowser.open(html_path.absolute().as_uri())
            
            self.log(f"✅ Documentation opened in browser")
            self.statusBar().showMessage("Documentation opened in browser")
            
        except Exception as e:
            QMessageBox.critical(
                self,
                "Open Error",
                f"Failed to open documentation:\n\n{str(e)}"
            )
            self.log(f"❌ Failed to open documentation: {e}")
    
    def launch_exe(self, exe_name, tool_name):
        """Launch a standalone .exe file"""
        exe_path = Path(exe_name)
        
        if not exe_path.exists():
            QMessageBox.critical(
                self,
                f"{tool_name} Not Found",
                f"{exe_name} not found!\n\nExpected location: {exe_path.absolute()}\n\n"
                f"Please ensure {exe_name} is in the DTS Creator folder."
            )
            self.log(f"❌ {tool_name} not found: {exe_path}")
            return
        
        try:
            self.log(f"🚀 Launching {tool_name}...")
            self.statusBar().showMessage(f"Launching {tool_name}...")
            
            # Launch as a detached process
            subprocess.Popen([str(exe_path.absolute())], cwd=str(exe_path.parent.absolute()))
            
            self.log(f"✅ {tool_name} launched successfully")
            self.statusBar().showMessage(f"{tool_name} running")
            
        except Exception as e:
            QMessageBox.critical(
                self,
                "Launch Error",
                f"Failed to launch {tool_name}:\n\n{str(e)}"
            )
            self.log(f"❌ Failed to launch {tool_name}: {e}")
    
    def launch_reloaded_ii(self):
        """Launch Reloaded-II mod loader"""
        reloaded_path = Path("Reloaded-II/Reloaded-II.exe")
        
        if not reloaded_path.exists():
            QMessageBox.critical(
                self,
                "Reloaded-II Not Found",
                f"Reloaded-II.exe not found!\n\nExpected location: {reloaded_path.absolute()}\n\n"
                "Please ensure Reloaded-II is installed in the Reloaded-II folder."
            )
            self.log(f"❌ Reloaded-II not found: {reloaded_path}")
            return
        
        try:
            self.log(f"🚀 Launching Reloaded-II...")
            self.statusBar().showMessage(f"Launching Reloaded-II...")
            
            # Launch Reloaded-II as a detached process
            subprocess.Popen([str(reloaded_path.absolute())], cwd=str(reloaded_path.parent.absolute()))
            
            self.log(f"✅ Reloaded-II launched successfully")
            self.statusBar().showMessage("Reloaded-II running")
            
            QMessageBox.information(
                self,
                "Reloaded-II Launched",
                "🚀 Reloaded-II has been launched!\n\n"
                "The mod loader is now running.\n"
                "Use it to start the game with your mods enabled."
            )
            
        except Exception as e:
            QMessageBox.critical(
                self,
                "Launch Error",
                f"Failed to launch Reloaded-II:\n\n{str(e)}"
            )
            self.log(f"❌ Failed to launch Reloaded-II: {e}")
    
    def on_process_started(self, tool_name):
        """Handle process started"""
        self.log(f"✅ {tool_name} started successfully")
        self.statusBar().showMessage(f"{tool_name} is running")
    
    def on_process_error(self, tool_name, error):
        """Handle process error"""
        error_messages = {
            QProcess.ProcessError.FailedToStart: "Failed to start",
            QProcess.ProcessError.Crashed: "Crashed",
            QProcess.ProcessError.Timedout: "Timed out",
            QProcess.ProcessError.WriteError: "Write error",
            QProcess.ProcessError.ReadError: "Read error",
            QProcess.ProcessError.UnknownError: "Unknown error"
        }
        error_msg = error_messages.get(error, "Unknown error")
        self.log(f"❌ {tool_name} error: {error_msg}")
        self.statusBar().showMessage(f"{tool_name} error: {error_msg}")
    
    def on_process_finished(self, tool_name, exit_code):
        """Handle process finished"""
        if exit_code == 0:
            self.log(f"✅ {tool_name} closed successfully")
        else:
            self.log(f"⚠️ {tool_name} closed with exit code {exit_code}")
        
        self.statusBar().showMessage(f"{tool_name} closed")
        
        # Remove from process tracking
        if tool_name in self.processes:
            del self.processes[tool_name]
    
    def log(self, message):
        """Add message to log output"""
        self.log_output.append(message)
        self.log_output.verticalScrollBar().setValue(
            self.log_output.verticalScrollBar().maximum()
        )
    
    def closeEvent(self, event):
        """Handle window close"""
        if self.processes:
            reply = QMessageBox.question(
                self,
                "Close Launcher",
                f"{len(self.processes)} tool(s) are still running.\n\n"
                "Close launcher anyway?\n(Tools will continue running)",
                QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No
            )
            
            if reply == QMessageBox.StandardButton.No:
                event.ignore()
                return
        
        event.accept()


def main():
    """Main entry point"""
    try:
        app = QApplication(sys.argv)
        app.setStyle('Fusion')
        
        window = DTSCreatorLauncher()
        window.show()
        
        return app.exec()
    
    except Exception as e:
        import traceback
        error_msg = f"Fatal Error:\n\n{str(e)}\n\n{traceback.format_exc()}"
        print(error_msg)
        try:
            QMessageBox.critical(None, "Fatal Error", error_msg)
        except:
            pass
        return 1


if __name__ == '__main__':
    try:
        sys.exit(main())
    except Exception as e:
        import traceback
        print(f"Fatal Error: {e}")
        print(traceback.format_exc())
        sys.exit(1)

