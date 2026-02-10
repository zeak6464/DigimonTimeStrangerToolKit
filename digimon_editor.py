"""
DTS Creator - Digimon Editor GUI using PyQt6
"""

import sys
import os
from pathlib import Path
from typing import Optional, List
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
    QLabel, QLineEdit, QSpinBox, QComboBox, QPushButton, QTabWidget,
    QScrollArea, QGroupBox, QGridLayout, QCheckBox, QTextEdit,
    QMessageBox, QFileDialog, QTableWidget, QTableWidgetItem, QPlainTextEdit,
    QHeaderView, QSplitter, QListWidget, QListWidgetItem, QDoubleSpinBox, QFormLayout,
    QDialog, QDialogButtonBox, QWizard, QWizardPage, QFrame
)
from PyQt6.QtCore import Qt, pyqtSignal
from PyQt6.QtGui import QFont, QPixmap, QIcon, QPalette, QColor

from data_loader import MBELoader, DigimonData, DLCExporter
from csv_exporter import CSVExporter, repack_mbe_files, repack_dlc_mbe_files


class SkillEditor(QWidget):
    """Widget for editing signature and generic skills"""
    
    def __init__(self, skill_type: str = "signature", loader=None):
        super().__init__()
        self.skill_type = skill_type
        self.loader = loader
        self.skill_widgets = []
        self.setup_ui()
    
    def setup_ui(self):
        layout = QVBoxLayout()
        
        # Title
        title = QLabel(f"{self.skill_type.title()} Skills")
        title.setFont(QFont("Arial", 12, QFont.Weight.Bold))
        layout.addWidget(title)
        
        # Skills container
        scroll = QScrollArea()
        scroll_widget = QWidget()
        scroll_layout = QVBoxLayout(scroll_widget)
        
        # Create skill input widgets
        max_skills = 12 if self.skill_type == "signature" else 4
        for i in range(max_skills):
            skill_widget = self.create_skill_widget(i)
            self.skill_widgets.append(skill_widget)
            scroll_layout.addWidget(skill_widget)
        
        scroll.setWidget(scroll_widget)
        scroll.setWidgetResizable(True)
        scroll.setMaximumHeight(300)
        layout.addWidget(scroll)
        
        self.setLayout(layout)
    
    def create_skill_widget(self, index: int) -> QWidget:
        """Create a single skill input widget"""
        widget = QGroupBox(f"Skill {index + 1}")
        layout = QHBoxLayout()
        
        # Skill ID with name display
        layout.addWidget(QLabel("Skill:"))
        skill_id = QSpinBox()
        skill_id.setRange(0, 99999)
        skill_id.setObjectName(f"skill_id_{index}")
        skill_id.valueChanged.connect(lambda v, idx=index: self.update_skill_name(idx))
        layout.addWidget(skill_id)
        
        # Skill name display
        skill_name_label = QLabel("")
        skill_name_label.setObjectName(f"skill_name_{index}")
        skill_name_label.setStyleSheet("color: #666; font-style: italic;")
        layout.addWidget(skill_name_label)
        
        # Skill Level/Slot
        slot_label = "Slot:" if self.skill_type == "signature" else "Level:"
        layout.addWidget(QLabel(slot_label))
        skill_level = QSpinBox()
        skill_level.setRange(0, 100)
        skill_level.setObjectName(f"skill_level_{index}")
        layout.addWidget(skill_level)
        
        layout.addStretch()
        widget.setLayout(layout)
        return widget
    
    def load_skills(self, skills: List[dict]):
        """Load skills into the widget"""
        for i, skill_widget in enumerate(self.skill_widgets):
            skill_id_widget = skill_widget.findChild(QSpinBox, f"skill_id_{i}")
            skill_level_widget = skill_widget.findChild(QSpinBox, f"skill_level_{i}")
            
            if i < len(skills):
                skill_id_widget.setValue(skills[i].get("id", 0))
                level_key = "slot" if self.skill_type == "signature" else "level"
                skill_level_widget.setValue(skills[i].get(level_key, 0))
            else:
                skill_id_widget.setValue(0)
                skill_level_widget.setValue(0)
    
    def get_skills(self) -> List[dict]:
        """Get skills from the widget"""
        skills = []
        for i, skill_widget in enumerate(self.skill_widgets):
            skill_id_widget = skill_widget.findChild(QSpinBox, f"skill_id_{i}")
            skill_level_widget = skill_widget.findChild(QSpinBox, f"skill_level_{i}")
            
            skill_id = skill_id_widget.value()
            skill_level = skill_level_widget.value()
            
            if skill_id > 0:
                level_key = "slot" if self.skill_type == "signature" else "level"
                skills.append({"id": skill_id, level_key: skill_level})
        
        return skills
    
    def update_skill_name(self, index: int):
        """Update skill name display when skill ID changes"""
        skill_id_widget = self.skill_widgets[index].findChild(QSpinBox, f"skill_id_{index}")
        skill_name_widget = self.skill_widgets[index].findChild(QLabel, f"skill_name_{index}")
        
        if skill_id_widget and skill_name_widget:
            skill_id = skill_id_widget.value()
            if skill_id > 0:
                # Get skill name from loader
                skill_name = self.loader.get_skill_name(skill_id)
                clean_name = self.loader.clean_ui_text(skill_name)
                skill_name_widget.setText(clean_name)
            else:
                skill_name_widget.setText("")
    
    def update_all_skill_names(self):
        """Update skill names for all skill widgets"""
        for i in range(len(self.skill_widgets)):
            self.update_skill_name(i)


class DigimonCreationWizard(QWizard):
    """Multi-step wizard for creating new Digimon and exporting to dsts-loader"""
    
    def __init__(self, parent=None, loader=None):
        super().__init__(parent)
        self.loader = loader
        self.template_digimon: Optional[DigimonData] = None
        self.new_digimon: Optional[DigimonData] = None
        self.last_export_path: Optional[Path] = None  # Store export path for later import
        
        self.setWindowTitle("✨ Digimon Creation Wizard - Export to dsts-loader")
        self.setMinimumSize(700, 600)
        self.resize(900, 700)  # Set a larger default size
        
        # Enable maximize button and make window resizable
        self.setWindowFlags(self.windowFlags() | Qt.WindowType.WindowMaximizeButtonHint)
        
        # Set wizard style
        self.setWizardStyle(QWizard.WizardStyle.ModernStyle)
        self.setOption(QWizard.WizardOption.HaveHelpButton, False)
        
        # Add pages
        self.addPage(TemplateSelectionPage(self))
        self.addPage(BasicInfoPage(self))
        self.addPage(ClassificationPage(self))
        self.addPage(ProfilePage(self))
        self.addPage(StatsPage(self))
        self.addPage(ResistancesPage(self))
        self.addPage(SkillsPage(self))
        self.addPage(EvolutionPage(self))
        self.addPage(ModelPage(self))
        self.addPage(ReviewPage(self))
        
        # Connect signals
        self.button(QWizard.WizardButton.FinishButton).clicked.connect(self.finish_wizard)
        
        # Apply styling
        self.setStyleSheet("""
            QWizard {
                background-color: #f5f7fa;
            }
            QWizardPage {
                background-color: white;
                border-radius: 8px;
                padding: 20px;
            }
        """)
    
    def finish_wizard(self):
        """Called when wizard is finished - export to DLC"""
        try:
            # Get all data from pages
            template_page = self.page(0)
            basic_page = self.page(1)
            class_page = self.page(2)
            profile_page = self.page(3)
            stats_page = self.page(4)
            resist_page = self.page(5)
            skills_page = self.page(6)
            evolution_page = self.page(7)
            model_page = self.page(8)
        except Exception as e:
            import traceback
            error_trace = traceback.format_exc()
            QMessageBox.critical(
                self,
                "Wizard Error",
                f"Error getting wizard pages:\n\n{str(e)}\n\nSee console for details."
            )
            print(f"\n{'='*80}")
            print("WIZARD PAGE ERROR:")
            print(error_trace)
            print(f"{'='*80}\n")
            return
        
        # Create new Digimon from template
        try:
            if not self.template_digimon:
                QMessageBox.warning(self, "Error", "No template Digimon selected!")
                return
            
            # Copy template
            from copy import deepcopy
            self.new_digimon = deepcopy(self.template_digimon)
            
            # Store template chr_id for reference
            template_chr_id = self.template_digimon.chr_id
            
            # Update with wizard data
            self.new_digimon.id = basic_page.id_spin.value()
            self.new_digimon.name = basic_page.name_edit.text()
            self.new_digimon.char_key = basic_page.char_key_edit.text()
            new_chr_id = basic_page.chr_id_edit.text()
            self.new_digimon.chr_id = new_chr_id
        except Exception as e:
            import traceback
            error_trace = traceback.format_exc()
            QMessageBox.critical(
                self,
                "Wizard Error",
                f"Error collecting basic data:\n\n{str(e)}\n\nSee console for details."
            )
            print(f"\n{'='*80}")
            print("DATA COLLECTION ERROR:")
            print(error_trace)
            print(f"{'='*80}\n")
            return
        
        try:
            self.new_digimon.stage_id = class_page.stage_combo.currentData() if class_page.stage_combo.currentData() is not None else 0
            self.new_digimon.type_id = class_page.type_combo.currentData() if class_page.type_combo.currentData() is not None else 0
            self.new_digimon.generation_id = self.new_digimon.stage_id
            self.new_digimon.personality_id = class_page.personality_combo.currentData() if class_page.personality_combo.currentData() is not None else 0
            self.new_digimon.base_personality = self.new_digimon.personality_id
            self.new_digimon.growth_pattern_id = class_page.growth_combo.currentData() if class_page.growth_combo.currentData() is not None else 1
            self.new_digimon.tribe_name = class_page.tribe_combo.currentText() if class_page.tribe_combo.currentText() else "None"
            
            # Store selected tribe name for belong export
            if not hasattr(self.new_digimon, 'tribe_name'):
                self.new_digimon.tribe_name = None
            self.new_digimon.tribe_name = class_page.tribe_combo.currentText()
            
            # Profile
            self.new_digimon.profile_text = profile_page.profile_edit.toPlainText()
            
            # Stats
            self.new_digimon.base_hp = stats_page.hp_spin.value()
            self.new_digimon.base_sp = stats_page.sp_spin.value()
            self.new_digimon.base_atk = stats_page.atk_spin.value()
            self.new_digimon.base_def = stats_page.def_spin.value()
            self.new_digimon.base_int = stats_page.int_spin.value()
            self.new_digimon.base_spi = stats_page.spi_spin.value()
            self.new_digimon.base_spd = stats_page.spd_spin.value()
            
            self.new_digimon.res_null = resist_page.resist_widgets["null"].value()
            self.new_digimon.res_fire = resist_page.resist_widgets["fire"].value()
            self.new_digimon.res_water = resist_page.resist_widgets["water"].value()
            self.new_digimon.res_ice = resist_page.resist_widgets["ice"].value()
            self.new_digimon.res_grass = resist_page.resist_widgets["grass"].value()
            self.new_digimon.res_wind = resist_page.resist_widgets["wind"].value()
            self.new_digimon.res_elec = resist_page.resist_widgets["elec"].value()
            self.new_digimon.res_ground = resist_page.resist_widgets["ground"].value()
            self.new_digimon.res_steel = resist_page.resist_widgets["steel"].value()
            self.new_digimon.res_light = resist_page.resist_widgets["light"].value()
            self.new_digimon.res_dark = resist_page.resist_widgets["dark"].value()
            
            # Skills
            self.new_digimon.signature_skills = skills_page.signature_skills_editor.get_skills()
            self.new_digimon.generic_skills = skills_page.generic_skills_editor.get_skills()
            
            # Evolution paths (from EvolutionPage)
            self.new_digimon.evolution_paths = evolution_page.evolution_paths.copy()
            self.new_digimon.deevolution_sources = evolution_page.deevolution_sources.copy()
            
            # Get evolution requirements from the single requirements section
            self.new_digimon.evolution_conditions = [evolution_page.evolution_requirements]
            
            self.new_digimon.model_id = model_page.model_id_edit.text()
            self.new_digimon.motion_id = model_page.motion_id_edit.text()
            
            # Update chr_id references in all data structures
            self._update_chr_id_references(self.new_digimon, template_chr_id, new_chr_id)
        except Exception as e:
            import traceback
            error_trace = traceback.format_exc()
            QMessageBox.critical(
                self,
                "Wizard Error",
                f"Error collecting wizard data:\n\n{str(e)}\n\nSee console for details."
            )
            print(f"\n{'='*80}")
            print("WIZARD DATA COLLECTION ERROR:")
            print(error_trace)
            print(f"{'='*80}\n")
            return
        
        # Get animation reference
        animation_ref = model_page.animation_ref_edit.text().strip() if model_page.animation_ref_edit.text().strip() else template_chr_id
        
        # Ask user where to export
        from pathlib import Path
        default_path = Path.cwd() / "dsts-loader"
        
        export_dir = QFileDialog.getExistingDirectory(
            self,
            "Select dsts-loader Export Directory",
            str(default_path),
            QFileDialog.Option.ShowDirsOnly
        )
        
        if not export_dir:
            # Don't lose work if user cancels - ask if they want to retry or exit
            reply = QMessageBox.question(
                self,
                "Export Cancelled",
                "Do you want to go back and review your Digimon, or discard all changes?",
                QMessageBox.StandardButton.Retry | QMessageBox.StandardButton.Discard,
                QMessageBox.StandardButton.Retry
            )
            
            if reply == QMessageBox.StandardButton.Retry:
                # Go back to review page
                self.back()
                return
            else:
                # User chose to discard - close wizard
                return
        
        # Store export path for later import
        self.last_export_path = Path(export_dir)
        
        # Export to dsts-loader format
        try:
            success = self._export_to_dsts_loader(Path(export_dir), self.new_digimon, animation_ref)
        except Exception as e:
            import traceback
            error_trace = traceback.format_exc()
            QMessageBox.critical(
                self,
                "Export Error",
                f"An error occurred during export:\n\n{str(e)}\n\nSee console for full traceback."
            )
            print(f"\n{'='*80}")
            print("EXPORT ERROR:")
            print(error_trace)
            print(f"{'='*80}\n")
            return
        
        if success:
            QMessageBox.information(
                self,
                "Success! 🎉",
                f"✅ {self.new_digimon.name} has been successfully exported!\n\n"
                f"ID: {self.new_digimon.id}\n"
                f"Chr ID: {self.new_digimon.chr_id}\n"
                f"Animation Reference: {animation_ref}\n\n"
                f"📁 Files created in dsts-loader format:\n\n"
                f"patch/data/:\n"
                f"  • digimon_status_data.ap.csv\n"
                f"  • char_info.ap.csv\n"
                f"  • model_setting.ap.csv\n"
                f"  • lod.ap.csv + lod_model.ap.csv\n"
                f"  • evolution_to.ap.csv + evolution_condition.ap.csv\n"
                f"  • same_animation_data.ap.csv\n\n"
                f"patch_text01/text/:\n"
                f"  • char_name.ap.csv\n"
                f"  • digimon_profile.ap.csv\n"
                f"  • belong.ap.csv\n\n"
                f"app_0/data/:\n"
                f"  • model_outline_battle.ap.csv\n\n"
                f"Ready to use with dsts-loader! ✨"
            )
        else:
            QMessageBox.warning(self, "Error", "Failed to export Digimon")
    
    def _update_chr_id_references(self, digimon: DigimonData, old_chr_id: str, new_chr_id: str):
        """Update all chr_id references in digimon data structures"""
        import json
        
        old_chr_id_clean = old_chr_id.strip('"')
        new_chr_id_clean = new_chr_id.strip('"')
        
        # Update char_info_data
        if digimon.char_info_data:
            for key, value in digimon.char_info_data.items():
                if isinstance(value, str) and old_chr_id_clean in value:
                    digimon.char_info_data[key] = value.replace(old_chr_id_clean, new_chr_id_clean)
        
        # Update model_setting_data
        if digimon.model_setting_data:
            for key, value in digimon.model_setting_data.items():
                if isinstance(value, str) and old_chr_id_clean in value:
                    digimon.model_setting_data[key] = value.replace(old_chr_id_clean, new_chr_id_clean)
                elif key == 'raw_data' and isinstance(value, list):
                    # Update raw_data array - replace chr_id references in all string elements
                    for idx, item in enumerate(value):
                        if isinstance(item, str) and old_chr_id_clean in item:
                            value[idx] = item.replace(old_chr_id_clean, new_chr_id_clean)
        
        # Update model_locator_data
        if digimon.model_locator_data:
            for key, value in digimon.model_locator_data.items():
                if isinstance(value, str) and old_chr_id_clean in value:
                    digimon.model_locator_data[key] = value.replace(old_chr_id_clean, new_chr_id_clean)
        
        # Update model_locator_motion_data - update motion keys
        for motion_entry in digimon.model_locator_motion_data:
            motion_key = motion_entry.get('motion_key', '')
            if isinstance(motion_key, str) and old_chr_id_clean in motion_key:
                motion_entry['motion_key'] = motion_key.replace(old_chr_id_clean, new_chr_id_clean)
            motion_name = motion_entry.get('motion_name', '')
            if isinstance(motion_name, str) and old_chr_id_clean in motion_name:
                motion_entry['motion_name'] = motion_name.replace(old_chr_id_clean, new_chr_id_clean)
        
        # Update lod_data
        if digimon.lod_data:
            for key, value in digimon.lod_data.items():
                if isinstance(value, str) and old_chr_id_clean in value:
                    digimon.lod_data[key] = value.replace(old_chr_id_clean, new_chr_id_clean)
        
        # Update lod_model_data
        if digimon.lod_model_data:
            for key, value in digimon.lod_model_data.items():
                if isinstance(value, str) and old_chr_id_clean in value:
                    digimon.lod_model_data[key] = value.replace(old_chr_id_clean, new_chr_id_clean)
        
        # Update field_move_animation_data - update animation keys
        for anim_entry in digimon.field_move_animation_data:
            anim_key = anim_entry.get('animation_key', '')
            if isinstance(anim_key, str) and old_chr_id_clean in anim_key:
                anim_entry['animation_key'] = anim_key.replace(old_chr_id_clean, new_chr_id_clean)
            for motion_key in ['motion1', 'motion2', 'motion3']:
                motion_value = anim_entry.get(motion_key, '')
                if isinstance(motion_value, str) and old_chr_id_clean in motion_value:
                    anim_entry[motion_key] = motion_value.replace(old_chr_id_clean, new_chr_id_clean)
    
    def _escape_csv_value(self, value: str) -> str:
        """Properly escape a value for CSV output"""
        if not value:
            return value
        # Escape quotes by doubling them
        if '"' in value:
            value = value.replace('"', '""')
        return value
    
    def _export_to_dsts_loader(self, base_path: Path, digimon: DigimonData, animation_ref: str) -> bool:
        """Export digimon to dsts-loader format (.ap.csv files)"""
        try:
            from pathlib import Path
            import csv
            
            # Create directory structure
            patch_data = base_path / "patch" / "data"
            patch_text = base_path / "patch_text01" / "text"
            app_data = base_path / "app_0" / "data"
            
            # Create all needed directories
            (patch_data / "digimon_status.mbe").mkdir(parents=True, exist_ok=True)
            (patch_data / "char_info.mbe").mkdir(parents=True, exist_ok=True)
            (patch_data / "model_setting.mbe").mkdir(parents=True, exist_ok=True)
            (patch_data / "lod_chara.mbe").mkdir(parents=True, exist_ok=True)
            (patch_data / "evolution.mbe").mkdir(parents=True, exist_ok=True)
            (patch_data / "anim_setting.mbe").mkdir(parents=True, exist_ok=True)
            (patch_text / "char_name.mbe").mkdir(parents=True, exist_ok=True)
            (patch_text / "digimon_profile.mbe").mkdir(parents=True, exist_ok=True)
            (patch_text / "belong.mbe").mkdir(parents=True, exist_ok=True)
            (app_data / "model_outline.mbe").mkdir(parents=True, exist_ok=True)
            
            # Export digimon_status_data
            self._write_digimon_status_ap_csv(patch_data / "digimon_status.mbe" / "000_digimon_status_data.ap.csv", digimon)
            
            # Export char_info
            self._write_char_info_ap_csv(patch_data / "char_info.mbe" / "000_char_info.ap.csv", digimon)
            
            # Export model_setting
            if digimon.model_setting_data:
                self._write_model_setting_ap_csv(patch_data / "model_setting.mbe" / "000_model_setting.ap.csv", digimon)
            
            # Export lod data
            if digimon.lod_data:
                self._write_lod_ap_csv(patch_data / "lod_chara.mbe" / "000_lod.ap.csv", digimon)
                self._write_lod_model_ap_csv(patch_data / "lod_chara.mbe" / "001_lod_model.ap.csv", digimon)
            
            # Export animation reference
            self._write_anim_setting_ap_csv(patch_data / "anim_setting.mbe" / "001_same_animation_data.ap.csv", digimon.chr_id, animation_ref)
            
            # Export evolution data (includes both evolutions FROM this Digimon and pre-evolutions TO this Digimon)
            if digimon.evolution_paths or digimon.deevolution_sources:
                self._write_evolution_ap_csv(patch_data / "evolution.mbe" / "001_evolution_to.ap.csv", digimon)
                self._write_evolution_condition_ap_csv(patch_data / "evolution.mbe" / "000_evolution_condition.ap.csv", digimon)
            
            # Export char_name
            self._write_char_name_ap_csv(patch_text / "char_name.mbe" / "000_Sheet1.ap.csv", digimon)
            
            # Export digimon_profile (always export, even if empty - use default text)
            self._write_profile_ap_csv(patch_text / "digimon_profile.mbe" / "000_Sheet1.ap.csv", digimon)
            
            # Export belong (classification text)
            self._write_belong_ap_csv(patch_text / "belong.mbe" / "000_Sheet1.ap.csv", digimon)
            
            # Export model_outline
            self._write_model_outline_ap_csv(app_data / "model_outline.mbe" / "000_model_outline_battle.ap.csv", digimon)
            
            return True
            
        except Exception as e:
            print(f"Error exporting to dsts-loader: {e}")
            import traceback
            traceback.print_exc()
            return False
    
    def _write_digimon_status_ap_csv(self, filepath: Path, digimon: DigimonData):
        """Write digimon_status_data.ap.csv"""
        # Header from dsts-loader format
        header = "int32 0,empty 1,string2 2,string2 3,int32 4,int32 5,int32 6,int32 7,int32 8,int32 9,int32 10,int32 11,int32 12,int32 13,int32 14,int32 15,int32 16,int32 17,empty 18,bool 19,bool 20,bool 21,bool 22,bool 23,bool 24,bool 25,bool 26,bool 27,bool 28,bool 29,bool 30,bool 31,bool 32,bool 33,bool 34,bool 35,bool 36,bool 37,bool 38,bool 39,bool 40,bool 41,bool 42,bool 43,bool 44,bool 45,bool 46,bool 47,bool 48,bool 49,bool 50,int32 51,bool 52,bool 53,bool 54,bool 55,bool 56,bool 57,bool 58,bool 59,bool 60,int32 61,int32 62,int32 63,int32 64,int32 65,int32 66,int32 67,int32 68,int32 69,int32 70,int32 71,int32 72,empty 73,int32 74,int32 75,empty 76,int32 77,int32 78,empty 79,int32 80,int32 81,empty 82,int32 83,int32 84,empty 85,int32 86,int32 87,empty 88,int32 89,int32 90,empty 91,int32 92,int32 93,empty 94,int32 95,int32 96,empty 97,int32 98,int32 99,empty 100,int32 101,int32 102,empty 103,int32 104,int32 105,empty 106,int32 107,int32 108,empty 109,int32 110,int32 111,empty 112,int32 113,int32 114,empty 115,int32 116,int32 117,empty 118,int32 119,int32 120,int32 121,int32 122,float 123,bool 124,bool 125,int32 126,empty 127,int32 128,int32 129,int32 130,int32 131,int32 132,int32 133,int32 134,int32 135"
        
        # Build data row
        parts = []
        parts.append(str(digimon.id))  # 0
        parts.append('')  # 1 empty (blank, not quoted)
        parts.append(f'"{self._escape_csv_value(digimon.char_key)}"')  # 2
        parts.append(f'"{self._escape_csv_value(digimon.chr_id)}"')  # 3
        parts.append(str(digimon.stage_id))  # 4
        parts.append(str(digimon.personality_id))  # 5
        parts.append(str(digimon.type_id))  # 6
        
        # Resistances (7-17)
        parts.append(str(digimon.res_null))
        parts.append(str(digimon.res_fire))
        parts.append(str(digimon.res_water))
        parts.append(str(digimon.res_ice))
        parts.append(str(digimon.res_grass))
        parts.append(str(digimon.res_wind))
        parts.append(str(digimon.res_elec))
        parts.append(str(digimon.res_ground))
        parts.append(str(digimon.res_steel))
        parts.append(str(digimon.res_light))
        parts.append(str(digimon.res_dark))
        parts.append('')  # 18 empty
        
        # Traits part 1 (19-50 bool) - 32 traits
        for i in range(32):
            if i < len(digimon.traits):
                parts.append("true" if digimon.traits[i] else "false")
            else:
                parts.append("false")
        
        parts.append("0")  # 51 int32
        
        # Traits part 2 (52-60 bool) - 9 traits
        for i in range(32, 41):
            if i < len(digimon.traits):
                parts.append("true" if digimon.traits[i] else "false")
            else:
                parts.append("false")
        
        parts.append(str(digimon.base_personality))  # 61 int32
        parts.append("1")  # 62
        parts.append("99")  # 63
        parts.append(str(digimon.base_hp))  # 64
        parts.append(str(digimon.base_sp))  # 65
        parts.append(str(digimon.base_atk))  # 66
        parts.append(str(digimon.base_def))  # 67
        parts.append(str(digimon.base_int))  # 68
        parts.append(str(digimon.base_spi))  # 69
        parts.append(str(digimon.base_spd))  # 70
        parts.append(str(digimon.growth_pattern_id))  # 71 - Growth Pattern (1-18)
        
        # Signature skills (72-107) - pattern: id, empty, slot
        for i in range(12):
            if i < len(digimon.signature_skills):
                skill = digimon.signature_skills[i]
                parts.append(str(skill.get('id', 0)))
                parts.append('')  # empty
                parts.append(str(skill.get('slot', 0)))
            else:
                parts.append("0")
                parts.append('')  # empty
                parts.append("0")
        
        # Generic skills (108-119) - pattern: id, empty, level
        for i in range(4):
            if i < len(digimon.generic_skills):
                skill = digimon.generic_skills[i]
                parts.append(str(skill.get('id', 0)))
                parts.append('')  # empty
                parts.append(str(skill.get('level', 0)))
            else:
                parts.append("0")
                parts.append('')  # empty
                parts.append("0")
        
        # Remaining fields (120-135)
        # Column 126: Signature Animation Reference - Formula: 20000 + (ID × 10) + 1
        anim_ref = 20000 + (digimon.id * 10) + 1
        
        parts.extend([
            "2",  # 120 - Size category
            str(digimon.model_type) if hasattr(digimon, 'model_type') else "1",  # 121 - Model type
            str(digimon.animation_set) if hasattr(digimon, 'animation_set') else "1",  # 122 - Animation set
            "0",  # 123 - Model scale override (float, 0 = normal)
            "true",  # 124 - Boolean flag
            "false",  # 125 - Boolean flag
            str(anim_ref),  # 126 - Signature Animation Reference (calculated)
            '',  # 127 - empty
            "0",  # 128 - Color/Palette ID (0 for new Digimon)
            "0",  # 129 - Texture/Material ID (0 for new Digimon)
            "0",  # 130 - Model Variant (0 for new Digimon)
            str(digimon.field_guide_id),  # 131 - Field Guide ID (-1 = none, 0+ = valid ID)
            str(digimon.script_id),  # 132 - Script ID (internal ID for scripts, -1 = none, 0+ = valid ID)
            "-1",  # 133 - Reserved (don't touch)
            "0",  # 134 - Reserved (always 0)
            "-1"  # 135 - Reserved (always -1)
        ])
        
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(header + '\n')
            f.write(','.join(parts) + '\n')
    
    def _write_char_info_ap_csv(self, filepath: Path, digimon: DigimonData):
        """Write char_info.ap.csv
        
        Columns:
        0: char_key, 1-2: empty, 3: chr_id, 4: id, 5: empty
        6-7: 0,0, 8: audio_id (motion_id), 9: 0, 10: model_id
        11: 0, 12: empty, 13: 0
        """
        header = 'string2 0,empty 1,empty 2,string2 3,string2 4,empty 5,int32 6,int32 7,string2 8,int32 9,string2 10,int32 11,string2 12,int32 13'
        
        # Get audio_id (motion_id) - prefer wizard value, fallback to template
        audio_id = ""
        if hasattr(digimon, 'motion_id') and digimon.motion_id:
            audio_id = digimon.motion_id
        elif hasattr(digimon, 'char_info_data') and digimon.char_info_data:
            audio_id = digimon.char_info_data.get('motion_ref', '')
        
        # Get model_id - prefer wizard value, fallback to template
        model_id = ""
        if hasattr(digimon, 'model_id') and digimon.model_id:
            model_id = digimon.model_id
        elif hasattr(digimon, 'char_info_data') and digimon.char_info_data:
            model_id = digimon.char_info_data.get('model_ref', '')
        
        parts = [
            f'"{self._escape_csv_value(digimon.char_key)}"',  # 0: char_key
            '', '',  # 1-2: empty columns
            f'"{self._escape_csv_value(digimon.chr_id)}"',  # 3: chr_id
            f'"{str(digimon.id)}"',  # 4: id
            '',  # 5: empty
            '0', '0',  # 6-7
            f'"{audio_id}"',  # 8: audio_id (motion_id in our code)
            '0',  # 9
            f'"{model_id}"',  # 10: model_id
            '0',  # 11
            '""',  # 12: empty string
            '0'  # 13
        ]
        
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(header + '\n')
            f.write(','.join(parts) + '\n')
    
    def _write_model_setting_ap_csv(self, filepath: Path, digimon: DigimonData):
        """Write model_setting.ap.csv"""
        if not digimon.model_setting_data or 'raw_data' not in digimon.model_setting_data:
            return
        
        header = 'string2 0,empty 1,string2 2,string2 3,string2 4,float 5,empty 6,empty 7,float 8,float 9,float 10,float 11,float 12,float 13,float 14,float 15,float 16,float 17,float 18,float 19,float 20,float 21,float 22,float 23,float 24,float 25,float 26,string2 27,string2 28,string2 29,string2 30,string2 31,string2 32,float 33,float 34,float 35,float 36,int32 37,float 38,float 39,int32 40,float 41,float 42,float 43,float 44,float 45,float 46,float 47,empty 48,empty 49,empty 50,float 51,string2 52,float 53,float 54,float 55,float 56,float 57,float 58,float 59,float 60,float 61,float 62,float 63,int32 64,int32 65,int32 66,int8 67,int8 68,int8 69,int8 70,int32 71,empty 72,int32 73,int32 74,int8 75,int8 76,int8 77,int8 78,string2 79,int32 80,int32 81'
        
        # Convert raw_data to proper format and replace chr_id references
        raw_data = digimon.model_setting_data['raw_data'].copy()
        header_types = header.split(',')
        parts = []
        
        # Get the template chr_id from raw_data[0] to know what to replace
        template_chr_id = raw_data[0].strip('"') if raw_data[0] else ""
        new_chr_id = digimon.chr_id
        
        # Update model_id and motion_id from the digimon object if they're set
        if hasattr(digimon, 'model_id') and digimon.model_id:
            if len(raw_data) > 2:
                raw_data[2] = f'"{digimon.model_id}"'
        if hasattr(digimon, 'motion_id') and digimon.motion_id:
            if len(raw_data) > 3:
                raw_data[3] = f'"{digimon.motion_id}"'
        
        for i, value in enumerate(raw_data):
            col_type = header_types[i] if i < len(header_types) else ''
            
            if 'string' in col_type:
                # String columns: quote non-empty values, use "" for empty
                if value and value != '""':
                    # Remove existing quotes if present
                    clean_value = value.strip('"') if isinstance(value, str) else str(value)
                    
                    # Replace template chr_id with new chr_id in ALL string columns
                    if template_chr_id and template_chr_id in clean_value:
                        clean_value = clean_value.replace(template_chr_id, new_chr_id)
                    
                    escaped_value = self._escape_csv_value(clean_value)
                    parts.append(f'"{escaped_value}"')
                else:
                    parts.append('""')
            elif 'empty' in col_type:
                # Empty columns: just blank
                parts.append('')
            else:
                # Numeric columns: no quotes
                parts.append(str(value) if value else '0')
        
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(header + '\n')
            f.write(','.join(parts) + '\n')
    
    def _write_lod_ap_csv(self, filepath: Path, digimon: DigimonData):
        """Write lod.ap.csv"""
        header = 'string2 0,float 1,float 2,float 3,float 4,float 5,float 6,float 7,float 8,float 9,float 10'
        parts = [
            f'"{self._escape_csv_value(digimon.chr_id)}"',
            str(digimon.lod_data.get('lod_distance_1', 20)),
            str(digimon.lod_data.get('lod_distance_2', 65)),
            str(digimon.lod_data.get('lod_distance_3', 500)),
            '0', '0', '0', '0', '0', '0', '0'
        ]
        
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(header + '\n')
            f.write(','.join(parts) + '\n')
    
    def _write_lod_model_ap_csv(self, filepath: Path, digimon: DigimonData):
        """Write lod_model.ap.csv"""
        header = 'string2 0,string2 1,string2 2,string2 3,string2 4,string2 5,string2 6,string2 7,string2 8,string2 9,string2 10'
        escaped_chr_id = self._escape_csv_value(digimon.chr_id)
        parts = [
            f'"{escaped_chr_id}"',
            '""',  # empty string
            f'"{escaped_chr_id}_LOD_2"',  # LOD model name
            '""', '""', '""', '""', '""', '""', '""', '""'  # 8 empty strings
        ]
        
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(header + '\n')
            f.write(','.join(parts) + '\n')
    
    def _write_anim_setting_ap_csv(self, filepath: Path, chr_id: str, animation_ref: str):
        """Write same_animation_data.ap.csv"""
        header = 'string2 0,string2 1'
        parts = [f'"{self._escape_csv_value(chr_id)}"', f'"{self._escape_csv_value(animation_ref)}"']
        
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(header + '\n')
            f.write(','.join(parts) + '\n')
    
    def _write_evolution_ap_csv(self, filepath: Path, digimon: DigimonData):
        """Write evolution_to.ap.csv
        
        This file contains ALL evolution relationships:
        - Evolutions FROM this Digimon (what it evolves into)
        - Pre-evolutions TO this Digimon (what evolves into it)
        
        Format: [evo_id], [source_id], "", [target_id], "", [type], -1, -1, -1, -1, -1
        - type 0 = Normal evolution
        - type 2 = Mode Change
        
        Note: Max 6 evolutions per source Digimon or game will crash!
        """
        header = 'int32 0,int32 1,empty 2,int32 3,empty 4,int32 5,int32 6,int32 7,int32 8,int32 9,int32 10'
        
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(header + '\n')
            
            # Use user's suggested formula: (digimon.id * 100) + counter
            # For ID 640: 64000, 64001, 64002, etc.
            counter = 0
            
            # Track seen entries to avoid duplicates
            seen_entries = set()  # (source_id, target_id)
            
            # 1. Write evolutions FROM this Digimon (what it evolves into)
            for evo in digimon.evolution_paths:
                to_id = evo.get('to_id', 0)
                
                # Skip if to_id is 0 or already written
                entry_key = (digimon.id, to_id)
                if to_id == 0 or entry_key in seen_entries:
                    continue
                seen_entries.add(entry_key)
                
                # Get evolution type/mode (default to 0 for normal evolution)
                evo_type = evo.get('evolution_type', 0)
                
                # Calculate evolution ID
                evo_id = (digimon.id * 100) + counter
                counter += 1
                
                parts = [
                    str(evo_id),
                    str(digimon.id),  # Source: this Digimon
                    '',  # empty column
                    str(to_id),  # Target: what it evolves into
                    '',  # empty column
                    str(evo_type),  # Evolution type: 0=Normal, 2=Mode Change
                    '-1', '-1', '-1', '-1', '-1'
                ]
                f.write(','.join(parts) + '\n')
            
            # 2. Write pre-evolutions TO this Digimon (what evolves into it)
            # These are stored as: [pre-evo ID] evolves TO [this Digimon's ID]
            for deevo in digimon.deevolution_sources:
                from_id = deevo.get('from_id', 0)
                
                # Skip if from_id is 0 or already written
                entry_key = (from_id, digimon.id)
                if from_id == 0 or entry_key in seen_entries:
                    continue
                seen_entries.add(entry_key)
                
                # Get evolution type (default to 0 for normal evolution)
                evo_type = deevo.get('evolution_type', 0)
                
                # Calculate evolution ID using the PRE-evolution's ID as base
                evo_id = (from_id * 100) + 50 + counter  # Offset by 50 to avoid collision
                counter += 1
                
                parts = [
                    str(evo_id),
                    str(from_id),  # Source: the pre-evolution Digimon
                    '',  # empty column
                    str(digimon.id),  # Target: this Digimon (what it evolves into)
                    '',  # empty column
                    str(evo_type),  # Evolution type: 0=Normal, 2=Mode Change
                    '-1', '-1', '-1', '-1', '-1'
                ]
                f.write(','.join(parts) + '\n')
    
    def _write_char_name_ap_csv(self, filepath: Path, digimon: DigimonData):
        """Write char_name.ap.csv"""
        import csv
        
        header = 'string2 0,string 1'
        
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(header + '\n')
            # Use csv.writer to properly handle special characters
            writer = csv.writer(f, quoting=csv.QUOTE_ALL)
            writer.writerow([digimon.char_key, digimon.name])
    
    def _write_profile_ap_csv(self, filepath: Path, digimon: DigimonData):
        """Write digimon_profile.ap.csv"""
        import csv
        import textwrap
        
        header = 'string2 0,string 1'
        profile = digimon.profile_text if digimon.profile_text else f"A mysterious Digimon known as {digimon.name}."
        
        # If profile doesn't already have line breaks, add them at reasonable intervals
        # Check if profile has newlines already
        if '\n' not in profile and len(profile) > 50:
            # Wrap text to ~50 characters per line to match base game format (max 55-58)
            profile = '\n'.join(textwrap.wrap(profile, width=50, break_long_words=False, break_on_hyphens=False))
        
        # Use correct profile key format: digimon_{id}_profile
        profile_key = f"digimon_{digimon.id}_profile"
        
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(header + '\n')
            # Use csv.writer to properly handle multi-line text
            writer = csv.writer(f, quoting=csv.QUOTE_ALL)
            writer.writerow([profile_key, profile])
    
    def _write_model_outline_ap_csv(self, filepath: Path, digimon: DigimonData):
        """Write model_outline_battle.ap.csv"""
        header = 'string2 0,float 1,float 2'
        parts = [
            f'"{self._escape_csv_value(digimon.chr_id)}"',
            '-0.003',  # Default outline thickness values
            '-0.003'
        ]
        
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(header + '\n')
            f.write(','.join(parts) + '\n')
    
    def _write_evolution_condition_ap_csv(self, filepath: Path, digimon: DigimonData):
        """Write evolution_condition.ap.csv - requirements to evolve INTO this new Digimon"""
        header = 'int32 0,empty 1,int32 2,int32 3,int32 4,int32 5,int32 6,int32 7,int32 8,int32 9,int32 10,int32 11,int32 12,int32 13,int32 14,int32 15,int32 16,int32 17,empty 18,int32 19,int32 20,int32 21,int32 22,empty 23,int32 24,empty 25,int32 26,int32 27,empty 28,int32 29'
        
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(header + '\n')
            
            # For the NEW Digimon we're creating, we need to define what requirements
            # are needed for OTHER Digimon to evolve INTO this new one
            # Column 0 is THIS new Digimon's ID (what requirements to become it)
            
            # Use the evolution_requirements from the wizard
            condition = {}
            if digimon.evolution_conditions and len(digimon.evolution_conditions) > 0:
                condition = digimon.evolution_conditions[0]
            
            parts = [
                str(digimon.id),  # 0: THIS Digimon's ID (requirements to evolve INTO it)
                '',  # 1: empty
                str(condition.get('mode', 1)),  # 2: condition type/mode (default 1 = no requirements)
                str(condition.get('tamerLevel', 0)),  # 3: tamer level
                str(condition.get('HP', 0)),  # 4: HP requirement
                str(condition.get('SP', 0)),  # 5: SP requirement
                str(condition.get('ATK', 0)),  # 6: ATK requirement
                str(condition.get('DEF', 0)),  # 7: DEF requirement
                str(condition.get('INT', 0)),  # 8: INT requirement
                str(condition.get('SPI', 0)),  # 9: SPI requirement
                str(condition.get('SPD', 0)),  # 10: SPD requirement
                str(condition.get('unknown1', 0)),  # 11
                str(condition.get('unknown2', 0)),  # 12
                str(condition.get('skillCountValor', 0)),  # 13
                str(condition.get('skillCountPhilantropy', 0)),  # 14
                str(condition.get('skillCountAmicable', 0)),  # 15
                str(condition.get('skillCountWisdom', 0)),  # 16
                '0', # 17
                '',  # 18: empty
                '0', '0', '0',  # 19-21
                str(condition.get('needsItem', 0)),  # 22
                '',  # 23: empty
                str(condition.get('jogressDbIdA', 0)),  # 24
                '',  # 25: empty
                str(condition.get('jogressPersonalityA', 0)),  # 26
                str(condition.get('jogressDbIdB', 0)),  # 27
                '',  # 28: empty
                str(condition.get('jogressPersonalityB', 0))  # 29
            ]
            f.write(','.join(parts) + '\n')
    
    def _write_belong_ap_csv(self, filepath: Path, digimon: DigimonData):
        """Write belong.ap.csv (tribe/species classification)"""
        import csv
        
        header = 'string2 0,string 1'
        
        # Use the tribe_name if available, otherwise fallback to "Unknown"
        tribe_name = "Unknown"
        if hasattr(digimon, 'tribe_name') and digimon.tribe_name:
            tribe_name = digimon.tribe_name
        
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(header + '\n')
            # Use csv.writer to properly handle any special characters
            writer = csv.writer(f, quoting=csv.QUOTE_ALL)
            writer.writerow([str(digimon.id), tribe_name])





class TemplateSelectionPage(QWizardPage):
    """Step 1: Select template Digimon"""
    
    def __init__(self, wizard):
        super().__init__()
        self.wizard = wizard
        self.setTitle("📋 Step 1: Select Template")
        self.setSubTitle("Choose an existing Digimon to use as a template. The new Digimon will copy all properties from the template.")
        
        layout = QVBoxLayout()
        
        # Instructions
        info_label = QLabel(
            "Select a Digimon to use as a template.\n"
            "All stats, skills, traits, and properties will be copied from the template.\n"
            "You can customize them in the following steps."
        )
        info_label.setWordWrap(True)
        info_label.setStyleSheet("color: #666; padding: 10px; background-color: #f8f9fa; border-radius: 6px;")
        layout.addWidget(info_label)
        
        # Template selection
        layout.addWidget(QLabel("\n🔍 Template Digimon:"))
        self.template_combo = QComboBox()
        
        # Populate with all Digimon
        chr_ids = wizard.loader.get_all_digimon_chr_ids()
        
        # Sort by numeric part
        def sort_key(chr_id):
            try:
                numeric_part = ''
                for char in chr_id.replace('chr', ''):
                    if char.isdigit():
                        numeric_part += char
                    else:
                        break
                return int(numeric_part) if numeric_part else 999999
            except:
                return 999999
        
        # Deduplicate chr_ids (in case same Digimon appears in base game and DLC)
        chr_ids_unique = list(dict.fromkeys(chr_ids))  # Preserves order, removes duplicates
        chr_ids_sorted = sorted(chr_ids_unique, key=sort_key)
        
        for chr_id in chr_ids_sorted:
            name = wizard.loader._get_digimon_name_by_chr_id(chr_id)
            
            # Skip entries where name lookup failed (returns char_key or chr_id)
            if not name or name.startswith("char_") or name == chr_id:
                continue  # Skip - no proper name found
            
            self.template_combo.addItem(f"{name} ({chr_id})", chr_id)
        
        # Default to chr805 (Darkshadow)
        default_index = self.template_combo.findData("chr805")
        if default_index >= 0:
            self.template_combo.setCurrentIndex(default_index)
        
        self.template_combo.currentIndexChanged.connect(self.on_template_changed)
        layout.addWidget(self.template_combo)
        
        # Preview info
        self.preview_label = QLabel("")
        self.preview_label.setWordWrap(True)
        self.preview_label.setStyleSheet("padding: 10px; background-color: #e7f5ff; border-radius: 6px; margin-top: 10px;")
        layout.addWidget(self.preview_label)
        
        layout.addStretch()
        self.setLayout(layout)
        
        # Load initial preview
        self.on_template_changed()
    
    def on_template_changed(self):
        """Update preview when template changes"""
        chr_id = self.template_combo.currentData()
        if chr_id:
            digimon = self.wizard.loader.get_digimon_by_chr_id(chr_id)
            if digimon:
                # Ensure all model data is loaded
                self.wizard.loader._load_model_data(digimon)
                # Ensure all extended data is loaded
                self.wizard.loader._load_extended_character_data(digimon)
                
                self.wizard.template_digimon = digimon
                self.preview_label.setText(
                    f"📊 Template Preview:\n"
                    f"Name: {digimon.name}\n"
                    f"ID: {digimon.id} | Stage: {self.wizard.loader.get_generation_name(digimon.stage_id)}\n"
                    f"HP: {digimon.base_hp} | ATK: {digimon.base_atk} | DEF: {digimon.base_def}\n"
                    f"Signature Skills: {len([s for s in digimon.signature_skills if s.get('id', 0) > 0])}\n"
                    f"Model Data: {'✅' if digimon.model_setting_data else '❌'}\n"
                    f"LOD Data: {'✅' if digimon.lod_data else '❌'}\n"
                    f"Field Animation: {'✅' if digimon.field_move_animation_data else '❌'}"
                )
    
    def validatePage(self):
        """Validate that a template is selected"""
        if not self.wizard.template_digimon:
            QMessageBox.warning(self, "Error", "Please select a template Digimon")
            return False
        return True


class BasicInfoPage(QWizardPage):
    """Step 2: Basic Information"""
    
    def __init__(self, wizard):
        super().__init__()
        self.wizard = wizard
        self.setTitle("📝 Step 2: Basic Information")
        self.setSubTitle("Enter the basic information for your new Digimon")
        
        layout = QFormLayout()
        layout.setSpacing(15)
        
        # ID
        self.id_spin = QSpinBox()
        self.id_spin.setRange(1, 99999)
        # Find next available ID - check both base game and DLC
        existing_ids = wizard.loader.get_all_digimon_ids()
        # Also check DLC IDs
        try:
            from data_loader import DLCExporter
            dlc_exporter = DLCExporter(wizard.loader)
            dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
            dlc_status_file = wizard.loader._resolve_prefixed_file(dlc_data / "digimon_status_dlc17.mbe" / "000_digimon_status_data.csv")
            if dlc_status_file.exists():
                dlc_rows = wizard.loader.load_csv(dlc_status_file)
                for row in dlc_rows[1:]:  # Skip header
                    if len(row) > 0 and row[0]:
                        try:
                            existing_ids.append(int(row[0]))
                        except ValueError:
                            continue
        except Exception:
            pass  # If DLC check fails, just use base game IDs
        next_id = max(existing_ids) + 1 if existing_ids else 1000
        self.id_spin.setValue(next_id)
        layout.addRow("🆔 Digimon ID:", self.id_spin)
        
        # Name
        self.name_edit = QLineEdit()
        self.name_edit.setPlaceholderText("Enter Digimon name")
        layout.addRow("📛 Name:", self.name_edit)
        
        # Character Key
        self.char_key_edit = QLineEdit()
        self.char_key_edit.setPlaceholderText("e.g., char_NEW_DIGIMON")
        layout.addRow("🔑 Character Key:", self.char_key_edit)
        
        # Chr ID
        self.chr_id_edit = QLineEdit()
        self.chr_id_edit.setPlaceholderText("e.g., chr1000")
        layout.addRow("🔢 Chr ID:", self.chr_id_edit)
        
        # Auto-generate based on ID
        self.id_spin.valueChanged.connect(self.auto_generate_ids)
        self.auto_generate_ids()
        
        self.setLayout(layout)
    
    def auto_generate_ids(self):
        """Auto-generate char_key and chr_id based on ID"""
        digimon_id = self.id_spin.value()
        if not self.char_key_edit.text() or self.char_key_edit.text().startswith("char_"):
            self.char_key_edit.setText(f"char_DIGIMON_{digimon_id}")
        if not self.chr_id_edit.text() or self.chr_id_edit.text().startswith("chr"):
            self.chr_id_edit.setText(f"chr{digimon_id}")
    
    def validatePage(self):
        """Validate basic info"""
        if not self.name_edit.text().strip():
            QMessageBox.warning(self, "Error", "Please enter a name for the Digimon")
            return False
        if not self.char_key_edit.text().strip():
            QMessageBox.warning(self, "Error", "Please enter a character key")
            return False
        if not self.chr_id_edit.text().strip():
            QMessageBox.warning(self, "Error", "Please enter a Chr ID")
            return False
        return True


class ClassificationPage(QWizardPage):
    """Step 3: Classification"""
    
    def __init__(self, wizard):
        super().__init__()
        self.wizard = wizard
        self.setTitle("🏷️ Step 3: Classification")
        self.setSubTitle("Set the Digimon's stage, type/tribe, personality, and growth pattern")
        
        layout = QFormLayout()
        layout.setSpacing(15)
        
        # Stage
        self.stage_combo = QComboBox()
        for i in range(15):  # Stages 0-14 (based on generation_name.mbe CSV)
            stage_name = wizard.loader.get_generation_name(i)
            clean_name = wizard.loader.clean_ui_text(stage_name)
            self.stage_combo.addItem(clean_name, i)
        self.stage_combo.setToolTip("Digimon stage/level (Baby, In-Training, Rookie, Champion, Ultimate, Mega, etc.)")
        layout.addRow("⭐ Stage:", self.stage_combo)
        
        # Type (for game mechanics)
        self.type_combo = QComboBox()
        for i in range(20):
            type_name = wizard.loader.get_type_name(i)
            if not type_name or type_name == str(i):
                type_name = f"Type {i}"
            else:
                type_name = wizard.loader.clean_ui_text(type_name)
            self.type_combo.addItem(type_name, i)
        self.type_combo.setToolTip("Digimon type (for game mechanics like weaknesses)")
        layout.addRow("🔷 Type:", self.type_combo)
        
        # Tribe/Species (Belong) - Load unique tribes from belong.mbe
        self.tribe_combo = QComboBox()
        unique_tribes = self._load_unique_tribes(wizard)
        for tribe_name in sorted(unique_tribes):
            self.tribe_combo.addItem(tribe_name)
        self.tribe_combo.setToolTip("Digimon tribe/species classification (shown in Digimon profile)")
        layout.addRow("🦁 Tribe/Species (Belong):", self.tribe_combo)
        
        # Growth Pattern
        self.growth_combo = QComboBox()
        for i in range(1, 19):  # Growth patterns 1-18
            self.growth_combo.addItem(f"Growth Pattern {i}", i)
        self.growth_combo.setToolTip("Growth curve pattern (1-18) - determines stat growth per level")
        layout.addRow("📈 Growth Pattern:", self.growth_combo)
        
        # Personality
        self.personality_combo = QComboBox()
        for i in range(17):
            personality_name = wizard.loader.get_personality_name(i)
            clean_name = wizard.loader.clean_ui_text(personality_name)
            self.personality_combo.addItem(clean_name, i)
        self.personality_combo.setToolTip("Digimon personality type (affects skill learning)")
        layout.addRow("🎭 Personality:", self.personality_combo)
        
        # Set defaults from template
        if wizard.template_digimon:
            stage_idx = self.stage_combo.findData(wizard.template_digimon.stage_id)
            if stage_idx >= 0:
                self.stage_combo.setCurrentIndex(stage_idx)
            type_idx = self.type_combo.findData(wizard.template_digimon.type_id)
            if type_idx >= 0:
                self.type_combo.setCurrentIndex(type_idx)
            personality_idx = self.personality_combo.findData(wizard.template_digimon.personality_id)
            if personality_idx >= 0:
                self.personality_combo.setCurrentIndex(personality_idx)
            growth_idx = self.growth_combo.findData(wizard.template_digimon.growth_pattern_id)
            if growth_idx >= 0:
                self.growth_combo.setCurrentIndex(growth_idx)
            
            # Load template's tribe from belong.mbe if available
            if hasattr(wizard.template_digimon, 'tribe_name') and wizard.template_digimon.tribe_name:
                tribe_idx = self.tribe_combo.findText(wizard.template_digimon.tribe_name)
                if tribe_idx >= 0:
                    self.tribe_combo.setCurrentIndex(tribe_idx)
        
        self.setLayout(layout)
    
    def _load_unique_tribes(self, wizard):
        """Load unique tribe names from belong.mbe"""
        unique_tribes = set()
        try:
            # Try to load from backup folder first (most complete)
            belong_file = wizard.loader._resolve_prefixed_file(Path("backup") / "text" / "belong.mbe" / "000_Sheet1.csv")
            if not belong_file.exists():
                # Try loader's text path
                belong_file = wizard.loader._resolve_prefixed_file(wizard.loader.text_path / "belong.mbe" / "000_Sheet1.csv")
            
            if belong_file.exists():
                rows = wizard.loader.load_csv(belong_file)
                for row in rows[1:]:  # Skip header
                    if len(row) >= 2:
                        tribe_name = row[1].strip('"')
                        if tribe_name:
                            unique_tribes.add(tribe_name)
        except Exception as e:
            print(f"Error loading tribes: {e}")
            # Fallback to common tribes
            unique_tribes = {"None", "Mammal", "Beast Man", "Dragon", "Machine", "Beast"}
        
        return unique_tribes
    
    def initializePage(self):
        """Initialize page with template data when shown"""
        if self.wizard.template_digimon:
            stage_idx = self.stage_combo.findData(self.wizard.template_digimon.stage_id)
            if stage_idx >= 0:
                self.stage_combo.setCurrentIndex(stage_idx)
            type_idx = self.type_combo.findData(self.wizard.template_digimon.type_id)
            if type_idx >= 0:
                self.type_combo.setCurrentIndex(type_idx)
            personality_idx = self.personality_combo.findData(self.wizard.template_digimon.personality_id)
            if personality_idx >= 0:
                self.personality_combo.setCurrentIndex(personality_idx)
            growth_idx = self.growth_combo.findData(self.wizard.template_digimon.growth_pattern_id)
            if growth_idx >= 0:
                self.growth_combo.setCurrentIndex(growth_idx)
            
            # Load template's tribe from belong.mbe if available
            if hasattr(self.wizard.template_digimon, 'tribe_name') and self.wizard.template_digimon.tribe_name:
                tribe_idx = self.tribe_combo.findText(self.wizard.template_digimon.tribe_name)
                if tribe_idx >= 0:
                    self.tribe_combo.setCurrentIndex(tribe_idx)


class ProfilePage(QWizardPage):
    """Step 4: Profile / Description"""
    
    def __init__(self, wizard):
        super().__init__()
        self.wizard = wizard
        self.setTitle("📖 Step 4: Profile / Description")
        self.setSubTitle("Enter the Digimon's profile text (will be wrapped automatically for display)")
        
        layout = QVBoxLayout()
        
        # Info label
        info = QLabel(
            "The profile text will be automatically wrapped to 50 characters per line for proper in-game display.\n"
            "You can enter it as one paragraph or pre-format it with line breaks."
        )
        info.setWordWrap(True)
        info.setStyleSheet("color: #666; padding: 8px; background: #f0f0f0; border-radius: 4px; margin-bottom: 10px;")
        layout.addWidget(info)
        
        # Profile text editor
        layout.addWidget(QLabel("Profile Text:"))
        self.profile_edit = QTextEdit()
        self.profile_edit.setPlaceholderText("Enter Digimon profile/description here...")
        self.profile_edit.setMinimumHeight(200)
        layout.addWidget(self.profile_edit)
        
        # Character counter
        self.char_count_label = QLabel("Characters: 0")
        self.char_count_label.setStyleSheet("color: #666; font-size: 9pt;")
        self.profile_edit.textChanged.connect(self.update_char_count)
        layout.addWidget(self.char_count_label)
        
        layout.addStretch()
        self.setLayout(layout)
    
    def update_char_count(self):
        """Update character counter"""
        text = self.profile_edit.toPlainText()
        char_count = len(text)
        self.char_count_label.setText(f"Characters: {char_count}")
    
    def initializePage(self):
        """Initialize with template data"""
        if self.wizard.template_digimon and self.wizard.template_digimon.profile_text:
            self.profile_edit.setPlainText(self.wizard.template_digimon.profile_text)


class StatsPage(QWizardPage):
    """Step 5: Base Stats"""
    
    def __init__(self, wizard):
        super().__init__()
        self.wizard = wizard
        self.setTitle("📊 Step 5: Base Stats")
        self.setSubTitle("Set the base stats for your Digimon")
        
        layout = QFormLayout()
        layout.setSpacing(15)
        
        self.hp_spin = QSpinBox()
        self.hp_spin.setRange(1, 9999)
        layout.addRow("❤️ HP:", self.hp_spin)
        
        self.sp_spin = QSpinBox()
        self.sp_spin.setRange(1, 9999)
        layout.addRow("💙 SP:", self.sp_spin)
        
        self.atk_spin = QSpinBox()
        self.atk_spin.setRange(1, 9999)
        layout.addRow("⚔️ ATK:", self.atk_spin)
        
        self.def_spin = QSpinBox()
        self.def_spin.setRange(1, 9999)
        layout.addRow("🛡️ DEF:", self.def_spin)
        
        self.int_spin = QSpinBox()
        self.int_spin.setRange(1, 9999)
        layout.addRow("🧠 INT:", self.int_spin)
        
        self.spi_spin = QSpinBox()
        self.spi_spin.setRange(1, 9999)
        layout.addRow("✨ SPI:", self.spi_spin)
        
        self.spd_spin = QSpinBox()
        self.spd_spin.setRange(1, 9999)
        layout.addRow("⚡ SPD:", self.spd_spin)
        
        # Set defaults from template
        if wizard.template_digimon:
            self.hp_spin.setValue(wizard.template_digimon.base_hp)
            self.sp_spin.setValue(wizard.template_digimon.base_sp)
            self.atk_spin.setValue(wizard.template_digimon.base_atk)
            self.def_spin.setValue(wizard.template_digimon.base_def)
            self.int_spin.setValue(wizard.template_digimon.base_int)
            self.spi_spin.setValue(wizard.template_digimon.base_spi)
            self.spd_spin.setValue(wizard.template_digimon.base_spd)
        
        self.setLayout(layout)
    
    def initializePage(self):
        """Initialize page with template data when shown"""
        if self.wizard.template_digimon:
            self.hp_spin.setValue(self.wizard.template_digimon.base_hp)
            self.sp_spin.setValue(self.wizard.template_digimon.base_sp)
            self.atk_spin.setValue(self.wizard.template_digimon.base_atk)
            self.def_spin.setValue(self.wizard.template_digimon.base_def)
            self.int_spin.setValue(self.wizard.template_digimon.base_int)
            self.spi_spin.setValue(self.wizard.template_digimon.base_spi)
            self.spd_spin.setValue(self.wizard.template_digimon.base_spd)


class ResistancesPage(QWizardPage):
    """Step 5: Elemental Resistances"""
    
    def __init__(self, wizard):
        super().__init__()
        self.wizard = wizard
        self.setTitle("🛡️ Step 6: Elemental Resistances")
        self.setSubTitle("Set elemental resistances (0=Normal, 1=Weak, 2=Very Weak, 3=Resist, 4=Immune)")
        
        layout = QGridLayout()
        
        self.resist_widgets = {}
        # IMPORTANT: Order must match CSV columns 7-17 (resNull, resFire, resWater, resGrass, resIce, resElec, resGround, resSteel, resWind, resLight, resDark)
        resistances = [
            ("null", "Null"),
            ("fire", "Fire"),
            ("water", "Water"),
            ("grass", "Plant"),
            ("ice", "Ice"),
            ("elec", "Electric"),
            ("ground", "Earth"),
            ("steel", "Steel"),
            ("wind", "Wind"),
            ("light", "Light"),
            ("dark", "Dark")
        ]
        
        resistance_labels = {
            0: "Normal (1.0x)",
            1: "Weak (1.5x)",
            2: "Very Weak (2.0x)",
            3: "Resist (0.5x)",
            4: "Immune (0.0x)"
        }
        
        for i, (resist_key, resist_name) in enumerate(resistances):
            row = i // 2
            col = (i % 2) * 3
            layout.addWidget(QLabel(f"{resist_name}:"), row, col)
            
            spin = QSpinBox()
            spin.setRange(0, 4)
            spin.setObjectName(f"resist_{resist_key}")
            spin.setToolTip(
                f"Set {resist_name} resistance:\n"
                "0 = Weak (150% damage - 1.5x)\n"
                "1 = Normal (100% damage - 1.0x)\n"
                "2 = Resist (75% damage - 0.75x)\n"
                "3 = Null (50% damage - 0.5x)\n"
                "4 = Absorb (heals instead of damages)"
            )
            self.resist_widgets[resist_key] = spin
            layout.addWidget(spin, row, col + 1)
            
            value_label = QLabel(resistance_labels[0])
            value_label.setObjectName(f"resist_label_{resist_key}")
            value_label.setStyleSheet("color: #666; font-size: 9pt;")
            layout.addWidget(value_label, row, col + 2)
            
            spin.valueChanged.connect(lambda v, label=value_label: label.setText(resistance_labels.get(v, "Unknown")))
        
        # Set defaults from template
        if wizard.template_digimon:
            self.resist_widgets["null"].setValue(wizard.template_digimon.res_null)
            self.resist_widgets["fire"].setValue(wizard.template_digimon.res_fire)
            self.resist_widgets["water"].setValue(wizard.template_digimon.res_water)
            self.resist_widgets["ice"].setValue(wizard.template_digimon.res_ice)
            self.resist_widgets["grass"].setValue(wizard.template_digimon.res_grass)
            self.resist_widgets["wind"].setValue(wizard.template_digimon.res_wind)
            self.resist_widgets["elec"].setValue(wizard.template_digimon.res_elec)
            self.resist_widgets["ground"].setValue(wizard.template_digimon.res_ground)
            self.resist_widgets["steel"].setValue(wizard.template_digimon.res_steel)
            self.resist_widgets["light"].setValue(wizard.template_digimon.res_light)
            self.resist_widgets["dark"].setValue(wizard.template_digimon.res_dark)
        
        self.setLayout(layout)
    
    def initializePage(self):
        """Initialize page with template data when shown"""
        if self.wizard.template_digimon:
            self.resist_widgets["null"].setValue(self.wizard.template_digimon.res_null)
            self.resist_widgets["fire"].setValue(self.wizard.template_digimon.res_fire)
            self.resist_widgets["water"].setValue(self.wizard.template_digimon.res_water)
            self.resist_widgets["ice"].setValue(self.wizard.template_digimon.res_ice)
            self.resist_widgets["grass"].setValue(self.wizard.template_digimon.res_grass)
            self.resist_widgets["wind"].setValue(self.wizard.template_digimon.res_wind)
            self.resist_widgets["elec"].setValue(self.wizard.template_digimon.res_elec)
            self.resist_widgets["ground"].setValue(self.wizard.template_digimon.res_ground)
            self.resist_widgets["steel"].setValue(self.wizard.template_digimon.res_steel)
            self.resist_widgets["light"].setValue(self.wizard.template_digimon.res_light)
            self.resist_widgets["dark"].setValue(self.wizard.template_digimon.res_dark)


class SkillsPage(QWizardPage):
    """Step 6: Skills"""
    
    def __init__(self, wizard):
        super().__init__()
        self.wizard = wizard
        self.setTitle("⚔️ Step 7: Skills")
        self.setSubTitle("Configure signature and generic skills for your Digimon")
        
        layout = QVBoxLayout()
        
        # Instructions
        info_label = QLabel(
            "Configure the Digimon's skills.\n"
            "Signature skills are unique moves, while generic skills are common abilities.\n"
            "Click 'Add Skill' to select from a list, or enter skill ID manually."
        )
        info_label.setWordWrap(True)
        info_label.setStyleSheet("color: #666; padding: 10px; background-color: #f8f9fa; border-radius: 6px;")
        layout.addWidget(info_label)
        
        # Signature Skills
        sig_group = QGroupBox("Signature Skills (up to 12)")
        sig_layout = QVBoxLayout()
        
        # Add skill button
        sig_add_btn = QPushButton("➕ Add Signature Skill")
        sig_add_btn.clicked.connect(lambda: self.add_skill("signature"))
        sig_layout.addWidget(sig_add_btn)
        
        self.signature_skills_editor = SkillEditor("signature", wizard.loader)
        sig_layout.addWidget(self.signature_skills_editor)
        sig_group.setLayout(sig_layout)
        layout.addWidget(sig_group)
        
        # Generic Skills
        gen_group = QGroupBox("Generic Skills (up to 4)")
        gen_layout = QVBoxLayout()
        
        # Add skill button
        gen_add_btn = QPushButton("➕ Add Generic Skill")
        gen_add_btn.clicked.connect(lambda: self.add_skill("generic"))
        gen_layout.addWidget(gen_add_btn)
        
        self.generic_skills_editor = SkillEditor("generic", wizard.loader)
        gen_layout.addWidget(self.generic_skills_editor)
        gen_group.setLayout(gen_layout)
        layout.addWidget(gen_group)
        
        layout.addStretch()
        self.setLayout(layout)
    
    def add_skill(self, skill_type: str):
        """Show dialog to select a skill from list"""
        dialog = QDialog(self)
        dialog.setWindowTitle(f"Select {skill_type.title()} Skill")
        dialog.setMinimumSize(500, 400)
        
        layout = QVBoxLayout(dialog)
        
        # Search box
        search_label = QLabel("Search:")
        search_edit = QLineEdit()
        search_edit.setPlaceholderText("Type to search skills...")
        layout.addWidget(search_label)
        layout.addWidget(search_edit)
        
        # Skill list
        skill_list = QListWidget()
        layout.addWidget(QLabel("Available Skills:"))
        layout.addWidget(skill_list)
        
        # Populate skill list
        self.populate_skill_list(skill_list)
        
        # Filter on search
        def filter_skills(text):
            for i in range(skill_list.count()):
                item = skill_list.item(i)
                item.setHidden(text.lower() not in item.text().lower())
        search_edit.textChanged.connect(filter_skills)
        
        # Buttons
        buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel)
        buttons.accepted.connect(dialog.accept)
        buttons.rejected.connect(dialog.reject)
        layout.addWidget(buttons)
        
        if dialog.exec() == QDialog.DialogCode.Accepted:
            selected_item = skill_list.currentItem()
            if selected_item:
                skill_id = selected_item.data(Qt.ItemDataRole.UserRole)
                self.add_skill_to_editor(skill_type, skill_id)
    
    def populate_skill_list(self, skill_list: QListWidget):
        """Populate skill list with all available skills"""
        try:
            skills_file = self.wizard.loader.data_path / "battle_skill.mbe" / "000_battle_skill_list.csv"
            skills_file = self.wizard.loader._resolve_prefixed_file(skills_file)
            if not skills_file.exists():
                return
            
            rows = self.wizard.loader.load_csv(skills_file)
            
            for row in rows[1:]:
                if not row or len(row) < 1:
                    continue
                
                try:
                    skill_id = int(row[0])
                    skill_name = self.wizard.loader.get_skill_name(skill_id)
                    if skill_name and skill_name != f"skill_{skill_id}":
                        skill_name = self.wizard.loader.clean_ui_text(skill_name)
                        item = QListWidgetItem(f"ID {skill_id}: {skill_name}")
                        item.setData(Qt.ItemDataRole.UserRole, skill_id)
                        skill_list.addItem(item)
                except (ValueError, IndexError, TypeError):
                    continue
        except Exception as e:
            print(f"Error loading skills: {e}")
    
    def add_skill_to_editor(self, skill_type: str, skill_id: int):
        """Add a skill to the appropriate editor"""
        editor = self.signature_skills_editor if skill_type == "signature" else self.generic_skills_editor
        
        # Find first empty slot
        for i, skill_widget in enumerate(editor.skill_widgets):
            skill_id_widget = skill_widget.findChild(QSpinBox, f"skill_id_{i}")
            if skill_id_widget.value() == 0:
                skill_id_widget.setValue(skill_id)
                editor.update_skill_name(i)
                break
    
    def initializePage(self):
        """Load skills from template when page is shown"""
        if self.wizard.template_digimon:
            self.signature_skills_editor.load_skills(self.wizard.template_digimon.signature_skills)
            self.generic_skills_editor.load_skills(self.wizard.template_digimon.generic_skills)
            self.signature_skills_editor.update_all_skill_names()
            self.generic_skills_editor.update_all_skill_names()


class EvolutionPage(QWizardPage):
    """Step 7: Evolution"""
    
    def __init__(self, wizard):
        super().__init__()
        self.wizard = wizard
        self.setTitle("🔄 Step 8: Evolution")
        self.setSubTitle("Configure evolution requirements and paths")
        
        layout = QVBoxLayout()
        
        # Instructions
        info_label = QLabel(
            "First, set the requirements needed to evolve INTO this new Digimon.\n"
            "Then configure evolution paths (what this Digimon can evolve into) and pre-evolutions."
        )
        info_label.setWordWrap(True)
        info_label.setStyleSheet("color: #666; padding: 10px; background-color: #f8f9fa; border-radius: 6px;")
        layout.addWidget(info_label)
        
        # Evolution Requirements section (for obtaining THIS Digimon)
        req_group = QGroupBox("⭐ Requirements to Obtain This Digimon")
        req_group.setStyleSheet("QGroupBox { font-weight: bold; }")
        req_layout = QVBoxLayout()
        
        req_info = QLabel(
            "These are the requirements that other Digimon must meet to evolve INTO this new Digimon.\n"
            "Leave values at 0 for no requirement."
        )
        req_info.setWordWrap(True)
        req_info.setStyleSheet("color: #555; font-size: 10pt; font-weight: normal;")
        req_layout.addWidget(req_info)
        
        edit_req_btn = QPushButton("📝 Edit Requirements")
        edit_req_btn.setStyleSheet("padding: 8px; font-size: 11pt;")
        edit_req_btn.clicked.connect(self.edit_evolution_requirements)
        req_layout.addWidget(edit_req_btn)
        
        self.requirements_label = QLabel("Mode: No Requirements (default)")
        self.requirements_label.setStyleSheet("color: #666; padding: 5px; background: #f0f0f0; border-radius: 3px;")
        self.requirements_label.setWordWrap(True)
        req_layout.addWidget(self.requirements_label)
        
        req_group.setLayout(req_layout)
        layout.addWidget(req_group)
        
        # Store the evolution requirements (for THIS Digimon)
        self.evolution_requirements = {
            'mode': 1,  # Default: no requirements
            'tamerLevel': 0,
            'HP': 0, 'SP': 0, 'ATK': 0, 'DEF': 0, 'INT': 0, 'SPI': 0, 'SPD': 0,
            'skillCountValor': 0, 'skillCountPhilantropy': 0, 
            'skillCountAmicable': 0, 'skillCountWisdom': 0,
            'needsItem': 0,
            'jogressDbIdA': 0, 'jogressPersonalityA': 0,
            'jogressDbIdB': 0, 'jogressPersonalityB': 0
        }
        
        # Evolution paths section
        evo_group = QGroupBox("Evolution Paths (what this Digimon evolves into)")
        evo_layout = QVBoxLayout()
        
        evo_buttons = QHBoxLayout()
        add_evo_btn = QPushButton("➕ Add Evolution")
        add_evo_btn.clicked.connect(self.add_evolution)
        remove_evo_btn = QPushButton("➖ Remove Selected")
        remove_evo_btn.clicked.connect(self.remove_evolution)
        evo_buttons.addWidget(add_evo_btn)
        evo_buttons.addWidget(remove_evo_btn)
        evo_buttons.addStretch()
        evo_layout.addLayout(evo_buttons)
        
        self.evolution_list = QListWidget()
        self.evolution_list.setMaximumHeight(200)
        evo_layout.addWidget(self.evolution_list)
        evo_group.setLayout(evo_layout)
        layout.addWidget(evo_group)
        
        # Pre-evolution section
        deevo_group = QGroupBox("⬅️ Pre-Evolutions (Digimon that evolve INTO this one)")
        deevo_layout = QVBoxLayout()
        
        deevo_info = QLabel(
            "💡 Adding a pre-evolution creates an evolution entry where THAT Digimon evolves into THIS one.\n"
            "⚠️ Each Digimon can only have 6 evolution targets. If a Digimon is full, you cannot add it as a pre-evolution."
        )
        deevo_info.setStyleSheet("color: #666; font-size: 9pt; padding: 5px; background-color: #fff3cd; border-radius: 4px;")
        deevo_info.setWordWrap(True)
        deevo_layout.addWidget(deevo_info)
        
        deevo_buttons = QHBoxLayout()
        add_deevo_btn = QPushButton("➕ Add Pre-Evolution")
        add_deevo_btn.clicked.connect(self.add_pre_evolution)
        remove_deevo_btn = QPushButton("➖ Remove Selected")
        remove_deevo_btn.clicked.connect(self.remove_pre_evolution)
        deevo_buttons.addWidget(add_deevo_btn)
        deevo_buttons.addWidget(remove_deevo_btn)
        deevo_buttons.addStretch()
        deevo_layout.addLayout(deevo_buttons)
        
        self.deevolution_list = QListWidget()
        self.deevolution_list.setMaximumHeight(150)
        deevo_layout.addWidget(self.deevolution_list)
        deevo_group.setLayout(deevo_layout)
        layout.addWidget(deevo_group)
        
        # Store evolution data
        self.evolution_paths = []
        self.deevolution_sources = []
        
        layout.addStretch()
        self.setLayout(layout)
    
    def edit_evolution_requirements(self):
        """Show dialog to edit evolution requirements for THIS Digimon"""
        dialog = QDialog(self)
        dialog.setWindowTitle("Requirements to Obtain This Digimon")
        dialog.setMinimumWidth(500)
        
        layout = QVBoxLayout(dialog)
        
        # Scroll area for all fields
        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        scroll_widget = QWidget()
        scroll_layout = QVBoxLayout(scroll_widget)
        
        # Info label
        info = QLabel("Configure the requirements needed for other Digimon to evolve INTO this new Digimon.\nLeave values at 0 for no requirement.")
        info.setWordWrap(True)
        info.setStyleSheet("color: #666; padding: 8px; background: #f0f0f0; border-radius: 4px; margin-bottom: 10px;")
        scroll_layout.addWidget(info)
        
        # Agent Rank Requirement
        rank_group = QGroupBox("Agent Rank Requirement")
        rank_layout = QFormLayout()
        rank_spin = QSpinBox()
        rank_spin.setRange(1, 8)
        rank_spin.setValue(self.evolution_requirements.get('mode', 1))  # Column 2 is actually Agent Rank
        rank_spin.setToolTip("Required Agent Rank to evolve into this Digimon (1-8)")
        rank_layout.addRow("Agent Rank:", rank_spin)
        rank_group.setLayout(rank_layout)
        
        # Digimon Level Requirement
        level_group = QGroupBox("Digimon Level Requirement")
        level_layout = QFormLayout()
        digimon_level_spin = QSpinBox()
        digimon_level_spin.setRange(0, 99)
        digimon_level_spin.setValue(self.evolution_requirements.get('tamerLevel', 0))  # tamerLevel is actually Digimon level
        digimon_level_spin.setSuffix(" (0 = no requirement)")
        digimon_level_spin.setToolTip("Required Digimon level to evolve (0 = no level requirement)")
        level_layout.addRow("Digimon Level:", digimon_level_spin)
        level_group.setLayout(level_layout)
        scroll_layout.addWidget(rank_group)
        scroll_layout.addWidget(level_group)
        
        # Stat Requirements
        stats_group = QGroupBox("Stat Requirements")
        stats_layout = QFormLayout()
        
        hp_spin = QSpinBox()
        hp_spin.setRange(0, 99999)
        hp_spin.setValue(self.evolution_requirements.get('HP', 0))
        stats_layout.addRow("HP:", hp_spin)
        
        sp_spin = QSpinBox()
        sp_spin.setRange(0, 99999)
        sp_spin.setValue(self.evolution_requirements.get('SP', 0))
        stats_layout.addRow("SP:", sp_spin)
        
        atk_spin = QSpinBox()
        atk_spin.setRange(0, 9999)
        atk_spin.setValue(self.evolution_requirements.get('ATK', 0))
        stats_layout.addRow("ATK:", atk_spin)
        
        def_spin = QSpinBox()
        def_spin.setRange(0, 9999)
        def_spin.setValue(self.evolution_requirements.get('DEF', 0))
        stats_layout.addRow("DEF:", def_spin)
        
        int_spin = QSpinBox()
        int_spin.setRange(0, 9999)
        int_spin.setValue(self.evolution_requirements.get('INT', 0))
        stats_layout.addRow("INT:", int_spin)
        
        spi_spin = QSpinBox()
        spi_spin.setRange(0, 9999)
        spi_spin.setValue(self.evolution_requirements.get('SPI', 0))
        stats_layout.addRow("SPI:", spi_spin)
        
        spd_spin = QSpinBox()
        spd_spin.setRange(0, 9999)
        spd_spin.setValue(self.evolution_requirements.get('SPD', 0))
        stats_layout.addRow("SPD:", spd_spin)
        
        stats_group.setLayout(stats_layout)
        scroll_layout.addWidget(stats_group)
        
        # Skill Count Requirements
        skills_group = QGroupBox("Skill Count Requirements (by Personality Type)")
        skills_layout = QFormLayout()
        
        valor_spin = QSpinBox()
        valor_spin.setRange(0, 999)
        valor_spin.setValue(self.evolution_requirements.get('skillCountValor', 0))
        skills_layout.addRow("Valor Skills:", valor_spin)
        
        philanthropy_spin = QSpinBox()
        philanthropy_spin.setRange(0, 999)
        philanthropy_spin.setValue(self.evolution_requirements.get('skillCountPhilantropy', 0))
        skills_layout.addRow("Philanthropy Skills:", philanthropy_spin)
        
        amicable_spin = QSpinBox()
        amicable_spin.setRange(0, 999)
        amicable_spin.setValue(self.evolution_requirements.get('skillCountAmicable', 0))
        skills_layout.addRow("Amicable Skills:", amicable_spin)
        
        wisdom_spin = QSpinBox()
        wisdom_spin.setRange(0, 999)
        wisdom_spin.setValue(self.evolution_requirements.get('skillCountWisdom', 0))
        skills_layout.addRow("Wisdom Skills:", wisdom_spin)
        
        skills_group.setLayout(skills_layout)
        scroll_layout.addWidget(skills_group)
        
        # Item Requirement
        item_group = QGroupBox("Item Requirement")
        item_layout = QFormLayout()
        item_spin = QSpinBox()
        item_spin.setRange(0, 999999)
        item_spin.setValue(self.evolution_requirements.get('needsItem', 0))
        item_spin.setSuffix(" (0 = no item needed)")
        item_layout.addRow("Item ID:", item_spin)
        item_group.setLayout(item_layout)
        scroll_layout.addWidget(item_group)
        
        # Jogress Requirements
        jogress_group = QGroupBox("Jogress/DNA Digivolution Requirements")
        jogress_layout = QFormLayout()
        
        jogress_a_id = QSpinBox()
        jogress_a_id.setRange(0, 999999)
        jogress_a_id.setValue(self.evolution_requirements.get('jogressDbIdA', 0))
        jogress_layout.addRow("Jogress Partner A ID:", jogress_a_id)
        
        jogress_a_personality = QSpinBox()
        jogress_a_personality.setRange(0, 9999)
        jogress_a_personality.setValue(self.evolution_requirements.get('jogressPersonalityA', 0))
        jogress_layout.addRow("Partner A Personality:", jogress_a_personality)
        
        jogress_b_id = QSpinBox()
        jogress_b_id.setRange(0, 999999)
        jogress_b_id.setValue(self.evolution_requirements.get('jogressDbIdB', 0))
        jogress_layout.addRow("Jogress Partner B ID:", jogress_b_id)
        
        jogress_b_personality = QSpinBox()
        jogress_b_personality.setRange(0, 9999)
        jogress_b_personality.setValue(self.evolution_requirements.get('jogressPersonalityB', 0))
        jogress_layout.addRow("Partner B Personality:", jogress_b_personality)
        
        jogress_group.setLayout(jogress_layout)
        scroll_layout.addWidget(jogress_group)
        
        scroll.setWidget(scroll_widget)
        layout.addWidget(scroll)
        
        # Buttons
        buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel)
        buttons.accepted.connect(dialog.accept)
        buttons.rejected.connect(dialog.reject)
        layout.addWidget(buttons)
        
        if dialog.exec() == QDialog.DialogCode.Accepted:
            # Update requirements
            self.evolution_requirements = {
                'mode': rank_spin.value(),  # Agent Rank (1-8)
                'tamerLevel': digimon_level_spin.value(),  # Digimon Level
                'HP': hp_spin.value(),
                'SP': sp_spin.value(),
                'ATK': atk_spin.value(),
                'DEF': def_spin.value(),
                'INT': int_spin.value(),
                'SPI': spi_spin.value(),
                'SPD': spd_spin.value(),
                'unknown1': 0,
                'unknown2': 0,
                'skillCountValor': valor_spin.value(),
                'skillCountPhilantropy': philanthropy_spin.value(),
                'skillCountAmicable': amicable_spin.value(),
                'skillCountWisdom': wisdom_spin.value(),
                'needsItem': item_spin.value(),
                'jogressDbIdA': jogress_a_id.value(),
                'jogressPersonalityA': jogress_a_personality.value(),
                'jogressDbIdB': jogress_b_id.value(),
                'jogressPersonalityB': jogress_b_personality.value()
            }
            
            # Update label
            self.update_requirements_label()
    
    def update_requirements_label(self):
        """Update the requirements display label"""
        parts = []
        agent_rank = self.evolution_requirements.get('mode', 1)  # mode is actually Agent Rank
        parts.append(f"Agent Rank: {agent_rank}")
        
        if self.evolution_requirements.get('tamerLevel', 0) > 0:
            parts.append(f"Digimon Lv{self.evolution_requirements['tamerLevel']}")
        
        stats = []
        for stat in ['HP', 'SP', 'ATK', 'DEF', 'INT', 'SPI', 'SPD']:
            if self.evolution_requirements.get(stat, 0) > 0:
                stats.append(f"{stat}{self.evolution_requirements[stat]}")
        if stats:
            parts.append(", ".join(stats))
        
        if self.evolution_requirements.get('needsItem', 0) > 0:
            parts.append(f"Item#{self.evolution_requirements['needsItem']}")
        
        self.requirements_label.setText(" | ".join(parts) if len(parts) > 1 else parts[0])
    
    def add_evolution(self):
        """Show dialog to select a Digimon to evolve into"""
        try:
            dialog = QDialog(self)
            dialog.setWindowTitle("Select Evolution Target")
            dialog.setMinimumSize(500, 450)
            
            layout = QVBoxLayout(dialog)
            
            # Search box
            search_label = QLabel("Search:")
            search_edit = QLineEdit()
            search_edit.setPlaceholderText("Type to search Digimon...")
            layout.addWidget(search_label)
            layout.addWidget(search_edit)
            
            # Digimon list
            digimon_list = QListWidget()
            layout.addWidget(QLabel("Available Digimon:"))
            layout.addWidget(digimon_list)
            
            # Populate Digimon list
            self.populate_digimon_list(digimon_list)
            
            # Filter on search
            def filter_digimon(text):
                for i in range(digimon_list.count()):
                    item = digimon_list.item(i)
                    if item:
                        item.setHidden(text.lower() not in item.text().lower())
            search_edit.textChanged.connect(filter_digimon)
            
            # Custom ID option (for mod Digimon not in base game)
            custom_id_group = QGroupBox("Or Enter Custom ID")
            custom_id_layout = QHBoxLayout()
            custom_id_label = QLabel("Digimon ID:")
            custom_id_spin = QSpinBox()
            custom_id_spin.setRange(1, 999999)
            custom_id_spin.setValue(1000)
            custom_id_spin.setToolTip("Enter the ID of a custom/modded Digimon")
            custom_id_layout.addWidget(custom_id_label)
            custom_id_layout.addWidget(custom_id_spin)
            custom_id_group.setLayout(custom_id_layout)
            layout.addWidget(custom_id_group)
            
            # Buttons
            buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel)
            buttons.accepted.connect(dialog.accept)
            buttons.rejected.connect(dialog.reject)
            layout.addWidget(buttons)
            
            if dialog.exec() == QDialog.DialogCode.Accepted:
                selected_item = digimon_list.currentItem()
                if selected_item:
                    digimon_id = selected_item.data(Qt.ItemDataRole.UserRole)
                    chr_id = selected_item.data(Qt.ItemDataRole.UserRole + 1)
                    if digimon_id and chr_id:
                        self.add_evolution_path(digimon_id, chr_id)
                else:
                    # No selection in list - use custom ID
                    custom_id = custom_id_spin.value()
                    custom_chr_id = f"chr{custom_id}"
                    self.add_evolution_path(custom_id, custom_chr_id)
        except Exception as e:
            print(f"Error in add_evolution: {e}")
            import traceback
            traceback.print_exc()
            QMessageBox.warning(self, "Error", f"Failed to open evolution dialog: {str(e)}")
    
    def get_evolution_count_for_digimon(self, digimon_id: int) -> int:
        """Count how many evolution targets a Digimon has in the base game + pending additions"""
        count = 0
        
        # Check base game evolution_to.csv
        try:
            evolution_to_file = self.wizard.loader._resolve_prefixed_file(self.wizard.loader.data_path / "evolution.mbe" / "001_evolution_to.csv")
            if evolution_to_file.exists():
                rows = self.wizard.loader.load_csv(evolution_to_file)
                for row in rows[1:]:  # Skip header
                    if len(row) > 1 and row[1] == str(digimon_id):
                        count += 1
            
            # Also check DLC files
            dlc_path = self.wizard.loader._resolve_prefixed_file(self.wizard.loader.data_path.parent / "addcont_17" / "data" / "mbe" / "evolution_dlc17.mbe" / "001_evolution_to.csv")
            if dlc_path.exists():
                rows = self.wizard.loader.load_csv(dlc_path)
                for row in rows[1:]:
                    if len(row) > 1 and row[1] == str(digimon_id):
                        count += 1
        except Exception as e:
            print(f"Error counting evolutions: {e}")
        
        # Also count pending pre-evolutions we've added that use this Digimon as source
        for deevo in self.deevolution_sources:
            if deevo.get('from_id') == digimon_id:
                count += 1
        
        return count
    
    def add_pre_evolution(self):
        """Show dialog to select a Digimon that evolves into this one"""
        try:
            dialog = QDialog(self)
            dialog.setWindowTitle("Select Pre-Evolution Source")
            dialog.setMinimumSize(550, 550)
            
            layout = QVBoxLayout(dialog)
            
            # Info banner
            info_banner = QLabel(
                "⚠️ IMPORTANT: When you add a pre-evolution, that Digimon gains a new evolution target.\n"
                "Each Digimon can only have 6 evolution targets maximum!"
            )
            info_banner.setStyleSheet("background-color: #fff3cd; padding: 10px; border-radius: 6px; color: #856404;")
            info_banner.setWordWrap(True)
            layout.addWidget(info_banner)
            
            # Search box
            search_label = QLabel("Search:")
            search_edit = QLineEdit()
            search_edit.setPlaceholderText("Type to search Digimon...")
            layout.addWidget(search_label)
            layout.addWidget(search_edit)
            
            # Evolution count display
            self.evo_count_label = QLabel("Select a Digimon to see their evolution count")
            self.evo_count_label.setStyleSheet("padding: 5px; font-style: italic; color: #666;")
            layout.addWidget(self.evo_count_label)
            
            # Digimon list
            digimon_list = QListWidget()
            layout.addWidget(QLabel("Available Digimon:"))
            layout.addWidget(digimon_list)
            
            # Populate Digimon list with evolution counts
            self.populate_digimon_list_with_evo_count(digimon_list)
            
            # Update count on selection
            def update_evo_count():
                current = digimon_list.currentItem()
                if current:
                    data = current.data(100)  # Qt.UserRole
                    if data:
                        from_id = data.get('id', 0)
                        count = self.get_evolution_count_for_digimon(from_id)
                        status = "✅ Can add" if count < 6 else "❌ FULL - Cannot add!"
                        color = "#28a745" if count < 6 else "#dc3545"
                        self.evo_count_label.setText(f"Evolution slots: {count}/6 — {status}")
                        self.evo_count_label.setStyleSheet(f"padding: 5px; font-weight: bold; color: {color};")
            
            digimon_list.currentItemChanged.connect(lambda: update_evo_count())
            
            # Filter on search
            def filter_digimon(text):
                for i in range(digimon_list.count()):
                    item = digimon_list.item(i)
                    if item:
                        item.setHidden(text.lower() not in item.text().lower())
            search_edit.textChanged.connect(filter_digimon)
            
            # Custom ID option (for mod Digimon not in base game)
            custom_id_group = QGroupBox("Or Enter Custom ID (for modded Digimon)")
            custom_id_layout = QHBoxLayout()
            custom_id_label = QLabel("Digimon ID:")
            custom_id_spin = QSpinBox()
            custom_id_spin.setRange(1, 999999)
            custom_id_spin.setValue(1000)
            custom_id_spin.setToolTip("Enter the ID of a custom/modded Digimon")
            custom_id_layout.addWidget(custom_id_label)
            custom_id_layout.addWidget(custom_id_spin)
            custom_id_group.setLayout(custom_id_layout)
            layout.addWidget(custom_id_group)
            
            # Buttons
            buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel)
            buttons.accepted.connect(dialog.accept)
            buttons.rejected.connect(dialog.reject)
            layout.addWidget(buttons)
            
            if dialog.exec() == QDialog.DialogCode.Accepted:
                selected_item = digimon_list.currentItem()
                if selected_item:
                    # Data is stored as a dictionary at role 100
                    data = selected_item.data(100)
                    if data:
                        digimon_id = data.get('id')
                        chr_id = data.get('chr_id')
                        if digimon_id and chr_id:
                            self.add_pre_evolution_source(digimon_id, chr_id)
                else:
                    # No selection in list - use custom ID
                    custom_id = custom_id_spin.value()
                    custom_chr_id = f"chr{custom_id}"
                    self.add_pre_evolution_source(custom_id, custom_chr_id)
        except Exception as e:
            print(f"Error in add_pre_evolution: {e}")
            import traceback
            traceback.print_exc()
            QMessageBox.warning(self, "Error", f"Failed to open pre-evolution dialog: {str(e)}")
    
    def populate_digimon_list(self, digimon_list: QListWidget):
        """Populate list with all available Digimon"""
        try:
            # Show loading message
            digimon_list.clear()
            digimon_list.addItem("Loading Digimon list...")
            QApplication.processEvents()  # Update UI
            
            chr_ids = self.wizard.loader.get_all_digimon_chr_ids()
            
            # Also get DLC Digimon
            try:
                dlc_chr_ids = self.wizard.loader.get_all_digimon_chr_ids(from_dlc=True)
                chr_ids.extend(dlc_chr_ids)
            except:
                pass
            
            # Remove duplicates
            chr_ids = list(dict.fromkeys(chr_ids))
            
            digimon_list.clear()
            
            # Cache status file data to avoid reading multiple times
            id_cache = {}
            try:
                # Load base game IDs
                status_file = self.wizard.loader._resolve_prefixed_file(self.wizard.loader.data_path / "digimon_status.mbe" / "000_digimon_status_data.csv")
                if status_file.exists():
                    rows = self.wizard.loader.load_csv(status_file)
                    for row in rows[1:]:
                        if len(row) > 3 and row[3]:
                            chr_id = row[3].strip('"')
                            if len(row) > 0 and row[0]:
                                try:
                                    digimon_id = int(row[0])
                                    id_cache[chr_id] = digimon_id
                                except:
                                    pass
                
                # Load DLC IDs
                dlc_exporter = DLCExporter(self.wizard.loader)
                dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
                dlc_status_file = self.wizard.loader._resolve_prefixed_file(dlc_data / "digimon_status_dlc17.mbe" / "000_digimon_status_data.csv")
                if dlc_status_file.exists():
                    rows = self.wizard.loader.load_csv(dlc_status_file)
                    for row in rows[1:]:
                        if len(row) > 3 and row[3]:
                            chr_id = row[3].strip('"')
                            if len(row) > 0 and row[0]:
                                try:
                                    digimon_id = int(row[0])
                                    id_cache[chr_id] = digimon_id
                                except:
                                    pass
            except Exception as e:
                print(f"Error caching IDs: {e}")
            
            # Load Digimon data more efficiently - just get names and IDs
            loaded_count = 0
            for chr_id in chr_ids:
                try:
                    # Get name directly without loading full Digimon
                    name = self.wizard.loader._get_digimon_name_by_chr_id(chr_id)
                    if not name or name == chr_id:
                        name = chr_id
                    
                    # Get ID from cache
                    digimon_id = id_cache.get(chr_id, 0)
                    
                    item = QListWidgetItem(f"{name} (ID: {digimon_id}, {chr_id})")
                    item.setData(Qt.ItemDataRole.UserRole, digimon_id)
                    item.setData(Qt.ItemDataRole.UserRole + 1, chr_id)
                    digimon_list.addItem(item)
                    loaded_count += 1
                    
                    # Update UI every 50 items to prevent freezing
                    if loaded_count % 50 == 0:
                        QApplication.processEvents()
                except Exception as e:
                    # Skip individual Digimon that fail to load
                    print(f"Error loading Digimon {chr_id}: {e}")
                    continue
            
            if digimon_list.count() == 0:
                digimon_list.addItem("(No Digimon found)")
        except Exception as e:
            print(f"Error loading Digimon list: {e}")
            import traceback
            traceback.print_exc()
            digimon_list.clear()
            digimon_list.addItem(f"Error loading Digimon list: {str(e)}")
    
    def populate_digimon_list_with_evo_count(self, digimon_list: QListWidget):
        """Populate list with all available Digimon including evolution slot count"""
        try:
            # Show loading message
            digimon_list.clear()
            digimon_list.addItem("Loading Digimon list with evolution counts...")
            QApplication.processEvents()
            
            chr_ids = self.wizard.loader.get_all_digimon_chr_ids()
            
            # Also get DLC Digimon
            try:
                dlc_chr_ids = self.wizard.loader.get_all_digimon_chr_ids(from_dlc=True)
                chr_ids.extend(dlc_chr_ids)
            except:
                pass
            
            # Remove duplicates
            chr_ids = list(dict.fromkeys(chr_ids))
            
            # Cache status file data
            id_cache = {}
            try:
                status_file = self.wizard.loader._resolve_prefixed_file(self.wizard.loader.data_path / "digimon_status.mbe" / "000_digimon_status_data.csv")
                if status_file.exists():
                    rows = self.wizard.loader.load_csv(status_file)
                    for row in rows[1:]:
                        if len(row) > 3 and row[3]:
                            chr_id = row[3].strip('"')
                            if len(row) > 0 and row[0]:
                                try:
                                    digimon_id = int(row[0])
                                    id_cache[chr_id] = digimon_id
                                except:
                                    pass
                
                # Load DLC IDs
                dlc_exporter = DLCExporter(self.wizard.loader)
                dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
                dlc_status_file = self.wizard.loader._resolve_prefixed_file(dlc_data / "digimon_status_dlc17.mbe" / "000_digimon_status_data.csv")
                if dlc_status_file.exists():
                    rows = self.wizard.loader.load_csv(dlc_status_file)
                    for row in rows[1:]:
                        if len(row) > 3 and row[3]:
                            chr_id = row[3].strip('"')
                            if len(row) > 0 and row[0]:
                                try:
                                    digimon_id = int(row[0])
                                    id_cache[chr_id] = digimon_id
                                except:
                                    pass
            except Exception as e:
                print(f"Error caching IDs: {e}")
            
            # Count evolutions for each Digimon
            evo_counts = {}
            try:
                evolution_to_file = self.wizard.loader._resolve_prefixed_file(self.wizard.loader.data_path / "evolution.mbe" / "001_evolution_to.csv")
                if evolution_to_file.exists():
                    rows = self.wizard.loader.load_csv(evolution_to_file)
                    for row in rows[1:]:
                        if len(row) > 1 and row[1]:
                            try:
                                source_id = int(row[1])
                                evo_counts[source_id] = evo_counts.get(source_id, 0) + 1
                            except:
                                pass
                
                # Also count DLC evolutions
                dlc_evo_file = self.wizard.loader._resolve_prefixed_file(dlc_data / "evolution_dlc17.mbe" / "001_evolution_to.csv")
                if dlc_evo_file.exists():
                    rows = self.wizard.loader.load_csv(dlc_evo_file)
                    for row in rows[1:]:
                        if len(row) > 1 and row[1]:
                            try:
                                source_id = int(row[1])
                                evo_counts[source_id] = evo_counts.get(source_id, 0) + 1
                            except:
                                pass
            except Exception as e:
                print(f"Error counting evolutions: {e}")
            
            digimon_list.clear()
            
            loaded_count = 0
            for chr_id in chr_ids:
                try:
                    name = self.wizard.loader._get_digimon_name_by_chr_id(chr_id)
                    if not name or name == chr_id:
                        name = chr_id
                    
                    digimon_id = id_cache.get(chr_id, 0)
                    evo_count = evo_counts.get(digimon_id, 0)
                    
                    # Show slot status
                    if evo_count >= 6:
                        status = "❌ FULL"
                        style_hint = "full"
                    elif evo_count >= 5:
                        status = f"⚠️ {evo_count}/6"
                        style_hint = "warning"
                    else:
                        status = f"✅ {evo_count}/6"
                        style_hint = "ok"
                    
                    item = QListWidgetItem(f"{name} [{status}] (ID: {digimon_id})")
                    item.setData(100, {'id': digimon_id, 'chr_id': chr_id, 'evo_count': evo_count})
                    
                    # Color code items
                    if style_hint == "full":
                        item.setForeground(Qt.GlobalColor.red)
                    elif style_hint == "warning":
                        item.setForeground(Qt.GlobalColor.darkYellow)
                    
                    digimon_list.addItem(item)
                    loaded_count += 1
                    
                    if loaded_count % 50 == 0:
                        QApplication.processEvents()
                except Exception as e:
                    continue
            
            if digimon_list.count() == 0:
                digimon_list.addItem("(No Digimon found)")
        except Exception as e:
            print(f"Error loading Digimon list with evo counts: {e}")
            import traceback
            traceback.print_exc()
            digimon_list.clear()
            digimon_list.addItem(f"Error: {str(e)}")
    
    def add_evolution_path(self, to_id: int, to_chr_id: str):
        """Add an evolution path (no longer needs per-path requirements)"""
        try:
            # Check if already exists
            for evo in self.evolution_paths:
                if evo.get('to_id') == to_id:
                    QMessageBox.information(self, "Already Added", f"This evolution path already exists.")
                    return
            
            # Get Digimon name
            to_name = self.wizard.loader._get_digimon_name_by_chr_id(to_chr_id)
            if not to_name or to_name == to_chr_id:
                to_name = f"Unknown (ID: {to_id})"
            
            # Add to list (no per-evolution requirements anymore)
            evo_data = {
                'to_id': to_id,
                'to_chr_id': to_chr_id,
                'raw_data': [0, self.wizard.template_digimon.id if self.wizard.template_digimon else 0, 0, to_id]
            }
            self.evolution_paths.append(evo_data)
            
            # Update display - remove placeholder if present
            if self.evolution_list.count() == 1:
                item = self.evolution_list.item(0)
                if item and item.text().startswith("(No evolution"):
                    self.evolution_list.clear()
            
            # Simple display without requirements
            self.evolution_list.addItem(f"→ {to_name} (ID: {to_id})")
        except Exception as e:
            print(f"Error adding evolution path: {e}")
            import traceback
            traceback.print_exc()
            QMessageBox.warning(self, "Error", f"Failed to add evolution path: {str(e)}")
    
    def add_pre_evolution_source(self, from_id: int, from_chr_id: str):
        """Add a pre-evolution source (creates an evolution from that Digimon to this one)"""
        try:
            # Check if already exists
            for deevo in self.deevolution_sources:
                if deevo.get('from_id') == from_id:
                    QMessageBox.information(self, "Already Added", f"This pre-evolution already exists.")
                    return
            
            # Check the 6-evolution limit for the source Digimon
            evo_count = self.get_evolution_count_for_digimon(from_id)
            if evo_count >= 6:
                from_name = self.wizard.loader._get_digimon_name_by_chr_id(from_chr_id)
                if not from_name or from_name == from_chr_id:
                    from_name = f"Unknown (ID: {from_id})"
                
                QMessageBox.warning(
                    self,
                    "Evolution Limit Reached",
                    f"❌ Cannot add pre-evolution!\n\n"
                    f"{from_name} already has 6 evolution targets.\n\n"
                    f"Each Digimon can only have 6 evolutions maximum.\n"
                    f"Adding this pre-evolution would make {from_name} evolve into your Digimon, "
                    f"but they have no available evolution slots.\n\n"
                    f"Choose a different Digimon with available slots."
                )
                return
            
            # Get Digimon name
            from_name = self.wizard.loader._get_digimon_name_by_chr_id(from_chr_id)
            if not from_name or from_name == from_chr_id:
                from_name = f"Unknown (ID: {from_id})"
            
            # Add to list
            deevo_data = {
                'from_id': from_id,
                'from_chr_id': from_chr_id
            }
            self.deevolution_sources.append(deevo_data)
            
            # Update display - remove placeholder if present
            if self.deevolution_list.count() == 1 and self.deevolution_list.item(0).text().startswith("(No pre-evolution"):
                self.deevolution_list.clear()
            
            remaining_slots = 5 - evo_count  # After adding this one
            self.deevolution_list.addItem(f"← {from_name} (ID: {from_id}) [{evo_count + 1}/6 slots used]")
        except Exception as e:
            print(f"Error adding pre-evolution: {e}")
            import traceback
            traceback.print_exc()
            QMessageBox.warning(self, "Error", f"Failed to add pre-evolution: {str(e)}")
    
    def remove_evolution(self):
        """Remove selected evolution path"""
        current_row = self.evolution_list.currentRow()
        if current_row >= 0 and current_row < len(self.evolution_paths):
            self.evolution_paths.pop(current_row)
            self.evolution_list.takeItem(current_row)
    
    def remove_pre_evolution(self):
        """Remove selected pre-evolution"""
        current_row = self.deevolution_list.currentRow()
        if current_row >= 0 and current_row < len(self.deevolution_sources):
            self.deevolution_sources.pop(current_row)
            self.deevolution_list.takeItem(current_row)
    
    def show_evolution_requirements_dialog(self, target_name: str):
        """Show dialog to configure evolution requirements"""
        dialog = QDialog(self)
        dialog.setWindowTitle(f"Evolution Requirements → {target_name}")
        dialog.setMinimumWidth(500)
        
        layout = QVBoxLayout(dialog)
        
        # Scroll area for all fields
        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        scroll_widget = QWidget()
        scroll_layout = QVBoxLayout(scroll_widget)
        
        # Info label
        info = QLabel("Configure the requirements needed to evolve to this Digimon.\nLeave values at 0 for no requirement.")
        info.setWordWrap(True)
        info.setStyleSheet("color: #666; padding: 8px; background: #f0f0f0; border-radius: 4px; margin-bottom: 10px;")
        scroll_layout.addWidget(info)
        
        # Agent Rank (column 2 in evolution_condition.csv)
        mode_group = QGroupBox("Agent Rank Requirement")
        mode_layout = QVBoxLayout()
        mode_combo = QComboBox()
        mode_combo.addItem("Rank 1", 1)
        mode_combo.addItem("Rank 2", 2)
        mode_combo.addItem("Rank 3", 3)
        mode_combo.addItem("Rank 4", 4)
        mode_combo.addItem("Rank 5", 5)
        mode_combo.addItem("Rank 6", 6)
        mode_combo.addItem("Rank 7", 7)
        mode_combo.addItem("Rank 8", 8)
        mode_combo.addItem("Rank 9", 9)
        mode_combo.addItem("Rank 10", 10)
        mode_combo.setCurrentIndex(0)  # Default to Rank 1
        mode_layout.addWidget(mode_combo)
        mode_group.setLayout(mode_layout)
        scroll_layout.addWidget(mode_group)
        
        # Tamer Level
        tamer_group = QGroupBox("Tamer Requirements")
        tamer_layout = QFormLayout()
        tamer_level_spin = QSpinBox()
        tamer_level_spin.setRange(0, 99)
        tamer_level_spin.setSuffix(" (0 = no requirement)")
        tamer_layout.addRow("Tamer Level:", tamer_level_spin)
        tamer_group.setLayout(tamer_layout)
        scroll_layout.addWidget(tamer_group)
        
        # Stat Requirements
        stats_group = QGroupBox("Stat Requirements")
        stats_layout = QFormLayout()
        
        hp_spin = QSpinBox()
        hp_spin.setRange(0, 99999)
        hp_spin.setSuffix(" HP")
        stats_layout.addRow("HP:", hp_spin)
        
        sp_spin = QSpinBox()
        sp_spin.setRange(0, 99999)
        sp_spin.setSuffix(" SP")
        stats_layout.addRow("SP:", sp_spin)
        
        atk_spin = QSpinBox()
        atk_spin.setRange(0, 9999)
        atk_spin.setSuffix(" ATK")
        stats_layout.addRow("ATK:", atk_spin)
        
        def_spin = QSpinBox()
        def_spin.setRange(0, 9999)
        def_spin.setSuffix(" DEF")
        stats_layout.addRow("DEF:", def_spin)
        
        int_spin = QSpinBox()
        int_spin.setRange(0, 9999)
        int_spin.setSuffix(" INT")
        stats_layout.addRow("INT:", int_spin)
        
        spi_spin = QSpinBox()
        spi_spin.setRange(0, 9999)
        spi_spin.setSuffix(" SPI")
        stats_layout.addRow("SPI:", spi_spin)
        
        spd_spin = QSpinBox()
        spd_spin.setRange(0, 9999)
        spd_spin.setSuffix(" SPD")
        stats_layout.addRow("SPD:", spd_spin)
        
        stats_group.setLayout(stats_layout)
        scroll_layout.addWidget(stats_group)
        
        # Skill Count Requirements
        skills_group = QGroupBox("Skill Count Requirements (by Personality)")
        skills_layout = QFormLayout()
        
        valor_spin = QSpinBox()
        valor_spin.setRange(0, 999)
        skills_layout.addRow("Valor Skills:", valor_spin)
        
        philanthropy_spin = QSpinBox()
        philanthropy_spin.setRange(0, 999)
        skills_layout.addRow("Philanthropy Skills:", philanthropy_spin)
        
        amicable_spin = QSpinBox()
        amicable_spin.setRange(0, 999)
        skills_layout.addRow("Amicable Skills:", amicable_spin)
        
        wisdom_spin = QSpinBox()
        wisdom_spin.setRange(0, 999)
        skills_layout.addRow("Wisdom Skills:", wisdom_spin)
        
        skills_group.setLayout(skills_layout)
        scroll_layout.addWidget(skills_group)
        
        # Item Requirement
        item_group = QGroupBox("Item Requirement (Mode 2)")
        item_layout = QFormLayout()
        item_spin = QSpinBox()
        item_spin.setRange(0, 999999)
        item_spin.setSuffix(" (Item ID, 0 = none)")
        item_layout.addRow("Required Item:", item_spin)
        item_group.setLayout(item_layout)
        scroll_layout.addWidget(item_group)
        
        # Jogress Requirements
        jogress_group = QGroupBox("Jogress/DNA Digivolution (Mode 3)")
        jogress_layout = QFormLayout()
        
        jogress_a_id_spin = QSpinBox()
        jogress_a_id_spin.setRange(0, 999999)
        jogress_a_id_spin.setSuffix(" (Partner A ID)")
        jogress_layout.addRow("Partner A Digimon ID:", jogress_a_id_spin)
        
        jogress_a_personality_spin = QSpinBox()
        jogress_a_personality_spin.setRange(0, 99)
        jogress_a_personality_spin.setSuffix(" (Personality)")
        jogress_layout.addRow("Partner A Personality:", jogress_a_personality_spin)
        
        jogress_b_id_spin = QSpinBox()
        jogress_b_id_spin.setRange(0, 999999)
        jogress_b_id_spin.setSuffix(" (Partner B ID)")
        jogress_layout.addRow("Partner B Digimon ID:", jogress_b_id_spin)
        
        jogress_b_personality_spin = QSpinBox()
        jogress_b_personality_spin.setRange(0, 99)
        jogress_b_personality_spin.setSuffix(" (Personality)")
        jogress_layout.addRow("Partner B Personality:", jogress_b_personality_spin)
        
        jogress_group.setLayout(jogress_layout)
        scroll_layout.addWidget(jogress_group)
        
        scroll_layout.addStretch()
        scroll.setWidget(scroll_widget)
        layout.addWidget(scroll)
        
        # Buttons
        buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel)
        buttons.accepted.connect(dialog.accept)
        buttons.rejected.connect(dialog.reject)
        layout.addWidget(buttons)
        
        if dialog.exec() == QDialog.DialogCode.Accepted:
            return {
                'mode': mode_combo.currentData(),
                'tamerLevel': tamer_level_spin.value(),
                'HP': hp_spin.value(),
                'SP': sp_spin.value(),
                'ATK': atk_spin.value(),
                'DEF': def_spin.value(),
                'INT': int_spin.value(),
                'SPI': spi_spin.value(),
                'SPD': spd_spin.value(),
                'unknown1': 0,
                'unknown2': 0,
                'skillCountValor': valor_spin.value(),
                'skillCountPhilantropy': philanthropy_spin.value(),
                'skillCountAmicable': amicable_spin.value(),
                'skillCountWisdom': wisdom_spin.value(),
                'needsItem': item_spin.value(),
                'jogressDbIdA': jogress_a_id_spin.value(),
                'jogressPersonalityA': jogress_a_personality_spin.value(),
                'jogressDbIdB': jogress_b_id_spin.value(),
                'jogressPersonalityB': jogress_b_personality_spin.value()
            }
        return None  # Cancelled
    
    def _format_requirements_summary(self, conditions: dict) -> str:
        """Format evolution requirements as a short summary"""
        parts = []
        if conditions.get('tamerLevel', 0) > 0:
            parts.append(f"Tamer Lv{conditions['tamerLevel']}")
        
        stats = []
        for stat in ['HP', 'SP', 'ATK', 'DEF', 'INT', 'SPI', 'SPD']:
            if conditions.get(stat, 0) > 0:
                stats.append(f"{stat}{conditions[stat]}")
        if stats:
            parts.append(", ".join(stats))
        
        if conditions.get('needsItem', 0) > 0:
            parts.append(f"Item#{conditions['needsItem']}")
        
        if conditions.get('jogressDbIdA', 0) > 0:
            parts.append(f"Jogress w/ ID{conditions['jogressDbIdA']}")
        
        if parts:
            return f"[{'; '.join(parts)}]"
        return "[No requirements]"
    
    def initializePage(self):
        """Load evolution data from template when page is shown"""
        if not self.wizard.template_digimon:
            return
        
        digimon = self.wizard.template_digimon
        
        # Clear existing data
        self.evolution_list.clear()
        self.deevolution_list.clear()
        self.evolution_paths = []
        self.deevolution_sources = []
        
        # Populate evolution paths (deduplicate by to_id)
        seen_to_ids = set()
        for evo in digimon.evolution_paths:
            to_id = evo.get('to_id', 0)
            if to_id > 0 and to_id not in seen_to_ids:
                seen_to_ids.add(to_id)
                
                # Get name by numeric ID
                to_name = self.wizard.loader._get_digimon_name_by_id(to_id)
                if not to_name:
                    to_name = f"Unknown (ID: {to_id})"
                
                # Store evolution data
                evo_data = evo.copy()
                self.evolution_paths.append(evo_data)
                
                # Build requirements string
                reqs = []
                if 'raw_data' in evo and len(evo['raw_data']) > 2:
                    level_req = evo['raw_data'][2] if len(evo['raw_data']) > 2 else 0
                    if level_req and str(level_req).isdigit() and int(level_req) > 0:
                        reqs.append(f"Lv{level_req}")
                
                req_str = f" [{', '.join(reqs)}]" if reqs else ""
                self.evolution_list.addItem(f"→ {to_name}{req_str}")
        
        # Populate de-evolution sources (deduplicate by from_id)
        seen_from_ids = set()
        for deevo in digimon.deevolution_sources:
            from_id = deevo.get('from_id', 0)
            if from_id > 0 and from_id not in seen_from_ids:
                seen_from_ids.add(from_id)
                
                # Get name by numeric ID
                from_name = self.wizard.loader._get_digimon_name_by_id(from_id)
                if not from_name:
                    from_name = f"Unknown (ID: {from_id})"
                
                # Store deevolution data
                deevo_data = deevo.copy()
                self.deevolution_sources.append(deevo_data)
                
                self.deevolution_list.addItem(f"← {from_name} (ID: {from_id})")
        
        if self.evolution_list.count() == 0:
            self.evolution_list.addItem("(No evolution paths - click 'Add Evolution' to add)")
        if self.deevolution_list.count() == 0:
            self.deevolution_list.addItem("(No pre-evolutions - click 'Add Pre-Evolution' to add)")


class ModelPage(QWizardPage):
    """Step 8: Model & Animation"""
    
    def __init__(self, wizard):
        super().__init__()
        self.wizard = wizard
        self.setTitle("🎨 Step 9: Model & Animation")
        self.setSubTitle("Set model and animation references")
        
        layout = QFormLayout()
        layout.setSpacing(15)
        
        # Model ID
        self.model_id_edit = QLineEdit()
        self.model_id_edit.setPlaceholderText("e.g., model_001")
        layout.addRow("🎭 Model ID:", self.model_id_edit)
        
        # Audio ID (motion_ref in char_info)
        self.motion_id_edit = QLineEdit()
        self.motion_id_edit.setPlaceholderText("e.g., ymc007")
        layout.addRow("🔊 Audio ID:", self.motion_id_edit)
        
        # Animation Reference
        self.animation_ref_edit = QLineEdit()
        self.animation_ref_edit.setPlaceholderText("e.g., chr805 (which Digimon's animations to use)")
        layout.addRow("🔄 Animation Reference:", self.animation_ref_edit)
        
        # Info label
        info_label = QLabel("💡 The Animation Reference determines which Digimon's animations this Digimon uses.\nSet to the template's chr_id or another Digimon with similar animations.")
        info_label.setWordWrap(True)
        info_label.setStyleSheet("color: #666; font-size: 9pt; padding: 10px; background-color: #f8f9fa; border-radius: 6px;")
        layout.addRow("", info_label)
        
        # Set defaults from template
        if wizard.template_digimon:
            self.model_id_edit.setText(wizard.template_digimon.model_id)
            self.motion_id_edit.setText(wizard.template_digimon.motion_id)
            self.animation_ref_edit.setText(wizard.template_digimon.chr_id)
        
        self.setLayout(layout)
    
    def initializePage(self):
        """Initialize page with template data when shown"""
        if self.wizard.template_digimon:
            self.model_id_edit.setText(self.wizard.template_digimon.model_id)
            self.motion_id_edit.setText(self.wizard.template_digimon.motion_id)
            self.animation_ref_edit.setText(self.wizard.template_digimon.chr_id)


class ReviewPage(QWizardPage):
    """Step 9: Review & Export"""
    
    def __init__(self, wizard):
        super().__init__()
        self.wizard = wizard
        self.setTitle("✅ Step 10: Review & Export")
        self.setSubTitle("Review your Digimon settings and export to dsts-loader")
        
        layout = QVBoxLayout()
        
        # Review text
        self.review_text = QTextEdit()
        self.review_text.setReadOnly(True)
        self.review_text.setMaximumHeight(400)
        layout.addWidget(self.review_text)
        
        # Info
        info_label = QLabel(
            "✨ Click 'Finish' to export this Digimon to dsts-loader format.\n"
            "You will be asked to select an export directory.\n"
            "The wizard will create .ap.csv files ready for dsts-loader!"
        )
        info_label.setWordWrap(True)
        info_label.setStyleSheet("color: #495057; padding: 10px; background-color: #e7f5ff; border-radius: 6px; margin-top: 10px;")
        layout.addWidget(info_label)
        
        self.setLayout(layout)
    
    def initializePage(self):
        """Update review text when page is shown"""
        template_page = self.wizard.page(0)
        basic_page = self.wizard.page(1)
        class_page = self.wizard.page(2)
        profile_page = self.wizard.page(3)  # New page
        stats_page = self.wizard.page(4)    # Updated index
        resist_page = self.wizard.page(5)   # Updated index
        skills_page = self.wizard.page(6)   # Updated index
        evolution_page = self.wizard.page(7) # Updated index
        model_page = self.wizard.page(8)    # Updated index
        
        # Get profile text preview (first 100 chars)
        profile_text = profile_page.profile_edit.toPlainText()
        profile_preview = profile_text[:100] + "..." if len(profile_text) > 100 else profile_text
        
        review_html = f"""
        <h2>📋 Digimon Summary</h2>
        <table style="width: 100%; border-collapse: collapse;">
        <tr><td style="padding: 5px;"><b>Name:</b></td><td style="padding: 5px;">{basic_page.name_edit.text()}</td></tr>
        <tr><td style="padding: 5px;"><b>ID:</b></td><td style="padding: 5px;">{basic_page.id_spin.value()}</td></tr>
        <tr><td style="padding: 5px;"><b>Chr ID:</b></td><td style="padding: 5px;">{basic_page.chr_id_edit.text()}</td></tr>
        <tr><td style="padding: 5px;"><b>Character Key:</b></td><td style="padding: 5px;">{basic_page.char_key_edit.text()}</td></tr>
        <tr><td style="padding: 5px;"><b>Stage:</b></td><td style="padding: 5px;">{class_page.stage_combo.currentText()}</td></tr>
        <tr><td style="padding: 5px;"><b>Type:</b></td><td style="padding: 5px;">{class_page.type_combo.currentText()}</td></tr>
        <tr><td style="padding: 5px;"><b>Personality:</b></td><td style="padding: 5px;">{class_page.personality_combo.currentText()}</td></tr>
        <tr><td style="padding: 5px;"><b>Profile:</b></td><td style="padding: 5px; font-style: italic;">{profile_preview}</td></tr>
        <tr><td style="padding: 5px;"><b>HP:</b></td><td style="padding: 5px;">{stats_page.hp_spin.value()}</td></tr>
        <tr><td style="padding: 5px;"><b>SP:</b></td><td style="padding: 5px;">{stats_page.sp_spin.value()}</td></tr>
        <tr><td style="padding: 5px;"><b>ATK:</b></td><td style="padding: 5px;">{stats_page.atk_spin.value()}</td></tr>
        <tr><td style="padding: 5px;"><b>DEF:</b></td><td style="padding: 5px;">{stats_page.def_spin.value()}</td></tr>
        <tr><td style="padding: 5px;"><b>INT:</b></td><td style="padding: 5px;">{stats_page.int_spin.value()}</td></tr>
        <tr><td style="padding: 5px;"><b>SPI:</b></td><td style="padding: 5px;">{stats_page.spi_spin.value()}</td></tr>
        <tr><td style="padding: 5px;"><b>SPD:</b></td><td style="padding: 5px;">{stats_page.spd_spin.value()}</td></tr>
        <tr><td style="padding: 5px;"><b>Signature Skills:</b></td><td style="padding: 5px;">{len([s for s in skills_page.signature_skills_editor.get_skills() if s.get('id', 0) > 0])}</td></tr>
        <tr><td style="padding: 5px;"><b>Generic Skills:</b></td><td style="padding: 5px;">{len([s for s in skills_page.generic_skills_editor.get_skills() if s.get('id', 0) > 0])}</td></tr>
        <tr><td style="padding: 5px;"><b>Evolution Paths:</b></td><td style="padding: 5px;">{len(evolution_page.evolution_paths)}</td></tr>
        <tr><td style="padding: 5px;"><b>Pre-Evolutions:</b></td><td style="padding: 5px;">{len(evolution_page.deevolution_sources)}</td></tr>
        <tr><td style="padding: 5px;"><b>Animation Reference:</b></td><td style="padding: 5px;">{model_page.animation_ref_edit.text()}</td></tr>
        </table>
        <p><b>Template:</b> {template_page.template_combo.currentText()}</p>
        """
        
        self.review_text.setHtml(review_html)


class TraitsEditor(QWidget):
    """Widget for editing Digimon traits (boolean flags)"""
    
    def __init__(self, loader=None):
        super().__init__()
        self.loader = loader
        self.trait_checkboxes = []
        self.setup_ui()
    
    def setup_ui(self):
        layout = QVBoxLayout()
        
        # Title
        title = QLabel("Traits")
        title.setFont(QFont("Arial", 12, QFont.Weight.Bold))
        layout.addWidget(title)
        
        # Traits container
        scroll = QScrollArea()
        scroll_widget = QWidget()
        scroll_layout = QGridLayout(scroll_widget)
        
        # Trait descriptions for tooltips
        trait_descriptions = {
            0: "Searcher - Find items more easily",
            1: "Fighter - Better at combat",
            2: "Brainy - Higher INT growth",
            3: "Defender - Higher DEF growth",
            4: "Nimble - Higher SPD growth",
            5: "Builder - Better at construction",
            6: "Durable - Higher HP growth",
            7: "Lively - Higher SP growth",
            8: "Fire Specialist - Fire attacks more effective",
            9: "Water Specialist - Water attacks more effective",
            10: "Plant Specialist - Grass attacks more effective",
            11: "Earth Specialist - Ground attacks more effective",
            12: "Wind Specialist - Wind attacks more effective",
            13: "Electricity Specialist - Electric attacks more effective",
            14: "Light Specialist - Light attacks more effective",
            15: "Dark Specialist - Dark attacks more effective"
        }
        
        # Create 41 trait checkboxes in a grid
        for i in range(41):
            trait_name = f"Trait {i + 1}"
            if self.loader:
                trait_name = self.loader.get_trait_name(i)
                clean_name = self.loader.clean_ui_text(trait_name)
                trait_name = clean_name if clean_name else f"Trait {i + 1}"
            checkbox = QCheckBox(trait_name)
            checkbox.setObjectName(f"trait_{i}")
            
            # Add tooltip if available
            if i in trait_descriptions:
                checkbox.setToolTip(trait_descriptions[i])
            else:
                checkbox.setToolTip(f"{trait_name} - Check to enable this trait")
            
            self.trait_checkboxes.append(checkbox)
            
            row = i // 3
            col = i % 3
            scroll_layout.addWidget(checkbox, row, col)
        
        scroll.setWidget(scroll_widget)
        scroll.setWidgetResizable(True)
        scroll.setMaximumHeight(300)
        layout.addWidget(scroll)
        
        self.setLayout(layout)
    
    def load_traits(self, traits: List[bool]):
        """Load traits into checkboxes"""
        for i, checkbox in enumerate(self.trait_checkboxes):
            if i < len(traits):
                checkbox.setChecked(traits[i])
            else:
                checkbox.setChecked(False)
    
    def get_traits(self) -> List[bool]:
        """Get traits from checkboxes"""
        return [checkbox.isChecked() for checkbox in self.trait_checkboxes]


class DigimonEditor(QMainWindow):
    """Main Digimon Editor window"""
    
    def __init__(self):
        super().__init__()
        # Use Base folders for base game data
        self.loader = MBELoader(data_path="Base/data", text_path="Base/text")
        self.exporter = CSVExporter(data_path="Base/data", text_path="Base/text")
        self.current_digimon: Optional[DigimonData] = None
        self.has_unsaved_changes = False
        self.setup_ui()
        self.connect_change_signals()
        self.load_digimon_list()
    
    def mark_as_modified(self):
        """Mark the current Digimon as having unsaved changes"""
        if self.current_digimon and not self.has_unsaved_changes:
            self.has_unsaved_changes = True
            # Update window title to show unsaved indicator
            current_title = self.windowTitle()
            if not current_title.endswith("*"):
                self.setWindowTitle(current_title + " *")
            # Update current digimon label
            if hasattr(self, 'current_digimon_label'):
                label_text = self.current_digimon_label.text()
                if not label_text.endswith("*"):
                    self.current_digimon_label.setText(label_text + " *")
    
    def clear_modified_flag(self):
        """Clear the unsaved changes flag"""
        self.has_unsaved_changes = False
        # Remove asterisk from window title
        current_title = self.windowTitle()
        if current_title.endswith(" *"):
            self.setWindowTitle(current_title[:-2])
        # Remove asterisk from label
        if hasattr(self, 'current_digimon_label'):
            label_text = self.current_digimon_label.text()
            if label_text.endswith(" *"):
                self.current_digimon_label.setText(label_text[:-2])
    
    def validate_digimon_uniqueness(self, original_id: int, original_chr_id: str) -> bool:
        """Validate that ID and chr_id are unique"""
        new_id = self.current_digimon.id
        new_chr_id = self.current_digimon.chr_id
        
        # If values haven't changed, no need to validate
        if new_id == original_id and new_chr_id == original_chr_id:
            return True
        
        # Check ID uniqueness
        if new_id != original_id:
            # Get all Digimon IDs from both base game and DLC
            all_chr_ids = self.loader.get_all_digimon_chr_ids(from_dlc=False)
            all_chr_ids.extend(self.loader.get_all_digimon_chr_ids(from_dlc=True))
            
            for chr_id in all_chr_ids:
                digimon = self.loader.get_digimon_by_chr_id(chr_id)
                if digimon and digimon.id == new_id and digimon.chr_id != original_chr_id:
                    QMessageBox.warning(
                        self,
                        "Duplicate ID",
                        f"❌ ID {new_id} is already used by {digimon.name} ({digimon.chr_id})!\n\n"
                        "Please choose a different ID."
                    )
                    return False
        
        # Check chr_id uniqueness
        if new_chr_id != original_chr_id:
            existing_digimon = self.loader.get_digimon_by_chr_id(new_chr_id)
            if existing_digimon and existing_digimon.chr_id != original_chr_id:
                QMessageBox.warning(
                    self,
                    "Duplicate Chr ID",
                    f"❌ Chr ID '{new_chr_id}' is already used by {existing_digimon.name}!\n\n"
                    "Please choose a different Chr ID."
                )
                return False
        
        return True
    
    def connect_change_signals(self):
        """Connect all form widgets to mark_as_modified"""
        # Basic info
        self.id_spin.valueChanged.connect(self.mark_as_modified)
        self.char_key_edit.textChanged.connect(self.mark_as_modified)
        self.chr_id_edit.textChanged.connect(self.mark_as_modified)
        self.name_edit.textChanged.connect(self.mark_as_modified)
        self.stage_combo.currentIndexChanged.connect(self.mark_as_modified)
        self.type_combo.currentIndexChanged.connect(self.mark_as_modified)
        self.personality_combo.currentIndexChanged.connect(self.mark_as_modified)
        self.tribe_combo.currentIndexChanged.connect(self.mark_as_modified)
        self.profile_text_edit.textChanged.connect(self.mark_as_modified)
        
        # Stats
        for widget in self.stat_widgets.values():
            widget.valueChanged.connect(self.mark_as_modified)
        self.growth_pattern_combo.currentIndexChanged.connect(self.mark_as_modified)
        
        # Resistances
        for widget in self.resist_widgets.values():
            widget.valueChanged.connect(self.mark_as_modified)
        
        # Model settings
        self.model_id_edit.textChanged.connect(self.mark_as_modified)
        self.motion_id_edit.textChanged.connect(self.mark_as_modified)
        self.animation_ref_edit.textChanged.connect(self.mark_as_modified)
    
    def setup_ui(self):
        self.setWindowTitle("DTS Creator - Digimon Editor")
        # Set initial size smaller to fit most screens, window is resizable
        self.setGeometry(100, 100, 1400, 800)
        
        # Modern stylesheet for the entire application
        self.setStyleSheet("""
            QMainWindow {
                background-color: #f5f7fa;
            }
            QWidget {
                font-family: 'Segoe UI', Arial, sans-serif;
            }
            QTabWidget::pane {
                border: 2px solid #667eea;
                border-radius: 8px;
                background-color: white;
                padding: 5px;
            }
            QTabBar::tab {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #f8f9fa, stop:1 #e9ecef);
                color: #495057;
                border: 2px solid #dee2e6;
                border-bottom: none;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
                padding: 10px 20px;
                margin-right: 2px;
                font-weight: bold;
                font-size: 11pt;
            }
            QTabBar::tab:selected {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #667eea, stop:1 #764ba2);
                color: white;
                border-color: #667eea;
            }
            QTabBar::tab:hover:!selected {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #e7f5ff, stop:1 #d0ebff);
            }
            
            /* Modern Input Fields */
            QLineEdit, QSpinBox, QDoubleSpinBox {
                background-color: white;
                border: 2px solid #dee2e6;
                border-radius: 6px;
                padding: 8px;
                font-size: 10pt;
                color: #495057;
            }
            QLineEdit:focus, QSpinBox:focus, QDoubleSpinBox:focus {
                border-color: #667eea;
                background-color: #f8f9fa;
            }
            QLineEdit:disabled, QSpinBox:disabled, QDoubleSpinBox:disabled {
                background-color: #e9ecef;
                color: #adb5bd;
            }
            
            /* ComboBox Styling */
            QComboBox {
                background-color: white;
                border: 2px solid #dee2e6;
                border-radius: 6px;
                padding: 8px;
                font-size: 10pt;
                color: #495057;
            }
            QComboBox:hover {
                border-color: #667eea;
            }
            QComboBox:focus {
                border-color: #667eea;
                background-color: #f8f9fa;
            }
            QComboBox::drop-down {
                border: none;
            }
            
            /* Group Box Styling */
            QGroupBox {
                font-weight: bold;
                border: 2px solid #667eea;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 15px;
                background-color: white;
                font-size: 11pt;
            }
            QGroupBox::title {
                color: #667eea;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
            
            /* Modern Buttons */
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #667eea, stop:1 #764ba2);
                color: white;
                border: none;
                border-radius: 6px;
                padding: 10px 15px;
                font-weight: bold;
                font-size: 10pt;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #5568d3, stop:1 #653b8e);
            }
            QPushButton:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #4a5bc4, stop:1 #563380);
            }
            QPushButton:disabled {
                background: #e9ecef;
                color: #adb5bd;
            }
            
            /* List Widget Styling */
            QListWidget {
                background-color: white;
                border: 2px solid #dee2e6;
                border-radius: 8px;
                padding: 5px;
            }
            QListWidget::item {
                padding: 10px;
                margin: 2px;
                border-radius: 6px;
            }
            QListWidget::item:hover {
                background-color: #e7f5ff;
            }
            QListWidget::item:selected {
                background: qlineargradient(x1:0, y1:0, x2:1, y2:0,
                    stop:0 #667eea, stop:1 #764ba2);
                color: white;
            }
            
            /* Label Styling */
            QLabel {
                color: #495057;
            }
        """)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QHBoxLayout(central_widget)
        main_layout.setSpacing(15)
        main_layout.setContentsMargins(15, 15, 15, 15)
        
        # Left panel - Digimon list
        left_panel = self.create_left_panel()
        main_layout.addWidget(left_panel, 1)
        
        # Right panel - Editor
        right_panel = self.create_right_panel()
        main_layout.addWidget(right_panel, 3)
    
    def create_left_panel(self) -> QWidget:
        """Create the left panel with Digimon list"""
        panel = QWidget()
        panel.setStyleSheet("""
            QWidget {
                background-color: white;
                border-radius: 12px;
                border: 2px solid #dee2e6;
            }
        """)
        layout = QVBoxLayout(panel)
        layout.setContentsMargins(15, 15, 15, 15)
        layout.setSpacing(12)
        
        # Title
        title = QLabel("📚 Digimon Database")
        title.setFont(QFont("Segoe UI", 14, QFont.Weight.Bold))
        title.setStyleSheet("""
            QLabel {
                color: #667eea;
                padding: 12px;
                background: qlineargradient(x1:0, y1:0, x2:1, y2:0,
                    stop:0 #f8f9fa, stop:1 #e9ecef);
                border-radius: 8px;
                border: 2px solid #dee2e6;
            }
        """)
        layout.addWidget(title)
        
        # Source selector (Base Game vs DLC)
        source_container = QWidget()
        source_container.setStyleSheet("""
            QWidget {
                background-color: #f8f9fa;
                border-radius: 8px;
                border: 2px solid #dee2e6;
                padding: 8px;
            }
        """)
        source_layout = QHBoxLayout(source_container)
        source_layout.setContentsMargins(10, 5, 10, 5)
        
        source_label = QLabel("📂 Source:")
        source_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        source_label.setStyleSheet("border: none; background: transparent; color: #667eea;")
        source_layout.addWidget(source_label)
        
        self.source_combo = QComboBox()
        self.source_combo.addItem("Base Game", False)
        self.source_combo.addItem("DLC (addcont_17)", True)
        self.source_combo.setToolTip("Select which Digimon to view:\n• Base Game - Original game Digimon\n• DLC - Custom/modded Digimon\n\nSaving behavior changes based on selection")
        self.source_combo.currentIndexChanged.connect(self.load_digimon_list)
        self.source_combo.currentIndexChanged.connect(self.on_source_changed)
        self.source_combo.setStyleSheet("""
            QComboBox {
                border: none;
                background: white;
                border-radius: 6px;
                padding: 6px 10px;
                font-size: 10pt;
                color: #333333;
            }
            QComboBox:hover {
                background: #e7f5ff;
            }
            QComboBox::drop-down {
                border: none;
            }
            QComboBox QAbstractItemView {
                background: white;
                color: #333333;
                selection-background-color: #667eea;
                selection-color: white;
            }
            QComboBox QAbstractItemView::item {
                color: #333333;
                padding: 5px;
            }
        """)
        # Fix for Windows 11 - explicitly set view palette
        source_view = self.source_combo.view()
        source_palette = source_view.palette()
        source_palette.setColor(QPalette.ColorRole.Text, QColor("#333333"))
        source_palette.setColor(QPalette.ColorRole.Base, QColor("white"))
        source_view.setPalette(source_palette)
        source_layout.addWidget(self.source_combo)
        layout.addWidget(source_container)
        
        # Search box
        search_container = QWidget()
        search_container.setStyleSheet("""
            QWidget {
                background-color: #f8f9fa;
                border-radius: 8px;
                border: 2px solid #dee2e6;
                padding: 5px;
            }
        """)
        search_layout = QHBoxLayout(search_container)
        search_layout.setContentsMargins(10, 5, 10, 5)
        
        search_icon = QLabel("🔎")
        search_icon.setFont(QFont("Segoe UI", 12))
        search_icon.setStyleSheet("border: none; background: transparent;")
        search_layout.addWidget(search_icon)
        
        self.search_box = QLineEdit()
        self.search_box.setPlaceholderText("Search Digimon...")
        self.search_box.setStyleSheet("""
            QLineEdit {
                border: none;
                background: transparent;
                font-size: 11pt;
                padding: 5px;
                color: #495057;
            }
            QLineEdit:focus {
                color: #667eea;
            }
        """)
        self.search_box.textChanged.connect(self.filter_digimon_list)
        search_layout.addWidget(self.search_box)
        layout.addWidget(search_container)
        
        # Digimon list
        self.digimon_list = QComboBox()
        self.digimon_list.currentTextChanged.connect(self.on_digimon_selected)
        self.digimon_list.setStyleSheet("""
            QComboBox {
                background: white;
                border: 2px solid #dee2e6;
                border-radius: 8px;
                padding: 10px;
                font-size: 11pt;
                color: #333333;
            }
            QComboBox:hover {
                border-color: #667eea;
                background: #f8f9fa;
            }
            QComboBox:focus {
                border-color: #667eea;
            }
            QComboBox::drop-down {
                border: none;
                padding-right: 10px;
            }
            QComboBox QAbstractItemView {
                background: white;
                color: #333333;
                selection-background-color: #667eea;
                selection-color: white;
                border: 1px solid #dee2e6;
                padding: 5px;
            }
            QComboBox QAbstractItemView::item {
                padding: 8px;
                color: #333333;
            }
            QComboBox QAbstractItemView::item:hover {
                background-color: #e9ecef;
                color: #333333;
            }
            QComboBox QAbstractItemView::item:selected {
                background-color: #667eea;
                color: white;
            }
        """)
        # Fix for Windows 11 - explicitly set view palette to ensure text is visible
        view = self.digimon_list.view()
        palette = view.palette()
        palette.setColor(QPalette.ColorRole.Text, QColor("#333333"))
        palette.setColor(QPalette.ColorRole.Base, QColor("white"))
        palette.setColor(QPalette.ColorRole.Highlight, QColor("#667eea"))
        palette.setColor(QPalette.ColorRole.HighlightedText, QColor("white"))
        view.setPalette(palette)
        layout.addWidget(self.digimon_list)
        
        # Buttons with modern styling
        button_style = """
            QPushButton {{
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 {color1}, stop:1 {color2});
                color: white;
                border: none;
                border-radius: 8px;
                padding: 12px;
                font-weight: bold;
                font-size: 10pt;
            }}
            QPushButton:hover {{
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 {hover1}, stop:1 {hover2});
            }}
            QPushButton:disabled {{
                background: #e9ecef;
                color: #adb5bd;
            }}
        """
        
        button_layout = QVBoxLayout()
        button_layout.setSpacing(10)
        
        self.load_button = QPushButton("📖 Load Selected")
        self.load_button.clicked.connect(self.load_selected_digimon)
        self.load_button.setToolTip("Load the selected Digimon for editing")
        self.load_button.setStyleSheet(button_style.format(
            color1="#667eea", color2="#764ba2",
            hover1="#5568d3", hover2="#653b8e"
        ))
        button_layout.addWidget(self.load_button)
        
        self.new_button = QPushButton("➕ Create New")
        self.new_button.clicked.connect(self.launch_creation_wizard)
        self.new_button.setToolTip("Create a new Digimon using the step-by-step wizard\nExports to dsts-loader format")
        self.new_button.setStyleSheet(button_style.format(
            color1="#10b981", color2="#059669",
            hover1="#059669", hover2="#047857"
        ))
        button_layout.addWidget(self.new_button)
        
        self.import_button = QPushButton("📥 Import from dsts-loader")
        self.import_button.clicked.connect(self.import_from_dsts_loader)
        self.import_button.setToolTip("Import Digimon from dsts-loader .ap.csv files\nAllows you to edit previously exported Digimon")
        self.import_button.setStyleSheet(button_style.format(
            color1="#f59e0b", color2="#d97706",
            hover1="#d97706", hover2="#b45309"
        ))
        button_layout.addWidget(self.import_button)
        
        self.remove_button = QPushButton("🗑️ Remove from DLC")
        self.remove_button.clicked.connect(self.remove_digimon_from_dlc)
        self.remove_button.setEnabled(False)
        self.remove_button.setToolTip("Permanently delete this Digimon from DLC files\nOnly works for DLC Digimon")
        self.remove_button.setStyleSheet(button_style.format(
            color1="#f5576c", color2="#f093fb",
            hover1="#e34556", hover2="#de7fe9"
        ))
        button_layout.addWidget(self.remove_button)
        
        self.save_button = QPushButton("💾 Save Changes")
        self.save_button.clicked.connect(self.save_current_digimon)
        self.save_button.setEnabled(False)
        self.save_button.setToolTip("Save changes to the current Digimon\n• Base Game → Saves to .mbe files\n• DLC → Saves to DLC files\n• Imported → Choose save location")
        self.save_button.setStyleSheet(button_style.format(
            color1="#f093fb", color2="#f5576c",
            hover1="#de7fe9", hover2="#e34556"
        ))
        button_layout.addWidget(self.save_button)
        
        # Separator line
        separator = QWidget()
        separator.setFixedHeight(2)
        separator.setStyleSheet("background-color: #dee2e6; border-radius: 1px;")
        button_layout.addWidget(separator)
        
        self.export_dlc_button = QPushButton("📦 Export to DLC")
        self.export_dlc_button.clicked.connect(self.export_to_dlc)
        self.export_dlc_button.setEnabled(False)
        self.export_dlc_button.setToolTip("Export the current Digimon to DLC files\nMakes it available in-game without modifying base game")
        self.export_dlc_button.setStyleSheet(button_style.format(
            color1="#4CAF50", color2="#45a049",
            hover1="#45a049", hover2="#3d8b40"
        ))
        button_layout.addWidget(self.export_dlc_button)
        
        self.export_button = QPushButton("📄 Export CSV")
        self.export_button.clicked.connect(self.export_csv)
        self.export_button.setToolTip(
            "Export CSV files\n"
            "⚠️ WARNING: This will DELETE and replace all existing files in the destination directory!\n"
            "Only data currently in your DLC folder will be exported."
        )
        self.export_button.setStyleSheet(button_style.format(
            color1="#fa709a", color2="#fee140",
            hover1="#e85c89", hover2="#ecd32f"
        ))
        button_layout.addWidget(self.export_button)
        
        self.repack_button = QPushButton("📦 Repack to MBE Files")
        self.repack_button.clicked.connect(self.repack_mbe_files)
        self.repack_button.setToolTip("Repack DLC CSV files back into .mbe format\nRequired after making DLC changes")
        self.repack_button.setStyleSheet(button_style.format(
            color1="#667eea", color2="#764ba2",
            hover1="#5568d3", hover2="#653b8e"
        ))
        button_layout.addWidget(self.repack_button)
        
        layout.addLayout(button_layout)
        layout.addStretch()
        
        return panel
    
    def create_right_panel(self) -> QWidget:
        """Create the right panel with editor tabs"""
        panel = QWidget()
        panel.setStyleSheet("""
            QWidget {
                background-color: white;
                border-radius: 12px;
                border: 2px solid #dee2e6;
            }
        """)
        layout = QVBoxLayout(panel)
        layout.setContentsMargins(15, 15, 15, 15)
        layout.setSpacing(10)
        
        # Current Digimon info header
        self.current_digimon_label = QLabel("📂 No Digimon loaded")
        self.current_digimon_label.setFont(QFont("Segoe UI", 13, QFont.Weight.Bold))
        self.current_digimon_label.setStyleSheet("""
            QLabel {
                color: white;
                padding: 15px;
                background: qlineargradient(x1:0, y1:0, x2:1, y2:0,
                    stop:0 #667eea, stop:1 #764ba2);
                border-radius: 8px;
                border: none;
            }
        """)
        self.current_digimon_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        layout.addWidget(self.current_digimon_label)
        
        # Tab widget
        self.tab_widget = QTabWidget()
        
        # Basic Info Tab
        self.basic_tab = self.create_basic_tab()
        self.tab_widget.addTab(self.basic_tab, "📝 Basic Info")
        
        # Stats Tab
        self.stats_tab = self.create_stats_tab()
        self.tab_widget.addTab(self.stats_tab, "📊 Stats")
        
        # Skills Tab
        self.skills_tab = self.create_skills_tab()
        self.tab_widget.addTab(self.skills_tab, "⚡ Skills")
        
        # Advanced Skills Tab
        self.advanced_skills_tab = self.create_advanced_skills_tab()
        self.tab_widget.addTab(self.advanced_skills_tab, "🎯 Advanced Skills")
        
        # Traits Tab
        self.traits_tab = TraitsEditor(self.loader)
        self.tab_widget.addTab(self.traits_tab, "✨ Traits")
        
        # Model Tab
        self.model_tab = self.create_model_tab()
        self.tab_widget.addTab(self.model_tab, "🎨 Model & Animation")
        
        # Evolution Tab
        self.evolution_tab = self.create_evolution_tab()
        self.tab_widget.addTab(self.evolution_tab, "🔄 Evolution")
        
        # Battle Tab
        self.battle_tab = self.create_battle_tab()
        self.tab_widget.addTab(self.battle_tab, "⚔️ Battle Data")
        
        layout.addWidget(self.tab_widget)
        
        return panel
    
    def create_basic_tab(self) -> QWidget:
        """Create basic information tab"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        layout.setSpacing(15)
        
        # Main Information Group
        main_info_group = QGroupBox("📋 Main Information")
        main_info_layout = QGridLayout(main_info_group)
        main_info_layout.setSpacing(10)
        
        # ID
        id_label = QLabel("🆔 ID:")
        id_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        main_info_layout.addWidget(id_label, 0, 0)
        self.id_spin = QSpinBox()
        self.id_spin.setRange(0, 99999)
        main_info_layout.addWidget(self.id_spin, 0, 1)
        
        # Character Key
        char_key_label = QLabel("🔑 Character Key:")
        char_key_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        main_info_layout.addWidget(char_key_label, 1, 0)
        self.char_key_edit = QLineEdit()
        main_info_layout.addWidget(self.char_key_edit, 1, 1)
        
        # Chr ID
        chr_id_label = QLabel("🔢 Chr ID:")
        chr_id_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        main_info_layout.addWidget(chr_id_label, 2, 0)
        self.chr_id_edit = QLineEdit()
        main_info_layout.addWidget(self.chr_id_edit, 2, 1)
        
        # Name
        name_label = QLabel("📛 Name:")
        name_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        main_info_layout.addWidget(name_label, 3, 0)
        self.name_edit = QLineEdit()
        main_info_layout.addWidget(self.name_edit, 3, 1)
        
        layout.addWidget(main_info_group)
        
        # Classification Group
        classification_group = QGroupBox("🏷️ Classification")
        classification_layout = QGridLayout(classification_group)
        classification_layout.setSpacing(10)
        
        # Stage with dropdown
        stage_label = QLabel("⭐ Stage:")
        stage_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        classification_layout.addWidget(stage_label, 0, 0)
        self.stage_combo = QComboBox()
        self.populate_stage_dropdown()
        classification_layout.addWidget(self.stage_combo, 0, 1)
        
        # Type ID with dropdown
        type_label = QLabel("🔷 Type:")
        type_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        classification_layout.addWidget(type_label, 1, 0)
        self.type_combo = QComboBox()
        self.populate_type_dropdown()
        classification_layout.addWidget(self.type_combo, 1, 1)
        
        # Personality with dropdown
        personality_label = QLabel("🎭 Personality:")
        personality_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        classification_layout.addWidget(personality_label, 2, 0)
        self.personality_combo = QComboBox()
        self.populate_personality_dropdown()
        classification_layout.addWidget(self.personality_combo, 2, 1)
        
        # Tribe/Belong with dropdown
        tribe_label = QLabel("🦁 Tribe (Belong):")
        tribe_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        classification_layout.addWidget(tribe_label, 3, 0)
        self.tribe_combo = QComboBox()
        self.populate_tribe_dropdown()
        self.tribe_combo.setToolTip("Tribe/species classification shown in Digimon profile")
        classification_layout.addWidget(self.tribe_combo, 3, 1)
        
        layout.addWidget(classification_group)
        
        # Profile/Description Group
        profile_group = QGroupBox("📖 Profile / Description")
        profile_group.setStyleSheet("""
            QGroupBox {
                border-color: #84fab0;
            }
            QGroupBox::title {
                color: #2c9558;
            }
        """)
        profile_layout = QVBoxLayout(profile_group)
        
        self.profile_text_edit = QTextEdit()
        self.profile_text_edit.setPlaceholderText("Enter Digimon description/profile text...")
        self.profile_text_edit.setMaximumHeight(120)
        self.profile_text_edit.setStyleSheet("""
            QTextEdit {
                background-color: white;
                border: 2px solid #dee2e6;
                border-radius: 6px;
                padding: 10px;
                font-size: 10pt;
                color: #495057;
            }
            QTextEdit:focus {
                border-color: #84fab0;
                background-color: #f8f9fa;
            }
        """)
        profile_layout.addWidget(self.profile_text_edit)
        
        layout.addWidget(profile_group)
        layout.addStretch()
        
        return tab
    
    def create_stats_tab(self) -> QWidget:
        """Create stats tab"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        
        # Base Stats Group
        stats_group = QGroupBox("Base Stats")
        stats_layout = QGridLayout(stats_group)
        
        # Create stat spinboxes
        self.stat_widgets = {}
        stats = ["HP", "SP", "ATK", "DEF", "INT", "SPI", "SPD"]
        
        for i, stat in enumerate(stats):
            stats_layout.addWidget(QLabel(f"{stat}:"), i, 0)
            spin = QSpinBox()
            spin.setRange(0, 9999)
            self.stat_widgets[stat.lower()] = spin
            stats_layout.addWidget(spin, i, 1)
        
        layout.addWidget(stats_group)
        
        # Growth Pattern Group
        growth_group = QGroupBox("📈 Growth Pattern")
        growth_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #f093fb;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 15px;
                background-color: white;
                font-size: 11pt;
            }
            QGroupBox::title {
                color: #c967cc;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
        """)
        growth_layout = QHBoxLayout(growth_group)
        
        growth_label = QLabel("Growth Pattern (determines stat gains per level):")
        growth_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        growth_layout.addWidget(growth_label)
        
        self.growth_pattern_combo = QComboBox()
        for i in range(1, 19):  # Growth patterns 1-18
            self.growth_pattern_combo.addItem(f"Pattern {i}", i)
        growth_layout.addWidget(self.growth_pattern_combo)
        growth_layout.addStretch()
        
        layout.addWidget(growth_group)
        
        # Elemental Resistances Group
        resist_group = QGroupBox("🛡️ Elemental Resistances")
        resist_layout = QGridLayout(resist_group)
        
        # Create resistance spinboxes with element names
        self.resist_widgets = {}
        # IMPORTANT: Order must match CSV columns 7-17 (resNull, resFire, resWater, resGrass, resIce, resElec, resGround, resSteel, resWind, resLight, resDark)
        resistances = [
            ("null", "Null"),
            ("fire", "Fire"),
            ("water", "Water"),
            ("grass", "Plant"),
            ("ice", "Ice"),
            ("elec", "Electric"),
            ("ground", "Earth"),
            ("steel", "Steel"),
            ("wind", "Wind"),
            ("light", "Light"),
            ("dark", "Dark")
        ]
        
        resistance_labels = {
            0: "Normal (1.0x)",
            1: "Weak (1.5x)",
            2: "Very Weak (2.0x)",
            3: "Resist (0.5x)",
            4: "Immune (0.0x)"
        }
        
        for i, (resist_key, resist_name) in enumerate(resistances):
            row = i // 2
            col = (i % 2) * 3  # Changed to *3 to make room for label
            resist_layout.addWidget(QLabel(f"{resist_name}:"), row, col)
            
            spin = QSpinBox()
            spin.setRange(0, 4)
            spin.setObjectName(f"resist_{resist_key}")
            spin.setToolTip(
                f"Set {resist_name} resistance:\n"
                "0 = Normal (100% damage - 1.0x)\n"
                "1 = Weak (150% damage - 1.5x)\n"
                "2 = Very Weak (200% damage - 2.0x)\n"
                "3 = Resistant (50% damage - 0.5x)\n"
                "4 = Immune (0% damage - no damage taken)"
            )
            self.resist_widgets[resist_key] = spin
            resist_layout.addWidget(spin, row, col + 1)
            
            # Add label that updates based on value
            value_label = QLabel(resistance_labels[0])
            value_label.setObjectName(f"resist_label_{resist_key}")
            value_label.setStyleSheet("color: #666; font-size: 9pt;")
            resist_layout.addWidget(value_label, row, col + 2)
            
            # Connect to update label when value changes
            spin.valueChanged.connect(lambda v, label=value_label: label.setText(resistance_labels.get(v, "Unknown")))
        
        layout.addWidget(resist_group)
        layout.addStretch()
        
        return tab
    
    def create_skills_tab(self) -> QWidget:
        """Create skills tab"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        
        # Signature Skills Section
        sig_group = QGroupBox("Signature Skills (up to 12)")
        sig_layout = QVBoxLayout()
        
        # Add skill button
        sig_add_btn = QPushButton("➕ Add Signature Skill")
        sig_add_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #667eea, stop:1 #764ba2);
                color: white;
                border: none;
                border-radius: 6px;
                padding: 8px 16px;
                font-weight: bold;
                font-size: 10pt;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #5568d3, stop:1 #653b8e);
            }
        """)
        sig_add_btn.clicked.connect(lambda: self.add_skill_from_list("signature"))
        sig_layout.addWidget(sig_add_btn)
        
        self.signature_skills_editor = SkillEditor("signature", self.loader)
        sig_layout.addWidget(self.signature_skills_editor)
        sig_group.setLayout(sig_layout)
        layout.addWidget(sig_group)
        
        # Generic Skills Section
        gen_group = QGroupBox("Generic Skills (up to 4)")
        gen_layout = QVBoxLayout()
        
        # Add skill button
        gen_add_btn = QPushButton("➕ Add Generic Skill")
        gen_add_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #84fab0, stop:1 #8fd3f4);
                color: white;
                border: none;
                border-radius: 6px;
                padding: 8px 16px;
                font-weight: bold;
                font-size: 10pt;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #6ee89f, stop:1 #7bc9e8);
            }
        """)
        gen_add_btn.clicked.connect(lambda: self.add_skill_from_list("generic"))
        gen_layout.addWidget(gen_add_btn)
        
        self.generic_skills_editor = SkillEditor("generic", self.loader)
        gen_layout.addWidget(self.generic_skills_editor)
        gen_group.setLayout(gen_layout)
        layout.addWidget(gen_group)
        
        layout.addStretch()
        
        return tab
    
    def add_skill_from_list(self, skill_type: str):
        """Show dialog to select a skill from list"""
        dialog = QDialog(self)
        dialog.setWindowTitle(f"Select {skill_type.title()} Skill")
        dialog.setMinimumSize(600, 500)
        
        layout = QVBoxLayout(dialog)
        
        # Info label
        info_label = QLabel(f"Select a skill to add to the first empty slot in {skill_type} skills.")
        info_label.setWordWrap(True)
        info_label.setStyleSheet("color: #666; padding: 8px; background-color: #f0f0f0; border-radius: 4px;")
        layout.addWidget(info_label)
        
        # Search box
        search_label = QLabel("🔍 Search:")
        search_edit = QLineEdit()
        search_edit.setPlaceholderText("Type to search skills by name or ID...")
        layout.addWidget(search_label)
        layout.addWidget(search_edit)
        
        # Skill list
        skill_list = QListWidget()
        layout.addWidget(QLabel("Available Skills:"))
        layout.addWidget(skill_list)
        
        # Populate skill list
        self._populate_skill_list(skill_list)
        
        # Filter on search
        def filter_skills(text):
            for i in range(skill_list.count()):
                item = skill_list.item(i)
                item.setHidden(text.lower() not in item.text().lower())
        search_edit.textChanged.connect(filter_skills)
        
        # Buttons
        buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel)
        buttons.accepted.connect(dialog.accept)
        buttons.rejected.connect(dialog.reject)
        layout.addWidget(buttons)
        
        if dialog.exec() == QDialog.DialogCode.Accepted:
            selected_item = skill_list.currentItem()
            if selected_item:
                skill_id = selected_item.data(Qt.ItemDataRole.UserRole)
                self._add_skill_to_editor(skill_type, skill_id)
    
    def _populate_skill_list(self, skill_list: QListWidget):
        """Populate skill list with all available skills"""
        try:
            skills_file = self.loader.data_path / "battle_skill.mbe" / "000_battle_skill_list.csv"
            skills_file = self._resolve_prefixed_file(skills_file)
            if not skills_file.exists():
                return
            
            rows = self.loader.load_csv(skills_file)
            
            for row in rows[1:]:  # Skip header
                if len(row) > 4:
                    skill_id = int(row[0]) if row[0] else 0
                    skill_name_id = row[4].strip('"') if len(row) > 4 else ""
                    
                    # Get skill name
                    skill_name = self.loader.get_skill_name(skill_id)
                    if not skill_name or skill_name == str(skill_id) or skill_name.startswith("Skill_"):
                        skill_name = skill_name_id if skill_name_id else f"Skill {skill_id}"
                    
                    # Create list item
                    item = QListWidgetItem(f"{skill_name} (ID: {skill_id})")
                    item.setData(Qt.ItemDataRole.UserRole, skill_id)
                    skill_list.addItem(item)
        except Exception as e:
            print(f"Error loading skills: {e}")
    
    def _add_skill_to_editor(self, skill_type: str, skill_id: int):
        """Add a skill to the appropriate editor"""
        editor = self.signature_skills_editor if skill_type == "signature" else self.generic_skills_editor
        
        # Find first empty slot
        for i, skill_widget in enumerate(editor.skill_widgets):
            skill_id_widget = skill_widget.findChild(QSpinBox, f"skill_id_{i}")
            if skill_id_widget and skill_id_widget.value() == 0:
                skill_id_widget.setValue(skill_id)
                editor.update_skill_name(i)
                self.mark_as_modified()
                QMessageBox.information(self, "Skill Added", f"Skill {skill_id} added to slot {i+1}")
                return
        
        # No empty slots found
        max_slots = 12 if skill_type == "signature" else 4
        QMessageBox.warning(self, "No Empty Slots", f"All {max_slots} {skill_type} skill slots are filled.\nClear a slot first by setting its ID to 0.")
    
    def create_model_tab(self) -> QWidget:
        """Create model and animation tab"""
        tab = QWidget()
        
        # Use scroll area for the tab content
        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setFrameShape(QFrame.Shape.NoFrame)
        
        scroll_content = QWidget()
        layout = QVBoxLayout(scroll_content)
        
        # Model Info Group
        model_group = QGroupBox("Model Information")
        model_layout = QGridLayout(model_group)
        
        # Model ID
        model_layout.addWidget(QLabel("Model ID:"), 0, 0)
        self.model_id_edit = QLineEdit()
        model_layout.addWidget(self.model_id_edit, 0, 1)
        
        # Audio ID (motion_ref in char_info)
        model_layout.addWidget(QLabel("Audio ID:"), 1, 0)
        self.motion_id_edit = QLineEdit()
        model_layout.addWidget(self.motion_id_edit, 1, 1)
        
        # Animation Reference (chr_id used for animations)
        model_layout.addWidget(QLabel("Animation Reference:"), 2, 0)
        self.animation_ref_edit = QLineEdit()
        self.animation_ref_edit.setPlaceholderText("e.g., chr805 (which model's animations to use)")
        model_layout.addWidget(self.animation_ref_edit, 2, 1)
        
        # Add explanation label
        anim_note = QLabel("💡 This determines which chr_id's animations this Digimon uses.\nSet to same as Chr ID in Basic Info (e.g., chr805 for Darkshadow)")
        anim_note.setStyleSheet("color: #666; font-size: 9pt; font-style: italic;")
        anim_note.setWordWrap(True)
        model_layout.addWidget(anim_note, 3, 0, 1, 2)
        
        layout.addWidget(model_group)
        
        # Model Settings Group (from model_setting.mbe)
        settings_group = QGroupBox("Model Settings (model_setting.mbe)")
        settings_layout = QGridLayout(settings_group)
        
        # Scale settings
        settings_layout.addWidget(QLabel("<b>Scale Settings</b>"), 0, 0, 1, 4)
        
        settings_layout.addWidget(QLabel("Battle Scale:"), 1, 0)
        self.battle_scale_spin = QDoubleSpinBox()
        self.battle_scale_spin.setRange(0.0, 100.0)
        self.battle_scale_spin.setDecimals(3)
        self.battle_scale_spin.setSingleStep(0.1)
        self.battle_scale_spin.setValue(1.0)
        settings_layout.addWidget(self.battle_scale_spin, 1, 1)
        
        settings_layout.addWidget(QLabel("Menu Scale:"), 1, 2)
        self.menu_scale_spin = QDoubleSpinBox()
        self.menu_scale_spin.setRange(0.0, 100.0)
        self.menu_scale_spin.setDecimals(3)
        self.menu_scale_spin.setSingleStep(0.1)
        self.menu_scale_spin.setValue(1.0)
        settings_layout.addWidget(self.menu_scale_spin, 1, 3)
        
        settings_layout.addWidget(QLabel("Field Scale:"), 2, 0)
        self.field_scale_spin = QDoubleSpinBox()
        self.field_scale_spin.setRange(0.0, 100.0)
        self.field_scale_spin.setDecimals(3)
        self.field_scale_spin.setSingleStep(0.1)
        self.field_scale_spin.setValue(1.0)
        settings_layout.addWidget(self.field_scale_spin, 2, 1)
        
        # Collision and Shield
        settings_layout.addWidget(QLabel("<b>Collision & Shield</b>"), 3, 0, 1, 4)
        
        settings_layout.addWidget(QLabel("NPC Collision:"), 4, 0)
        self.npc_collision_spin = QDoubleSpinBox()
        self.npc_collision_spin.setRange(0.0, 1000.0)
        self.npc_collision_spin.setDecimals(3)
        self.npc_collision_spin.setSingleStep(0.1)
        settings_layout.addWidget(self.npc_collision_spin, 4, 1)
        
        settings_layout.addWidget(QLabel("Shield Size:"), 4, 2)
        self.shield_size_spin = QDoubleSpinBox()
        self.shield_size_spin.setRange(0.0, 1000.0)
        self.shield_size_spin.setDecimals(3)
        self.shield_size_spin.setSingleStep(0.1)
        settings_layout.addWidget(self.shield_size_spin, 4, 3)
        
        # Distance settings
        settings_layout.addWidget(QLabel("<b>Distance Settings</b>"), 5, 0, 1, 4)
        
        settings_layout.addWidget(QLabel("Agent Distance:"), 6, 0)
        self.agent_distance_spin = QSpinBox()
        self.agent_distance_spin.setRange(0, 99999)
        settings_layout.addWidget(self.agent_distance_spin, 6, 1)
        
        settings_layout.addWidget(QLabel("Agent Distance 2:"), 6, 2)
        self.agent_distance_2_spin = QDoubleSpinBox()
        self.agent_distance_2_spin.setRange(0.0, 1000.0)
        self.agent_distance_2_spin.setDecimals(3)
        self.agent_distance_2_spin.setSingleStep(0.1)
        settings_layout.addWidget(self.agent_distance_2_spin, 6, 3)
        
        settings_layout.addWidget(QLabel("Digimon Distance from Agent:"), 7, 0)
        self.digimon_distance_spin = QDoubleSpinBox()
        self.digimon_distance_spin.setRange(0.0, 1000.0)
        self.digimon_distance_spin.setDecimals(3)
        self.digimon_distance_spin.setSingleStep(0.1)
        settings_layout.addWidget(self.digimon_distance_spin, 7, 1)
        
        settings_layout.addWidget(QLabel("Camera Distance (Skill):"), 7, 2)
        self.camera_distance_skill_spin = QDoubleSpinBox()
        self.camera_distance_skill_spin.setRange(0.0, 1000.0)
        self.camera_distance_skill_spin.setDecimals(3)
        self.camera_distance_skill_spin.setSingleStep(0.1)
        self.camera_distance_skill_spin.setToolTip("Camera distance when selecting a skill (camera faces front of digimon)")
        settings_layout.addWidget(self.camera_distance_skill_spin, 7, 3)
        
        # Rideable checkbox
        settings_layout.addWidget(QLabel("<b>Other Settings</b>"), 8, 0, 1, 4)
        
        self.rideable_checkbox = QCheckBox("Rideable")
        self.rideable_checkbox.setToolTip("Enable/disable if this Digimon can be ridden")
        settings_layout.addWidget(self.rideable_checkbox, 9, 0, 1, 2)
        
        layout.addWidget(settings_group)
        
        # LOD Data Group
        lod_group = QGroupBox("LOD (Level of Detail) Data")
        lod_layout = QGridLayout(lod_group)
        
        # LOD distances
        self.lod_widgets = {}
        for i in range(1, 4):
            lod_layout.addWidget(QLabel(f"LOD Distance {i}:"), i-1, 0)
            spin = QSpinBox()
            spin.setRange(0, 1000)
            self.lod_widgets[f"lod_distance_{i}"] = spin
            lod_layout.addWidget(spin, i-1, 1)
        
        layout.addWidget(lod_group)
        
        # References Group
        ref_group = QGroupBox("References")
        ref_layout = QGridLayout(ref_group)
        
        # Field Guide ID
        ref_layout.addWidget(QLabel("Field Guide ID:"), 0, 0)
        self.field_guide_id_spin = QSpinBox()
        self.field_guide_id_spin.setRange(-1, 99999)
        self.field_guide_id_spin.setValue(-1)
        ref_layout.addWidget(self.field_guide_id_spin, 0, 1)
        
        # Script ID
        ref_layout.addWidget(QLabel("Script ID:"), 1, 0)
        self.script_id_spin = QSpinBox()
        self.script_id_spin.setRange(-1, 99999)
        self.script_id_spin.setValue(-1)
        ref_layout.addWidget(self.script_id_spin, 1, 1)
        
        layout.addWidget(ref_group)
        layout.addStretch()
        
        scroll.setWidget(scroll_content)
        
        # Main tab layout
        tab_layout = QVBoxLayout(tab)
        tab_layout.setContentsMargins(0, 0, 0, 0)
        tab_layout.addWidget(scroll)
        
        return tab
    
    def create_files_tab(self) -> QWidget:
        """Create files information tab showing all 12 required files"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        
        # Title
        title = QLabel("Complete Digimon Files (9 Required)")
        title.setFont(QFont("Arial", 14, QFont.Weight.Bold))
        layout.addWidget(title)
        
        # Info text
        info_text = QLabel("A complete Digimon requires data in all 9 files below:")
        info_text.setStyleSheet("color: #666; font-style: italic;")
        layout.addWidget(info_text)
        
        # Files status table
        self.files_table = QTableWidget()
        self.files_table.setColumnCount(3)
        self.files_table.setHorizontalHeaderLabels(["File", "Status", "Data Count"])
        self.files_table.horizontalHeader().setStretchLastSection(True)
        self.files_table.setRowCount(9)
        
        # Set up the 9 required files
        required_files = [
            "digimon_status.mbe/00_digimon_status_data.csv",
            "char_info.mbe/00_char_info.csv", 
            "text/char_name.mbe/00_Sheet1.csv",
            "model_setting.mbe/00_model_setting.csv",
            "model_locator.mbe/00_model_locator.csv",
            "model_locator.mbe/01_model_locator_motion.csv",
            "lod_chara.mbe/00_lod.csv",
            "lod_chara.mbe/01_lod_model.csv",
            "field_anime.mbe/00_field_move_animation.csv"
        ]
        
        for i, file_name in enumerate(required_files):
            self.files_table.setItem(i, 0, QTableWidgetItem(file_name))
            self.files_table.setItem(i, 1, QTableWidgetItem("Not Loaded"))
            self.files_table.setItem(i, 2, QTableWidgetItem("0"))
        
        layout.addWidget(self.files_table)
        
        # Export info
        export_info = QGroupBox("Export Information")
        export_layout = QVBoxLayout(export_info)
        
        export_text = QLabel("When you export a Digimon, all 9 files will be created/updated with the complete data.")
        export_text.setWordWrap(True)
        export_layout.addWidget(export_text)
        
        self.export_status_label = QLabel("Status: Ready to export")
        self.export_status_label.setStyleSheet("font-weight: bold; color: green;")
        export_layout.addWidget(self.export_status_label)
        
        layout.addWidget(export_info)
        
        return tab
    
    def create_advanced_skills_tab(self) -> QWidget:
        """Create advanced skills tab with detailed skill system"""
        tab = QWidget()
        main_layout = QVBoxLayout(tab)
        main_layout.setContentsMargins(0, 0, 0, 0)
        
        # Create scroll area for all content
        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setHorizontalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAsNeeded)
        scroll.setVerticalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAsNeeded)
        
        scroll_content = QWidget()
        layout = QVBoxLayout(scroll_content)
        layout.setSpacing(15)
        layout.setContentsMargins(10, 10, 10, 10)
        
        # Title with modern styling
        title = QLabel("🎯 Advanced Skill System Editor")
        title.setFont(QFont("Segoe UI", 14, QFont.Weight.Bold))
        title.setStyleSheet("""
            QLabel {
                color: white;
                padding: 15px;
                background: qlineargradient(x1:0, y1:0, x2:1, y2:0,
                    stop:0 #667eea, stop:1 #764ba2);
                border-radius: 8px;
                border: none;
            }
        """)
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)
        layout.addWidget(title)
        
        # Skill selection
        skill_selection_group = QGroupBox("🔍 Skill Selection")
        skill_selection_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #667eea;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 15px;
                background-color: white;
                font-size: 11pt;
            }
            QGroupBox::title {
                color: #667eea;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
        """)
        skill_selection_layout = QHBoxLayout(skill_selection_group)
        skill_selection_layout.setSpacing(15)
        
        skill_id_label = QLabel("🆔 Skill ID:")
        skill_id_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        skill_selection_layout.addWidget(skill_id_label)
        
        self.advanced_skill_id_edit = QSpinBox()
        self.advanced_skill_id_edit.setRange(0, 99999)
        self.advanced_skill_id_edit.setMinimumWidth(150)
        self.advanced_skill_id_edit.valueChanged.connect(self.update_advanced_skill_display)
        skill_selection_layout.addWidget(self.advanced_skill_id_edit)
        
        skill_selection_layout.addSpacing(20)
        
        skill_name_prefix = QLabel("📝 Skill Name:")
        skill_name_prefix.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        skill_selection_layout.addWidget(skill_name_prefix)
        
        self.advanced_skill_name_edit = QLineEdit()
        self.advanced_skill_name_edit.setPlaceholderText("(No skill selected)")
        self.advanced_skill_name_edit.setMinimumWidth(250)
        self.advanced_skill_name_edit.setStyleSheet("""
            QLineEdit {
                font-weight: bold;
                color: #667eea;
                font-size: 11pt;
                border: 2px solid #dee2e6;
                border-radius: 6px;
                padding: 6px;
            }
            QLineEdit:focus {
                border-color: #667eea;
            }
        """)
        skill_selection_layout.addWidget(self.advanced_skill_name_edit)
        
        skill_selection_layout.addStretch()
        layout.addWidget(skill_selection_group)
        
        # Skill description preview (read-only)
        desc_group = QGroupBox("🧾 Skill Description (read-only)")
        desc_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #c9d6ff;
                border-radius: 8px;
                margin-top: 8px;
                padding-top: 12px;
                background-color: white;
                font-size: 10pt;
            }
            QGroupBox::title {
                color: #667eea;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
        """)
        desc_layout = QVBoxLayout(desc_group)
        self.advanced_skill_desc = QPlainTextEdit()
        self.advanced_skill_desc.setReadOnly(True)
        self.advanced_skill_desc.setPlaceholderText("No description for this skill")
        self.advanced_skill_desc.setMaximumHeight(90)
        desc_layout.addWidget(self.advanced_skill_desc)
        layout.addWidget(desc_group)
        
        # Skill Browser
        browser_group = QGroupBox("📚 Skill Browser")
        browser_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #8fd3f4;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 15px;
                background-color: white;
                font-size: 11pt;
            }
            QGroupBox::title {
                color: #4aa3c7;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
        """)
        browser_layout = QVBoxLayout(browser_group)
        browser_layout.setSpacing(10)
        
        # Search box for skills
        search_layout = QHBoxLayout()
        search_icon = QLabel("🔍")
        search_icon.setFont(QFont("Segoe UI", 10))
        search_layout.addWidget(search_icon)
        
        self.skill_search_box = QLineEdit()
        self.skill_search_box.setPlaceholderText("Search skills by name or ID...")
        self.skill_search_box.setStyleSheet("""
            QLineEdit {
                border: 2px solid #dee2e6;
                border-radius: 6px;
                padding: 8px;
                font-size: 10pt;
            }
            QLineEdit:focus {
                border-color: #8fd3f4;
            }
        """)
        self.skill_search_box.textChanged.connect(self.filter_skill_list)
        search_layout.addWidget(self.skill_search_box)
        browser_layout.addLayout(search_layout)
        
        # Skills list
        self.skill_browser_list = QListWidget()
        self.skill_browser_list.setStyleSheet("""
            QListWidget {
                border: 2px solid #dee2e6;
                border-radius: 6px;
                padding: 5px;
                background-color: white;
                font-size: 10pt;
                color: #333333;
            }
            QListWidget::item {
                padding: 8px;
                margin: 2px;
                border-radius: 4px;
                color: #333333;
            }
            QListWidget::item:hover {
                background-color: #e7f5ff;
                color: #333333;
            }
            QListWidget::item:selected {
                background: qlineargradient(x1:0, y1:0, x2:1, y2:0,
                    stop:0 #8fd3f4, stop:1 #84fab0);
                color: white;
                font-weight: bold;
            }
        """)
        self.skill_browser_list.setMaximumHeight(200)
        self.skill_browser_list.itemDoubleClicked.connect(self.load_skill_from_browser)
        browser_layout.addWidget(self.skill_browser_list)
        
        # Populate skill list
        self.populate_skill_browser()
        
        layout.addWidget(browser_group)
        
        # Basic skill properties
        basic_group = QGroupBox("📊 Basic Properties")
        basic_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #84fab0;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 15px;
                background-color: white;
                font-size: 11pt;
            }
            QGroupBox::title {
                color: #2c9558;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
        """)
        basic_layout = QFormLayout(basic_group)
        basic_layout.setSpacing(12)
        basic_layout.setLabelAlignment(Qt.AlignmentFlag.AlignRight)
        basic_layout.setFieldGrowthPolicy(QFormLayout.FieldGrowthPolicy.ExpandingFieldsGrow)
        
        power_label = QLabel("⚡ Power:")
        power_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        power_label.setMinimumWidth(180)
        self.skill_power_edit = QSpinBox()
        self.skill_power_edit.setRange(0, 9999)
        self.skill_power_edit.setMinimumWidth(150)
        basic_layout.addRow(power_label, self.skill_power_edit)
        
        sp_label = QLabel("💧 SP Cost:")
        sp_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        sp_label.setMinimumWidth(180)
        self.skill_sp_cost_edit = QSpinBox()
        self.skill_sp_cost_edit.setRange(0, 999)
        self.skill_sp_cost_edit.setMinimumWidth(150)
        basic_layout.addRow(sp_label, self.skill_sp_cost_edit)
        
        cp_label = QLabel("⚙️ CP Cost:")
        cp_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        cp_label.setMinimumWidth(180)
        self.skill_cp_cost_edit = QSpinBox()
        self.skill_cp_cost_edit.setRange(0, 9999)
        self.skill_cp_cost_edit.setMinimumWidth(150)
        basic_layout.addRow(cp_label, self.skill_cp_cost_edit)
        
        anim_label = QLabel("🎞️ Animation/Action ID:")
        anim_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        anim_label.setMinimumWidth(180)
        self.skill_animation_id_edit = QSpinBox()
        self.skill_animation_id_edit.setRange(0, 999999)
        self.skill_animation_id_edit.setMinimumWidth(150)
        basic_layout.addRow(anim_label, self.skill_animation_id_edit)
        
        effect_label = QLabel("✨ Effect ID:")
        effect_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        effect_label.setMinimumWidth(180)
        self.skill_effect_id_edit = QSpinBox()
        self.skill_effect_id_edit.setRange(0, 999999)
        self.skill_effect_id_edit.setMinimumWidth(150)
        basic_layout.addRow(effect_label, self.skill_effect_id_edit)
        
        accuracy_label = QLabel("🎯 Accuracy:")
        accuracy_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        accuracy_label.setMinimumWidth(180)
        self.skill_accuracy_edit = QSpinBox()
        self.skill_accuracy_edit.setRange(0, 100)
        self.skill_accuracy_edit.setMinimumWidth(150)
        basic_layout.addRow(accuracy_label, self.skill_accuracy_edit)
        
        crit_label = QLabel("💥 Critical Rate:")
        crit_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        crit_label.setMinimumWidth(180)
        self.skill_crit_rate_edit = QSpinBox()
        self.skill_crit_rate_edit.setRange(0, 100)
        self.skill_crit_rate_edit.setMinimumWidth(150)
        basic_layout.addRow(crit_label, self.skill_crit_rate_edit)
        
        layout.addWidget(basic_group)
        
        # Damage and targeting
        damage_group = QGroupBox("🎯 Damage & Targeting")
        damage_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #fa709a;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 15px;
                background-color: white;
                font-size: 11pt;
            }
            QGroupBox::title {
                color: #e85c89;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
        """)
        damage_layout = QFormLayout(damage_group)
        damage_layout.setSpacing(12)
        damage_layout.setLabelAlignment(Qt.AlignmentFlag.AlignRight)
        damage_layout.setFieldGrowthPolicy(QFormLayout.FieldGrowthPolicy.ExpandingFieldsGrow)
        
        dtype_label = QLabel("💢 Damage Type:")
        dtype_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        dtype_label.setMinimumWidth(180)
        self.skill_damage_type_combo = QComboBox()
        damage_types = ["None/Self", "Physical", "Magic", "Fixed damage at", "Fixed %", "Buff", "Major Damage"]
        self.skill_damage_type_combo.addItems(damage_types)
        self.skill_damage_type_combo.setMinimumWidth(200)
        damage_layout.addRow(dtype_label, self.skill_damage_type_combo)
        
        element_label = QLabel("🔥 Element:")
        element_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        element_label.setMinimumWidth(180)
        self.skill_element_combo = QComboBox()
        for i in range(11):  # Elements 0-10
            element_name = self.loader.get_element_name(i)
            clean_name = self.loader.clean_ui_text(element_name)
            self.skill_element_combo.addItem(clean_name, i)
        self.skill_element_combo.setMinimumWidth(200)
        damage_layout.addRow(element_label, self.skill_element_combo)
        
        min_hits_label = QLabel("🎲 Min Hits:")
        min_hits_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        min_hits_label.setMinimumWidth(180)
        self.skill_min_hits_edit = QSpinBox()
        self.skill_min_hits_edit.setRange(1, 10)
        self.skill_min_hits_edit.setMinimumWidth(150)
        damage_layout.addRow(min_hits_label, self.skill_min_hits_edit)
        
        max_hits_label = QLabel("🎲 Max Hits:")
        max_hits_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        max_hits_label.setMinimumWidth(180)
        self.skill_max_hits_edit = QSpinBox()
        self.skill_max_hits_edit.setRange(1, 10)
        self.skill_max_hits_edit.setMinimumWidth(150)
        damage_layout.addRow(max_hits_label, self.skill_max_hits_edit)
        
        layout.addWidget(damage_group)
        
        # Mode change / Jogress
        mode_group = QGroupBox("🔀 Mode Change & Jogress")
        mode_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #ffd166;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 15px;
                background-color: white;
                font-size: 11pt;
            }
            QGroupBox::title {
                color: #c77d00;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
        """)
        mode_layout = QFormLayout(mode_group)
        mode_layout.setSpacing(10)
        mode_layout.setLabelAlignment(Qt.AlignmentFlag.AlignRight)
        
        mode_change_label = QLabel("🔁 Mode Change ID:")
        mode_change_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        mode_change_label.setMinimumWidth(180)
        self.skill_mode_change_edit = QSpinBox()
        self.skill_mode_change_edit.setRange(0, 999999)
        self.skill_mode_change_edit.setMinimumWidth(150)
        mode_layout.addRow(mode_change_label, self.skill_mode_change_edit)
        
        jogress_skill_label = QLabel("🧬 Jogress Skill ID:")
        jogress_skill_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        jogress_skill_label.setMinimumWidth(180)
        self.skill_jogress_skill_edit = QSpinBox()
        self.skill_jogress_skill_edit.setRange(0, 999999)
        self.skill_jogress_skill_edit.setMinimumWidth(150)
        mode_layout.addRow(jogress_skill_label, self.skill_jogress_skill_edit)
        
        jogress_p1_label = QLabel("🤝 Jogress Partner 1 ID:")
        jogress_p1_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        jogress_p1_label.setMinimumWidth(180)
        self.skill_jogress_p1_edit = QSpinBox()
        self.skill_jogress_p1_edit.setRange(0, 999999)
        self.skill_jogress_p1_edit.setMinimumWidth(150)
        mode_layout.addRow(jogress_p1_label, self.skill_jogress_p1_edit)
        
        jogress_p2_label = QLabel("🤝 Jogress Partner 2 ID:")
        jogress_p2_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        jogress_p2_label.setMinimumWidth(180)
        self.skill_jogress_p2_edit = QSpinBox()
        self.skill_jogress_p2_edit.setRange(0, 999999)
        self.skill_jogress_p2_edit.setMinimumWidth(150)
        mode_layout.addRow(jogress_p2_label, self.skill_jogress_p2_edit)
        
        layout.addWidget(mode_group)
        
        # Advanced properties
        advanced_group = QGroupBox("⚙️ Advanced Properties")
        advanced_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #f093fb;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 15px;
                background-color: white;
                font-size: 11pt;
            }
            QGroupBox::title {
                color: #c967cc;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
        """)
        advanced_layout = QFormLayout(advanced_group)
        advanced_layout.setSpacing(12)
        advanced_layout.setLabelAlignment(Qt.AlignmentFlag.AlignRight)
        advanced_layout.setFieldGrowthPolicy(QFormLayout.FieldGrowthPolicy.ExpandingFieldsGrow)
        
        prop1_label = QLabel("🔧 Additional Property 1:")
        prop1_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        prop1_label.setMinimumWidth(220)
        self.skill_additional_prop1_combo = QComboBox()
        additional_props = [
            "None", "Lower HP = Higher damage", "Lower allies HP = Higher damage",
            "Lower HP = Lower damage", "Lower allies HP = Lower damage",
            "Lower SP = Higher damage", "Lower allies SP = Higher damage",
            "Lower SP = Lower damage", "Lower allies SP = Lower damage",
            "More KO'd = Higher damage", "More allies KO'd = Higher damage",
            "More uses = Higher damage", "More rounds = Higher damage",
            "More buffs = Higher damage"
        ]
        self.skill_additional_prop1_combo.addItems(additional_props)
        self.skill_additional_prop1_combo.setMinimumWidth(300)
        advanced_layout.addRow(prop1_label, self.skill_additional_prop1_combo)
        
        prop2_label = QLabel("🔧 Additional Property 2:")
        prop2_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        prop2_label.setMinimumWidth(220)
        self.skill_additional_prop2_combo = QComboBox()
        additional_effects = [
            "None", "No Effect", "Nullifies unfavorable compatibility",
            "Inverts stat changes", "Steals stat changes", "Recovers beyond Max HP",
            "Consumes all SP", "Nullifies attribute compatibility",
            "Attack as Vaccine", "Attack as Data", "Attack as Virus",
            "Attack as Free", "Attack as Variable"
        ]
        self.skill_additional_prop2_combo.addItems(additional_effects)
        self.skill_additional_prop2_combo.setMinimumWidth(300)
        advanced_layout.addRow(prop2_label, self.skill_additional_prop2_combo)
        
        layout.addWidget(advanced_group)
        
        # Conditional effects
        conditional_group = QGroupBox("🔀 Conditional Effects")
        conditional_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #8fd3f4;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 15px;
                background-color: white;
                font-size: 11pt;
            }
            QGroupBox::title {
                color: #4aa3c7;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
        """)
        conditional_layout = QFormLayout(conditional_group)
        conditional_layout.setSpacing(12)
        conditional_layout.setLabelAlignment(Qt.AlignmentFlag.AlignRight)
        conditional_layout.setFieldGrowthPolicy(QFormLayout.FieldGrowthPolicy.ExpandingFieldsGrow)
        
        cond_type_label = QLabel("❓ Conditional Type:")
        cond_type_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        cond_type_label.setMinimumWidth(220)
        self.skill_conditional_type_combo = QComboBox()
        conditional_types = [
            "None", "User has (de)buff", "Target has (de)buff", "Target attribute",
            "Target element", "Target higher generation", "Target lower generation",
            "Target acted", "Target hasn't acted", "Target HP ≥ 50%",
            "Target HP ≤ X%", "Target SP ≥ X%", "Target SP ≤ X%", "Target KO'd"
        ]
        self.skill_conditional_type_combo.addItems(conditional_types)
        self.skill_conditional_type_combo.setMinimumWidth(300)
        conditional_layout.addRow(cond_type_label, self.skill_conditional_type_combo)
        
        cond_effect_label = QLabel("✨ Conditional Effect:")
        cond_effect_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        cond_effect_label.setMinimumWidth(220)
        self.skill_conditional_effect_combo = QComboBox()
        conditional_effects = [
            "None", "+X% damage", "Increased Damage", "CRT Rate up",
            "Restore HP", "Restore SP", "Restore SP/HP", "Reduce Target SP"
        ]
        self.skill_conditional_effect_combo.addItems(conditional_effects)
        self.skill_conditional_effect_combo.setMinimumWidth(300)
        conditional_layout.addRow(cond_effect_label, self.skill_conditional_effect_combo)
        
        cond_arg_label = QLabel("📊 Conditional Argument:")
        cond_arg_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        cond_arg_label.setMinimumWidth(220)
        self.skill_conditional_arg_edit = QSpinBox()
        self.skill_conditional_arg_edit.setRange(0, 100)
        self.skill_conditional_arg_edit.setMinimumWidth(150)
        conditional_layout.addRow(cond_arg_label, self.skill_conditional_arg_edit)
        
        layout.addWidget(conditional_group)
        
        # Buff sets
        buff_group = QGroupBox("✨ Buff Sets (up to 5)")
        buff_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #fee140;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 15px;
                background-color: white;
                font-size: 11pt;
            }
            QGroupBox::title {
                color: #d9b12f;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
        """)
        buff_layout = QVBoxLayout(buff_group)
        buff_layout.setSpacing(8)
        
        self.buff_set_widgets = []
        self.buff_name_labels = []
        buff_icons = ["1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣"]
        for i in range(5):
            buff_widget = QWidget()
            buff_widget_layout = QHBoxLayout(buff_widget)
            buff_widget_layout.setSpacing(10)
            
            buff_label = QLabel(f"{buff_icons[i]} Buff Set {i+1}:")
            buff_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
            buff_label.setMinimumWidth(120)
            buff_widget_layout.addWidget(buff_label)
            
            buff_set_edit = QSpinBox()
            buff_set_edit.setRange(0, 9999)
            buff_set_edit.setObjectName(f"buff_set_{i}")
            buff_set_edit.setMinimumWidth(100)
            buff_widget_layout.addWidget(buff_set_edit)
            
            # Add label to show buff name
            buff_name_label = QLabel("")
            buff_name_label.setObjectName(f"buff_name_{i}")
            buff_name_label.setStyleSheet("""
                QLabel {
                    color: #667eea;
                    font-weight: bold;
                    font-size: 10pt;
                    padding: 5px 10px;
                    background-color: #e7f5ff;
                    border-radius: 4px;
                    border-left: 3px solid #667eea;
                }
            """)
            buff_name_label.setMinimumWidth(200)
            buff_widget_layout.addWidget(buff_name_label)
            self.buff_name_labels.append(buff_name_label)
            
            # Connect to update buff name when value changes
            buff_set_edit.valueChanged.connect(lambda v, idx=i: self.update_buff_name_display(idx, v))
            
            buff_widget_layout.addStretch()
            
            self.buff_set_widgets.append(buff_set_edit)
            buff_layout.addWidget(buff_widget)
        
        layout.addWidget(buff_group)
        
        # Special effects
        special_group = QGroupBox("💫 Special Effects")
        special_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #a18cd1;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 15px;
                background-color: white;
                font-size: 11pt;
            }
            QGroupBox::title {
                color: #7d6aad;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
        """)
        special_layout = QFormLayout(special_group)
        special_layout.setSpacing(12)
        special_layout.setLabelAlignment(Qt.AlignmentFlag.AlignRight)
        special_layout.setFieldGrowthPolicy(QFormLayout.FieldGrowthPolicy.ExpandingFieldsGrow)
        
        hp_drain_label = QLabel("🩸 HP Drain %:")
        hp_drain_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        hp_drain_label.setMinimumWidth(180)
        self.skill_hp_drain_edit = QSpinBox()
        self.skill_hp_drain_edit.setRange(0, 100)
        self.skill_hp_drain_edit.setMinimumWidth(150)
        special_layout.addRow(hp_drain_label, self.skill_hp_drain_edit)
        
        sp_drain_label = QLabel("💙 SP Drain %:")
        sp_drain_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        sp_drain_label.setMinimumWidth(180)
        self.skill_sp_drain_edit = QSpinBox()
        self.skill_sp_drain_edit.setRange(0, 100)
        self.skill_sp_drain_edit.setMinimumWidth(150)
        special_layout.addRow(sp_drain_label, self.skill_sp_drain_edit)
        
        recoil_label = QLabel("💥 Recoil %:")
        recoil_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        recoil_label.setMinimumWidth(180)
        self.skill_recoil_edit = QSpinBox()
        self.skill_recoil_edit.setRange(0, 100)
        self.skill_recoil_edit.setMinimumWidth(150)
        special_layout.addRow(recoil_label, self.skill_recoil_edit)
        
        always_hits_label = QLabel("🎯 Special:")
        always_hits_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        always_hits_label.setMinimumWidth(180)
        self.skill_always_hits_check = QCheckBox("Always Hits")
        self.skill_always_hits_check.setFont(QFont("Segoe UI", 10))
        special_layout.addRow(always_hits_label, self.skill_always_hits_check)
        
        layout.addWidget(special_group)
        
        # Save button with modern styling
        save_skill_button = QPushButton("💾 Save Skill Data")
        save_skill_button.clicked.connect(self.save_advanced_skill)
        save_skill_button.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #f093fb, stop:1 #f5576c);
                color: white;
                border: none;
                border-radius: 8px;
                padding: 15px;
                font-weight: bold;
                font-size: 12pt;
                margin-top: 10px;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #de7fe9, stop:1 #e34556);
            }
            QPushButton:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #cd6fd7, stop:1 #d13443);
            }
        """)
        layout.addWidget(save_skill_button)
        
        layout.addStretch()
        
        # Set the scroll content and add to main layout
        scroll.setWidget(scroll_content)
        main_layout.addWidget(scroll)
        
        return tab
    
    def create_evolution_tab(self) -> QWidget:
        """Create evolution management tab - matching wizard layout"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        layout.setSpacing(15)
        
        # Title
        title = QLabel("🔄 Evolution Management")
        title.setFont(QFont("Segoe UI", 16, QFont.Weight.Bold))
        title.setStyleSheet("""
            QLabel {
                color: #667eea;
                padding: 15px;
                background: qlineargradient(x1:0, y1:0, x2:1, y2:0,
                    stop:0 #f8f9fa, stop:1 #e9ecef);
                border-radius: 8px;
                border: 2px solid #dee2e6;
            }
        """)
        layout.addWidget(title)
        
        # Instructions
        info_label = QLabel(
            "First, set the requirements needed to evolve INTO this Digimon.\n"
            "Then configure evolution paths (what this Digimon can evolve into) and view pre-evolutions."
        )
        info_label.setWordWrap(True)
        info_label.setStyleSheet("color: #666; padding: 10px; background-color: #f8f9fa; border-radius: 6px;")
        layout.addWidget(info_label)
        
        # Evolution Requirements section (for obtaining THIS Digimon)
        req_group = QGroupBox("⭐ Requirements to Obtain This Digimon")
        req_group.setStyleSheet("QGroupBox { font-weight: bold; font-size: 11pt; }")
        req_layout = QVBoxLayout()
        
        req_info = QLabel(
            "These are the requirements that other Digimon must meet to evolve INTO this Digimon.\n"
            "Leave values at 0 for no requirement."
        )
        req_info.setWordWrap(True)
        req_info.setStyleSheet("color: #555; font-size: 10pt; font-weight: normal;")
        req_layout.addWidget(req_info)
        
        edit_req_btn = QPushButton("📝 Edit Requirements")
        edit_req_btn.setStyleSheet("padding: 8px; font-size: 11pt;")
        edit_req_btn.clicked.connect(self.edit_evolution_requirements)
        req_layout.addWidget(edit_req_btn)
        
        self.requirements_label = QLabel("Mode: No Requirements (default)")
        self.requirements_label.setStyleSheet("color: #666; padding: 5px; background: #f0f0f0; border-radius: 3px;")
        self.requirements_label.setWordWrap(True)
        req_layout.addWidget(self.requirements_label)
        
        req_group.setLayout(req_layout)
        layout.addWidget(req_group)
        
        # Evolution paths section
        evo_group = QGroupBox("➡️ Evolution Paths (What this Digimon evolves into)")
        evo_group.setStyleSheet("QGroupBox { font-weight: bold; font-size: 11pt; }")
        evo_layout = QVBoxLayout()
        
        evo_buttons = QHBoxLayout()
        add_evo_btn = QPushButton("➕ Add Evolution")
        add_evo_btn.setStyleSheet("padding: 8px; font-size: 11pt;")
        add_evo_btn.clicked.connect(self.add_evolution)
        remove_evo_btn = QPushButton("➖ Remove Selected")
        remove_evo_btn.setStyleSheet("padding: 8px; font-size: 11pt;")
        remove_evo_btn.clicked.connect(self.remove_evolution)
        evo_buttons.addWidget(add_evo_btn)
        evo_buttons.addWidget(remove_evo_btn)
        evo_buttons.addStretch()
        evo_layout.addLayout(evo_buttons)
        
        self.evolution_list = QListWidget()
        self.evolution_list.setMinimumHeight(150)
        self.evolution_list.setStyleSheet("""
            QListWidget {
                border: 1px solid #ddd;
                border-radius: 6px;
                padding: 5px;
                background-color: white;
            }
            QListWidget::item {
                padding: 8px;
                border-radius: 4px;
                margin: 2px;
            }
            QListWidget::item:selected {
                background-color: #84fab0;
                color: #1a1a1a;
            }
            QListWidget::item:hover {
                background-color: #e8f5e9;
            }
        """)
        evo_layout.addWidget(self.evolution_list)
        evo_group.setLayout(evo_layout)
        layout.addWidget(evo_group)
        
        # Pre-evolution section
        deevo_group = QGroupBox("⬅️ Pre-Evolutions (Digimon that evolve INTO this one)")
        deevo_group.setStyleSheet("QGroupBox { font-weight: bold; font-size: 11pt; }")
        deevo_layout = QVBoxLayout()
        
        deevo_info = QLabel(
            "💡 Adding a pre-evolution creates an evolution entry where THAT Digimon evolves into THIS one.\n"
            "⚠️ Each Digimon can only have 6 evolution targets maximum!"
        )
        deevo_info.setWordWrap(True)
        deevo_info.setStyleSheet("""
            color: #856404;
            font-size: 9pt;
            padding: 8px;
            background-color: #fff3cd;
            border-radius: 4px;
        """)
        deevo_layout.addWidget(deevo_info)
        
        # Buttons for adding/removing pre-evolutions
        deevo_buttons = QHBoxLayout()
        add_deevo_btn = QPushButton("➕ Add Pre-Evolution")
        add_deevo_btn.setStyleSheet("padding: 8px; font-size: 11pt;")
        add_deevo_btn.clicked.connect(self.add_pre_evolution)
        remove_deevo_btn = QPushButton("➖ Remove Selected")
        remove_deevo_btn.setStyleSheet("padding: 8px; font-size: 11pt;")
        remove_deevo_btn.clicked.connect(self.remove_pre_evolution)
        deevo_buttons.addWidget(add_deevo_btn)
        deevo_buttons.addWidget(remove_deevo_btn)
        deevo_buttons.addStretch()
        deevo_layout.addLayout(deevo_buttons)
        
        self.deevolution_list = QListWidget()
        self.deevolution_list.setMinimumHeight(120)
        self.deevolution_list.setStyleSheet("""
            QListWidget {
                border: 1px solid #ddd;
                border-radius: 6px;
                padding: 5px;
                background-color: white;
            }
            QListWidget::item {
                padding: 8px;
                border-radius: 4px;
                margin: 2px;
            }
            QListWidget::item:selected {
                background-color: #e1bee7;
                color: #1a1a1a;
            }
            QListWidget::item:hover {
                background-color: #f3e5f5;
            }
        """)
        deevo_layout.addWidget(self.deevolution_list)
        
        deevo_group.setLayout(deevo_layout)
        layout.addWidget(deevo_group)
        
        layout.addStretch()
        
        return tab
    
    def create_evolution_tree_tab(self) -> QWidget:
        """Create a visual evolution tree tab (like Digimon evolution chart)"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        
        # Title
        title = QLabel("🌳 Evolution Tree")
        title.setFont(QFont("Segoe UI", 16, QFont.Weight.Bold))
        title.setStyleSheet("""
            QLabel {
                color: #667eea;
                padding: 15px;
                background: qlineargradient(x1:0, y1:0, x2:1, y2:0,
                    stop:0 #f8f9fa, stop:1 #e9ecef);
                border-radius: 8px;
                border: 2px solid #dee2e6;
            }
        """)
        layout.addWidget(title)
        
        # Scroll area for the tree
        tree_scroll = QScrollArea()
        tree_scroll.setWidgetResizable(True)
        tree_scroll.setStyleSheet("""
            QScrollArea {
                border: 2px solid #667eea;
                border-radius: 8px;
                background-color: white;
            }
        """)
        
        self.evolution_tree_canvas = QWidget()
        self.evolution_tree_canvas.setMinimumSize(800, 600)
        self.evolution_tree_canvas.setStyleSheet("background-color: white;")
        
        # Add initial placeholder
        canvas_layout = QVBoxLayout(self.evolution_tree_canvas)
        canvas_layout.setContentsMargins(0, 0, 0, 0)
        placeholder = QLabel("🔍 Load a Digimon to see its evolution tree")
        placeholder.setStyleSheet("""
            QLabel {
                color: #999;
                font-size: 14pt;
                padding: 100px;
                text-align: center;
            }
        """)
        placeholder.setAlignment(Qt.AlignmentFlag.AlignCenter)
        placeholder.setWordWrap(True)
        canvas_layout.addWidget(placeholder)
        
        tree_scroll.setWidget(self.evolution_tree_canvas)
        layout.addWidget(tree_scroll)
        
        return tab
    
    def create_battle_tab(self) -> QWidget:
        """Create battle data management tab"""
        tab = QWidget()
        main_layout = QVBoxLayout(tab)
        main_layout.setContentsMargins(0, 0, 0, 0)
        
        # Create scroll area for all content
        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setHorizontalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAsNeeded)
        scroll.setVerticalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAsNeeded)
        
        scroll_content = QWidget()
        layout = QVBoxLayout(scroll_content)
        layout.setSpacing(15)
        layout.setContentsMargins(10, 10, 10, 10)
        
        # Title with modern styling
        title = QLabel("⚔️ Battle & Enemy Data")
        title.setFont(QFont("Segoe UI", 14, QFont.Weight.Bold))
        title.setStyleSheet("""
            QLabel {
                color: white;
                padding: 15px;
                background: qlineargradient(x1:0, y1:0, x2:1, y2:0,
                    stop:0 #667eea, stop:1 #764ba2);
                border-radius: 8px;
                border: none;
            }
        """)
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)
        layout.addWidget(title)
        
        # Battle enemy parameters
        enemy_group = QGroupBox("👾 Enemy Parameters (44 columns)")
        enemy_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #667eea;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 15px;
                background-color: white;
                font-size: 11pt;
            }
            QGroupBox::title {
                color: #667eea;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
        """)
        enemy_layout = QFormLayout(enemy_group)
        enemy_layout.setSpacing(12)
        enemy_layout.setLabelAlignment(Qt.AlignmentFlag.AlignRight)
        enemy_layout.setFieldGrowthPolicy(QFormLayout.FieldGrowthPolicy.ExpandingFieldsGrow)
        
        # Enemy ID
        enemy_id_label = QLabel("🆔 Enemy ID (Col 0):")
        enemy_id_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        enemy_id_label.setMinimumWidth(220)
        self.enemy_id_edit = QLineEdit()
        self.enemy_id_edit.setMinimumWidth(200)
        enemy_layout.addRow(enemy_id_label, self.enemy_id_edit)
        
        # Base Digimon ID
        base_id_label = QLabel("📌 Base Digimon ID (Col 2):")
        base_id_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        base_id_label.setMinimumWidth(220)
        self.base_digimon_id_edit = QLineEdit()
        self.base_digimon_id_edit.setMinimumWidth(200)
        enemy_layout.addRow(base_id_label, self.base_digimon_id_edit)
        
        # AI Level
        ai_level_label = QLabel("🤖 AI Level (Col 10):")
        ai_level_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        ai_level_label.setMinimumWidth(220)
        self.ai_level_edit = QSpinBox()
        self.ai_level_edit.setRange(0, 50)
        self.ai_level_edit.setMinimumWidth(150)
        enemy_layout.addRow(ai_level_label, self.ai_level_edit)
        
        # Battle stats (columns 17-23)
        hp_label = QLabel("❤️ Battle HP (Col 17):")
        hp_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        hp_label.setMinimumWidth(220)
        self.battle_hp_edit = QSpinBox()
        self.battle_hp_edit.setRange(1, 99999)
        self.battle_hp_edit.setMinimumWidth(150)
        enemy_layout.addRow(hp_label, self.battle_hp_edit)
        
        sp_label = QLabel("💙 Battle SP (Col 18):")
        sp_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        sp_label.setMinimumWidth(220)
        self.battle_sp_edit = QSpinBox()
        self.battle_sp_edit.setRange(1, 9999)
        self.battle_sp_edit.setMinimumWidth(150)
        enemy_layout.addRow(sp_label, self.battle_sp_edit)
        
        atk_label = QLabel("⚔️ Battle ATK (Col 19):")
        atk_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        atk_label.setMinimumWidth(220)
        self.battle_attack_edit = QSpinBox()
        self.battle_attack_edit.setRange(1, 9999)
        self.battle_attack_edit.setMinimumWidth(150)
        enemy_layout.addRow(atk_label, self.battle_attack_edit)
        
        def_label = QLabel("🛡️ Battle DEF (Col 20):")
        def_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        def_label.setMinimumWidth(220)
        self.battle_defense_edit = QSpinBox()
        self.battle_defense_edit.setRange(1, 9999)
        self.battle_defense_edit.setMinimumWidth(150)
        enemy_layout.addRow(def_label, self.battle_defense_edit)
        
        int_label = QLabel("🧠 Battle INT (Col 21):")
        int_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        int_label.setMinimumWidth(220)
        self.battle_intelligence_edit = QSpinBox()
        self.battle_intelligence_edit.setRange(1, 9999)
        self.battle_intelligence_edit.setMinimumWidth(150)
        enemy_layout.addRow(int_label, self.battle_intelligence_edit)
        
        spi_label = QLabel("✨ Battle SPI (Col 22):")
        spi_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        spi_label.setMinimumWidth(220)
        self.battle_spirit_edit = QSpinBox()
        self.battle_spirit_edit.setRange(1, 9999)
        self.battle_spirit_edit.setMinimumWidth(150)
        enemy_layout.addRow(spi_label, self.battle_spirit_edit)
        
        spd_label = QLabel("⚡ Battle SPD (Col 23):")
        spd_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        spd_label.setMinimumWidth(220)
        self.battle_speed_edit = QSpinBox()
        self.battle_speed_edit.setRange(1, 9999)
        self.battle_speed_edit.setMinimumWidth(150)
        enemy_layout.addRow(spd_label, self.battle_speed_edit)
        
        # AI behavior parameters
        skill_id_label = QLabel("🎯 AI Skill ID (Col 36):")
        skill_id_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        skill_id_label.setMinimumWidth(220)
        self.ai_skill_id_edit = QSpinBox()
        self.ai_skill_id_edit.setRange(0, 99999)
        self.ai_skill_id_edit.setMinimumWidth(150)
        enemy_layout.addRow(skill_id_label, self.ai_skill_id_edit)
        
        aggression_label = QLabel("💢 AI Aggression (Col 32):")
        aggression_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        aggression_label.setMinimumWidth(220)
        self.ai_aggression_edit = QSpinBox()
        self.ai_aggression_edit.setRange(0, 100)
        self.ai_aggression_edit.setMinimumWidth(150)
        enemy_layout.addRow(aggression_label, self.ai_aggression_edit)
        
        layout.addWidget(enemy_group)
        
        # Encounter groups
        encounter_group = QGroupBox("🌍 Encounter Groups")
        encounter_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #84fab0;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 15px;
                background-color: white;
                font-size: 11pt;
            }
            QGroupBox::title {
                color: #2c9558;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
        """)
        encounter_layout = QVBoxLayout(encounter_group)
        encounter_layout.setSpacing(10)
        
        encounter_label = QLabel("📍 Appears in encounter groups:")
        encounter_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        encounter_layout.addWidget(encounter_label)
        
        self.encounter_list = QListWidget()
        self.encounter_list.setStyleSheet("""
            QListWidget {
                border: 2px solid #dee2e6;
                border-radius: 6px;
                padding: 5px;
                background-color: white;
            }
            QListWidget::item {
                padding: 8px;
                margin: 2px;
                border-radius: 4px;
            }
            QListWidget::item:hover {
                background-color: #e7f5ff;
            }
            QListWidget::item:selected {
                background: qlineargradient(x1:0, y1:0, x2:1, y2:0,
                    stop:0 #84fab0, stop:1 #8fd3f4);
                color: white;
            }
        """)
        encounter_layout.addWidget(self.encounter_list)
        
        encounter_buttons = QHBoxLayout()
        encounter_buttons.setSpacing(10)
        
        add_group_btn = QPushButton("➕ Add to Group")
        add_group_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #84fab0, stop:1 #8fd3f4);
                color: white;
                border: none;
                border-radius: 6px;
                padding: 10px 15px;
                font-weight: bold;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #6ee89f, stop:1 #7bc9e8);
            }
        """)
        encounter_buttons.addWidget(add_group_btn)
        
        remove_group_btn = QPushButton("➖ Remove from Group")
        remove_group_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #fa709a, stop:1 #fee140);
                color: white;
                border: none;
                border-radius: 6px;
                padding: 10px 15px;
                font-weight: bold;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #e85c89, stop:1 #ecd32f);
            }
        """)
        encounter_buttons.addWidget(remove_group_btn)
        
        encounter_layout.addLayout(encounter_buttons)
        
        layout.addWidget(encounter_group)
        
        # Battle formation
        formation_group = QGroupBox("📐 Battle Formation")
        formation_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #f093fb;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 15px;
                background-color: white;
                font-size: 11pt;
            }
            QGroupBox::title {
                color: #c967cc;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                background-color: white;
            }
        """)
        formation_layout = QFormLayout(formation_group)
        formation_layout.setSpacing(12)
        formation_layout.setLabelAlignment(Qt.AlignmentFlag.AlignRight)
        formation_layout.setFieldGrowthPolicy(QFormLayout.FieldGrowthPolicy.ExpandingFieldsGrow)
        
        form_id_label = QLabel("🆔 Formation ID:")
        form_id_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        form_id_label.setMinimumWidth(180)
        self.formation_id_edit = QLineEdit()
        self.formation_id_edit.setMinimumWidth(200)
        formation_layout.addRow(form_id_label, self.formation_id_edit)
        
        form_type_label = QLabel("📋 Formation Type:")
        form_type_label.setFont(QFont("Segoe UI", 10, QFont.Weight.Bold))
        form_type_label.setMinimumWidth(180)
        self.formation_type_edit = QLineEdit()
        self.formation_type_edit.setMinimumWidth(200)
        formation_layout.addRow(form_type_label, self.formation_type_edit)
        
        layout.addWidget(formation_group)
        
        layout.addStretch()
        
        # Set the scroll content and add to main layout
        scroll.setWidget(scroll_content)
        main_layout.addWidget(scroll)
        
        return tab
    
    
    def update_files_tab(self, digimon: DigimonData):
        """Update the files tab with current Digimon data status"""
        file_checks = [
            ("digimon_status.mbe/00_digimon_status_data.csv", bool(digimon.id), "1"),
            ("char_info.mbe/00_char_info.csv", bool(digimon.char_info_data), "1" if digimon.char_info_data else "0"),
            ("text/char_name.mbe/00_Sheet1.csv", bool(digimon.name), "1"),
            ("model_setting.mbe/00_model_setting.csv", bool(digimon.model_setting_data), "1" if digimon.model_setting_data else "0"),
            ("model_locator.mbe/00_model_locator.csv", bool(digimon.model_locator_data), "1" if digimon.model_locator_data else "0"),
            ("model_locator.mbe/01_model_locator_motion.csv", bool(digimon.model_locator_motion_data), str(len(digimon.model_locator_motion_data))),
            ("lod_chara.mbe/00_lod.csv", bool(digimon.lod_data), "1" if digimon.lod_data else "0"),
            ("lod_chara.mbe/01_lod_model.csv", bool(digimon.lod_model_data), "1" if digimon.lod_model_data else "0"),
            ("field_anime.mbe/00_field_move_animation.csv", bool(digimon.field_move_animation_data), str(len(digimon.field_move_animation_data)))
        ]
        
        complete_count = 0
        for i, (file_name, has_data, count) in enumerate(file_checks):
            status = "✓ Complete" if has_data else "✗ Missing"
            status_color = "green" if has_data else "red"
            
            # Update table
            status_item = QTableWidgetItem(status)
            status_item.setForeground(Qt.GlobalColor.green if has_data else Qt.GlobalColor.red)
            self.files_table.setItem(i, 1, status_item)
            self.files_table.setItem(i, 2, QTableWidgetItem(count))
            
            if has_data:
                complete_count += 1
        
        # Update export status
        if complete_count == 9:
            self.export_status_label.setText("Status: Complete! All 9 files ready for export")
            self.export_status_label.setStyleSheet("font-weight: bold; color: green;")
        else:
            missing_count = 9 - complete_count
            self.export_status_label.setText(f"Status: {missing_count} files missing data")
            self.export_status_label.setStyleSheet("font-weight: bold; color: orange;")
    
    def update_evolution_tab(self, digimon: DigimonData):
        """Update evolution tab with current Digimon data"""
        # Clear existing data
        self.evolution_list.clear()
        self.deevolution_list.clear()
        
        # Update evolution requirements label (using wizard format)
        if digimon.evolution_conditions:
            # Check what type we have
            cond_data = digimon.evolution_conditions
            
            # If it's a list of dicts (multiple conditions), take the first one
            if isinstance(cond_data, list) and len(cond_data) > 0:
                if isinstance(cond_data[0], dict):
                    cond_data = cond_data[0]  # Take first condition dict
            
            # Now process based on type
            if isinstance(cond_data, dict):
                parts = []
                
                # Agent Rank (Mode)
                agent_rank = cond_data.get('mode', 1)
                parts.append(f"Agent Rank: {agent_rank}")
                
                # Digimon Level
                tamer_level = cond_data.get('tamerLevel', 0)
                if isinstance(tamer_level, (int, str)) and int(tamer_level) > 0:
                    parts.append(f"Digimon Lv{tamer_level}")
                
                # Stats (compact format)
                stats = []
                for stat in ['HP', 'SP', 'ATK', 'DEF', 'INT', 'SPI', 'SPD']:
                    val = cond_data.get(stat, 0)
                    if isinstance(val, (int, str)) and int(val) > 0:
                        stats.append(f"{stat}{val}")
                if stats:
                    parts.append(", ".join(stats))
                
                # Item requirement
                item_val = cond_data.get('needsItem', 0)
                if isinstance(item_val, (int, str)) and int(item_val) > 0:
                    parts.append(f"Item#{item_val}")
                
                # Jogress partners
                jogress_a = cond_data.get('jogressDbIdA', 0)
                if isinstance(jogress_a, (int, str)) and int(jogress_a) > 0:
                    parts.append(f"Jogress#{jogress_a}")
                
                self.requirements_label.setText(" | ".join(parts) if len(parts) > 1 else parts[0])
            elif isinstance(cond_data, list):
                # Raw CSV row format
                row = cond_data
                parts = []
                
                # Agent Rank
                if len(row) > 2 and row[2]:
                    parts.append(f"Agent Rank: {row[2]}")
                else:
                    parts.append("Agent Rank: 1")
                
                # Digimon Level
                if len(row) > 3 and row[3]:
                    try:
                        level = int(row[3])
                        if level > 0:
                            parts.append(f"Digimon Lv{level}")
                    except:
                        pass
                
                self.requirements_label.setText(" | ".join(parts))
            else:
                self.requirements_label.setText("Agent Rank: 1")
        else:
            self.requirements_label.setText("Agent Rank: 1")
        
        # Populate evolution paths with detailed requirements
        for evo in digimon.evolution_paths:
            to_id = evo['to_id']
            to_name = None
            
            # First check if we have a stored chr_id in the evolution path (for custom Digimon)
            to_chr_id = evo.get('to_chr_id') or evo.get('chr_id')
            
            # Check imported Digimon first (custom Digimon from dsts-loader)
            if hasattr(self.loader, 'imported_digimon') and self.loader.imported_digimon:
                for imported_digimon in self.loader.imported_digimon:
                    if imported_digimon.id == to_id:
                        to_name = imported_digimon.name
                        break
                    # Also check by chr_id if we have it
                    if to_chr_id and imported_digimon.chr_id == to_chr_id:
                        to_name = imported_digimon.name
                        break
            
            # If not found in imported, try standard lookup by numeric ID
            if not to_name:
                to_name = self.loader._get_digimon_name_by_id(to_id)
            
            # If still not found, try chr_id lookup
            if not to_name:
                if not to_chr_id:
                    # Generate chr_id from numeric ID
                    to_chr_id = f"chr{to_id:03d}"
                to_name = self.loader._get_digimon_name_by_chr_id(to_chr_id)
                if not to_name or to_name == to_chr_id:
                    # Try without padding
                    to_chr_id_alt = f"chr{to_id}"
                    if to_chr_id_alt != to_chr_id:
                        to_name = self.loader._get_digimon_name_by_chr_id(to_chr_id_alt)
                        if to_name and to_name != to_chr_id_alt:
                            to_chr_id = to_chr_id_alt
            
            # Final fallback
            if not to_name:
                to_name = f"Unknown (ID: {to_id})"
            
            # Build requirements string - check for conditions first (new format), then raw_data (old format)
            req_str = ""
            if 'conditions' in evo and evo['conditions']:
                # Use the comprehensive requirements summary
                req_str = f" {self._format_requirements_summary(evo['conditions'])}"
            elif 'raw_data' in evo and len(evo['raw_data']) > 2:
                # Fall back to old raw_data format
                reqs = []
                level_req = evo['raw_data'][2] if len(evo['raw_data']) > 2 else 0
                if level_req and str(level_req).isdigit() and int(level_req) > 0:
                    reqs.append(f"Lv{level_req}")
                req_str = f" [{', '.join(reqs)}]" if reqs else ""
            
            self.evolution_list.addItem(f"→ {to_name} (ID: {to_id}){req_str}")
        
        # Populate de-evolution sources
        for deevo in digimon.deevolution_sources:
            from_id = deevo['from_id']
            from_name = None
            
            # First check imported Digimon (custom Digimon from dsts-loader)
            if hasattr(self.loader, 'imported_digimon') and self.loader.imported_digimon:
                for imported_digimon in self.loader.imported_digimon:
                    if imported_digimon.id == from_id:
                        from_name = imported_digimon.name
                        break
                    # Also check by chr_id if we have it
                    from_chr_id = deevo.get('from_chr_id')
                    if from_chr_id and imported_digimon.chr_id == from_chr_id:
                        from_name = imported_digimon.name
                        break
            
            # If not found in imported, try standard lookup
            if not from_name:
                from_name = self.loader._get_digimon_name_by_id(from_id)
            
            # Try chr_id lookup as fallback
            if not from_name:
                from_chr_id = deevo.get('from_chr_id')
                if from_chr_id:
                    from_name = self.loader._get_digimon_name_by_chr_id(from_chr_id)
                else:
                    # Try generating chr_id from ID
                    from_chr_id = f"chr{from_id:03d}"
                    from_name = self.loader._get_digimon_name_by_chr_id(from_chr_id)
                    if not from_name or from_name == from_chr_id:
                        from_chr_id = f"chr{from_id}"
                        from_name = self.loader._get_digimon_name_by_chr_id(from_chr_id)
            
            # Final fallback
            if not from_name:
                from_name = f"Unknown (ID: {from_id})"
            
            self.deevolution_list.addItem(f"← {from_name} (ID: {from_id})")
    
    def edit_evolution_requirements(self):
        """Edit requirements to obtain this Digimon"""
        if not self.current_digimon:
            QMessageBox.warning(self, "No Digimon Loaded", "Please load a Digimon first.")
            return
        
        # Get existing requirements or create defaults
        existing = self.current_digimon.evolution_conditions if self.current_digimon.evolution_conditions else {
            'mode': 1, 'tamerLevel': 0,
            'HP': 0, 'SP': 0, 'ATK': 0, 'DEF': 0, 'INT': 0, 'SPI': 0, 'SPD': 0,
            'skillCountValor': 0, 'skillCountPhilantropy': 0, 
            'skillCountAmicable': 0, 'skillCountWisdom': 0,
            'needsItem': 0,
            'jogressDbIdA': 0, 'jogressPersonalityA': 0,
            'jogressDbIdB': 0, 'jogressPersonalityB': 0
        }
        
        # Show the same dialog as used for evolution paths
        new_conditions = self._show_evolution_requirements_dialog(
            f"{self.current_digimon.name} (Requirements to obtain THIS Digimon)",
            existing
        )
        
        if new_conditions is not None:
            self.current_digimon.evolution_conditions = new_conditions
            self.update_evolution_tab(self.current_digimon)
            QMessageBox.information(self, "Success", "Evolution requirements updated!")
    
    def update_evolution_tree_tab(self, digimon: DigimonData):
        """Update the visual evolution tree tab with current Digimon"""
        # This will be implemented to show the tree structure
        # For now, just clear the canvas
        old_layout = self.evolution_tree_canvas.layout()
        if old_layout:
            while old_layout.count():
                child = old_layout.takeAt(0)
                if child.widget():
                    child.widget().deleteLater()
            QWidget().setLayout(old_layout)
        
        canvas_layout = QVBoxLayout(self.evolution_tree_canvas)
        canvas_layout.setContentsMargins(0, 0, 0, 0)
        label = QLabel(f"Evolution tree for {digimon.name} (ID: {digimon.id}) will be displayed here")
        label.setStyleSheet("color: #666; font-size: 12pt; padding: 40px;")
        label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        label.setWordWrap(True)
        canvas_layout.addWidget(label)
    
    def draw_evolution_tree(self, digimon: DigimonData):
        """Draw visual representation of evolution tree"""
        try:
            from PyQt6.QtWidgets import QTextBrowser
            
            # Calculate tree structure
            nodes = []
            
            # Add pre-evolutions (sources)
            for i, deevo in enumerate(digimon.deevolution_sources):
                from_id = deevo.get('from_id', 0)
                
                # Get name by numeric ID
                from_name = self.loader._get_digimon_name_by_id(from_id)
                if not from_name:
                    from_name = f"ID:{from_id}"
                
                nodes.append({
                    'name': from_name,
                    'type': 'source',
                    'id': from_id
                })
            
            # Add current Digimon (center)
            nodes.append({
                'name': digimon.name,
                'type': 'current',
                'id': digimon.id
            })
            
            # Add evolutions (targets)
            for i, evo in enumerate(digimon.evolution_paths):
                to_id = evo.get('to_id', 0)
                
                # Get name by numeric ID
                to_name = self.loader._get_digimon_name_by_id(to_id)
                if not to_name:
                    to_name = f"ID:{to_id}"
                
                nodes.append({
                    'name': to_name,
                    'type': 'target',
                    'id': to_id
                })
            
            # Create HTML-based tree visualization
            html = self.generate_tree_html(nodes, digimon)
            
            # Create or update text browser
            text_browser = QTextBrowser()
            text_browser.setHtml(html)
            text_browser.setMinimumSize(600, 400)
            text_browser.setOpenExternalLinks(False)
            
            # Debug: Print HTML length to verify it's being generated
            print(f"Generated HTML length: {len(html)}")
            print(f"Nodes count: {len(nodes)}")
            print(f"Current Digimon: {digimon.name}")
            
            # Replace canvas content
            old_layout = self.evolution_tree_canvas.layout()
            if old_layout:
                # Clear existing widgets
                while old_layout.count():
                    child = old_layout.takeAt(0)
                    if child.widget():
                        child.widget().deleteLater()
                # Delete old layout
                QWidget().setLayout(old_layout)
            
            # Create new layout and add browser
            new_layout = QVBoxLayout(self.evolution_tree_canvas)
            new_layout.setContentsMargins(0, 0, 0, 0)
            new_layout.addWidget(text_browser)
            
        except Exception as e:
            # Show error in tree area
            error_label = QLabel(f"Error displaying tree: {str(e)}")
            error_label.setStyleSheet("color: red; padding: 20px;")
            error_label.setWordWrap(True)
            
            old_layout = self.evolution_tree_canvas.layout()
            if old_layout:
                while old_layout.count():
                    child = old_layout.takeAt(0)
                    if child.widget():
                        child.widget().deleteLater()
                QWidget().setLayout(old_layout)
            
            new_layout = QVBoxLayout(self.evolution_tree_canvas)
            new_layout.addWidget(error_label)
    
    def generate_tree_html(self, nodes, digimon):
        """Generate HTML representation of evolution tree - Tournament bracket style"""
        html = """
        <html>
        <head>
        <style>
            body { 
                font-family: Arial, sans-serif; 
                padding: 20px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                margin: 0;
            }
            .tournament-container {
                display: table;
                width: 100%;
                table-layout: fixed;
            }
            .tournament-row {
                display: table-row;
            }
            .tournament-cell {
                display: table-cell;
                vertical-align: middle;
                padding: 10px;
            }
            .column-left {
                width: 35%;
                text-align: right;
            }
            .column-center {
                width: 30%;
                text-align: center;
            }
            .column-right {
                width: 35%;
                text-align: left;
            }
            .section-title { 
                color: white;
                font-size: 12px;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-bottom: 10px;
                padding: 5px 10px;
                background: rgba(255, 255, 255, 0.2);
                border-radius: 5px;
                display: inline-block;
            }
            .node { 
                background: rgba(255, 255, 255, 0.95);
                color: #333;
                border: 2px solid white;
                border-radius: 8px;
                padding: 10px 12px;
                margin: 5px 0;
                font-weight: bold;
                font-size: 12px;
                box-shadow: 0 3px 6px rgba(0, 0, 0, 0.3);
                display: inline-block;
                min-width: 150px;
            }
            .node-current { 
                background: linear-gradient(135deg, #f5576c 0%, #f093fb 100%);
                color: white;
                font-size: 15px;
                padding: 20px;
                border: 3px solid white;
                min-width: 180px;
            }
            .node-source { 
                background: linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%);
                color: white;
            }
            .node-target { 
                background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
                color: #333;
            }
            .node-name {
                font-weight: bold;
            }
            .node-id {
                font-size: 10px;
                opacity: 0.8;
                margin-top: 4px;
            }
            .connector {
                color: white;
                font-size: 24px;
                font-weight: bold;
                padding: 0 10px;
            }
            .nodes-container {
                display: inline-block;
            }
            .empty-state {
                color: white;
                text-align: center;
                padding: 40px 20px;
                font-size: 14px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 10px;
            }
            .count-badge {
                background: rgba(255, 255, 255, 0.4);
                color: white;
                padding: 2px 6px;
                border-radius: 10px;
                font-size: 10px;
                margin-left: 5px;
            }
        </style>
        </head>
        <body>
        """
        
        # Pre-evolutions, current, and target nodes
        sources = [n for n in nodes if n['type'] == 'source']
        current = [n for n in nodes if n['type'] == 'current']
        targets = [n for n in nodes if n['type'] == 'target']
        
        # Check if we have any data
        if not sources and not targets:
            html += '<div class="empty-state">'
            html += '<b style="font-size: 16px;">⚠️ No Evolution Data Available</b><br/><br/>'
            html += 'This Digimon has no defined pre-evolutions or evolutions.<br/>'
            html += 'Use the buttons above to add evolution paths.'
            html += '</div>'
        else:
            html += '<div class="tournament-container">'
            html += '<div class="tournament-row">'
            
            # Left column - Pre-evolutions
            html += '<div class="tournament-cell column-left">'
            if sources:
                html += f'<div class="section-title">⬅️ PRE-EVOLUTION <span class="count-badge">{len(sources)}</span></div><br/>'
                html += '<div class="nodes-container">'
                for node in sources:
                    html += f'<div class="node node-source"><div class="node-name">{node["name"]}</div><div class="node-id">ID: {node["id"]}</div></div><br/>'
                html += '</div>'
            html += '</div>'
            
            # Center connector arrow
            html += '<div class="tournament-cell" style="width: 5%; text-align: center;">'
            if sources:
                html += '<div class="connector">→</div>'
            html += '</div>'
            
            # Center column - Current Digimon
            html += '<div class="tournament-cell column-center">'
            if current:
                current_node = current[0]
                html += '<div class="section-title">📍 CURRENT</div><br/>'
                html += f'<div class="node node-current"><div class="node-name">{current_node["name"]}</div><div class="node-id">ID: {current_node["id"]}</div></div>'
            html += '</div>'
            
            # Center-Right connector arrow
            html += '<div class="tournament-cell" style="width: 5%; text-align: center;">'
            if targets:
                html += '<div class="connector">→</div>'
            html += '</div>'
            
            # Right column - Evolutions
            html += '<div class="tournament-cell column-right">'
            if targets:
                html += f'<div class="section-title">➡️ EVOLUTION <span class="count-badge">{len(targets)}</span></div><br/>'
                html += '<div class="nodes-container">'
                for node in targets:
                    html += f'<div class="node node-target"><div class="node-name">{node["name"]}</div><div class="node-id">ID: {node["id"]}</div></div><br/>'
                html += '</div>'
            html += '</div>'
            
            html += '</div>' # Close tournament-row
            html += '</div>' # Close tournament-container
        
        html += """
        </body>
        </html>
        """
        
        return html
    
    def update_battle_tab(self, digimon: DigimonData):
        """Update battle tab with current Digimon data"""
        # Clear existing data
        self.encounter_list.clear()
        
        # Populate battle enemy data
        if digimon.battle_enemy_data:
            enemy = digimon.battle_enemy_data
            self.enemy_id_edit.setText(str(enemy.get('enemy_id', '')))
            self.base_digimon_id_edit.setText(str(enemy.get('base_id', '')))
            self.ai_level_edit.setValue(enemy.get('level', 1))
            
            # Battle stats
            self.battle_hp_edit.setValue(enemy.get('hp', 0))
            self.battle_sp_edit.setValue(enemy.get('sp', 0))
            self.battle_attack_edit.setValue(enemy.get('attack', 0))
            self.battle_defense_edit.setValue(enemy.get('defense', 0))
            self.battle_intelligence_edit.setValue(enemy.get('intelligence', 0))
            self.battle_spirit_edit.setValue(enemy.get('spirit', 0))
            self.battle_speed_edit.setValue(enemy.get('speed', 0))
            
            # AI parameters (would need to be loaded from raw_data)
            raw_data = enemy.get('raw_data', [])
            if len(raw_data) > 36:
                self.ai_skill_id_edit.setValue(int(raw_data[36]) if raw_data[36] else 0)
            if len(raw_data) > 32:
                self.ai_aggression_edit.setValue(int(raw_data[32]) if raw_data[32] else 0)
        else:
            self.enemy_id_edit.clear()
            self.base_digimon_id_edit.clear()
            self.ai_level_edit.setValue(1)
            self.battle_hp_edit.setValue(0)
            self.battle_sp_edit.setValue(0)
            self.battle_attack_edit.setValue(0)
            self.battle_defense_edit.setValue(0)
            self.battle_intelligence_edit.setValue(0)
            self.battle_spirit_edit.setValue(0)
            self.battle_speed_edit.setValue(0)
            self.ai_skill_id_edit.setValue(0)
            self.ai_aggression_edit.setValue(0)
        
        # Populate encounter groups
        for encounter in digimon.encounter_groups:
            encounter_id = encounter.get('encounter_id', 0)
            slot = encounter.get('slot', 0)
            count = encounter.get('enemy_count', 1)
            group_text = f"Encounter {encounter_id} (Slot {slot+1}, Count: {count})"
            self.encounter_list.addItem(group_text)
        
        # Populate battle formation data
        if digimon.battle_formation_data:
            formation = digimon.battle_formation_data
            self.formation_id_edit.setText(str(formation.get('formation_id', '')))
            self.formation_type_edit.setText(formation.get('formation_type', ''))
        else:
            self.formation_id_edit.clear()
            self.formation_type_edit.clear()
    
    
    def load_digimon_list(self):
        """Load list of available Digimon by name"""
        # Get source selection (Base Game or DLC)
        from_dlc = self.source_combo.currentData() if hasattr(self, 'source_combo') else False
        
        chr_ids = self.loader.get_all_digimon_chr_ids(from_dlc=from_dlc)
        self.digimon_data = {}  # Store mapping of display name to chr_id
        
        if not chr_ids:
            # No Digimon found in selected source
            self.digimon_list.clear()
            if from_dlc:
                self.digimon_list.addItem("(No DLC Digimon found)")
            self.all_digimon_names = []
            return
        
        digimon_names = []
        for chr_id in chr_ids:
            # Get the name for this chr_id (returns None if not found in char_name.mbe)
            name = self.loader._get_digimon_name_by_chr_id(chr_id)
            
            # Skip if no name found (not in char_name.mbe)
            if not name:
                continue
            
            display_name = f"{name} ({chr_id})"
            digimon_names.append(display_name)
            self.digimon_data[display_name] = chr_id
        
        # Add imported Digimon (marked with 📥)
        if hasattr(self.loader, 'imported_digimon'):
            for digimon in self.loader.imported_digimon:
                display_name = f"📥 {digimon.name} ({digimon.chr_id})"
                digimon_names.append(display_name)
                self.digimon_data[display_name] = digimon.chr_id
        
        # Sort by name
        digimon_names.sort()
        
        self.digimon_list.clear()
        self.digimon_list.addItems(digimon_names)
        
        # Store all names for filtering
        self.all_digimon_names = digimon_names.copy()
    
    def on_source_changed(self):
        """Handle source combo change - disable remove button if switching away from DLC"""
        if not self.current_digimon:
            self.remove_button.setEnabled(False)
        else:
            is_from_dlc = self.source_combo.currentData()
            self.remove_button.setEnabled(is_from_dlc)
    
    def filter_digimon_list(self, text: str):
        """Filter Digimon list based on search text"""
        if not hasattr(self, 'all_digimon_names'):
            # Store all names for filtering
            self.all_digimon_names = [self.digimon_list.itemText(i) for i in range(self.digimon_list.count())]
        
        # Clear and repopulate with filtered results
        self.digimon_list.clear()
        
        if not text.strip():
            # If no search text, show all
            self.digimon_list.addItems(self.all_digimon_names)
        else:
            # Filter by search text (case insensitive)
            filtered_names = [name for name in self.all_digimon_names 
                            if text.lower() in name.lower()]
            self.digimon_list.addItems(filtered_names)
    
    def on_digimon_selected(self, display_name: str):
        """Handle Digimon selection from list"""
        if display_name:
            self.load_button.setEnabled(True)
        else:
            self.load_button.setEnabled(False)
    
    def load_selected_digimon(self):
        """Load the selected Digimon"""
        # Check for unsaved changes
        if self.has_unsaved_changes:
            reply = QMessageBox.question(
                self,
                "Unsaved Changes",
                f"You have unsaved changes to {self.current_digimon.name if self.current_digimon else 'the current Digimon'}.\n\n"
                "Do you want to save before switching?",
                QMessageBox.StandardButton.Save | QMessageBox.StandardButton.Discard | QMessageBox.StandardButton.Cancel,
                QMessageBox.StandardButton.Save
            )
            
            if reply == QMessageBox.StandardButton.Cancel:
                return  # Don't switch
            elif reply == QMessageBox.StandardButton.Save:
                self.save_current_digimon()
                if self.has_unsaved_changes:  # Save failed or was cancelled
                    return
        
        display_name = self.digimon_list.currentText()
        if display_name and display_name in self.digimon_data:
            chr_id = self.digimon_data[display_name]
            
            # Check if this is an imported Digimon
            if display_name.startswith("📥"):
                if hasattr(self.loader, 'imported_digimon'):
                    for digimon in self.loader.imported_digimon:
                        if digimon.chr_id == chr_id:
                            self.load_digimon_data(digimon)
                            return
            
            # Otherwise load from normal sources
            digimon = self.loader.get_digimon_by_chr_id(chr_id)
            if digimon:
                self.load_digimon_data(digimon)
            else:
                QMessageBox.warning(self, "Error", f"Could not load Digimon {display_name}")
    
    def load_digimon_data(self, digimon: DigimonData):
        """Load Digimon data into the editor"""
        self.current_digimon = digimon
        self.current_digimon_label.setText(f"✏️ Editing: {digimon.name} ({digimon.chr_id})")
        
        # Clear unsaved changes flag when loading new Digimon
        self.clear_modified_flag()
        
        # Enable/disable remove button based on source
        is_from_dlc = self.source_combo.currentData()
        self.remove_button.setEnabled(is_from_dlc)
        
        # Basic Info
        self.id_spin.setValue(digimon.id)
        self.char_key_edit.setText(digimon.char_key)
        self.chr_id_edit.setText(digimon.chr_id)
        self.name_edit.setText(digimon.name)
        
        # Sync animation reference - use template chr_id if available, otherwise use digimon's chr_id
        if hasattr(self, 'template_chr_id_for_animation'):
            self.animation_ref_edit.setText(self.template_chr_id_for_animation)
            delattr(self, 'template_chr_id_for_animation')  # Clear after use
        else:
            self.animation_ref_edit.setText(digimon.chr_id)
        
        # Set stage combo box
        # Ensure stage_id is in valid range (0-14, based on generation_name.mbe CSV)
        stage_id = max(0, min(14, digimon.stage_id)) if digimon.stage_id is not None else 0
        stage_index = self.stage_combo.findData(stage_id)
        if stage_index >= 0:
            self.stage_combo.setCurrentIndex(stage_index)
        else:
            # If stage_id is 0 or not found, set to index 0 (which should be the first stage)
            # Try to find index 0 explicitly
            stage_index_0 = self.stage_combo.findData(0)
            if stage_index_0 >= 0:
                self.stage_combo.setCurrentIndex(stage_index_0)
            else:
                self.stage_combo.setCurrentIndex(0)
        
        # Set type combo box
        type_index = self.type_combo.findData(digimon.type_id)
        if type_index >= 0:
            self.type_combo.setCurrentIndex(type_index)
        
        # Set personality combo box
        personality_index = self.personality_combo.findData(digimon.personality_id)
        if personality_index >= 0:
            self.personality_combo.setCurrentIndex(personality_index)
        else:
            # If personality_id is 0 or not found, set to index 0 (which should be "-")
            self.personality_combo.setCurrentIndex(0)
        
        # Set tribe combo box
        if hasattr(digimon, 'tribe_name') and digimon.tribe_name:
            tribe_index = self.tribe_combo.findText(digimon.tribe_name)
            if tribe_index >= 0:
                self.tribe_combo.setCurrentIndex(tribe_index)
        else:
            # Default to first item (usually "None" or alphabetically first)
            self.tribe_combo.setCurrentIndex(0)
        
        # Profile text
        self.profile_text_edit.setPlainText(digimon.profile_text)
        
        # Stats
        self.stat_widgets["hp"].setValue(digimon.base_hp)
        self.stat_widgets["sp"].setValue(digimon.base_sp)
        self.stat_widgets["atk"].setValue(digimon.base_atk)
        self.stat_widgets["def"].setValue(digimon.base_def)
        self.stat_widgets["int"].setValue(digimon.base_int)
        self.stat_widgets["spi"].setValue(digimon.base_spi)
        self.stat_widgets["spd"].setValue(digimon.base_spd)
        
        # Growth Pattern
        growth_index = self.growth_pattern_combo.findData(digimon.growth_pattern_id)
        if growth_index >= 0:
            self.growth_pattern_combo.setCurrentIndex(growth_index)
        else:
            self.growth_pattern_combo.setCurrentIndex(0)  # Default to pattern 1
        
        # Resistances
        self.resist_widgets["null"].setValue(digimon.res_null)
        self.resist_widgets["fire"].setValue(digimon.res_fire)
        self.resist_widgets["water"].setValue(digimon.res_water)
        self.resist_widgets["ice"].setValue(digimon.res_ice)
        self.resist_widgets["grass"].setValue(digimon.res_grass)
        self.resist_widgets["wind"].setValue(digimon.res_wind)
        self.resist_widgets["elec"].setValue(digimon.res_elec)
        self.resist_widgets["ground"].setValue(digimon.res_ground)
        self.resist_widgets["steel"].setValue(digimon.res_steel)
        self.resist_widgets["light"].setValue(digimon.res_light)
        self.resist_widgets["dark"].setValue(digimon.res_dark)
        
        # Skills
        self.signature_skills_editor.load_skills(digimon.signature_skills)
        self.generic_skills_editor.load_skills(digimon.generic_skills)
        
        # Update skill names for all skills
        self.signature_skills_editor.update_all_skill_names()
        self.generic_skills_editor.update_all_skill_names()
        
        # Traits
        self.traits_tab.load_traits(digimon.traits)
        
        # Model data
        self.model_id_edit.setText(digimon.model_id)
        self.motion_id_edit.setText(digimon.motion_id)
        
        # LOD data
        for key, widget in self.lod_widgets.items():
            widget.setValue(int(digimon.lod_data.get(key, 0)))
        
        # Model settings (from model_setting.mbe)
        if digimon.model_setting_data:
            self.battle_scale_spin.setValue(digimon.model_setting_data.get('battle_scale', 1.0))
            self.menu_scale_spin.setValue(digimon.model_setting_data.get('menu_scale', 1.0))
            self.field_scale_spin.setValue(digimon.model_setting_data.get('field_scale', 1.0))
            self.npc_collision_spin.setValue(digimon.model_setting_data.get('npc_collision', 0.0))
            self.shield_size_spin.setValue(digimon.model_setting_data.get('shield_size', 0.0))
            self.agent_distance_spin.setValue(digimon.model_setting_data.get('agent_distance', 0))
            self.agent_distance_2_spin.setValue(digimon.model_setting_data.get('agent_distance_2', 0.0))
            self.digimon_distance_spin.setValue(digimon.model_setting_data.get('digimon_distance_from_agent', 0.0))
            self.camera_distance_skill_spin.setValue(digimon.model_setting_data.get('camera_distance_skill', 0.0))
            self.rideable_checkbox.setChecked(digimon.model_setting_data.get('rideable', 0) != 0)
        else:
            # Reset to defaults if no model_setting data
            self.battle_scale_spin.setValue(1.0)
            self.menu_scale_spin.setValue(1.0)
            self.field_scale_spin.setValue(1.0)
            self.npc_collision_spin.setValue(0.0)
            self.shield_size_spin.setValue(0.0)
            self.agent_distance_spin.setValue(0)
            self.agent_distance_2_spin.setValue(0.0)
            self.digimon_distance_spin.setValue(0.0)
            self.camera_distance_skill_spin.setValue(0.0)
            self.rideable_checkbox.setChecked(False)
        
        # References
        self.field_guide_id_spin.setValue(digimon.field_guide_id)
        self.script_id_spin.setValue(digimon.script_id)
        
        # Update extended tabs
        self.update_evolution_tab(digimon)
        self.update_battle_tab(digimon)
        
        self.save_button.setEnabled(True)
        self.export_dlc_button.setEnabled(True)
    
    def launch_creation_wizard(self):
        """Launch the Digimon creation wizard"""
        wizard = DigimonCreationWizard(self, self.loader)
        wizard.exec()
        
        # Inform user if a new Digimon was created
        if wizard.new_digimon:
            # Ask if they want to import it for editing
            reply = QMessageBox.question(
                self,
                "Digimon Created",
                f"✅ {wizard.new_digimon.name} has been exported to dsts-loader format!\n\n"
                f"Would you like to import it for editing?\n"
                f"(This will import the Digimon from the folder you just exported to)",
                QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No
            )
            if reply == QMessageBox.StandardButton.Yes:
                # Import from the dsts-loader folder that was just exported to
                if hasattr(wizard, 'last_export_path') and wizard.last_export_path:
                    try:
                        from pathlib import Path
                        loader_path = wizard.last_export_path
                        
                        # Look for the exported digimon_status_data.ap.csv
                        status_files = list((loader_path / "patch" / "data" / "digimon_status.mbe").glob("*.ap.csv"))
                        
                        if not status_files:
                            QMessageBox.warning(
                                self,
                                "Import Failed",
                                "Could not find exported files.\n"
                                "Try using 'Import from dsts-loader' manually."
                            )
                            return
                        
                        # Parse and import
                        if not hasattr(self.loader, 'imported_digimon'):
                            self.loader.imported_digimon = []
                        
                        imported_before = len(self.loader.imported_digimon)
                        
                        for status_file in status_files:
                            digimon_list = self._parse_digimon_status_csv(status_file, loader_path)
                            for digimon in digimon_list:
                                self.loader.imported_digimon.append(digimon)
                        
                        if len(self.loader.imported_digimon) > imported_before:
                            # Refresh list to show imported Digimon
                            self.load_digimon_list()
                            
                            # Find and select the newly imported Digimon
                            first_digimon = self.loader.imported_digimon[-1]  # Get last imported
                            self.load_digimon_data(first_digimon)
                            self.current_digimon = first_digimon
                            
                            # Try to select it in the list
                            display_name = f"📥 {first_digimon.name} ({first_digimon.chr_id})"
                            index = self.digimon_list.findText(display_name, Qt.MatchFlag.MatchExactly)
                            if index >= 0:
                                self.digimon_list.setCurrentIndex(index)
                            
                            QMessageBox.information(
                                self,
                                "Import Successful",
                                f"✅ {first_digimon.name} has been loaded for editing!"
                            )
                        else:
                            QMessageBox.warning(
                                self,
                                "Import Failed",
                                "Could not import the newly created Digimon.\n"
                                "Try using 'Import from dsts-loader' manually."
                            )
                    except Exception as e:
                        import traceback
                        traceback.print_exc()
                        QMessageBox.warning(
                            self,
                            "Import Failed",
                            f"Could not import the newly created Digimon:\n\n{str(e)}\n\n"
                            f"Try using 'Import from dsts-loader' manually."
                        )
    
    def import_from_dsts_loader(self):
        """Import Digimon from dsts-loader format files"""
        from pathlib import Path
        import csv
        
        # Ask user to select dsts-loader directory
        default_path = Path.cwd() / "dsts-loader"
        
        loader_dir = QFileDialog.getExistingDirectory(
            self,
            "Select dsts-loader Directory to Import From",
            str(default_path),
            QFileDialog.Option.ShowDirsOnly
        )
        
        if not loader_dir:
            return
        
        loader_path = Path(loader_dir)
        
        # Look for digimon_status_data.ap.csv files
        status_files = list((loader_path / "patch" / "data" / "digimon_status.mbe").glob("*.ap.csv"))
        
        if not status_files:
            QMessageBox.warning(
                self,
                "No Files Found",
                "No .ap.csv files found in patch/data/digimon_status.mbe/\n\n"
                "Make sure you selected the correct dsts-loader directory."
            )
            return
        
        imported_count = 0
        imported_names = []
        
        try:
            for status_file in status_files:
                # Parse each status file
                digimon_list = self._parse_digimon_status_csv(status_file, loader_path)
                
                for digimon in digimon_list:
                    # Add to loader's digimon list
                    if not hasattr(self.loader, 'imported_digimon'):
                        self.loader.imported_digimon = []
                    
                    self.loader.imported_digimon.append(digimon)
                    imported_count += 1
                    imported_names.append(digimon.name)
            
            # Refresh the list
            self.load_digimon_list()
            
            # Ask if user wants to load the first imported Digimon for editing
            reply = QMessageBox.question(
                self,
                "Import Successful! 🎉",
                f"✅ Successfully imported {imported_count} Digimon:\n\n" +
                "\n".join(f"  • {name}" for name in imported_names[:10]) +
                (f"\n  ... and {len(imported_names) - 10} more" if len(imported_names) > 10 else "") +
                "\n\nDo you want to load the first imported Digimon for editing?",
                QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No,
                QMessageBox.StandardButton.Yes
            )
            
            if reply == QMessageBox.StandardButton.Yes and hasattr(self.loader, 'imported_digimon') and self.loader.imported_digimon:
                # Load the first imported Digimon
                first_digimon = self.loader.imported_digimon[0]
                self.load_digimon_data(first_digimon)
                self.current_digimon = first_digimon
                
                # Try to select it in the list (if it exists)
                try:
                    display_name = f"📥 {first_digimon.name} ({first_digimon.chr_id})"
                    index = self.digimon_list.findText(display_name, Qt.MatchFlag.MatchExactly)
                    if index >= 0:
                        self.digimon_list.setCurrentIndex(index)
                except Exception as select_error:
                    # Don't fail import if we can't select the item
                    print(f"Could not select imported item: {select_error}")
            
        except Exception as e:
            QMessageBox.critical(
                self,
                "Import Error",
                f"Failed to import Digimon:\n\n{str(e)}\n\n"
                "Make sure the files are in the correct dsts-loader format."
            )
            import traceback
            traceback.print_exc()
    
    def _parse_digimon_status_csv(self, csv_file: Path, base_path: Path):
        """Parse a digimon_status_data.ap.csv and related files"""
        import csv
        from copy import deepcopy
        
        digimon_list = []
        
        with open(csv_file, 'r', encoding='utf-8') as f:
            reader = csv.reader(f)
            header = next(reader)  # Skip header
            
            for row in reader:
                if not row or len(row) < 4:
                    continue
                
                # Create new DigimonData object
                digimon = DigimonData()
                
                # Parse basic info from digimon_status_data
                digimon.id = int(row[0]) if row[0] else 0
                digimon.char_key = row[2].strip('"') if len(row) > 2 else ""
                digimon.chr_id = row[3].strip('"') if len(row) > 3 else ""
                digimon.stage_id = int(row[4]) if len(row) > 4 and row[4] else 0
                digimon.personality_id = int(row[5]) if len(row) > 5 and row[5] else 0
                digimon.type_id = int(row[6]) if len(row) > 6 and row[6] else 0
                digimon.generation_id = digimon.stage_id
                
                # Parse resistances (columns 7-17) - CORRECTED ORDER
                if len(row) > 17:
                    digimon.res_null = int(row[7]) if row[7] else 0
                    digimon.res_fire = int(row[8]) if row[8] else 0
                    digimon.res_water = int(row[9]) if row[9] else 0
                    digimon.res_ice = int(row[10]) if row[10] else 0      # Col10 = Ice
                    digimon.res_grass = int(row[11]) if row[11] else 0    # Col11 = Grass
                    digimon.res_wind = int(row[12]) if row[12] else 0     # Col12 = Wind
                    digimon.res_elec = int(row[13]) if row[13] else 0     # Col13 = Elec
                    digimon.res_ground = int(row[14]) if row[14] else 0   # Col14 = Ground
                    digimon.res_steel = int(row[15]) if row[15] else 0    # Col15 = Steel
                    digimon.res_light = int(row[16]) if row[16] else 0
                    digimon.res_dark = int(row[17]) if row[17] else 0
                
                # Parse traits (columns 19-60)
                # Handle multiple boolean formats: "true", "True", "1", "TRUE"
                digimon.traits = []
                for i in range(19, min(61, len(row))):
                    val = row[i].strip().lower() if row[i] else ''
                    digimon.traits.append(val in ('true', '1', 'yes'))
                
                # Parse base stats (columns 64-70)
                if len(row) > 70:
                    digimon.base_personality = int(row[61]) if row[61] else 0
                    digimon.base_hp = int(row[64]) if row[64] else 0
                    digimon.base_sp = int(row[65]) if row[65] else 0
                    digimon.base_atk = int(row[66]) if row[66] else 0
                    digimon.base_def = int(row[67]) if row[67] else 0
                    digimon.base_int = int(row[68]) if row[68] else 0
                    digimon.base_spi = int(row[69]) if row[69] else 0
                    digimon.base_spd = int(row[70]) if row[70] else 0
                
                # Parse signature skills (every 3 columns starting at 72)
                digimon.signature_skills = []
                for i in range(12):
                    idx = 72 + (i * 3)
                    if len(row) > idx + 2:
                        skill_id = int(row[idx]) if row[idx] else 0
                        slot = int(row[idx + 2]) if row[idx + 2] else 0
                        if skill_id > 0:
                            digimon.signature_skills.append({'id': skill_id, 'slot': slot})
                
                # Parse generic skills (every 3 columns starting at 108)
                digimon.generic_skills = []
                for i in range(4):
                    idx = 108 + (i * 3)
                    if len(row) > idx + 2:
                        skill_id = int(row[idx]) if row[idx] else 0
                        level = int(row[idx + 2]) if row[idx + 2] else 0
                        if skill_id > 0:
                            digimon.generic_skills.append({'id': skill_id, 'level': level})
                
                # Parse model type and animation set (columns 121-122)
                if len(row) > 122:
                    digimon.model_type = int(row[121]) if row[121] else 1  # Column 121: Model type
                    digimon.animation_set = int(row[122]) if row[122] else 1  # Column 122: Animation set
                    print(f"DEBUG: Loaded model_type: {digimon.model_type}, animation_set: {digimon.animation_set}")
                
                # Parse field guide ID (column 131)
                if len(row) > 131:
                    field_guide_val = row[131].strip() if row[131] else ""
                    if field_guide_val:
                        try:
                            digimon.field_guide_id = int(field_guide_val)
                        except (ValueError, TypeError):
                            digimon.field_guide_id = -1
                    else:
                        digimon.field_guide_id = -1
                    print(f"DEBUG: Loaded field_guide_id: {digimon.field_guide_id} from column 131 (raw value: '{row[131] if len(row) > 131 else 'N/A'}')")
                else:
                    digimon.field_guide_id = -1
                
                # Parse script ID (column 132)
                if len(row) > 132:
                    script_val = row[132].strip() if row[132] else ""
                    if script_val:
                        try:
                            digimon.script_id = int(script_val)
                        except (ValueError, TypeError):
                            digimon.script_id = -1
                    else:
                        digimon.script_id = -1
                    print(f"DEBUG: Loaded script_id: {digimon.script_id} from column 132 (raw value: '{row[132] if len(row) > 132 else 'N/A'}')")
                else:
                    digimon.script_id = -1
                
                # Load name from char_name
                name_file = base_path / "patch_text01" / "text" / "char_name.mbe"
                digimon.name = self._load_name_from_csv(name_file, digimon.char_key)
                
                # Load profile from digimon_profile
                profile_file = base_path / "patch_text01" / "text" / "digimon_profile.mbe"
                digimon.profile_text = self._load_profile_from_csv(profile_file, digimon.id)
                print(f"DEBUG: Loaded profile for ID {digimon.id}: '{digimon.profile_text[:50] if digimon.profile_text else 'EMPTY'}'...")
                
                # Load char_info data (contains motion_ref and model_ref)
                char_info_file = base_path / "patch" / "data" / "char_info.mbe"
                char_info_data = self._load_char_info_from_csv(char_info_file, digimon.char_key)
                if char_info_data:
                    digimon.motion_id = char_info_data.get('motion_ref', "")
                    digimon.model_id = char_info_data.get('model_ref', "")
                    print(f"DEBUG: Loaded from char_info - model_id: '{digimon.model_id}', motion_id: '{digimon.motion_id}'")
                
                # Load model settings
                model_file = base_path / "patch" / "data" / "model_setting.mbe"
                digimon.model_setting_data = self._load_model_setting_from_csv(model_file, digimon.chr_id)
                
                # Load LOD data
                lod_file = base_path / "patch" / "data" / "lod_chara.mbe"
                digimon.lod_data = self._load_lod_from_csv(lod_file, digimon.chr_id)
                
                # Load evolution data
                evolution_file = base_path / "patch" / "data" / "evolution.mbe"
                digimon.evolution_paths, digimon.evolution_conditions = self._load_evolution_from_csv(evolution_file, digimon.id)
                
                # Load pre-evolutions from evolution_to.csv (Digimon that evolve INTO this one)
                evolution_file_path = base_path / "patch" / "data" / "evolution.mbe"
                digimon.deevolution_sources = self._load_preevolutions_from_csv(evolution_file_path, digimon.id)
                
                # Load tribe/belong data
                belong_file = base_path / "patch_text01" / "text" / "belong.mbe"
                digimon.tribe_name = self._load_tribe_from_csv(belong_file, digimon.id)
                
                # Initialize other required data structures
                digimon.model_locator_data = {}
                digimon.model_locator_motion_data = []
                digimon.field_move_animation_data = []
                digimon.lod_model_data = {}
                
                digimon_list.append(digimon)
        
        return digimon_list
    
    def _load_name_from_csv(self, base_path: Path, char_key: str) -> str:
        """Load Digimon name from char_name CSV files"""
        import csv
        
        csv_files = list(base_path.glob("*.ap.csv"))
        for csv_file in csv_files:
            try:
                with open(csv_file, 'r', encoding='utf-8') as f:
                    reader = csv.reader(f)
                    next(reader)  # Skip header
                    for row in reader:
                        if len(row) >= 2 and row[0].strip('"') == char_key:
                            return row[1].strip('"')
            except:
                continue
        return "Unknown"
    
    def _load_char_info_from_csv(self, base_path: Path, char_key: str) -> dict:
        """Load char_info data from CSV files"""
        import csv
        
        csv_files = list(base_path.glob("*.ap.csv"))
        for csv_file in csv_files:
            try:
                with open(csv_file, 'r', encoding='utf-8') as f:
                    reader = csv.reader(f)
                    next(reader)  # Skip header
                    for row in reader:
                        if len(row) >= 1 and row[0].strip('"') == char_key:
                            # Extract relevant fields and strip quotes
                            # Column 3: Model ID (model_ref)
                            # Column 8: Audio ID (motion_ref)
                            model_ref = row[3].strip('"') if len(row) > 3 and row[3] else ""
                            motion_ref = row[8].strip('"') if len(row) > 8 and row[8] else ""
                            print(f"DEBUG: Found char_info for {char_key} - motion_ref (col8): '{motion_ref}', model_ref (col3): '{model_ref}'")
                            return {
                                'motion_ref': motion_ref,  # Column 8: Audio ID (motion_ref)
                                'model_ref': model_ref  # Column 3: Model ID (model_ref)
                            }
            except Exception as e:
                print(f"DEBUG: Error loading char_info from {csv_file}: {e}")
                continue
        print(f"DEBUG: No char_info found for char_key: {char_key}")
        return {}
    
    def _load_profile_from_csv(self, base_path: Path, digimon_id: int) -> str:
        """Load Digimon profile from digimon_profile CSV files"""
        import csv
        
        # Profile key format is "digimon_{id}_profile"
        profile_key = f"digimon_{digimon_id}_profile"
        
        csv_files = list(base_path.glob("*.ap.csv"))
        for csv_file in csv_files:
            try:
                with open(csv_file, 'r', encoding='utf-8') as f:
                    reader = csv.reader(f)
                    next(reader)  # Skip header
                    for row in reader:
                        if len(row) >= 2 and row[0] == profile_key:
                            return row[1]  # Don't strip quotes - csv.reader already handles that
            except:
                continue
        return ""
    
    def _load_model_setting_from_csv(self, base_path: Path, chr_id: str) -> dict:
        """Load model_setting data from CSV files"""
        import csv
        
        csv_files = list(base_path.glob("*.ap.csv"))
        for csv_file in csv_files:
            try:
                with open(csv_file, 'r', encoding='utf-8') as f:
                    reader = csv.reader(f)
                    header = next(reader)  # Skip header
                    for row in reader:
                        if len(row) >= 1 and row[0].strip('"') == chr_id:
                            result = {'raw_data': row}
                            # Parse known fields from model_setting.mbe
                            # Column indices based on research findings
                            if len(row) > 10:
                                try:
                                    result['npc_collision'] = float(row[10]) if row[10] else 0.0
                                except (ValueError, TypeError):
                                    result['npc_collision'] = 0.0
                            if len(row) > 38:
                                try:
                                    result['digimon_distance_from_agent'] = float(row[38]) if row[38] else 0.0
                                except (ValueError, TypeError):
                                    result['digimon_distance_from_agent'] = 0.0
                            if len(row) > 39:
                                try:
                                    result['agent_distance_2'] = float(row[39]) if row[39] else 0.0
                                except (ValueError, TypeError):
                                    result['agent_distance_2'] = 0.0
                            if len(row) > 40:
                                try:
                                    result['agent_distance'] = int(row[40]) if row[40] else 0
                                except (ValueError, TypeError):
                                    result['agent_distance'] = 0
                            if len(row) > 43:
                                try:
                                    result['camera_distance_skill'] = float(row[43]) if row[43] else 0.0
                                except (ValueError, TypeError):
                                    result['camera_distance_skill'] = 0.0
                            if len(row) > 47:
                                try:
                                    result['shield_size'] = float(row[47]) if row[47] else 0.0
                                except (ValueError, TypeError):
                                    result['shield_size'] = 0.0
                            if len(row) > 56:
                                try:
                                    result['battle_scale'] = float(row[56]) if row[56] else 1.0
                                except (ValueError, TypeError):
                                    result['battle_scale'] = 1.0
                            if len(row) > 58:
                                try:
                                    result['menu_scale'] = float(row[58]) if row[58] else 1.0
                                except (ValueError, TypeError):
                                    result['menu_scale'] = 1.0
                            if len(row) > 59:
                                try:
                                    result['field_scale'] = float(row[59]) if row[59] else 1.0
                                except (ValueError, TypeError):
                                    result['field_scale'] = 1.0
                            if len(row) > 71:
                                try:
                                    result['rideable'] = int(row[71]) if row[71] else 0
                                except (ValueError, TypeError):
                                    result['rideable'] = 0
                            return result
            except:
                continue
        return {}
    
    def _resolve_prefixed_file(self, file_path: Path) -> Path:
        """
        Resolve file path with flexible numeric prefix (e.g., 000_, 01_, 1_).
        Wraps the loader's method for use in DigimonEditor.
        """
        return self.loader._resolve_prefixed_file(file_path)
    
    def _load_lod_from_csv(self, base_path: Path, chr_id: str) -> dict:
        """Load LOD data from CSV files"""
        import csv
        
        lod_file = self._resolve_prefixed_file(base_path / "000_lod.ap.csv")
        if lod_file.exists():
            try:
                with open(lod_file, 'r', encoding='utf-8') as f:
                    reader = csv.reader(f)
                    next(reader)  # Skip header
                    for row in reader:
                        if len(row) >= 4 and row[0].strip('"') == chr_id:
                            return {
                                'lod_distance_1': float(row[1]) if row[1] else 20,
                                'lod_distance_2': float(row[2]) if row[2] else 65,
                                'lod_distance_3': float(row[3]) if row[3] else 500
                            }
            except:
                pass
        
        return {'lod_distance_1': 20, 'lod_distance_2': 65, 'lod_distance_3': 500}
    
    def _load_evolution_from_csv(self, base_path: Path, digimon_id: int):
        """Load evolution paths and conditions from CSV files"""
        import csv
        
        evolution_paths = []
        evolution_conditions = []
        
        # Load evolution paths from 001_evolution_to.ap.csv
        evo_file = self._resolve_prefixed_file(base_path / "001_evolution_to.ap.csv")
        if evo_file.exists():
            try:
                with open(evo_file, 'r', encoding='utf-8') as f:
                    reader = csv.reader(f)
                    next(reader)  # Skip header
                    for row in reader:
                        if len(row) >= 4:
                            from_id = int(row[1]) if row[1] else 0
                            if from_id == digimon_id:
                                to_id = int(row[3]) if row[3] else 0
                                evo_type = int(row[5]) if len(row) > 5 and row[5] else 0
                                if to_id > 0:
                                    evolution_paths.append({
                                        'to_id': to_id,
                                        'evolution_type': evo_type
                                    })
            except Exception as e:
                print(f"Error loading evolution paths: {e}")
        
        # Load evolution conditions from 000_evolution_condition.ap.csv
        cond_file = self._resolve_prefixed_file(base_path / "000_evolution_condition.ap.csv")
        if cond_file.exists():
            try:
                with open(cond_file, 'r', encoding='utf-8') as f:
                    reader = csv.reader(f)
                    next(reader)  # Skip header
                    for row in reader:
                        if len(row) >= 3:
                            target_id = int(row[0]) if row[0] else 0
                            if target_id == digimon_id:
                                evolution_conditions.append({
                                    'mode': int(row[2]) if row[2] else 1,
                                    'tamerLevel': int(row[3]) if len(row) > 3 and row[3] else 0,
                                    'HP': int(row[4]) if len(row) > 4 and row[4] else 0,
                                    'SP': int(row[5]) if len(row) > 5 and row[5] else 0,
                                    'ATK': int(row[6]) if len(row) > 6 and row[6] else 0,
                                    'DEF': int(row[7]) if len(row) > 7 and row[7] else 0,
                                    'INT': int(row[8]) if len(row) > 8 and row[8] else 0,
                                    'SPI': int(row[9]) if len(row) > 9 and row[9] else 0,
                                    'SPD': int(row[10]) if len(row) > 10 and row[10] else 0,
                                    'skillCountValor': int(row[13]) if len(row) > 13 and row[13] else 0,
                                    'skillCountPhilantropy': int(row[14]) if len(row) > 14 and row[14] else 0,
                                    'skillCountAmicable': int(row[15]) if len(row) > 15 and row[15] else 0,
                                    'skillCountWisdom': int(row[16]) if len(row) > 16 and row[16] else 0,
                                    'needsItem': int(row[22]) if len(row) > 22 and row[22] else 0,
                                    'jogressDbIdA': int(row[24]) if len(row) > 24 and row[24] else 0,
                                    'jogressPersonalityA': int(row[26]) if len(row) > 26 and row[26] else 0,
                                    'jogressDbIdB': int(row[27]) if len(row) > 27 and row[27] else 0,
                                    'jogressPersonalityB': int(row[29]) if len(row) > 29 and row[29] else 0
                                })
            except Exception as e:
                print(f"Error loading evolution conditions: {e}")
        
        return evolution_paths, evolution_conditions
    
    def _load_preevolutions_from_csv(self, base_path: Path, digimon_id: int):
        """Load pre-evolutions from evolution_to.csv
        
        Pre-evolutions are Digimon that evolve INTO this Digimon.
        In evolution_to.csv:
        - Column 1 = source Digimon ID (the one that evolves)
        - Column 3 = target Digimon ID (what it evolves into)
        
        So pre-evolutions are entries where column 3 == digimon_id
        """
        import csv
        
        preevolution_sources = []
        
        evo_file = self._resolve_prefixed_file(base_path / "001_evolution_to.ap.csv")
        if evo_file.exists():
            try:
                with open(evo_file, 'r', encoding='utf-8') as f:
                    reader = csv.reader(f)
                    next(reader)  # Skip header
                    for row in reader:
                        if len(row) >= 4:
                            source_id = int(row[1]) if row[1] else 0
                            target_id = int(row[3]) if row[3] else 0
                            evo_type = int(row[5]) if len(row) > 5 and row[5] else 0
                            
                            # If this Digimon is the TARGET, then source is a pre-evolution
                            if target_id == digimon_id and source_id > 0:
                                preevolution_sources.append({
                                    'from_id': source_id,
                                    'evolution_type': evo_type
                                })
            except Exception as e:
                print(f"Error loading pre-evolutions: {e}")
        
        return preevolution_sources
    
    def _load_tribe_from_csv(self, base_path: Path, digimon_id: int) -> str:
        """Load tribe/belong data from CSV"""
        import csv
        
        tribe_file = self._resolve_prefixed_file(base_path / "000_Sheet1.ap.csv")
        if tribe_file.exists():
            try:
                with open(tribe_file, 'r', encoding='utf-8') as f:
                    reader = csv.reader(f)
                    next(reader)  # Skip header
                    for row in reader:
                        if len(row) >= 2:
                            row_id = int(row[0]) if row[0] else 0
                            if row_id == digimon_id:
                                return row[1].strip('"') if row[1] else "None"
            except Exception as e:
                print(f"Error loading tribe: {e}")
        
        return "None"
    
    def create_new_digimon(self):
        """Create a new Digimon entry using a selected Digimon as template"""
        # Create dialog to select template Digimon
        dialog = QDialog(self)
        dialog.setWindowTitle("Create New Digimon")
        dialog.setMinimumWidth(400)
        layout = QVBoxLayout(dialog)
        
        # Instructions
        instruction_label = QLabel(
            "Select a Digimon to use as a template.\n"
            "The new Digimon will copy all stats, skills, and properties\n"
            "from the selected template, which you can then customize."
        )
        instruction_label.setWordWrap(True)
        layout.addWidget(instruction_label)
        
        # Template selection
        layout.addWidget(QLabel("\nTemplate Digimon:"))
        template_combo = QComboBox()
        
        # Populate with all Digimon (sorted by ID)
        chr_ids = self.loader.get_all_digimon_chr_ids()
        
        # Sort by numeric part, handling non-numeric suffixes (e.g., chr183aa010101)
        def sort_key(chr_id):
            try:
                # Extract just the numeric part after 'chr'
                numeric_part = ''
                for char in chr_id.replace('chr', ''):
                    if char.isdigit():
                        numeric_part += char
                    else:
                        break
                return int(numeric_part) if numeric_part else 999999
            except:
                return 999999
        
        chr_ids_sorted = sorted(chr_ids, key=sort_key)
        
        for chr_id in chr_ids_sorted:
            name = self.loader._get_digimon_name_by_chr_id(chr_id)
            digimon_id = chr_id.replace('chr', '')
            template_combo.addItem(f"{name} ({chr_id})", chr_id)
        
        # Default to chr805 (Darkshadow)
        default_index = template_combo.findData("chr805")
        if default_index >= 0:
            template_combo.setCurrentIndex(default_index)
        
        layout.addWidget(template_combo)
        
        # Buttons
        buttons = QDialogButtonBox(
            QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel
        )
        buttons.accepted.connect(dialog.accept)
        buttons.rejected.connect(dialog.reject)
        layout.addWidget(buttons)
        
        # Show dialog
        if dialog.exec() == QDialog.DialogCode.Rejected:
            return  # User cancelled
        
        # Get selected template
        template_chr_id = template_combo.currentData()
        template_digimon = self.loader.get_digimon_by_chr_id(template_chr_id)
        
        if not template_digimon:
            QMessageBox.warning(
                self,
                "Error",
                f"Failed to load template Digimon: {template_chr_id}"
            )
            return
        
        # Use template but with new ID and name
        digimon = template_digimon
        
        # Find the next available ID - check both base game and DLC
        existing_ids = self.loader.get_all_digimon_ids()
        # Also check DLC IDs
        try:
            dlc_exporter = DLCExporter(self.loader)
            dlc_data = dlc_exporter.get_dlc_path("addcont_17") / "data" / "mbe"
            dlc_status_file = self.loader._resolve_prefixed_file(dlc_data / "digimon_status_dlc17.mbe" / "000_digimon_status_data.csv")
            if dlc_status_file.exists():
                dlc_rows = self.loader.load_csv(dlc_status_file)
                for row in dlc_rows[1:]:  # Skip header
                    if len(row) > 0 and row[0]:
                        try:
                            existing_ids.append(int(row[0]))
                        except ValueError:
                            continue
        except Exception:
            pass  # If DLC check fails, just use base game IDs
        next_id = max(existing_ids) + 1 if existing_ids else 1000
        
        digimon.id = next_id
        digimon.name = f"New Digimon (based on {template_digimon.name})"
        digimon.char_key = "char_NEW_DIGIMON"  # User can customize this
        
        # Create NEW chr_id for this Digimon (like chr1000)
        # But store template chr_id for animations (saved in animation_ref_edit)
        new_chr_id = f"chr{next_id}"
        digimon.chr_id = new_chr_id  # NEW unique chr_id
        
        # Store template chr_id separately (will be used in animation reference)
        self.template_chr_id_for_animation = template_chr_id
        
        self.load_digimon_data(digimon)
        
        # Show info message
        QMessageBox.information(
            self,
            "Template Loaded",
            f"✅ Created new Digimon based on {template_digimon.name}!\n\n"
            f"New ID: {next_id}\n"
            f"New Chr ID: {new_chr_id}\n"
            f"Animation Reference: {template_chr_id}\n\n"
            f"The new Digimon has a unique chr_id ({new_chr_id})\n"
            f"but uses animations from {template_chr_id}.\n\n"
            f"Customize the stats and click 'Export to DLC'."
        )
        
        # Refresh the digimon list to show the new Digimon
        self.load_digimon_list()
    
    def save_current_digimon(self):
        """Save the current Digimon data"""
        if not self.current_digimon:
            return
        
        # Store original values before updating
        original_id = self.current_digimon.id
        original_chr_id = self.current_digimon.chr_id
        chr_id_to_reload = self.current_digimon.chr_id
        
        # Update current digimon with form data
        self.update_digimon_from_form()
        
        # Validate for duplicates
        if not self.validate_digimon_uniqueness(original_id, original_chr_id):
            # Revert changes
            self.current_digimon.id = original_id
            self.current_digimon.chr_id = original_chr_id
            return
        
        # Check if this is an imported Digimon
        is_imported = hasattr(self.loader, 'imported_digimon') and any(
            d.chr_id == self.current_digimon.chr_id for d in self.loader.imported_digimon
        )
        
        if is_imported:
            # Create custom dialog for save options
            dialog = QMessageBox(self)
            dialog.setWindowTitle("Save Imported Digimon")
            dialog.setText(f"Where would you like to save {self.current_digimon.name}?")
            dialog.setInformativeText(
                "📥 dsts-loader: Update the .ap.csv files\n"
                "📦 DLC: Add to DLC files"
            )
            
            dsts_button = dialog.addButton("📥 Save to dsts-loader", QMessageBox.ButtonRole.AcceptRole)
            dlc_button = dialog.addButton("📦 Save to DLC", QMessageBox.ButtonRole.ActionRole)
            cancel_button = dialog.addButton("Cancel", QMessageBox.ButtonRole.RejectRole)
            
            dialog.exec()
            clicked = dialog.clickedButton()
            
            if clicked == cancel_button:
                return
            elif clicked == dsts_button:
                # Save to dsts-loader
                self.save_to_dsts_loader(self.current_digimon)
                return
            elif clicked == dlc_button:
                # Save to DLC
                self.save_to_dlc(self.current_digimon, chr_id_to_reload)
                return
        
        # Check if this Digimon is from DLC or base game
        is_from_dlc = self.source_combo.currentData()
        
        if is_from_dlc:
            # Save to DLC instead of base game
            dlc_exporter = DLCExporter(self.loader)
            animation_ref = self.animation_ref_edit.text().strip() if self.animation_ref_edit.text().strip() else self.current_digimon.chr_id
            
            if dlc_exporter.save_digimon_to_dlc(self.current_digimon, animation_ref):
                self.clear_modified_flag()
                QMessageBox.information(self, "Success", "Digimon data saved to DLC successfully!")
                # Invalidate caches to ensure fresh data is loaded
                if hasattr(self.loader, '_invalidate_digimon_status_cache'):
                    self.loader._invalidate_digimon_status_cache()
                # Clear profile cache to reload updated profile text
                self.loader._digimon_profiles_cache = None
                # Clear char_names cache if it exists to force fresh name lookup
                if hasattr(self.loader, '_char_names_cache'):
                    self.loader._char_names_cache = None
                # Refresh the digimon list to show any changes
                self.load_digimon_list()
                # Small delay to ensure file writes are complete
                QApplication.processEvents()
                # Reload the Digimon data to reflect any changes from save
                digimon = self.loader.get_digimon_by_chr_id(chr_id_to_reload)
                if digimon:
                    # Ensure name is loaded from DLC files
                    digimon.name = self.loader._get_digimon_name(digimon.char_key, check_dlc=True)
                    self.load_digimon_data(digimon)
            else:
                QMessageBox.warning(self, "Error", "Failed to save Digimon data to DLC")
        else:
            # Save to base game files
            if self.loader.save_digimon_data(self.current_digimon):
                self.clear_modified_flag()
                QMessageBox.information(self, "Success", "Digimon data saved successfully!")
                # Invalidate caches to ensure fresh data is loaded
                if hasattr(self.loader, '_invalidate_digimon_status_cache'):
                    self.loader._invalidate_digimon_status_cache()
                # Clear profile cache to reload updated profile text
                self.loader._digimon_profiles_cache = None
                # Clear char_names cache if it exists to force fresh name lookup
                if hasattr(self.loader, '_char_names_cache'):
                    self.loader._char_names_cache = None
                # Refresh the digimon list to show any changes
                self.load_digimon_list()
                # Small delay to ensure file writes are complete
                QApplication.processEvents()
                # Reload the Digimon data to reflect any changes from save
                digimon = self.loader.get_digimon_by_chr_id(chr_id_to_reload)
                if digimon:
                    # Ensure name is loaded from files
                    digimon.name = self.loader._get_digimon_name(digimon.char_key, check_dlc=True)
                    self.load_digimon_data(digimon)
            else:
                QMessageBox.warning(self, "Error", "Failed to save Digimon data")
    
    def remove_digimon_from_dlc(self):
        """Remove the current Digimon from DLC files"""
        if not self.current_digimon:
            QMessageBox.warning(self, "No Digimon", "Please load a Digimon first.")
            return
        
        # Check if this Digimon is from DLC
        is_from_dlc = self.source_combo.currentData()
        if not is_from_dlc:
            QMessageBox.warning(
                self, 
                "Cannot Remove", 
                "This Digimon is from the base game and cannot be removed.\n\n"
                "Only Digimon from DLC can be removed."
            )
            return
        
        # Confirmation dialog
        reply = QMessageBox.question(
            self,
            "Remove Digimon from DLC",
            f"⚠️ WARNING: This will permanently remove {self.current_digimon.name} (ID: {self.current_digimon.id}) from all DLC files!\n\n"
            f"This action cannot be undone.\n\n"
            f"The following will be removed:\n"
            f"- Character info\n"
            f"- Status data\n"
            f"- Evolution paths\n"
            f"- Name and profile text\n"
            f"- Model and animation data\n\n"
            f"Are you absolutely sure?",
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No,
            QMessageBox.StandardButton.No
        )
        
        if reply == QMessageBox.StandardButton.No:
            return
        
        # Remove from DLC
        dlc_exporter = DLCExporter(self.loader)
        success = dlc_exporter.remove_digimon_from_dlc(
            digimon_id=self.current_digimon.id,
            chr_id=self.current_digimon.chr_id,
            char_key=self.current_digimon.char_key
        )
        
        if success:
            QMessageBox.information(
                self,
                "Success",
                f"✅ {self.current_digimon.name} has been removed from DLC files!\n\n"
                f"All references to this Digimon have been cleaned up.\n"
                f"Remember to repack DLC to MBE files to finalize the changes."
            )
            # Clear current digimon and refresh list
            self.current_digimon = None
            self.current_digimon_label.setText("📂 No Digimon loaded")
            self.remove_button.setEnabled(False)
            self.save_button.setEnabled(False)
            self.export_dlc_button.setEnabled(False)
            self.load_digimon_list()
        else:
            QMessageBox.warning(
                self,
                "Error",
                f"Failed to remove {self.current_digimon.name} from DLC.\n\n"
                f"Check the console for details."
            )
    
    def export_to_dlc(self):
        """Export the current Digimon to DLC files"""
        if not self.current_digimon:
            return
        
        # Update current digimon with form data
        self.update_digimon_from_form()
        
        # Don't sync chr_id for DLC export - use animation_ref separately
        # chr_id = unique ID for this Digimon (e.g., chr1000)
        # animation_ref = which chr_id to use for animations (e.g., chr805)
        
        # Confirm export
        reply = QMessageBox.question(
            self, 
            "Export to DLC", 
            f"Export {self.current_digimon.name} (ID: {self.current_digimon.id}) to DLC files?\n\n"
            f"This will create/update entries in:\n"
            f"- DLC/addcont_17.dx11/data/mbe/ (game data)\n"
            f"- DLC/addcont_17_text01.dx11/text/mbe/ (text data)\n\n"
            f"Base game files will NOT be modified.",
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No
        )
        
        if reply == QMessageBox.StandardButton.No:
            return
        
        # Export to DLC
        dlc_exporter = DLCExporter(self.loader)
        
        # Pass the animation reference chr_id
        animation_ref_chr_id = self.animation_ref_edit.text().strip() if self.animation_ref_edit.text().strip() else self.current_digimon.chr_id
        
        if dlc_exporter.save_digimon_to_dlc(self.current_digimon, animation_ref_chr_id):
            QMessageBox.information(
                self, 
                "Success", 
                f"✅ {self.current_digimon.name} exported to DLC!\n\n"
                f"The Digimon has been added to DLC files and will appear in-game\n"
                f"without modifying the base game data."
            )
        else:
            QMessageBox.warning(self, "Error", "Failed to export to DLC")
    
    def save_to_dsts_loader(self, digimon: DigimonData):
        """Save Digimon back to dsts-loader format (merges with existing data)"""
        from pathlib import Path
        
        # Ask user to select dsts-loader directory
        default_path = Path.cwd() / "dsts-loader"
        
        loader_dir = QFileDialog.getExistingDirectory(
            self,
            "Select dsts-loader Directory to Save To",
            str(default_path),
            QFileDialog.Option.ShowDirsOnly
        )
        
        if not loader_dir:
            return
        
        # Update form data before saving
        self.update_digimon_from_form()
        
        output_path = Path(loader_dir)
        
        # Check if destination already has files
        patch_data_dir = output_path / "patch" / "data"
        has_existing = False
        if patch_data_dir.exists():
            status_file = patch_data_dir / "digimon_status.mbe" / "000_digimon_status_data.ap.csv"
            resolved_status_file = self._resolve_prefixed_file(status_file)
            if resolved_status_file.exists():
                has_existing = True
        
        # Always use merge mode to preserve other Digimon data
        if self._merge_digimon_to_dsts_loader(output_path, digimon):
            self.clear_modified_flag()
            if has_existing:
                QMessageBox.information(
                    self,
                    "Success! ✅",
                    f"✅ {digimon.name} has been updated in dsts-loader!\n\n"
                    f"Location: {loader_dir}\n\n"
                    "Other Digimon data was preserved."
                )
            else:
                QMessageBox.information(
                    self,
                    "Success! ✅",
                    f"✅ {digimon.name} has been saved to dsts-loader format!\n\n"
                    f"Location: {loader_dir}\n\n"
                    "All .ap.csv files have been created."
                )
        else:
            QMessageBox.warning(self, "Error", "Failed to save to dsts-loader format")
    
    def save_to_dlc(self, digimon: DigimonData, chr_id_to_reload: str):
        """Save Digimon to DLC files"""
        dlc_exporter = DLCExporter(self.loader)
        animation_ref = self.animation_ref_edit.text().strip() if self.animation_ref_edit.text().strip() else digimon.chr_id
        
        if dlc_exporter.save_digimon_to_dlc(digimon, animation_ref):
            self.clear_modified_flag()
            QMessageBox.information(
                self,
                "Success! ✅",
                f"✅ {digimon.name} has been saved to DLC!\n\n"
                "The Digimon is now available in DLC files."
            )
            # Invalidate caches
            if hasattr(self.loader, '_invalidate_digimon_status_cache'):
                self.loader._invalidate_digimon_status_cache()
            self.loader._digimon_profiles_cache = None
            if hasattr(self.loader, '_char_names_cache'):
                self.loader._char_names_cache = None
            
            # Refresh list
            self.load_digimon_list()
            
            # Reload Digimon
            QApplication.processEvents()
            digimon_reloaded = self.loader.get_digimon_by_chr_id(chr_id_to_reload)
            if digimon_reloaded:
                digimon_reloaded.name = self.loader._get_digimon_name(digimon_reloaded.char_key, check_dlc=True)
                self.load_digimon_data(digimon_reloaded)
        else:
            QMessageBox.warning(self, "Error", "Failed to save to DLC")
    
    def update_digimon_from_form(self):
        """Update current Digimon with data from form"""
        if not self.current_digimon:
            return
        
        # Basic Info
        self.current_digimon.id = self.id_spin.value()
        self.current_digimon.char_key = self.char_key_edit.text()
        self.current_digimon.chr_id = self.chr_id_edit.text()
        self.current_digimon.name = self.name_edit.text()
        self.current_digimon.stage_id = self.stage_combo.currentData() if self.stage_combo.currentData() is not None else 0
        self.current_digimon.type_id = self.type_combo.currentData() if self.type_combo.currentData() is not None else 0
        self.current_digimon.generation_id = self.stage_combo.currentData() if self.stage_combo.currentData() is not None else 0  # Generation is the same as stage
        self.current_digimon.personality_id = self.personality_combo.currentData() if self.personality_combo.currentData() is not None else 0
        self.current_digimon.base_personality = self.personality_combo.currentData() if self.personality_combo.currentData() is not None else 0
        self.current_digimon.tribe_name = self.tribe_combo.currentText() if self.tribe_combo.currentText() else "None"
        
        # Profile text
        self.current_digimon.profile_text = self.profile_text_edit.toPlainText()
        
        # Stats
        self.current_digimon.base_hp = self.stat_widgets["hp"].value()
        self.current_digimon.base_sp = self.stat_widgets["sp"].value()
        self.current_digimon.base_atk = self.stat_widgets["atk"].value()
        self.current_digimon.base_def = self.stat_widgets["def"].value()
        self.current_digimon.base_int = self.stat_widgets["int"].value()
        self.current_digimon.base_spi = self.stat_widgets["spi"].value()
        self.current_digimon.base_spd = self.stat_widgets["spd"].value()
        self.current_digimon.growth_pattern_id = self.growth_pattern_combo.currentData() if self.growth_pattern_combo.currentData() is not None else 1
        
        # Resistances
        self.current_digimon.res_null = self.resist_widgets["null"].value()
        self.current_digimon.res_fire = self.resist_widgets["fire"].value()
        self.current_digimon.res_water = self.resist_widgets["water"].value()
        self.current_digimon.res_ice = self.resist_widgets["ice"].value()
        self.current_digimon.res_grass = self.resist_widgets["grass"].value()
        self.current_digimon.res_wind = self.resist_widgets["wind"].value()
        self.current_digimon.res_elec = self.resist_widgets["elec"].value()
        self.current_digimon.res_ground = self.resist_widgets["ground"].value()
        self.current_digimon.res_steel = self.resist_widgets["steel"].value()
        self.current_digimon.res_light = self.resist_widgets["light"].value()
        self.current_digimon.res_dark = self.resist_widgets["dark"].value()
        
        # Skills
        self.current_digimon.signature_skills = self.signature_skills_editor.get_skills()
        self.current_digimon.generic_skills = self.generic_skills_editor.get_skills()
        
        # Traits
        self.current_digimon.traits = self.traits_tab.get_traits()
        
        # Model data
        self.current_digimon.model_id = self.model_id_edit.text()
        self.current_digimon.motion_id = self.motion_id_edit.text()
        
        # LOD data - FIX: Save LOD distances from widgets
        if not hasattr(self.current_digimon, 'lod_data') or not self.current_digimon.lod_data:
            self.current_digimon.lod_data = {}
        
        for key, widget in self.lod_widgets.items():
            self.current_digimon.lod_data[key] = widget.value()
        
        # Model settings (from model_setting.mbe)
        if not hasattr(self.current_digimon, 'model_setting_data') or not self.current_digimon.model_setting_data:
            self.current_digimon.model_setting_data = {}
        
        # Update parsed fields from UI
        self.current_digimon.model_setting_data['battle_scale'] = self.battle_scale_spin.value()
        self.current_digimon.model_setting_data['menu_scale'] = self.menu_scale_spin.value()
        self.current_digimon.model_setting_data['field_scale'] = self.field_scale_spin.value()
        self.current_digimon.model_setting_data['npc_collision'] = self.npc_collision_spin.value()
        self.current_digimon.model_setting_data['shield_size'] = self.shield_size_spin.value()
        self.current_digimon.model_setting_data['agent_distance'] = self.agent_distance_spin.value()
        self.current_digimon.model_setting_data['agent_distance_2'] = self.agent_distance_2_spin.value()
        self.current_digimon.model_setting_data['digimon_distance_from_agent'] = self.digimon_distance_spin.value()
        self.current_digimon.model_setting_data['camera_distance_skill'] = self.camera_distance_skill_spin.value()
        self.current_digimon.model_setting_data['rideable'] = 1 if self.rideable_checkbox.isChecked() else 0
        
        # Update raw_data array if it exists
        if 'raw_data' in self.current_digimon.model_setting_data:
            raw_data = self.current_digimon.model_setting_data['raw_data']
            # Update specific columns based on research findings
            if len(raw_data) > 10:
                raw_data[10] = str(self.npc_collision_spin.value())
            if len(raw_data) > 38:
                raw_data[38] = str(self.digimon_distance_spin.value())
            if len(raw_data) > 39:
                raw_data[39] = str(self.agent_distance_2_spin.value())
            if len(raw_data) > 40:
                raw_data[40] = str(self.agent_distance_spin.value())
            if len(raw_data) > 43:
                raw_data[43] = str(self.camera_distance_skill_spin.value())
            if len(raw_data) > 47:
                raw_data[47] = str(self.shield_size_spin.value())
            if len(raw_data) > 56:
                raw_data[56] = str(self.battle_scale_spin.value())
            if len(raw_data) > 58:
                raw_data[58] = str(self.menu_scale_spin.value())
            if len(raw_data) > 59:
                raw_data[59] = str(self.field_scale_spin.value())
            if len(raw_data) > 71:
                raw_data[71] = str(1 if self.rideable_checkbox.isChecked() else 0)
        
        # Evolution data - FIX: Save evolution paths from evolution tab
        # Note: Evolution paths are managed through add_evolution/remove_evolution methods
        # which directly modify self.current_digimon.evolution_paths and deevolution_sources
        # So they should already be updated, but we ensure the data structure exists
        if not hasattr(self.current_digimon, 'evolution_paths'):
            self.current_digimon.evolution_paths = []
        if not hasattr(self.current_digimon, 'deevolution_sources'):
            self.current_digimon.deevolution_sources = []
        
        # References
        self.current_digimon.field_guide_id = self.field_guide_id_spin.value()
        self.current_digimon.script_id = self.script_id_spin.value()
    
    def add_evolution(self):
        """Add a new evolution path"""
        if not self.current_digimon:
            return
        
        # Create dialog to select target Digimon
        dialog = QDialog(self)
        dialog.setWindowTitle("Add Evolution")
        dialog.setMinimumSize(550, 600)
        layout = QVBoxLayout(dialog)
        
        # Instructions
        info_label = QLabel("Select a Digimon from the list below, or enter a custom Digimon name/ID in the text field.")
        info_label.setWordWrap(True)
        info_label.setStyleSheet("color: #666; padding: 10px; background-color: #f8f9fa; border-radius: 6px;")
        layout.addWidget(info_label)
        
        # Tab widget for list selection vs custom input
        tab_widget = QTabWidget()
        
        # Tab 1: Select from list
        list_tab = QWidget()
        list_layout = QVBoxLayout(list_tab)
        list_layout.addWidget(QLabel("Select target Digimon:"))
        
        # Search box
        search_edit = QLineEdit()
        search_edit.setPlaceholderText("Search Digimon...")
        list_layout.addWidget(search_edit)
        
        target_list = QListWidget()
        target_list.setMinimumHeight(300)
        
        # Populate with all Digimon
        chr_ids = self.loader.get_all_digimon_chr_ids()
        for chr_id in chr_ids:
            name = self.loader._get_digimon_name_by_chr_id(chr_id)
            if not name:
                name = chr_id
            # Try to get ID
            digimon_obj = self.loader.get_digimon_by_chr_id(chr_id)
            digimon_id = digimon_obj.id if digimon_obj else 0
            target_list.addItem(f"{name} ({chr_id}) - ID: {digimon_id}")
        
        # Filter on search
        def filter_digimon(text):
            for i in range(target_list.count()):
                item = target_list.item(i)
                if item:
                    item.setHidden(text.lower() not in item.text().lower())
        search_edit.textChanged.connect(filter_digimon)
        
        list_layout.addWidget(target_list)
        tab_widget.addTab(list_tab, "Select from List")
        
        # Tab 2: Custom input
        custom_tab = QWidget()
        custom_layout = QVBoxLayout(custom_tab)
        
        custom_info = QLabel("Enter a Digimon by name or ID.\nExamples:\n• Digimon Name: 'Agumon'\n• Chr ID: 'chr050'\n• Numeric ID: '50'")
        custom_info.setWordWrap(True)
        custom_info.setStyleSheet("color: #666; padding: 10px; background-color: #e7f5ff; border-radius: 6px;")
        custom_layout.addWidget(custom_info)
        
        custom_input = QLineEdit()
        custom_input.setPlaceholderText("Enter Digimon name, chr_id (e.g., chr050), or numeric ID")
        custom_layout.addWidget(QLabel("Custom Digimon:"))
        custom_layout.addWidget(custom_input)
        
        # Also allow custom ID directly
        custom_id_label = QLabel("Or enter numeric ID directly:")
        custom_id_spin = QSpinBox()
        custom_id_spin.setRange(1, 999999)
        custom_id_spin.setValue(1000)
        custom_layout.addWidget(custom_id_label)
        custom_layout.addWidget(custom_id_spin)
        
        custom_layout.addStretch()
        tab_widget.addTab(custom_tab, "Custom Input")
        
        layout.addWidget(tab_widget)
        
        buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel)
        buttons.accepted.connect(dialog.accept)
        buttons.rejected.connect(dialog.reject)
        layout.addWidget(buttons)
        
        if dialog.exec() == QDialog.DialogCode.Accepted:
            target_digimon_id = None
            target_chr_id = None
            
            if tab_widget.currentIndex() == 0:
                # List tab selected
                selected_item = target_list.currentItem()
                if selected_item:
                    # Extract chr_id from item text (format: "Name (chr_id) - ID: 123")
                    item_text = selected_item.text()
                    # Try to extract chr_id (e.g., "chr050")
                    import re
                    chr_match = re.search(r'\(chr\d+\)', item_text)
                    if chr_match:
                        target_chr_id = chr_match.group(0)[1:-1]  # Remove parentheses
            target_digimon = self.loader.get_digimon_by_chr_id(target_chr_id)
            if target_digimon:
                            target_digimon_id = target_digimon.id
            else:
                # Custom tab selected
                custom_text = custom_input.text().strip()
                found = False
                if custom_text:
                    # First check imported Digimon (custom Digimon from dsts-loader)
                    if hasattr(self.loader, 'imported_digimon') and self.loader.imported_digimon:
                        for imported_digimon in self.loader.imported_digimon:
                            # Check by name (case-insensitive partial match)
                            if custom_text.lower() in imported_digimon.name.lower():
                                target_chr_id = imported_digimon.chr_id
                                target_digimon_id = imported_digimon.id
                                found = True
                                break
                            # Check by chr_id (exact match)
                            if imported_digimon.chr_id.lower() == custom_text.lower():
                                target_chr_id = imported_digimon.chr_id
                                target_digimon_id = imported_digimon.id
                                found = True
                                break
                            # Check by numeric ID
                            if str(imported_digimon.id) == custom_text:
                                target_chr_id = imported_digimon.chr_id
                                target_digimon_id = imported_digimon.id
                                found = True
                                break
                    
                    # If not found in imported, try standard lookup
                    if not target_digimon_id:
                        # Try to find by name first
                        chr_ids_all = self.loader.get_all_digimon_chr_ids()
                        found = False
                        for chr_id in chr_ids_all:
                            name = self.loader._get_digimon_name_by_chr_id(chr_id)
                            if name and custom_text.lower() in name.lower():
                                target_chr_id = chr_id
                                target_digimon = self.loader.get_digimon_by_chr_id(chr_id)
                                if target_digimon:
                                    target_digimon_id = target_digimon.id
                                    found = True
                                    break
                        
                        # If not found by name, try as chr_id
                        if not found and (custom_text.startswith('chr') or custom_text.startswith('CHR')):
                            target_chr_id = custom_text.lower().replace('chr', 'chr')
                            target_digimon = self.loader.get_digimon_by_chr_id(target_chr_id)
                            if target_digimon:
                                target_digimon_id = target_digimon.id
                        
                        # If still not found, try as numeric ID
                        if not found and custom_text.isdigit():
                            target_digimon_id = int(custom_text)
                            # Try to find chr_id from ID
                            try:
                                status_file = self.loader._resolve_prefixed_file(self.loader.data_path / "digimon_status.mbe" / "000_digimon_status_data.csv")
                                if status_file.exists():
                                    rows = self.loader.load_csv(status_file)
                                    for row in rows[1:]:
                                        if len(row) > 0 and row[0] == str(target_digimon_id):
                                            if len(row) > 3:
                                                target_chr_id = row[3].strip('"')
                                                break
                            except:
                                pass
                
                # If custom input didn't work, use spinbox value
                if not target_digimon_id:
                    target_digimon_id = custom_id_spin.value()
                    # Generate chr_id from numeric ID
                    target_chr_id = f"chr{target_digimon_id:03d}"
            
            # Add evolution if we have an ID
            if target_digimon_id:
                # Check if evolution already exists
                existing = False
                for evo in self.current_digimon.evolution_paths:
                    if evo.get('to_id') == target_digimon_id:
                        existing = True
                        break
                
                if existing:
                    QMessageBox.warning(self, "Already Exists", f"Evolution to Digimon ID {target_digimon_id} already exists!")
                    return
                
                # Add to evolution paths
                new_evo = {
                    'evolution_id': 0,  # Will be assigned when saved
                    'from_id': self.current_digimon.id,
                    'to_id': target_digimon_id,
                    'to_chr_id': target_chr_id,  # Store chr_id for reference
                    'condition_flags': ['0', '-1', '-1', '-1', '-1', '-1'],
                    'raw_data': []
                }
                self.current_digimon.evolution_paths.append(new_evo)
                
                # Refresh the evolution tab
                self.update_evolution_tab(self.current_digimon)
                display_name = target_chr_id if target_chr_id else f"ID {target_digimon_id}"
                QMessageBox.information(self, "Success", f"Added evolution to {display_name}")
            else:
                QMessageBox.warning(self, "Invalid Input", "Could not find or parse the Digimon. Please check your input.")
    
    def _show_evolution_requirements_dialog(self, target_name: str, existing_conditions: dict = None):
        """Show comprehensive dialog to configure evolution requirements"""
        if existing_conditions is None:
            existing_conditions = {}
        
        # Convert list format to dict format if needed
        if isinstance(existing_conditions, list):
            row = existing_conditions
            def safe_int(val):
                try:
                    if val is None or val == '':
                        return 0
                    return int(val)
                except (ValueError, TypeError):
                    return 0
            
            existing_conditions = {
                'mode': safe_int(row[2]) if len(row) > 2 else 4,
                'tamerLevel': safe_int(row[3]) if len(row) > 3 else 0,
                'HP': safe_int(row[4]) if len(row) > 4 else 0,
                'SP': safe_int(row[5]) if len(row) > 5 else 0,
                'ATK': safe_int(row[6]) if len(row) > 6 else 0,
                'DEF': safe_int(row[7]) if len(row) > 7 else 0,
                'INT': safe_int(row[8]) if len(row) > 8 else 0,
                'SPI': safe_int(row[9]) if len(row) > 9 else 0,
                'SPD': safe_int(row[10]) if len(row) > 10 else 0,
                'skillCountValor': safe_int(row[13]) if len(row) > 13 else 0,
                'skillCountPhilantropy': safe_int(row[14]) if len(row) > 14 else 0,
                'skillCountAmicable': safe_int(row[15]) if len(row) > 15 else 0,
                'skillCountWisdom': safe_int(row[16]) if len(row) > 16 else 0,
                'needsItem': safe_int(row[22]) if len(row) > 22 else 0,
                'jogressDbIdA': safe_int(row[24]) if len(row) > 24 else 0,
                'jogressPersonalityA': safe_int(row[26]) if len(row) > 26 else 0,
                'jogressDbIdB': safe_int(row[27]) if len(row) > 27 else 0,
                'jogressPersonalityB': safe_int(row[29]) if len(row) > 29 else 0
            }
        elif not isinstance(existing_conditions, dict):
            # If it's neither list nor dict, create default
            existing_conditions = {}
        
        dialog = QDialog(self)
        dialog.setWindowTitle(f"Evolution Requirements → {target_name}")
        dialog.setMinimumWidth(500)
        
        layout = QVBoxLayout(dialog)
        
        # Scroll area for all fields
        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        scroll_widget = QWidget()
        scroll_layout = QVBoxLayout(scroll_widget)
        
        # Info label
        info = QLabel("Configure the requirements needed to evolve to this Digimon.\nLeave values at 0 for no requirement.")
        info.setWordWrap(True)
        info.setStyleSheet("color: #666; padding: 8px; background: #f0f0f0; border-radius: 4px; margin-bottom: 10px;")
        scroll_layout.addWidget(info)
        
        # Agent Rank (column 2 in evolution_condition.csv)
        mode_group = QGroupBox("Agent Rank Requirement")
        mode_layout = QVBoxLayout()
        mode_combo = QComboBox()
        mode_combo.addItem("Rank 1", 1)
        mode_combo.addItem("Rank 2", 2)
        mode_combo.addItem("Rank 3", 3)
        mode_combo.addItem("Rank 4", 4)
        mode_combo.addItem("Rank 5", 5)
        mode_combo.addItem("Rank 6", 6)
        mode_combo.addItem("Rank 7", 7)
        mode_combo.addItem("Rank 8", 8)
        mode_combo.addItem("Rank 9", 9)
        mode_combo.addItem("Rank 10", 10)
        # Set existing rank
        existing_mode = existing_conditions.get('mode', 1)
        mode_combo.setCurrentIndex(mode_combo.findData(existing_mode) if mode_combo.findData(existing_mode) >= 0 else 0)
        mode_layout.addWidget(mode_combo)
        mode_group.setLayout(mode_layout)
        scroll_layout.addWidget(mode_group)
        
        # Tamer Level
        tamer_group = QGroupBox("Tamer Requirements")
        tamer_layout = QFormLayout()
        tamer_level_spin = QSpinBox()
        tamer_level_spin.setRange(0, 99)
        tamer_level_spin.setValue(existing_conditions.get('tamerLevel', 0))
        tamer_level_spin.setSuffix(" (0 = no requirement)")
        tamer_layout.addRow("Tamer Level:", tamer_level_spin)
        tamer_group.setLayout(tamer_layout)
        scroll_layout.addWidget(tamer_group)
        
        # Stat Requirements
        stats_group = QGroupBox("Stat Requirements")
        stats_layout = QFormLayout()
        
        hp_spin = QSpinBox()
        hp_spin.setRange(0, 99999)
        hp_spin.setValue(existing_conditions.get('HP', 0))
        hp_spin.setSuffix(" HP")
        stats_layout.addRow("HP:", hp_spin)
        
        sp_spin = QSpinBox()
        sp_spin.setRange(0, 99999)
        sp_spin.setValue(existing_conditions.get('SP', 0))
        sp_spin.setSuffix(" SP")
        stats_layout.addRow("SP:", sp_spin)
        
        atk_spin = QSpinBox()
        atk_spin.setRange(0, 9999)
        atk_spin.setValue(existing_conditions.get('ATK', 0))
        atk_spin.setSuffix(" ATK")
        stats_layout.addRow("ATK:", atk_spin)
        
        def_spin = QSpinBox()
        def_spin.setRange(0, 9999)
        def_spin.setValue(existing_conditions.get('DEF', 0))
        def_spin.setSuffix(" DEF")
        stats_layout.addRow("DEF:", def_spin)
        
        int_spin = QSpinBox()
        int_spin.setRange(0, 9999)
        int_spin.setValue(existing_conditions.get('INT', 0))
        int_spin.setSuffix(" INT")
        stats_layout.addRow("INT:", int_spin)
        
        spi_spin = QSpinBox()
        spi_spin.setRange(0, 9999)
        spi_spin.setValue(existing_conditions.get('SPI', 0))
        spi_spin.setSuffix(" SPI")
        stats_layout.addRow("SPI:", spi_spin)
        
        spd_spin = QSpinBox()
        spd_spin.setRange(0, 9999)
        spd_spin.setValue(existing_conditions.get('SPD', 0))
        spd_spin.setSuffix(" SPD")
        stats_layout.addRow("SPD:", spd_spin)
        
        stats_group.setLayout(stats_layout)
        scroll_layout.addWidget(stats_group)
        
        # Skill Count Requirements
        skills_group = QGroupBox("Skill Count Requirements (by Personality)")
        skills_layout = QFormLayout()
        
        valor_spin = QSpinBox()
        valor_spin.setRange(0, 999)
        valor_spin.setValue(existing_conditions.get('skillCountValor', 0))
        skills_layout.addRow("Valor Skills:", valor_spin)
        
        philanthropy_spin = QSpinBox()
        philanthropy_spin.setRange(0, 999)
        philanthropy_spin.setValue(existing_conditions.get('skillCountPhilantropy', 0))
        skills_layout.addRow("Philanthropy Skills:", philanthropy_spin)
        
        amicable_spin = QSpinBox()
        amicable_spin.setRange(0, 999)
        amicable_spin.setValue(existing_conditions.get('skillCountAmicable', 0))
        skills_layout.addRow("Amicable Skills:", amicable_spin)
        
        wisdom_spin = QSpinBox()
        wisdom_spin.setRange(0, 999)
        wisdom_spin.setValue(existing_conditions.get('skillCountWisdom', 0))
        skills_layout.addRow("Wisdom Skills:", wisdom_spin)
        
        skills_group.setLayout(skills_layout)
        scroll_layout.addWidget(skills_group)
        
        # Item Requirement
        item_group = QGroupBox("Item Requirement (Mode 2)")
        item_layout = QFormLayout()
        item_spin = QSpinBox()
        item_spin.setRange(0, 999999)
        item_spin.setValue(existing_conditions.get('needsItem', 0))
        item_spin.setSuffix(" (Item ID, 0 = none)")
        item_layout.addRow("Required Item:", item_spin)
        item_group.setLayout(item_layout)
        scroll_layout.addWidget(item_group)
        
        # Jogress Requirements
        jogress_group = QGroupBox("Jogress/DNA Digivolution (Mode 3)")
        jogress_layout = QFormLayout()
        
        jogress_a_id_spin = QSpinBox()
        jogress_a_id_spin.setRange(0, 999999)
        jogress_a_id_spin.setValue(existing_conditions.get('jogressDbIdA', 0))
        jogress_a_id_spin.setSuffix(" (Partner A ID)")
        jogress_layout.addRow("Partner A Digimon ID:", jogress_a_id_spin)
        
        jogress_a_personality_spin = QSpinBox()
        jogress_a_personality_spin.setRange(0, 99)
        jogress_a_personality_spin.setValue(existing_conditions.get('jogressPersonalityA', 0))
        jogress_a_personality_spin.setSuffix(" (Personality)")
        jogress_layout.addRow("Partner A Personality:", jogress_a_personality_spin)
        
        jogress_b_id_spin = QSpinBox()
        jogress_b_id_spin.setRange(0, 999999)
        jogress_b_id_spin.setValue(existing_conditions.get('jogressDbIdB', 0))
        jogress_b_id_spin.setSuffix(" (Partner B ID)")
        jogress_layout.addRow("Partner B Digimon ID:", jogress_b_id_spin)
        
        jogress_b_personality_spin = QSpinBox()
        jogress_b_personality_spin.setRange(0, 99)
        jogress_b_personality_spin.setValue(existing_conditions.get('jogressPersonalityB', 0))
        jogress_b_personality_spin.setSuffix(" (Personality)")
        jogress_layout.addRow("Partner B Personality:", jogress_b_personality_spin)
        
        jogress_group.setLayout(jogress_layout)
        scroll_layout.addWidget(jogress_group)
        
        scroll_layout.addStretch()
        scroll.setWidget(scroll_widget)
        layout.addWidget(scroll)
        
        # Buttons
        buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel)
        buttons.accepted.connect(dialog.accept)
        buttons.rejected.connect(dialog.reject)
        layout.addWidget(buttons)
        
        if dialog.exec() == QDialog.DialogCode.Accepted:
            return {
                'mode': mode_combo.currentData(),
                'tamerLevel': tamer_level_spin.value(),
                'HP': hp_spin.value(),
                'SP': sp_spin.value(),
                'ATK': atk_spin.value(),
                'DEF': def_spin.value(),
                'INT': int_spin.value(),
                'SPI': spi_spin.value(),
                'SPD': spd_spin.value(),
                'unknown1': 0,
                'unknown2': 0,
                'skillCountValor': valor_spin.value(),
                'skillCountPhilantropy': philanthropy_spin.value(),
                'skillCountAmicable': amicable_spin.value(),
                'skillCountWisdom': wisdom_spin.value(),
                'needsItem': item_spin.value(),
                'jogressDbIdA': jogress_a_id_spin.value(),
                'jogressPersonalityA': jogress_a_personality_spin.value(),
                'jogressDbIdB': jogress_b_id_spin.value(),
                'jogressPersonalityB': jogress_b_personality_spin.value()
            }
        return None  # Cancelled
    
    def _format_requirements_summary(self, conditions: dict) -> str:
        """Format evolution requirements as a short summary"""
        parts = []
        if conditions.get('tamerLevel', 0) > 0:
            parts.append(f"Tamer Lv{conditions['tamerLevel']}")
        
        stats = []
        for stat in ['HP', 'SP', 'ATK', 'DEF', 'INT', 'SPI', 'SPD']:
            if conditions.get(stat, 0) > 0:
                stats.append(f"{stat}{conditions[stat]}")
        if stats:
            parts.append(", ".join(stats))
        
        if conditions.get('needsItem', 0) > 0:
            parts.append(f"Item#{conditions['needsItem']}")
        
        if conditions.get('jogressDbIdA', 0) > 0:
            parts.append(f"Jogress w/ ID{conditions['jogressDbIdA']}")
        
        if parts:
            return f"[{'; '.join(parts)}]"
        return "[No requirements]"
    
    def edit_evolution(self):
        """Edit selected evolution path with detailed requirements editor"""
        if not self.current_digimon:
            return
        
        current_index = self.evolution_list.currentRow()
        if current_index < 0:
            QMessageBox.warning(self, "Warning", "Please select an evolution to edit")
            return
        
        if current_index >= len(self.current_digimon.evolution_paths):
            return
        
        evo = self.current_digimon.evolution_paths[current_index]
        
        # Get target Digimon name
        to_id = evo['to_id']
        to_name = self.loader._get_digimon_name_by_id(to_id)
        if not to_name:
            to_name = f"ID {to_id}"
        
        # Get existing conditions or create default
        existing_conditions = evo.get('conditions', {})
        
        # Use the same comprehensive dialog as the wizard
        new_conditions = self._show_evolution_requirements_dialog(to_name, existing_conditions)
        
        if new_conditions is not None:
            # Update the evolution path with new conditions
            self.current_digimon.evolution_paths[current_index]['conditions'] = new_conditions
            
            # Update display
            req_text = self._format_requirements_summary(new_conditions)
            item_text = f"→ {to_name} (ID: {to_id}) {req_text}"
            self.evolution_list.item(current_index).setText(item_text)
            
            self.mark_as_modified()
            QMessageBox.information(self, "Success", f"Evolution requirements updated for {to_name}")
    
    # Old evolution dialog has been replaced with _show_evolution_requirements_dialog
    
    def remove_evolution(self):
        """Remove selected evolution path"""
        if not self.current_digimon:
            return
        
        current_index = self.evolution_list.currentRow()
        if current_index < 0:
            QMessageBox.warning(self, "Warning", "Please select an evolution to remove")
            return
        
        if current_index < len(self.current_digimon.evolution_paths):
            evo = self.current_digimon.evolution_paths[current_index]
            reply = QMessageBox.question(self, "Confirm", 
                                         f"Remove evolution to ID {evo['to_id']}?",
                                         QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No)
            if reply == QMessageBox.StandardButton.Yes:
                self.current_digimon.evolution_paths.pop(current_index)
                self.update_evolution_tab(self.current_digimon)
                QMessageBox.information(self, "Success", "Evolution removed")
    
    def get_evolution_count_for_digimon(self, digimon_id: int) -> int:
        """Count how many evolution targets a Digimon has"""
        count = 0
        
        try:
            # Check base game evolution_to.csv
            evolution_to_file = self.loader._resolve_prefixed_file(self.loader.data_path / "evolution.mbe" / "001_evolution_to.csv")
            if evolution_to_file.exists():
                rows = self.loader.load_csv(evolution_to_file)
                for row in rows[1:]:
                    if len(row) > 1 and row[1] == str(digimon_id):
                        count += 1
            
            # Also check DLC files
            dlc_path = self.loader._resolve_prefixed_file(self.loader.data_path.parent / "addcont_17" / "data" / "mbe" / "evolution_dlc17.mbe" / "001_evolution_to.csv")
            if dlc_path.exists():
                rows = self.loader.load_csv(dlc_path)
                for row in rows[1:]:
                    if len(row) > 1 and row[1] == str(digimon_id):
                        count += 1
        except Exception as e:
            print(f"Error counting evolutions: {e}")
        
        # Also count pending pre-evolutions we've added that use this Digimon as source
        if self.current_digimon:
            for deevo in self.current_digimon.deevolution_sources:
                if deevo.get('from_id') == digimon_id:
                    count += 1
        
        return count
    
    def add_pre_evolution(self):
        """Add a pre-evolution (a Digimon that evolves INTO this one)"""
        if not self.current_digimon:
            QMessageBox.warning(self, "Warning", "Please select a Digimon first")
            return
        
        # Create dialog to select source Digimon
        dialog = QDialog(self)
        dialog.setWindowTitle("Add Pre-Evolution")
        dialog.setMinimumSize(550, 550)
        layout = QVBoxLayout(dialog)
        
        # Info banner
        info_banner = QLabel(
            "⚠️ Adding a pre-evolution creates an evolution entry where THAT Digimon evolves into THIS one.\n"
            "Each Digimon can only have 6 evolution targets maximum!"
        )
        info_banner.setStyleSheet("background-color: #fff3cd; padding: 10px; border-radius: 6px; color: #856404;")
        info_banner.setWordWrap(True)
        layout.addWidget(info_banner)
        
        # Tab widget for list selection vs custom input
        tab_widget = QTabWidget()
        
        # Tab 1: Select from list
        list_tab = QWidget()
        list_layout = QVBoxLayout(list_tab)
        
        # Search
        search_edit = QLineEdit()
        search_edit.setPlaceholderText("Search Digimon...")
        list_layout.addWidget(search_edit)
        
        # Evolution count label
        evo_count_label = QLabel("Select a Digimon to see their evolution slot count")
        evo_count_label.setStyleSheet("padding: 5px; font-style: italic; color: #666;")
        list_layout.addWidget(evo_count_label)
        
        list_layout.addWidget(QLabel("Select Digimon to add as pre-evolution:"))
        source_list = QListWidget()
        source_list.setMinimumHeight(300)
        list_layout.addWidget(source_list)
        tab_widget.addTab(list_tab, "Select from List")
        
        # Tab 2: Custom input
        custom_tab = QWidget()
        custom_layout = QVBoxLayout(custom_tab)
        
        custom_info = QLabel("Enter a Digimon by name or ID.\nExamples:\n• Digimon Name: 'Agumon'\n• Chr ID: 'chr050'\n• Numeric ID: '50'")
        custom_info.setWordWrap(True)
        custom_info.setStyleSheet("color: #666; padding: 10px; background-color: #e7f5ff; border-radius: 6px;")
        custom_layout.addWidget(custom_info)
        
        custom_input = QLineEdit()
        custom_input.setPlaceholderText("Enter Digimon name, chr_id (e.g., chr050), or numeric ID")
        custom_layout.addWidget(QLabel("Custom Digimon:"))
        custom_layout.addWidget(custom_input)
        
        # Also allow custom ID directly
        custom_id_label = QLabel("Or enter numeric ID directly:")
        custom_id_spin = QSpinBox()
        custom_id_spin.setRange(1, 999999)
        custom_id_spin.setValue(1000)
        custom_layout.addWidget(custom_id_label)
        custom_layout.addWidget(custom_id_spin)
        
        custom_layout.addStretch()
        tab_widget.addTab(custom_tab, "Custom Input")
        
        # Populate with all Digimon and their evolution counts
        chr_ids = self.loader.get_all_digimon_chr_ids()
        
        # Build ID cache
        id_cache = {}
        try:
            status_file = self.loader._resolve_prefixed_file(self.loader.data_path / "digimon_status.mbe" / "000_digimon_status_data.csv")
            if status_file.exists():
                rows = self.loader.load_csv(status_file)
                for row in rows[1:]:
                    if len(row) > 3 and row[3]:
                        chr_id = row[3].strip('"')
                        if len(row) > 0 and row[0]:
                            try:
                                id_cache[chr_id] = int(row[0])
                            except:
                                pass
        except:
            pass
        
        # Count evolutions for each Digimon
        evo_counts = {}
        try:
            evolution_to_file = self.loader._resolve_prefixed_file(self.loader.data_path / "evolution.mbe" / "001_evolution_to.csv")
            if evolution_to_file.exists():
                rows = self.loader.load_csv(evolution_to_file)
                for row in rows[1:]:
                    if len(row) > 1 and row[1]:
                        try:
                            source_id = int(row[1])
                            evo_counts[source_id] = evo_counts.get(source_id, 0) + 1
                        except:
                            pass
        except:
            pass
        
        for chr_id in chr_ids:
            name = self.loader._get_digimon_name_by_chr_id(chr_id)
            if not name:
                name = chr_id
            digimon_id = id_cache.get(chr_id, 0)
            evo_count = evo_counts.get(digimon_id, 0)
            
            if evo_count >= 6:
                status = "❌ FULL"
            elif evo_count >= 5:
                status = f"⚠️ {evo_count}/6"
            else:
                status = f"✅ {evo_count}/6"
            
            item = QListWidgetItem(f"{name} [{status}] (ID: {digimon_id})")
            item.setData(100, {'id': digimon_id, 'chr_id': chr_id, 'evo_count': evo_count})
            
            if evo_count >= 6:
                item.setForeground(Qt.GlobalColor.red)
            elif evo_count >= 5:
                item.setForeground(Qt.GlobalColor.darkYellow)
            
            source_list.addItem(item)
        
        # Update count on selection
        def update_evo_count():
            current = source_list.currentItem()
            if current:
                data = current.data(100)
                if data:
                    count = data.get('evo_count', 0)
                    status = "✅ Can add" if count < 6 else "❌ FULL - Cannot add!"
                    color = "#28a745" if count < 6 else "#dc3545"
                    evo_count_label.setText(f"Evolution slots: {count}/6 — {status}")
                    evo_count_label.setStyleSheet(f"padding: 5px; font-weight: bold; color: {color};")
        
        source_list.currentItemChanged.connect(lambda: update_evo_count())
        
        # Filter
        def filter_list(text):
            for i in range(source_list.count()):
                item = source_list.item(i)
                item.setHidden(text.lower() not in item.text().lower())
        search_edit.textChanged.connect(filter_list)
        
        layout.addWidget(tab_widget)
        
        buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel)
        buttons.accepted.connect(dialog.accept)
        buttons.rejected.connect(dialog.reject)
        layout.addWidget(buttons)
        
        if dialog.exec() == QDialog.DialogCode.Accepted:
            from_id = None
            from_chr_id = None
            evo_count = 0
            
            if tab_widget.currentIndex() == 0:
                # List tab selected
                current = source_list.currentItem()
                if current:
                    data = current.data(100)
                    if data:
                        from_id = data.get('id', 0)
                        from_chr_id = data.get('chr_id', '')
                        evo_count = data.get('evo_count', 0)
            else:
                # Custom tab selected
                custom_text = custom_input.text().strip()
                found = False
                if custom_text:
                    # First check imported Digimon (custom Digimon from dsts-loader)
                    if hasattr(self.loader, 'imported_digimon') and self.loader.imported_digimon:
                        for imported_digimon in self.loader.imported_digimon:
                            # Check by name (case-insensitive partial match)
                            if custom_text.lower() in imported_digimon.name.lower():
                                from_chr_id = imported_digimon.chr_id
                                from_id = imported_digimon.id
                                evo_count = self.get_evolution_count_for_digimon(from_id)
                                found = True
                                break
                            # Check by chr_id (exact match)
                            if imported_digimon.chr_id.lower() == custom_text.lower():
                                from_chr_id = imported_digimon.chr_id
                                from_id = imported_digimon.id
                                evo_count = self.get_evolution_count_for_digimon(from_id)
                                found = True
                                break
                            # Check by numeric ID
                            if str(imported_digimon.id) == custom_text:
                                from_chr_id = imported_digimon.chr_id
                                from_id = imported_digimon.id
                                evo_count = self.get_evolution_count_for_digimon(from_id)
                                found = True
                                break
                    
                    # If not found in imported, try standard lookup
                    if not from_id:
                        # Try to find by name first
                        chr_ids_all = self.loader.get_all_digimon_chr_ids()
                        found = False
                        for chr_id in chr_ids_all:
                            name = self.loader._get_digimon_name_by_chr_id(chr_id)
                            if name and custom_text.lower() in name.lower():
                                from_chr_id = chr_id
                                digimon_obj = self.loader.get_digimon_by_chr_id(chr_id)
                                if digimon_obj:
                                    from_id = digimon_obj.id
                                    # Check evolution count
                                    evo_count = self.get_evolution_count_for_digimon(from_id)
                                    found = True
                                    break
                        
                        # If not found by name, try as chr_id
                        if not found and (custom_text.startswith('chr') or custom_text.startswith('CHR')):
                            from_chr_id = custom_text.lower().replace('chr', 'chr')
                            digimon_obj = self.loader.get_digimon_by_chr_id(from_chr_id)
                            if digimon_obj:
                                from_id = digimon_obj.id
                                evo_count = self.get_evolution_count_for_digimon(from_id)
                        
                        # If still not found, try as numeric ID
                        if not found and custom_text.isdigit():
                            from_id = int(custom_text)
                            # Try to find chr_id from ID
                            try:
                                status_file = self.loader._resolve_prefixed_file(self.loader.data_path / "digimon_status.mbe" / "000_digimon_status_data.csv")
                                if status_file.exists():
                                    rows = self.loader.load_csv(status_file)
                                    for row in rows[1:]:
                                        if len(row) > 0 and row[0] == str(from_id):
                                            if len(row) > 3:
                                                from_chr_id = row[3].strip('"')
                                                break
                            except:
                                pass
                            if from_id:
                                evo_count = self.get_evolution_count_for_digimon(from_id)
                
                # If custom input didn't work, use spinbox value
                if not from_id:
                    from_id = custom_id_spin.value()
                    # Generate chr_id from numeric ID
                    from_chr_id = f"chr{from_id:03d}"
                    evo_count = self.get_evolution_count_for_digimon(from_id)
            
            if from_id:
                # Check limit
                if evo_count >= 6:
                    from_name = self.loader._get_digimon_name_by_id(from_id) or f"ID {from_id}"
                    QMessageBox.warning(
                        self,
                        "Evolution Limit Reached",
                        f"❌ Cannot add pre-evolution!\n\n"
                        f"{from_name} already has 6 evolution targets.\n"
                        f"Choose a different Digimon with available slots."
                    )
                    return
                
                # Check if already exists
                for deevo in self.current_digimon.deevolution_sources:
                    if deevo.get('from_id') == from_id:
                        QMessageBox.information(self, "Already Added", "This pre-evolution already exists.")
                        return
                    
                    # Add pre-evolution
                    self.current_digimon.deevolution_sources.append({
                        'from_id': from_id,
                    'from_chr_id': from_chr_id or f"chr{from_id:03d}",
                        'evolution_type': 0
                    })
                    
                    self.update_evolution_tab(self.current_digimon)
                display_name = from_chr_id if from_chr_id else f"ID {from_id}"
                QMessageBox.information(self, "Success", f"Pre-evolution added! {display_name} now evolves into {self.current_digimon.name}")
            else:
                QMessageBox.warning(self, "Invalid Input", "Could not find or parse the Digimon. Please check your input.")
    
    def remove_pre_evolution(self):
        """Remove selected pre-evolution"""
        if not self.current_digimon:
            return
        
        current_index = self.deevolution_list.currentRow()
        if current_index < 0:
            QMessageBox.warning(self, "Warning", "Please select a pre-evolution to remove")
            return
        
        if current_index < len(self.current_digimon.deevolution_sources):
            deevo = self.current_digimon.deevolution_sources[current_index]
            from_id = deevo.get('from_id', 0)
            from_name = self.loader._get_digimon_name_by_id(from_id) or f"ID {from_id}"
            
            reply = QMessageBox.question(
                self, "Confirm", 
                f"Remove pre-evolution from {from_name}?\n\n"
                f"This means {from_name} will no longer evolve into {self.current_digimon.name}.",
                QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No
            )
            if reply == QMessageBox.StandardButton.Yes:
                self.current_digimon.deevolution_sources.pop(current_index)
                self.update_evolution_tab(self.current_digimon)
                QMessageBox.information(self, "Success", "Pre-evolution removed")


    def export_csv(self):
        """Export all CSV files with any changes made in the editor"""
        # Update current digimon with form data if one is loaded
        if self.current_digimon:
            self.update_digimon_from_form()
            # Save changes to the original files first
            if not self.loader.save_digimon_data(self.current_digimon):
                QMessageBox.warning(self, "Warning", "Failed to save current Digimon changes")
                return
        
        # Get directory to save to
        directory = QFileDialog.getExistingDirectory(self, "Select Export Directory")
        if directory:
            from pathlib import Path
            output_path = Path(directory)
            use_dsts_format = self._is_dsts_loader_directory(output_path)
            
            if not use_dsts_format:
                format_dialog = QMessageBox(self)
                format_dialog.setWindowTitle("Select Export Format")
                format_dialog.setText(
                    "The selected folder doesn't look like a dsts-loader mod.\n"
                    "How would you like to export the CSV files?"
                )
                dsts_button = format_dialog.addButton("dsts-loader layout", QMessageBox.ButtonRole.AcceptRole)
                standard_button = format_dialog.addButton("Standard layout", QMessageBox.ButtonRole.DestructiveRole)
                cancel_button = format_dialog.addButton(QMessageBox.StandardButton.Cancel)
                format_dialog.setDefaultButton(standard_button)
                format_dialog.exec()
                
                clicked = format_dialog.clickedButton()
                if clicked == cancel_button:
                    return
                if clicked == dsts_button:
                    use_dsts_format = True
            
            # If we have a current Digimon and dsts-loader format, offer merge option
            if use_dsts_format and self.current_digimon:
                # Check if destination already has files
                patch_data_dir = output_path / "patch" / "data"
                has_existing = False
                if patch_data_dir.exists():
                    status_file = patch_data_dir / "digimon_status.mbe" / "000_digimon_status_data.ap.csv"
                    if status_file.exists():
                        has_existing = True
                
                if has_existing:
                    # Offer merge vs overwrite
                    merge_dialog = QMessageBox(self)
                    merge_dialog.setWindowTitle("Export to dsts-loader")
                    merge_dialog.setText(
                        f"Found existing Digimon data in {directory}.\n\n"
                        "How would you like to export?"
                    )
                    merge_dialog.setIcon(QMessageBox.Icon.Question)
                    merge_button = merge_dialog.addButton("Merge (Update Current Digimon Only)", QMessageBox.ButtonRole.AcceptRole)
                    overwrite_button = merge_dialog.addButton("Overwrite All (Replace Everything)", QMessageBox.ButtonRole.DestructiveRole)
                    cancel_button = merge_dialog.addButton(QMessageBox.StandardButton.Cancel)
                    merge_dialog.setDefaultButton(merge_button)
                    merge_dialog.exec()
                    
                    clicked = merge_dialog.clickedButton()
                    if clicked == cancel_button:
                        return
                    
                    if clicked == merge_button:
                        # Merge: Update only the current Digimon, preserve others
                        if self._merge_digimon_to_dsts_loader(output_path, self.current_digimon):
                            QMessageBox.information(
                                self,
                                "Success",
                                f"✅ {self.current_digimon.name} has been updated in dsts-loader!\n\n"
                                "Other Digimon data was preserved."
                            )
                        else:
                            QMessageBox.warning(self, "Error", "Failed to merge Digimon data")
                        return
                    # else continue with overwrite (below)
                else:
                    # No existing data, just export single Digimon (this creates new files with just this Digimon)
                    if self._merge_digimon_to_dsts_loader(output_path, self.current_digimon):
                        QMessageBox.information(
                            self,
                            "Success",
                            f"✅ {self.current_digimon.name} has been exported to dsts-loader!"
                        )
                    else:
                        QMessageBox.warning(self, "Error", "Failed to export Digimon data")
                    return
            
            # Show warning about overwriting existing data (only for full export)
            warning_text = ""
            if use_dsts_format:
                warning_text = (
                    "⚠️ WARNING: Exporting to dsts-loader format will:\n\n"
                    "• DELETE all existing files in the destination directory\n"
                    "• REPLACE them with only the DLC data currently in your DLC folder\n"
                    "• This means if you have other Digimon data in dsts-loader that isn't in your DLC folder, it will be LOST\n\n"
                    "Only the Digimon data currently in your DLC folder will be exported.\n\n"
                    "Do you want to continue?"
                )
            else:
                warning_text = (
                    "⚠️ WARNING: Exporting all CSV files will:\n\n"
                    "• DELETE all existing files in the destination directory\n"
                    "• REPLACE them with copies of all files from your Base/data and Base/text folders\n"
                    "• Any files in the destination that don't exist in the source will be LOST\n\n"
                    "Do you want to continue?"
                )
            
            warning_dialog = QMessageBox(self)
            warning_dialog.setWindowTitle("⚠️ Confirm Export")
            warning_dialog.setText(warning_text)
            warning_dialog.setIcon(QMessageBox.Icon.Warning)
            warning_dialog.addButton(QMessageBox.StandardButton.Yes)
            warning_dialog.addButton(QMessageBox.StandardButton.No)
            warning_dialog.setDefaultButton(QMessageBox.StandardButton.No)
            
            if warning_dialog.exec() != QMessageBox.StandardButton.Yes:
                return
            
            if use_dsts_format:
                if self.exporter.export_for_dsts_loader(output_path):
                    QMessageBox.information(
                        self,
                        "Success",
                        f"Exported DLC CSV files for dsts-loader to {directory}"
                    )
                else:
                    QMessageBox.warning(
                        self,
                        "Error",
                        "Failed to export CSV files for dsts-loader"
                    )
            elif self.exporter.export_all_csv_files(output_path):
                QMessageBox.information(
                    self,
                    "Success",
                    f"Successfully exported all CSV files to {directory}"
                )
            else:
                QMessageBox.warning(self, "Error", "Failed to export CSV files")

    def _merge_digimon_to_dsts_loader(self, base_path: Path, digimon: DigimonData) -> bool:
        """Merge a single Digimon into existing dsts-loader files, preserving other entries"""
        try:
            from pathlib import Path
            import csv
            
            # Create directory structure
            patch_data = base_path / "patch" / "data"
            patch_text = base_path / "patch_text01" / "text"
            app_data = base_path / "app_0" / "data"
            
            # Create directories if they don't exist
            (patch_data / "digimon_status.mbe").mkdir(parents=True, exist_ok=True)
            (patch_data / "char_info.mbe").mkdir(parents=True, exist_ok=True)
            (patch_data / "model_setting.mbe").mkdir(parents=True, exist_ok=True)
            (patch_data / "lod_chara.mbe").mkdir(parents=True, exist_ok=True)
            (patch_data / "evolution.mbe").mkdir(parents=True, exist_ok=True)
            (patch_data / "anim_setting.mbe").mkdir(parents=True, exist_ok=True)
            (patch_text / "char_name.mbe").mkdir(parents=True, exist_ok=True)
            (patch_text / "digimon_profile.mbe").mkdir(parents=True, exist_ok=True)
            (patch_text / "belong.mbe").mkdir(parents=True, exist_ok=True)
            (app_data / "model_outline.mbe").mkdir(parents=True, exist_ok=True)
            
            # Update form data before saving
            if hasattr(self, 'update_digimon_from_form'):
                self.update_digimon_from_form()
            
            # Use wizard's write methods to create the data row for this Digimon
            wizard = DigimonCreationWizard(parent=None, loader=self.loader)
            
            # Debug: Print values before writing
            print(f"DEBUG: Writing digimon - field_guide_id={digimon.field_guide_id}, script_id={digimon.script_id}")
            
            # Merge digimon_status_data
            status_file = patch_data / "digimon_status.mbe" / "000_digimon_status_data.ap.csv"
            self._merge_csv_row(status_file, digimon, wizard._write_digimon_status_ap_csv, lambda r: len(r) > 3 and r[3].strip('"') == digimon.chr_id)
            
            # Merge char_info
            char_info_file = patch_data / "char_info.mbe" / "000_char_info.ap.csv"
            self._merge_csv_row(char_info_file, digimon, wizard._write_char_info_ap_csv, lambda r: len(r) > 0 and r[0].strip('"') == digimon.char_key)
            
            # Merge model_setting (if we have the data)
            if digimon.model_setting_data:
                model_file = patch_data / "model_setting.mbe" / "000_model_setting.ap.csv"
                self._merge_csv_row(model_file, digimon, wizard._write_model_setting_ap_csv, lambda r: len(r) > 0 and r[0].strip('"') == digimon.chr_id)
            
            # Merge lod files
            lod_file = patch_data / "lod_chara.mbe" / "000_lod.ap.csv"
            self._merge_csv_row(lod_file, digimon, wizard._write_lod_ap_csv, lambda r: len(r) > 0 and r[0].strip('"') == digimon.chr_id)
            
            lod_model_file = patch_data / "lod_chara.mbe" / "001_lod_model.ap.csv"
            self._merge_csv_row(lod_model_file, digimon, wizard._write_lod_model_ap_csv, lambda r: len(r) > 0 and r[0].strip('"') == digimon.chr_id)
            
            # Merge evolution files
            evolution_file = patch_data / "evolution.mbe" / "001_evolution_to.ap.csv"
            self._merge_evolution_file(evolution_file, digimon, wizard._write_evolution_ap_csv)
            
            evolution_cond_file = patch_data / "evolution.mbe" / "000_evolution_condition.ap.csv"
            self._merge_csv_row(evolution_cond_file, digimon, wizard._write_evolution_condition_ap_csv, lambda r: len(r) > 0 and r[0] == str(digimon.id))
            
            # Merge anim_setting - need to handle special signature
            anim_ref = digimon.chr_id  # Use chr_id as animation reference by default
            anim_file = patch_data / "anim_setting.mbe" / "001_same_animation_data.ap.csv"
            resolved_anim_file = self._resolve_prefixed_file(anim_file)
            import tempfile
            temp_anim = tempfile.NamedTemporaryFile(mode='w', delete=False, suffix='.csv', encoding='utf-8')
            temp_anim.close()
            try:
                wizard._write_anim_setting_ap_csv(Path(temp_anim.name), digimon.chr_id, anim_ref)
                with open(temp_anim.name, 'r', encoding='utf-8') as f:
                    reader = csv.reader(f)
                    anim_header = next(reader)
                    anim_new_rows = list(reader)
                Path(temp_anim.name).unlink()
                
                # Merge anim file
                anim_existing_rows = []
                if resolved_anim_file.exists():
                    with open(resolved_anim_file, 'r', encoding='utf-8') as f:
                        reader = csv.reader(f)
                        anim_existing_header = next(reader, None)
                        if anim_existing_header:
                            anim_header = anim_existing_header
                            anim_existing_rows = list(reader)
                
                found_anim = False
                for i, row in enumerate(anim_existing_rows):
                    if len(row) > 0 and row[0].strip('"') == digimon.chr_id:
                        anim_existing_rows[i] = anim_new_rows[0] if anim_new_rows else row
                        found_anim = True
                        break
                
                if not found_anim and anim_new_rows:
                    anim_existing_rows.extend(anim_new_rows)
                
                with open(resolved_anim_file, 'w', encoding='utf-8', newline='') as f:
                    writer = csv.writer(f)
                    writer.writerow(anim_header)
                    for row in anim_existing_rows:
                        writer.writerow(row)
            except Exception as e:
                print(f"Error merging anim_setting: {e}")
                if Path(temp_anim.name).exists():
                    Path(temp_anim.name).unlink()
            
            # Merge text files
            char_name_file = patch_text / "char_name.mbe" / "000_Sheet1.ap.csv"
            self._merge_csv_row(char_name_file, digimon, wizard._write_char_name_ap_csv, lambda r: len(r) > 0 and r[0].strip('"') == digimon.char_key)
            
            profile_file = patch_text / "digimon_profile.mbe" / "000_Sheet1.ap.csv"
            profile_key = f"digimon_{digimon.id}_profile"
            self._merge_csv_row(profile_file, digimon, wizard._write_profile_ap_csv, lambda r: len(r) > 0 and r[0].strip('"') == profile_key)
            
            belong_file = patch_text / "belong.mbe" / "000_Sheet1.ap.csv"
            self._merge_csv_row(belong_file, digimon, wizard._write_belong_ap_csv, lambda r: len(r) > 0 and r[0] == str(digimon.id))
            
            # Merge model_outline
            outline_file = app_data / "model_outline.mbe" / "000_model_outline_battle.ap.csv"
            self._merge_csv_row(outline_file, digimon, wizard._write_model_outline_ap_csv, lambda r: len(r) > 0 and r[0].strip('"') == digimon.chr_id)
            
            return True
            
        except Exception as e:
            print(f"Error merging Digimon to dsts-loader: {e}")
            import traceback
            traceback.print_exc()
            return False
    
    def _merge_csv_row(self, filepath: Path, digimon_or_data, write_func, find_row_func):
        """Merge a single row into a CSV file, preserving other rows"""
        import csv
        import tempfile
        
        # Generate new row data by writing to temp file
        temp_file = filepath.parent / f"_temp_{filepath.name}"
        header_str = None
        new_rows = []
        try:
            # Call write_func with appropriate arguments
            if isinstance(digimon_or_data, tuple):
                write_func(temp_file, *digimon_or_data)
            else:
                write_func(temp_file, digimon_or_data)
            
            # Read the new row from temp file (header is a string, data rows use csv.reader)
            if temp_file.exists():
                with open(temp_file, 'r', encoding='utf-8') as f:
                    header_str = f.readline().rstrip('\n\r')  # Read header as raw string
                    for line in f:
                        reader = csv.reader([line])
                        new_rows.extend(reader)
                temp_file.unlink()  # Delete temp file
            else:
                print(f"Warning: Temp file {temp_file} was not created")
                return
            
            if not new_rows:
                return  # No data to merge
            
            # Read existing file if it exists
            existing_rows = []
            header_to_use = header_str if header_str else ""
            if filepath.exists():
                with open(filepath, 'r', encoding='utf-8') as f:
                    existing_header = f.readline().rstrip('\n\r')
                    if existing_header:
                        header_to_use = existing_header  # Use existing header if file exists
                    for line in f:
                        reader = csv.reader([line])
                        existing_rows.extend(reader)
            
            # Find and replace existing row or add new
            found = False
            for i, row in enumerate(existing_rows):
                if find_row_func(row):
                    existing_rows[i] = new_rows[0]  # Replace with new data
                    found = True
                    break
            
            if not found:
                existing_rows.extend(new_rows)  # Add new rows
            
            # Write back preserving dsts-loader format
            if header_to_use:
                with open(filepath, 'w', encoding='utf-8', newline='') as f:
                    # Write header (as raw string to preserve format)
                    f.write(header_to_use + '\n')
                    # Write rows - csv.writer handles proper quoting/escaping
                    writer = csv.writer(f, quoting=csv.QUOTE_MINIMAL)
                    for row in existing_rows:
                        writer.writerow(row)
            else:
                print(f"Warning: No header available for {filepath.name}, skipping write")
                    
        except Exception as e:
            print(f"Error merging {filepath.name}: {e}")
            import traceback
            traceback.print_exc()
            if temp_file.exists():
                temp_file.unlink()
    
    def _merge_evolution_file(self, filepath: Path, digimon, write_func):
        """Merge evolution data, removing old entries for this digimon first"""
        import csv
        
        # Generate new evolution rows
        temp_file = filepath.parent / f"_temp_{filepath.name}"
        try:
            write_func(temp_file, digimon)
            
            # Read new rows
            with open(temp_file, 'r', encoding='utf-8') as f:
                header_str = f.readline().rstrip('\n\r')
                new_rows = []
                for line in f:
                    reader = csv.reader([line])
                    new_rows.extend(reader)
            temp_file.unlink()
            
            # Resolve filepath to handle any numeric prefix variation
            resolved_filepath = self._resolve_prefixed_file(filepath)
            
            # Read existing file (use resolved path)
            existing_rows = []
            header_to_use = header_str
            if resolved_filepath.exists():
                    with open(resolved_filepath, 'r', encoding='utf-8') as f:
                        existing_header = f.readline().rstrip('\n\r')
                        if existing_header:
                            header_to_use = existing_header
                        for line in f:
                            reader = csv.reader([line])
                            existing_rows.extend(reader)
            
            # Remove existing entries for this digimon (both as source and target)
            filtered_rows = []
            for row in existing_rows:
                if len(row) > 1:
                    source_id = row[1] if row[1] else None
                    target_id = row[3] if len(row) > 3 and row[3] else None
                    if source_id != str(digimon.id) and target_id != str(digimon.id):
                        filtered_rows.append(row)
            
            # Add new rows
            filtered_rows.extend(new_rows)
            
            # Write back preserving format (use resolved path to maintain existing prefix)
            with open(resolved_filepath, 'w', encoding='utf-8', newline='') as f:
                # Write header (as raw string to preserve format)
                f.write(header_to_use + '\n')
                # Write rows
                writer = csv.writer(f, quoting=csv.QUOTE_MINIMAL)
                for row in filtered_rows:
                    writer.writerow(row)
                    
        except Exception as e:
            print(f"Error merging evolution file {filepath.name}: {e}")
            if temp_file.exists():
                temp_file.unlink()

    def _is_dsts_loader_directory(self, path: Path) -> bool:
        """Check if the selected export path appears to be a dsts-loader directory."""
        try:
            lowered_parts = [part.lower() for part in path.parts]
            if "dsts-loader" in lowered_parts:
                return True
            if path.name.lower() in {"addcont_17", "addcont_17_text01", "data", "text"}:
                parent_parts = [part.lower() for part in path.parent.parts]
                if "dsts-loader" in parent_parts:
                    return True
            return (path / "addcont_17").exists() and (path / "addcont_17_text01").exists()
        except Exception:
            return False
    
    def repack_mbe_files(self):
        """Repack exported CSV folders to .mbe files"""
        # Let user select source folder (containing .mbe folders)
        source_dir = QFileDialog.getExistingDirectory(
            self, 
            "Select Source Folder (containing .mbe folders)", 
            str(Path.cwd())
        )
        
        if not source_dir:
            return  # User cancelled
        
        # Let user select target folder for .mbe files
        target_dir = QFileDialog.getExistingDirectory(
            self, 
            "Select Target Folder for .mbe files", 
            str(Path.cwd())
        )
        
        if not target_dir:
            return  # User cancelled
        
        # Repack the files
        if repack_mbe_files(Path(source_dir), Path(target_dir)):
            QMessageBox.information(self, "Success", 
                f"Successfully repacked .mbe files to {target_dir}")
        else:
            QMessageBox.warning(self, "Error", "Failed to repack .mbe files")
    
    def repack_dlc_mbe_files(self):
        """Repack DLC CSV folders to .mbe files"""
        # Confirm action
        reply = QMessageBox.question(
            self, 
            "Repack DLC to MBE", 
            "This will repack all DLC CSV folders into .mbe files.\n\n"
            "DLC folders to be repacked:\n"
            "- DLC/addcont_17.dx11/data/mbe/*_dlc17.mbe/\n"
            "- DLC/addcont_17_text01.dx11/text/mbe/*_dlc17.mbe/\n\n"
            "Requires DSCSToolsCLI.exe in the workspace root.\n\n"
            "Continue?",
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No
        )
        
        if reply == QMessageBox.StandardButton.No:
            return
        
        # Repack the DLC files
        if repack_dlc_mbe_files():
            QMessageBox.information(
                self, 
                "Success", 
                "✅ Successfully repacked DLC .mbe files!\n\n"
                "The DLC is now ready to use in-game.\n"
                "Copy the DLC folder to your game's directory."
            )
        else:
            QMessageBox.warning(
                self, 
                "Error", 
                "❌ Failed to repack DLC .mbe files.\n\n"
                "Make sure DSCSToolsCLI.exe is in the workspace root\n"
                "and that you have exported Digimon to DLC first."
            )
    
    def populate_stage_dropdown(self):
        """Populate the stage dropdown with localized names"""
        for i in range(15):  # Stages 0-14 (based on generation_name.mbe CSV)
            stage_name = self.loader.get_generation_name(i)
            clean_name = self.loader.clean_ui_text(stage_name)
            self.stage_combo.addItem(clean_name, i)
    
    def populate_type_dropdown(self):
        """Populate the type dropdown with localized names"""
        for i in range(7):  # Types 0-6
            type_name = self.loader.get_type_name(i)
            clean_name = self.loader.clean_ui_text(type_name)
            self.type_combo.addItem(clean_name, i)
    
    def populate_personality_dropdown(self):
        """Populate the personality dropdown with localized names"""
        for i in range(17):  # Personalities 0-16
            personality_name = self.loader.get_personality_name(i)
            clean_name = self.loader.clean_ui_text(personality_name)
            self.personality_combo.addItem(clean_name, i)
    
    def populate_tribe_dropdown(self):
        """Populate the tribe dropdown with unique tribes from belong.mbe"""
        unique_tribes = set()
        try:
            # Try to load from backup folder first (most complete)
            belong_file = self.loader._resolve_prefixed_file(Path("backup") / "text" / "belong.mbe" / "000_Sheet1.csv")
            if not belong_file.exists():
                # Try loader's text path
                belong_file = self.loader._resolve_prefixed_file(self.loader.text_path / "belong.mbe" / "000_Sheet1.csv")
            
            if belong_file.exists():
                rows = self.loader.load_csv(belong_file)
                for row in rows[1:]:  # Skip header
                    if len(row) >= 2:
                        tribe_name = row[1].strip('"')
                        if tribe_name:
                            unique_tribes.add(tribe_name)
        except Exception as e:
            print(f"Error loading tribes: {e}")
            # Fallback to common tribes
            unique_tribes = {"None", "Mammal", "Beast Man", "Dragon", "Machine", "Beast", "Bird", "Insectoid", "Reptile"}
        
        # Add to combo box (sorted)
        for tribe_name in sorted(unique_tribes):
            self.tribe_combo.addItem(tribe_name)
    
    def populate_skill_browser(self):
        """Populate the skill browser list with all available skills"""
        try:
            # Get all skills from the loader
            skills_file = self.loader.data_path / "battle_skill.mbe" / "000_battle_skill_list.csv"
            skills_file = self._resolve_prefixed_file(skills_file)
            if not skills_file.exists():
                print(f"Skill file not found: {skills_file}")
                return
            
            # Use the loader's CSV method
            rows = self.loader.load_csv(skills_file)
            
            self.skill_browser_list.clear()
            
            # Skip header
            for row in rows[1:]:
                if not row or len(row) < 1:
                    continue
                
                try:
                    skill_id = int(row[0])
                    # Get skill name from localization
                    skill_name = self.loader.get_skill_name(skill_id)
                    if skill_name and skill_name != f"skill_{skill_id}":
                        skill_name = self.loader.clean_ui_text(skill_name)
                        item = QListWidgetItem(f"ID {skill_id}: {skill_name}")
                        item.setData(Qt.ItemDataRole.UserRole, skill_id)
                        self.skill_browser_list.addItem(item)
                except (ValueError, IndexError, TypeError) as e:
                    continue
                    
        except Exception as e:
            print(f"Error populating skill browser: {e}")
    
    def filter_skill_list(self):
        """Filter the skill list based on search text"""
        search_text = self.skill_search_box.text().lower()
        
        for i in range(self.skill_browser_list.count()):
            item = self.skill_browser_list.item(i)
            item_text = item.text().lower()
            # Show item if search text is in the item text
            item.setHidden(search_text not in item_text)
    
    def load_skill_from_browser(self, item):
        """Load a skill when double-clicked from the browser list"""
        skill_id = item.data(Qt.ItemDataRole.UserRole)
        if skill_id:
            self.advanced_skill_id_edit.setValue(skill_id)
            # This will trigger update_advanced_skill_display automatically
    
    def update_buff_name_display(self, buff_index: int, buff_set_id: int):
        """Update the buff name label when buff set ID changes"""
        if buff_index < len(self.buff_name_labels):
            if buff_set_id > 0:
                # Try to load buff set and display first buff effect
                try:
                    buff_set_file = self.loader._resolve_prefixed_file(self.loader.data_path / "battle_skill.mbe" / "002_buff_set.csv")
                    if buff_set_file.exists():
                        rows = self.loader.load_csv(buff_set_file)
                        # Find the buff set row
                        for row in rows[1:]:  # Skip header
                            if len(row) > 0 and row[0]:
                                try:
                                    set_id = int(row[0])
                                    if set_id == buff_set_id:
                                        # Get first buff effect (column 6)
                                        if len(row) > 6 and row[6]:
                                            buff_effect_id = int(row[6])
                                            buff_name = self.loader.get_buff_name(buff_effect_id)
                                            self.buff_name_labels[buff_index].setText(f"Set {buff_set_id}: {buff_name}...")
                                            return
                                except (ValueError, IndexError):
                                    continue
                    # If not found, just show the set ID
                    self.buff_name_labels[buff_index].setText(f"Set {buff_set_id}")
                except Exception as e:
                    self.buff_name_labels[buff_index].setText(f"Set {buff_set_id}")
            else:
                self.buff_name_labels[buff_index].setText("")
    
    def update_advanced_skill_display(self):
        """Update advanced skill display when skill ID changes"""
        skill_id = self.advanced_skill_id_edit.value()
        if skill_id > 0:
            # Load skill data
            skill_data = self.loader.load_skill_data(skill_id)
            if skill_data:
                # Update skill name
                skill_name = self.loader.get_skill_name(skill_id)
                clean_name = self.loader.clean_ui_text(skill_name)
                self.advanced_skill_name_edit.setText(clean_name if clean_name else "")
                
                # Show description (from skill_explanation.mbe if available)
                description_text = self.loader.get_skill_explanation(skill_id)
                if description_text:
                    self.advanced_skill_desc.setPlainText(description_text)
                else:
                    self.advanced_skill_desc.setPlainText("No description found for this skill.")
                
                # Update all form fields with loaded data
                self.skill_power_edit.setValue(skill_data.get("power", 0))
                self.skill_sp_cost_edit.setValue(skill_data.get("sp_cost", 0))
                self.skill_cp_cost_edit.setValue(skill_data.get("cp_cost", 0))
                self.skill_animation_id_edit.setValue(skill_data.get("animation_id", 0))
                self.skill_effect_id_edit.setValue(skill_data.get("effect_id", 0))
                self.skill_mode_change_edit.setValue(skill_data.get("mode_change_id", 0))
                self.skill_jogress_skill_edit.setValue(skill_data.get("jogress_skill_id", 0))
                self.skill_jogress_p1_edit.setValue(skill_data.get("jogress_partner_1", 0))
                self.skill_jogress_p2_edit.setValue(skill_data.get("jogress_partner_2", 0))
                self.skill_accuracy_edit.setValue(skill_data.get("accuracy", 0))
                self.skill_crit_rate_edit.setValue(skill_data.get("crit_rate", 0))
                
                # Set damage type
                damage_type = skill_data.get("damage_type", 0)
                if damage_type < self.skill_damage_type_combo.count():
                    self.skill_damage_type_combo.setCurrentIndex(damage_type)
                
                # Set element
                element = skill_data.get("element", 0)
                for i in range(self.skill_element_combo.count()):
                    if self.skill_element_combo.itemData(i) == element:
                        self.skill_element_combo.setCurrentIndex(i)
                        break
                
                self.skill_min_hits_edit.setValue(skill_data.get("min_hits", 1))
                self.skill_max_hits_edit.setValue(skill_data.get("max_hits", 1))
                
                # Set additional properties
                prop1 = skill_data.get("additional_property_1", 0)
                if prop1 < self.skill_additional_prop1_combo.count():
                    self.skill_additional_prop1_combo.setCurrentIndex(prop1)
                
                prop2 = skill_data.get("additional_property", 0)
                if prop2 < self.skill_additional_prop2_combo.count():
                    self.skill_additional_prop2_combo.setCurrentIndex(prop2)
                
                # Set conditional effects
                cond_type = skill_data.get("conditional_type", 0)
                if cond_type < self.skill_conditional_type_combo.count():
                    self.skill_conditional_type_combo.setCurrentIndex(cond_type)
                
                cond_effect = skill_data.get("conditional_effect", 0)
                if cond_effect < self.skill_conditional_effect_combo.count():
                    self.skill_conditional_effect_combo.setCurrentIndex(cond_effect)
                
                self.skill_conditional_arg_edit.setValue(skill_data.get("conditional_arg", 0))
                
                # Set buff sets
                for i, widget in enumerate(self.buff_set_widgets):
                    buff_key = f"buff_set_{i}"
                    widget.setValue(skill_data.get(buff_key, 0))
                
                # Set special effects
                self.skill_hp_drain_edit.setValue(skill_data.get("hp_drain", 0))
                self.skill_sp_drain_edit.setValue(skill_data.get("sp_drain", 0))
                self.skill_recoil_edit.setValue(skill_data.get("recoil", 0))
                self.skill_always_hits_check.setChecked(skill_data.get("always_hits", False))
            else:
                self.advanced_skill_name_edit.setText("Skill not found")
                self.advanced_skill_desc.setPlainText("")
        else:
            self.advanced_skill_name_edit.setText("")
            self.advanced_skill_desc.setPlainText("")
    
    def save_advanced_skill(self):
        """Save the current skill data"""
        skill_id = self.advanced_skill_id_edit.value()
        if skill_id <= 0:
            QMessageBox.warning(self, "Error", "Please enter a valid skill ID")
            return
        
        # Collect all form data
        skill_data = {
            "skill_id": skill_id,
            "power": self.skill_power_edit.value(),
            "sp_cost": self.skill_sp_cost_edit.value(),
            "cp_cost": self.skill_cp_cost_edit.value(),
            "animation_id": self.skill_animation_id_edit.value(),
            "effect_id": self.skill_effect_id_edit.value(),
            "mode_change_id": self.skill_mode_change_edit.value(),
            "jogress_skill_id": self.skill_jogress_skill_edit.value(),
            "jogress_partner_1": self.skill_jogress_p1_edit.value(),
            "jogress_partner_2": self.skill_jogress_p2_edit.value(),
            "accuracy": self.skill_accuracy_edit.value(),
            "crit_rate": self.skill_crit_rate_edit.value(),
            "damage_type": self.skill_damage_type_combo.currentIndex(),
            "element": self.skill_element_combo.currentData(),
            "min_hits": self.skill_min_hits_edit.value(),
            "max_hits": self.skill_max_hits_edit.value(),
            "additional_property_1": self.skill_additional_prop1_combo.currentIndex(),
            "additional_property": self.skill_additional_prop2_combo.currentIndex(),
            "conditional_type": self.skill_conditional_type_combo.currentIndex(),
            "conditional_effect": self.skill_conditional_effect_combo.currentIndex(),
            "conditional_arg": self.skill_conditional_arg_edit.value(),
            "hp_drain": self.skill_hp_drain_edit.value(),
            "sp_drain": self.skill_sp_drain_edit.value(),
            "recoil": self.skill_recoil_edit.value(),
            "always_hits": self.skill_always_hits_check.isChecked()
        }
        
        # Add buff sets
        for i, widget in enumerate(self.buff_set_widgets):
            skill_data[f"buff_set_{i}"] = widget.value()
        
        # Save skill data
        skill_saved = self.loader.save_skill_data(skill_data)
        
        # Save skill name if it was edited
        skill_name = self.advanced_skill_name_edit.text().strip()
        name_saved = True
        if skill_name and skill_name != "Skill not found":
            name_saved = self.loader.save_skill_name(skill_id, skill_name)
        
        # Show result message
        if skill_saved and name_saved:
            QMessageBox.information(self, "Success", f"Skill {skill_id} and name saved successfully!")
        elif skill_saved:
            QMessageBox.warning(self, "Partial Success", f"Skill {skill_id} saved, but skill name could not be saved.")
        elif name_saved:
            QMessageBox.warning(self, "Partial Success", f"Skill name saved, but skill data could not be saved.")
        else:
            QMessageBox.critical(self, "Error", "Failed to save skill data and name")


def main():
    app = QApplication(sys.argv)
    
    # Set application properties
    app.setApplicationName("DTS Creator")
    app.setApplicationVersion("1.0")
    
    # Fix for Windows 11 - Set global palette to ensure text is visible
    palette = app.palette()
    palette.setColor(QPalette.ColorRole.WindowText, QColor("#333333"))
    palette.setColor(QPalette.ColorRole.Text, QColor("#333333"))
    palette.setColor(QPalette.ColorRole.ButtonText, QColor("#333333"))
    palette.setColor(QPalette.ColorRole.Base, QColor("white"))
    palette.setColor(QPalette.ColorRole.Window, QColor("#f8f9fa"))
    palette.setColor(QPalette.ColorRole.Highlight, QColor("#667eea"))
    palette.setColor(QPalette.ColorRole.HighlightedText, QColor("white"))
    palette.setColor(QPalette.ColorRole.PlaceholderText, QColor("#999999"))
    app.setPalette(palette)
    
    # Global stylesheet to ensure text visibility on Windows 11
    app.setStyleSheet("""
        QComboBox, QListWidget, QLineEdit, QTextEdit, QPlainTextEdit, QSpinBox, QDoubleSpinBox {
            color: #333333;
            background-color: white;
        }
        QComboBox QAbstractItemView {
            color: #333333;
            background-color: white;
            selection-background-color: #667eea;
            selection-color: white;
        }
        QComboBox QAbstractItemView::item {
            color: #333333;
        }
        QListWidget::item {
            color: #333333;
        }
        QListWidget::item:selected {
            color: white;
            background-color: #667eea;
        }
        QTableWidget {
            color: #333333;
            background-color: white;
        }
        QTableWidget::item {
            color: #333333;
        }
        QLabel {
            color: #333333;
        }
        QGroupBox {
            color: #333333;
        }
        QCheckBox {
            color: #333333;
        }
        QRadioButton {
            color: #333333;
        }
    """)
    
    # Create and show main window
    window = DigimonEditor()
    window.show()
    
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
