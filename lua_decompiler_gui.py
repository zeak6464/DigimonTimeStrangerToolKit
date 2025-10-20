#!/usr/bin/env python3
"""
Lua Decompiler GUI
A user-friendly interface for unluac.jar to decompile Lua files
"""

import sys
import subprocess
from pathlib import Path
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
    QPushButton, QLabel, QFileDialog, QTextEdit, QGroupBox, QMessageBox,
    QProgressBar, QLineEdit
)
from PyQt6.QtCore import Qt, QThread, pyqtSignal
from PyQt6.QtGui import QFont


class DecompilerThread(QThread):
    """Background thread for decompiling Lua files"""
    progress = pyqtSignal(str)
    file_progress = pyqtSignal(int, int)  # current, total
    finished = pyqtSignal(int, int)  # success_count, total_count
    
    def __init__(self, unluac_jar, input_dir, output_dir):
        super().__init__()
        self.unluac_jar = Path(unluac_jar)
        self.input_dir = Path(input_dir)
        self.output_dir = Path(output_dir)
    
    def run(self):
        """Execute decompilation"""
        try:
            # Create output directory
            self.output_dir.mkdir(parents=True, exist_ok=True)
            self.progress.emit(f"📁 Created output directory: {self.output_dir}")
            
            # Find all .lua files
            lua_files = list(self.input_dir.glob("*.lua"))
            
            if not lua_files:
                self.progress.emit("⚠️ No .lua files found in input directory!")
                self.finished.emit(0, 0)
                return
            
            self.progress.emit(f"📊 Found {len(lua_files)} Lua file(s) to decompile")
            self.progress.emit("")
            
            success_count = 0
            
            for idx, lua_file in enumerate(lua_files, 1):
                self.file_progress.emit(idx, len(lua_files))
                
                output_file = self.output_dir / lua_file.name
                
                self.progress.emit(f"[{idx}/{len(lua_files)}] Decompiling: {lua_file.name}")
                
                try:
                    # Run unluac
                    result = subprocess.run(
                        ['java', '-jar', str(self.unluac_jar), str(lua_file)],
                        capture_output=True,
                        text=True,
                        timeout=30
                    )
                    
                    if result.returncode == 0 and result.stdout:
                        # Write output
                        output_file.write_text(result.stdout, encoding='utf-8')
                        self.progress.emit(f"  ✅ Success → {output_file.name}")
                        success_count += 1
                    else:
                        error_msg = result.stderr if result.stderr else "Unknown error"
                        self.progress.emit(f"  ❌ Failed: {error_msg[:100]}")
                        
                except subprocess.TimeoutExpired:
                    self.progress.emit(f"  ❌ Timeout: File took too long to decompile")
                except Exception as e:
                    self.progress.emit(f"  ❌ Error: {str(e)}")
            
            self.progress.emit("")
            self.progress.emit("="*60)
            self.finished.emit(success_count, len(lua_files))
            
        except Exception as e:
            self.progress.emit(f"❌ Fatal error: {str(e)}")
            self.finished.emit(0, 0)


class LuaDecompilerGUI(QMainWindow):
    """Main GUI window for Lua Decompiler"""
    
    def __init__(self):
        super().__init__()
        self.decompiler_thread = None
        self.init_ui()
        self.check_dependencies()
        
    def init_ui(self):
        """Initialize the user interface"""
        self.setWindowTitle("Lua Decompiler - DTS Creator")
        self.setMinimumSize(800, 700)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout()
        central_widget.setLayout(main_layout)
        
        # Title
        title = QLabel("📜 Lua Decompiler")
        title_font = QFont()
        title_font.setPointSize(16)
        title_font.setBold(True)
        title.setFont(title_font)
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)
        main_layout.addWidget(title)
        
        subtitle = QLabel("Decompile Lua bytecode files using unluac")
        subtitle.setAlignment(Qt.AlignmentFlag.AlignCenter)
        subtitle.setStyleSheet("color: #666; font-style: italic;")
        main_layout.addWidget(subtitle)
        
        main_layout.addSpacing(20)
        
        # ===== UNLUAC JAR SECTION =====
        jar_group = QGroupBox("Unluac JAR File")
        jar_layout = QVBoxLayout()
        jar_group.setLayout(jar_layout)
        
        jar_row = QHBoxLayout()
        jar_row.addWidget(QLabel("JAR File:"))
        
        self.jar_path = QLineEdit()
        self.jar_path.setText("unluac_2023_12_24.jar")
        self.jar_path.setPlaceholderText("Path to unluac.jar...")
        jar_row.addWidget(self.jar_path)
        
        jar_browse_btn = QPushButton("Browse...")
        jar_browse_btn.clicked.connect(self.browse_jar)
        jar_row.addWidget(jar_browse_btn)
        
        jar_layout.addLayout(jar_row)
        
        jar_info = QLabel("ℹ️ Download from: github.com/pmachapman/unluac/releases")
        jar_info.setStyleSheet("color: #666; font-size: 9pt; font-style: italic;")
        jar_layout.addWidget(jar_info)
        
        main_layout.addWidget(jar_group)
        
        # ===== INPUT DIRECTORY =====
        input_group = QGroupBox("Input Directory")
        input_layout = QVBoxLayout()
        input_group.setLayout(input_layout)
        
        input_row = QHBoxLayout()
        input_row.addWidget(QLabel("Source Folder:"))
        
        self.input_path = QLineEdit()
        self.input_path.setPlaceholderText("Select folder containing .lua files...")
        self.input_path.setReadOnly(True)
        input_row.addWidget(self.input_path)
        
        input_browse_btn = QPushButton("Browse...")
        input_browse_btn.clicked.connect(self.browse_input)
        input_row.addWidget(input_browse_btn)
        
        input_layout.addLayout(input_row)
        
        self.input_status = QLabel("No folder selected")
        self.input_status.setStyleSheet("color: #666; font-size: 9pt;")
        input_layout.addWidget(self.input_status)
        
        main_layout.addWidget(input_group)
        
        # ===== OUTPUT DIRECTORY =====
        output_group = QGroupBox("Output Directory")
        output_layout = QVBoxLayout()
        output_group.setLayout(output_layout)
        
        output_row = QHBoxLayout()
        output_row.addWidget(QLabel("Output Folder:"))
        
        self.output_path = QLineEdit()
        self.output_path.setText("decompiled_lua")
        self.output_path.setPlaceholderText("Output folder for decompiled files...")
        output_row.addWidget(self.output_path)
        
        output_browse_btn = QPushButton("Browse...")
        output_browse_btn.clicked.connect(self.browse_output)
        output_row.addWidget(output_browse_btn)
        
        output_layout.addLayout(output_row)
        
        output_info = QLabel("ℹ️ Will be created if it doesn't exist")
        output_info.setStyleSheet("color: #666; font-size: 9pt; font-style: italic;")
        output_layout.addWidget(output_info)
        
        main_layout.addWidget(output_group)
        
        # ===== ACTION BUTTONS =====
        button_layout = QHBoxLayout()
        
        self.decompile_btn = QPushButton("▶ Start Decompilation")
        self.decompile_btn.setStyleSheet("""
            QPushButton {
                background-color: #4CAF50;
                color: white;
                font-size: 14px;
                font-weight: bold;
                padding: 15px;
                border-radius: 5px;
            }
            QPushButton:hover {
                background-color: #45a049;
            }
            QPushButton:disabled {
                background-color: #cccccc;
            }
        """)
        self.decompile_btn.clicked.connect(self.start_decompilation)
        button_layout.addWidget(self.decompile_btn)
        
        self.clear_btn = QPushButton("🗑 Clear")
        self.clear_btn.clicked.connect(self.clear_log)
        button_layout.addWidget(self.clear_btn)
        
        main_layout.addLayout(button_layout)
        
        # ===== PROGRESS BAR =====
        self.progress_bar = QProgressBar()
        self.progress_bar.setVisible(False)
        main_layout.addWidget(self.progress_bar)
        
        # ===== LOG OUTPUT =====
        log_group = QGroupBox("Decompilation Log")
        log_layout = QVBoxLayout()
        log_group.setLayout(log_layout)
        
        self.log_output = QTextEdit()
        self.log_output.setReadOnly(True)
        self.log_output.setMinimumHeight(250)
        self.log_output.setStyleSheet("""
            QTextEdit {
                background-color: #1e1e1e;
                color: #d4d4d4;
                font-family: 'Consolas', 'Courier New', monospace;
                font-size: 10pt;
            }
        """)
        log_layout.addWidget(self.log_output)
        
        main_layout.addWidget(log_group)
        
        # Status bar
        self.statusBar().showMessage("Ready")
        
        # Initial log
        self.log("✨ Lua Decompiler Ready")
        self.log("ℹ️ Select input folder and click 'Start Decompilation'")
    
    def check_dependencies(self):
        """Check if required tools exist"""
        self.log("")
        self.log("🔍 Checking dependencies...")
        
        # Check Java
        try:
            result = subprocess.run(
                ['java', '-version'],
                capture_output=True,
                text=True,
                timeout=5
            )
            if result.returncode == 0:
                version_line = result.stderr.split('\n')[0] if result.stderr else "Unknown version"
                self.log(f"  ✅ Java found: {version_line}")
            else:
                self.log("  ❌ Java not found or not working")
        except Exception as e:
            self.log(f"  ❌ Java not found: {str(e)}")
            self.log("  ℹ️ Install Java from: https://java.com/download")
        
        # Check unluac jar
        jar_path = Path(self.jar_path.text())
        if jar_path.exists():
            self.log(f"  ✅ Unluac JAR found: {jar_path}")
        else:
            self.log(f"  ⚠️ Unluac JAR not found: {jar_path}")
            self.log("  ℹ️ Download from: https://github.com/pmachapman/unluac/releases")
    
    def browse_jar(self):
        """Browse for unluac JAR file"""
        file_path, _ = QFileDialog.getOpenFileName(
            self,
            "Select Unluac JAR File",
            str(Path.cwd()),
            "JAR Files (*.jar);;All Files (*.*)"
        )
        if file_path:
            self.jar_path.setText(file_path)
            self.log(f"📦 Selected JAR: {file_path}")
    
    def browse_input(self):
        """Browse for input directory"""
        folder_path = QFileDialog.getExistingDirectory(
            self,
            "Select Input Folder (containing .lua files)",
            str(Path.cwd())
        )
        if folder_path:
            self.input_path.setText(folder_path)
            
            # Count .lua files
            lua_files = list(Path(folder_path).glob("*.lua"))
            self.input_status.setText(f"✅ Found {len(lua_files)} .lua file(s)")
            self.input_status.setStyleSheet("color: green; font-size: 9pt; font-weight: bold;")
            
            self.log(f"📂 Selected input folder: {folder_path}")
            self.log(f"   Found {len(lua_files)} .lua file(s)")
    
    def browse_output(self):
        """Browse for output directory"""
        folder_path = QFileDialog.getExistingDirectory(
            self,
            "Select Output Folder",
            str(Path.cwd())
        )
        if folder_path:
            self.output_path.setText(folder_path)
            self.log(f"📂 Selected output folder: {folder_path}")
    
    def clear_log(self):
        """Clear the log output"""
        self.log_output.clear()
        self.log("🗑 Log cleared")
    
    def log(self, message):
        """Add message to log output"""
        self.log_output.append(message)
        self.log_output.verticalScrollBar().setValue(
            self.log_output.verticalScrollBar().maximum()
        )
    
    def start_decompilation(self):
        """Start the decompilation process"""
        if self.decompiler_thread and self.decompiler_thread.isRunning():
            QMessageBox.warning(self, "Already Running", "Decompilation is already in progress!")
            return
        
        # Validate inputs
        jar_path = Path(self.jar_path.text())
        if not jar_path.exists():
            QMessageBox.critical(
                self,
                "JAR Not Found",
                f"Unluac JAR file not found!\n\n{jar_path}\n\n"
                "Please download it from:\nhttps://github.com/pmachapman/unluac/releases"
            )
            return
        
        input_dir = self.input_path.text()
        if not input_dir:
            QMessageBox.warning(self, "No Input", "Please select an input folder!")
            return
        
        input_path = Path(input_dir)
        if not input_path.exists():
            QMessageBox.critical(self, "Folder Not Found", f"Input folder not found:\n\n{input_path}")
            return
        
        output_dir = self.output_path.text()
        if not output_dir:
            QMessageBox.warning(self, "No Output", "Please specify an output folder!")
            return
        
        # Confirm
        lua_files = list(input_path.glob("*.lua"))
        reply = QMessageBox.question(
            self,
            "Start Decompilation",
            f"Decompile {len(lua_files)} Lua file(s)?\n\n"
            f"Input:  {input_path}\n"
            f"Output: {output_dir}\n\n"
            "This may take a while for large files.",
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No
        )
        
        if reply == QMessageBox.StandardButton.No:
            return
        
        # Disable UI
        self.decompile_btn.setEnabled(False)
        self.progress_bar.setVisible(True)
        self.progress_bar.setMaximum(len(lua_files))
        self.progress_bar.setValue(0)
        
        self.statusBar().showMessage("Decompiling...")
        
        self.log("\n" + "="*60)
        self.log("🚀 Starting decompilation...")
        self.log("="*60)
        
        # Start thread
        self.decompiler_thread = DecompilerThread(jar_path, input_path, output_dir)
        self.decompiler_thread.progress.connect(self.log)
        self.decompiler_thread.file_progress.connect(self.update_progress)
        self.decompiler_thread.finished.connect(self.on_decompilation_finished)
        self.decompiler_thread.start()
    
    def update_progress(self, current, total):
        """Update progress bar"""
        self.progress_bar.setValue(current)
        self.statusBar().showMessage(f"Decompiling... {current}/{total}")
    
    def on_decompilation_finished(self, success_count, total_count):
        """Handle decompilation completion"""
        self.progress_bar.setVisible(False)
        self.decompile_btn.setEnabled(True)
        
        if total_count == 0:
            self.statusBar().showMessage("No files to decompile")
            return
        
        self.log(f"🎉 Decompilation Complete!")
        self.log(f"   Success: {success_count}/{total_count} files")
        
        if success_count == total_count:
            self.log(f"   ✅ All files decompiled successfully!")
            self.statusBar().showMessage(f"✅ All {total_count} files decompiled successfully!")
            QMessageBox.information(
                self,
                "Success",
                f"✅ Decompilation complete!\n\n"
                f"Successfully decompiled {success_count}/{total_count} files.\n\n"
                f"Output folder: {self.output_path.text()}"
            )
        elif success_count > 0:
            failed = total_count - success_count
            self.log(f"   ⚠️ {failed} file(s) failed to decompile")
            self.statusBar().showMessage(f"⚠️ Completed with {failed} failure(s)")
            QMessageBox.warning(
                self,
                "Partial Success",
                f"⚠️ Decompilation completed with some failures.\n\n"
                f"Success: {success_count}/{total_count} files\n"
                f"Failed:  {failed} file(s)\n\n"
                f"Check the log for details."
            )
        else:
            self.log(f"   ❌ All files failed to decompile")
            self.statusBar().showMessage("❌ Decompilation failed")
            QMessageBox.critical(
                self,
                "Failed",
                f"❌ Decompilation failed!\n\n"
                f"All {total_count} files failed to decompile.\n\n"
                f"Check the log for details."
            )


def main():
    """Main entry point"""
    try:
        app = QApplication(sys.argv)
        app.setStyle('Fusion')
        
        window = LuaDecompilerGUI()
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

