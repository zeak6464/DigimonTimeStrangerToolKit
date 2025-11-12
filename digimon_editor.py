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
    QMessageBox, QFileDialog, QTableWidget, QTableWidgetItem,
    QHeaderView, QSplitter, QListWidget, QListWidgetItem, QDoubleSpinBox, QFormLayout,
    QDialog, QDialogButtonBox, QWizard, QWizardPage
)
from PyQt6.QtCore import Qt, pyqtSignal
from PyQt6.QtGui import QFont, QPixmap, QIcon

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
    """Multi-step wizard for creating new Digimon and adding them to DLC"""
    
    def __init__(self, parent=None, loader=None):
        super().__init__(parent)
        self.loader = loader
        self.template_digimon: Optional[DigimonData] = None
        self.new_digimon: Optional[DigimonData] = None
        
        self.setWindowTitle("✨ Digimon Creation Wizard - Add New Digimon to DLC")
        self.setMinimumSize(700, 600)
        
        # Set wizard style
        self.setWizardStyle(QWizard.WizardStyle.ModernStyle)
        self.setOption(QWizard.WizardOption.HaveHelpButton, False)
        
        # Add pages
        self.addPage(TemplateSelectionPage(self))
        self.addPage(BasicInfoPage(self))
        self.addPage(ClassificationPage(self))
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
        # Get all data from pages
        template_page = self.page(0)
        basic_page = self.page(1)
        class_page = self.page(2)
        stats_page = self.page(3)
        resist_page = self.page(4)
        skills_page = self.page(5)
        evolution_page = self.page(6)
        model_page = self.page(7)
        
        # Create new Digimon from template
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
        
        self.new_digimon.stage_id = class_page.stage_combo.currentData() if class_page.stage_combo.currentData() is not None else 0
        self.new_digimon.type_id = class_page.type_combo.currentData() if class_page.type_combo.currentData() is not None else 0
        self.new_digimon.generation_id = self.new_digimon.stage_id
        self.new_digimon.personality_id = class_page.personality_combo.currentData() if class_page.personality_combo.currentData() is not None else 0
        self.new_digimon.base_personality = self.new_digimon.personality_id
        
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
        
        self.new_digimon.model_id = model_page.model_id_edit.text()
        self.new_digimon.motion_id = model_page.motion_id_edit.text()
        
        # Update chr_id references in all data structures
        self._update_chr_id_references(self.new_digimon, template_chr_id, new_chr_id)
        
        # Export to DLC
        dlc_exporter = DLCExporter(self.loader)
        animation_ref = model_page.animation_ref_edit.text().strip() if model_page.animation_ref_edit.text().strip() else self.new_digimon.chr_id
        
        if dlc_exporter.save_digimon_to_dlc(self.new_digimon, animation_ref):
            QMessageBox.information(
                self,
                "Success! 🎉",
                f"✅ {self.new_digimon.name} has been successfully added to DLC!\n\n"
                f"ID: {self.new_digimon.id}\n"
                f"Chr ID: {self.new_digimon.chr_id}\n"
                f"Animation Reference: {animation_ref}\n\n"
                f"The Digimon is now available in DLC files.\n"
                f"Use 'Repack DLC to MBE' to finalize the changes."
            )
        else:
            QMessageBox.warning(self, "Error", "Failed to export Digimon to DLC")
    
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
        
        chr_ids_sorted = sorted(chr_ids, key=sort_key)
        
        for chr_id in chr_ids_sorted:
            name = wizard.loader._get_digimon_name_by_chr_id(chr_id)
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
        # Find next available ID
        existing_ids = wizard.loader.get_all_digimon_ids()
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
        self.setSubTitle("Set the Digimon's stage, type, and personality")
        
        layout = QFormLayout()
        layout.setSpacing(15)
        
        # Stage
        self.stage_combo = QComboBox()
        for i in range(10):
            stage_name = wizard.loader.get_generation_name(i)
            clean_name = wizard.loader.clean_ui_text(stage_name)
            self.stage_combo.addItem(clean_name, i)
        layout.addRow("⭐ Stage:", self.stage_combo)
        
        # Type
        self.type_combo = QComboBox()
        for i in range(7):
            type_name = wizard.loader.get_type_name(i)
            clean_name = wizard.loader.clean_ui_text(type_name)
            self.type_combo.addItem(clean_name, i)
        layout.addRow("🔷 Type:", self.type_combo)
        
        # Personality
        self.personality_combo = QComboBox()
        for i in range(17):
            personality_name = wizard.loader.get_personality_name(i)
            clean_name = wizard.loader.clean_ui_text(personality_name)
            self.personality_combo.addItem(clean_name, i)
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
        
        self.setLayout(layout)
    
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


class StatsPage(QWizardPage):
    """Step 4: Base Stats"""
    
    def __init__(self, wizard):
        super().__init__()
        self.wizard = wizard
        self.setTitle("📊 Step 4: Base Stats")
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
        self.setTitle("🛡️ Step 5: Elemental Resistances")
        self.setSubTitle("Set elemental resistances (0=Normal, 1=Weak 2x, 3=Resist 0.5x)")
        
        layout = QGridLayout()
        
        self.resist_widgets = {}
        resistances = ["Null", "Fire", "Water", "Ice", "Grass", "Wind", "Elec", "Ground", "Steel", "Light", "Dark"]
        
        resistance_labels = {
            0: "Normal (1.0x)",
            1: "Weak (2.0x)",
            2: "Slightly Weak (1.5x)",
            3: "Resist (0.5x)",
            4: "Strong Resist (0.25x)",
            5: "Immune (0.0x)"
        }
        
        for i, resist in enumerate(resistances):
            row = i // 2
            col = (i % 2) * 3
            element_name = wizard.loader.get_element_name(i)
            clean_name = wizard.loader.clean_ui_text(element_name)
            layout.addWidget(QLabel(f"{clean_name}:"), row, col)
            
            spin = QSpinBox()
            spin.setRange(0, 5)
            spin.setObjectName(f"resist_{resist.lower()}")
            self.resist_widgets[resist.lower()] = spin
            layout.addWidget(spin, row, col + 1)
            
            value_label = QLabel(resistance_labels[0])
            value_label.setObjectName(f"resist_label_{resist.lower()}")
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
        self.setTitle("⚔️ Step 6: Skills")
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
            skills_file = self.wizard.loader.data_path / "battle_skill.mbe" / "00_battle_skill_list.csv"
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
        self.setTitle("🔄 Step 7: Evolution")
        self.setSubTitle("Configure evolution paths and pre-evolutions")
        
        layout = QVBoxLayout()
        
        # Instructions
        info_label = QLabel(
            "Configure evolution paths (what this Digimon can evolve into) and pre-evolutions (what can evolve into this Digimon).\n"
            "Click 'Add Evolution' or 'Add Pre-Evolution' to select from a list of Digimon."
        )
        info_label.setWordWrap(True)
        info_label.setStyleSheet("color: #666; padding: 10px; background-color: #f8f9fa; border-radius: 6px;")
        layout.addWidget(info_label)
        
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
        deevo_group = QGroupBox("Pre-Evolutions (what evolves into this Digimon)")
        deevo_layout = QVBoxLayout()
        
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
    
    def add_evolution(self):
        """Show dialog to select a Digimon to evolve into"""
        try:
            dialog = QDialog(self)
            dialog.setWindowTitle("Select Evolution Target")
            dialog.setMinimumSize(500, 400)
            
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
        except Exception as e:
            print(f"Error in add_evolution: {e}")
            import traceback
            traceback.print_exc()
            QMessageBox.warning(self, "Error", f"Failed to open evolution dialog: {str(e)}")
    
    def add_pre_evolution(self):
        """Show dialog to select a Digimon that evolves into this one"""
        try:
            dialog = QDialog(self)
            dialog.setWindowTitle("Select Pre-Evolution Source")
            dialog.setMinimumSize(500, 400)
            
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
                        self.add_pre_evolution_source(digimon_id, chr_id)
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
                status_file = self.wizard.loader.data_path / "digimon_status.mbe" / "00_digimon_status_data.csv"
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
                dlc_status_file = dlc_data / "digimon_status_dlc17.mbe" / "00_digimon_status_data.csv"
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
    
    def add_evolution_path(self, to_id: int, to_chr_id: str):
        """Add an evolution path"""
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
            
            # Add to list
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
            
            self.evolution_list.addItem(f"→ {to_name} (ID: {to_id})")
        except Exception as e:
            print(f"Error adding evolution path: {e}")
            import traceback
            traceback.print_exc()
            QMessageBox.warning(self, "Error", f"Failed to add evolution path: {str(e)}")
    
    def add_pre_evolution_source(self, from_id: int, from_chr_id: str):
        """Add a pre-evolution source"""
        try:
            # Check if already exists
            for deevo in self.deevolution_sources:
                if deevo.get('from_id') == from_id:
                    QMessageBox.information(self, "Already Added", f"This pre-evolution already exists.")
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
            
            self.deevolution_list.addItem(f"← {from_name} (ID: {from_id})")
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
        
        # Populate evolution paths
        for evo in digimon.evolution_paths:
            to_id = evo.get('to_id', 0)
            if to_id > 0:
                # Try to get name
                to_chr_id = f"chr{to_id:03d}"
                to_name = self.wizard.loader._get_digimon_name_by_chr_id(to_chr_id)
                if not to_name or to_name == to_chr_id:
                    to_chr_id = f"chr{to_id}"
                    to_name = self.wizard.loader._get_digimon_name_by_chr_id(to_chr_id)
                if not to_name or to_name in [to_chr_id, f"chr{to_id:03d}", f"chr{to_id}"]:
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
        
        # Populate de-evolution sources
        for deevo in digimon.deevolution_sources:
            from_id = deevo.get('from_id', 0)
            if from_id > 0:
                from_chr_id = f"chr{from_id:03d}"
                from_name = self.wizard.loader._get_digimon_name_by_chr_id(from_chr_id)
                if not from_name or from_name == from_chr_id:
                    from_chr_id = f"chr{from_id}"
                    from_name = self.wizard.loader._get_digimon_name_by_chr_id(from_chr_id)
                if not from_name or from_name in [from_chr_id, f"chr{from_id:03d}", f"chr{from_id}"]:
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
        self.setTitle("🎨 Step 8: Model & Animation")
        self.setSubTitle("Set model and animation references")
        
        layout = QFormLayout()
        layout.setSpacing(15)
        
        # Model ID
        self.model_id_edit = QLineEdit()
        self.model_id_edit.setPlaceholderText("e.g., model_001")
        layout.addRow("🎭 Model ID:", self.model_id_edit)
        
        # Motion ID
        self.motion_id_edit = QLineEdit()
        self.motion_id_edit.setPlaceholderText("e.g., motion_001")
        layout.addRow("🎬 Motion ID:", self.motion_id_edit)
        
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
        self.setTitle("✅ Step 9: Review & Export")
        self.setSubTitle("Review your Digimon settings and export to DLC")
        
        layout = QVBoxLayout()
        
        # Review text
        self.review_text = QTextEdit()
        self.review_text.setReadOnly(True)
        self.review_text.setMaximumHeight(400)
        layout.addWidget(self.review_text)
        
        # Info
        info_label = QLabel(
            "📦 Click 'Finish' to export this Digimon to DLC.\n"
            "The Digimon will be added to DLC files and can be used in-game.\n"
            "Remember to use 'Repack DLC to MBE' after exporting."
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
        stats_page = self.wizard.page(3)
        resist_page = self.wizard.page(4)
        skills_page = self.wizard.page(5)
        evolution_page = self.wizard.page(6)
        model_page = self.wizard.page(7)
        
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
        
        # Create 41 trait checkboxes in a grid
        for i in range(41):
            trait_name = f"Trait {i + 1}"
            if self.loader:
                trait_name = self.loader.get_trait_name(i)
                clean_name = self.loader.clean_ui_text(trait_name)
                trait_name = clean_name if clean_name else f"Trait {i + 1}"
            checkbox = QCheckBox(trait_name)
            checkbox.setObjectName(f"trait_{i}")
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
        self.loader = MBELoader()
        self.exporter = CSVExporter()
        self.current_digimon: Optional[DigimonData] = None
        self.setup_ui()
        self.load_digimon_list()
    
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
        self.source_combo.currentIndexChanged.connect(self.load_digimon_list)
        self.source_combo.currentIndexChanged.connect(self.on_source_changed)
        self.source_combo.setStyleSheet("""
            QComboBox {
                border: none;
                background: white;
                border-radius: 6px;
                padding: 6px 10px;
                font-size: 10pt;
                color: #495057;
            }
            QComboBox:hover {
                background: #e7f5ff;
            }
            QComboBox::drop-down {
                border: none;
            }
        """)
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
                color: #495057;
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
        """)
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
        self.load_button.setStyleSheet(button_style.format(
            color1="#667eea", color2="#764ba2",
            hover1="#5568d3", hover2="#653b8e"
        ))
        button_layout.addWidget(self.load_button)
        
        self.new_button = QPushButton("➕ Create New")
        self.new_button.clicked.connect(self.launch_creation_wizard)
        self.new_button.setStyleSheet(button_style.format(
            color1="#84fab0", color2="#8fd3f4",
            hover1="#6ee89f", hover2="#7bc9e8"
        ))
        button_layout.addWidget(self.new_button)
        
        self.remove_button = QPushButton("🗑️ Remove from DLC")
        self.remove_button.clicked.connect(self.remove_digimon_from_dlc)
        self.remove_button.setEnabled(False)
        self.remove_button.setStyleSheet(button_style.format(
            color1="#f5576c", color2="#f093fb",
            hover1="#e34556", hover2="#de7fe9"
        ))
        button_layout.addWidget(self.remove_button)
        
        self.save_button = QPushButton("💾 Save Changes")
        self.save_button.clicked.connect(self.save_current_digimon)
        self.save_button.setEnabled(False)
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
        self.export_dlc_button.setStyleSheet(button_style.format(
            color1="#4CAF50", color2="#45a049",
            hover1="#45a049", hover2="#3d8b40"
        ))
        button_layout.addWidget(self.export_dlc_button)
        
        self.export_button = QPushButton("📄 Export CSV")
        self.export_button.clicked.connect(self.export_csv)
        self.export_button.setStyleSheet(button_style.format(
            color1="#fa709a", color2="#fee140",
            hover1="#e85c89", hover2="#ecd32f"
        ))
        button_layout.addWidget(self.export_button)
        
        self.repack_button = QPushButton("📦 Repack to MBE Files")
        self.repack_button.clicked.connect(self.repack_mbe_files)
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
        
        # Elemental Resistances Group
        resist_group = QGroupBox("Elemental Resistances (0=Normal, 1=Weak 2x, 3=Resist 0.5x)")
        resist_layout = QGridLayout(resist_group)
        
        # Create resistance spinboxes with element names
        self.resist_widgets = {}
        resistances = ["Null", "Fire", "Water", "Ice", "Grass", "Wind", "Elec", "Ground", "Steel", "Light", "Dark"]
        
        resistance_labels = {
            0: "Normal (1.0x)",
            1: "Weak (2.0x)",
            2: "Slightly Weak (1.5x)",
            3: "Resist (0.5x)",
            4: "Strong Resist (0.25x)",
            5: "Immune (0.0x)"
        }
        
        for i, resist in enumerate(resistances):
            row = i // 2
            col = (i % 2) * 3  # Changed to *3 to make room for label
            # Get localized element name
            element_name = self.loader.get_element_name(i)
            clean_name = self.loader.clean_ui_text(element_name)
            resist_layout.addWidget(QLabel(f"{clean_name}:"), row, col)
            
            spin = QSpinBox()
            spin.setRange(0, 5)
            spin.setObjectName(f"resist_{resist.lower()}")
            self.resist_widgets[resist.lower()] = spin
            resist_layout.addWidget(spin, row, col + 1)
            
            # Add label that updates based on value
            value_label = QLabel(resistance_labels[0])
            value_label.setObjectName(f"resist_label_{resist.lower()}")
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
        
        # Signature Skills
        self.signature_skills_editor = SkillEditor("signature", self.loader)
        layout.addWidget(self.signature_skills_editor)
        
        # Generic Skills
        self.generic_skills_editor = SkillEditor("generic", self.loader)
        layout.addWidget(self.generic_skills_editor)
        
        return tab
    
    def create_model_tab(self) -> QWidget:
        """Create model and animation tab"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        
        # Model Info Group
        model_group = QGroupBox("Model Information")
        model_layout = QGridLayout(model_group)
        
        # Model ID
        model_layout.addWidget(QLabel("Model ID:"), 0, 0)
        self.model_id_edit = QLineEdit()
        model_layout.addWidget(self.model_id_edit, 0, 1)
        
        # Motion ID
        model_layout.addWidget(QLabel("Motion ID:"), 1, 0)
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
        
        self.advanced_skill_name_label = QLabel("(No skill selected)")
        self.advanced_skill_name_label.setStyleSheet("font-weight: bold; color: #667eea; font-size: 11pt;")
        skill_selection_layout.addWidget(self.advanced_skill_name_label)
        
        skill_selection_layout.addStretch()
        layout.addWidget(skill_selection_group)
        
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
            buff_set_edit.setMinimumWidth(150)
            buff_widget_layout.addWidget(buff_set_edit)
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
        """Create evolution management tab with visual tree"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        
        # Title with improved styling
        title = QLabel("🔄 Evolution Tree & Requirements")
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
        
        # Create splitter for visual tree and details
        splitter = QSplitter(Qt.Orientation.Horizontal)
        
        # Left side: Visual Evolution Tree
        tree_widget = QWidget()
        tree_layout = QVBoxLayout(tree_widget)
        
        # Styled header for tree visualization
        tree_header = QLabel("🌳 Evolution Tree Visualization")
        tree_header.setStyleSheet("""
            QLabel {
                font-size: 13pt;
                font-weight: bold;
                color: #667eea;
                padding: 10px;
                background: qlineargradient(x1:0, y1:0, x2:1, y2:0,
                    stop:0 #f8f9fa, stop:1 #e9ecef);
                border-radius: 6px;
                border: 1px solid #dee2e6;
            }
        """)
        tree_layout.addWidget(tree_header)
        
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
        self.evolution_tree_canvas.setMinimumSize(400, 300)
        self.evolution_tree_canvas.setStyleSheet("background-color: white;")
        
        # Add initial placeholder
        canvas_layout = QVBoxLayout(self.evolution_tree_canvas)
        canvas_layout.setContentsMargins(0, 0, 0, 0)
        placeholder = QLabel("🔍 Load a Digimon to see its evolution tree")
        placeholder.setStyleSheet("""
            QLabel {
                color: #999;
                font-size: 12pt;
                padding: 40px;
                text-align: center;
            }
        """)
        placeholder.setAlignment(Qt.AlignmentFlag.AlignCenter)
        placeholder.setWordWrap(True)
        canvas_layout.addWidget(placeholder)
        
        tree_scroll.setWidget(self.evolution_tree_canvas)
        tree_layout.addWidget(tree_scroll)
        
        splitter.addWidget(tree_widget)
        
        # Right side: Detailed Lists and Management
        details_widget = QWidget()
        details_layout = QVBoxLayout(details_widget)
        
        # Evolution paths (what this Digimon can evolve into)
        evo_group = QGroupBox("Evolution Paths (What this Digimon evolves into)")
        evo_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #84fab0;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 10px;
                background-color: #f8f9fa;
            }
            QGroupBox::title {
                color: #2c5f2d;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 5px;
            }
        """)
        evo_layout = QVBoxLayout(evo_group)
        
        self.evolution_list = QListWidget()
        self.evolution_list.setSelectionMode(QListWidget.SelectionMode.SingleSelection)
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
        
        evo_buttons = QHBoxLayout()
        self.add_evo_btn = QPushButton("➕ Add Evolution")
        self.add_evo_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #84fab0, stop:1 #8fd3f4);
                color: white;
                border: none;
                border-radius: 6px;
                padding: 8px 16px;
                font-weight: bold;
                font-size: 11pt;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #6ee89f, stop:1 #7bc9e8);
            }
            QPushButton:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #6ee89f, stop:1 #6dbdd6);
            }
        """)
        self.add_evo_btn.clicked.connect(self.add_evolution)
        
        self.edit_evo_btn = QPushButton("✏️ Edit Requirements")
        self.edit_evo_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #667eea, stop:1 #764ba2);
                color: white;
                border: none;
                border-radius: 6px;
                padding: 8px 16px;
                font-weight: bold;
                font-size: 11pt;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #5568d3, stop:1 #653b8e);
            }
            QPushButton:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #4a5abf, stop:1 #552f7a);
            }
        """)
        self.edit_evo_btn.clicked.connect(self.edit_evolution)
        
        self.remove_evo_btn = QPushButton("❌ Remove")
        self.remove_evo_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #f093fb, stop:1 #f5576c);
                color: white;
                border: none;
                border-radius: 6px;
                padding: 8px 16px;
                font-weight: bold;
                font-size: 11pt;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #e67ee8, stop:1 #e8425a);
            }
            QPushButton:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #d969d5, stop:1 #d63149);
            }
        """)
        self.remove_evo_btn.clicked.connect(self.remove_evolution)
        
        evo_buttons.addWidget(self.add_evo_btn)
        evo_buttons.addWidget(self.edit_evo_btn)
        evo_buttons.addWidget(self.remove_evo_btn)
        evo_layout.addLayout(evo_buttons)
        
        details_layout.addWidget(evo_group)
        
        # De-evolution sources (what can evolve into this Digimon)
        deevo_group = QGroupBox("Pre-Evolution Sources (What evolves into this)")
        deevo_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #a18cd1;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 10px;
                background-color: #f8f9fa;
            }
            QGroupBox::title {
                color: #5e4a7e;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 5px;
            }
        """)
        deevo_layout = QVBoxLayout(deevo_group)
        
        self.deevolution_list = QListWidget()
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
            QListWidget::item:hover {
                background-color: #f3e5f5;
            }
        """)
        deevo_layout.addWidget(self.deevolution_list)
        
        deevo_info = QLabel("ℹ️ Read-only - Automatically determined by other Digimon's evolution paths")
        deevo_info.setStyleSheet("""
            color: #666;
            font-style: italic;
            font-size: 9pt;
            padding: 5px;
            background-color: #fff9e6;
            border-radius: 4px;
            border-left: 3px solid #ffc107;
        """)
        deevo_layout.addWidget(deevo_info)
        
        details_layout.addWidget(deevo_group)
        
        splitter.addWidget(details_widget)
        
        # Set splitter proportions (40% tree, 60% details)
        splitter.setStretchFactor(0, 40)
        splitter.setStretchFactor(1, 60)
        
        layout.addWidget(splitter)
        
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
        
        # Populate evolution paths with detailed requirements
        for evo in digimon.evolution_paths:
            to_id = evo['to_id']
            # Try both zero-padded (chr025) and non-padded (chr25) formats
            to_chr_id = f"chr{to_id:03d}"
            to_name = self.loader._get_digimon_name_by_chr_id(to_chr_id)
            if not to_name or to_name == to_chr_id:
                # Try without padding
                to_chr_id = f"chr{to_id}"
                to_name = self.loader._get_digimon_name_by_chr_id(to_chr_id)
            if not to_name or to_name in [to_chr_id, f"chr{to_id:03d}", f"chr{to_id}"]:
                to_name = f"Unknown (ID: {to_id})"
            
            # Build requirements string
            reqs = []
            if 'raw_data' in evo and len(evo['raw_data']) > 2:
                level_req = evo['raw_data'][2] if len(evo['raw_data']) > 2 else 0
                if level_req and str(level_req).isdigit() and int(level_req) > 0:
                    reqs.append(f"Lv{level_req}")
            
            req_str = f" [{', '.join(reqs)}]" if reqs else ""
            self.evolution_list.addItem(f"→ {to_name}{req_str}")
        
        # Populate de-evolution sources
        for deevo in digimon.deevolution_sources:
            from_id = deevo['from_id']
            # Try both zero-padded (chr025) and non-padded (chr25) formats
            from_chr_id = f"chr{from_id:03d}"
            from_name = self.loader._get_digimon_name_by_chr_id(from_chr_id)
            if not from_name or from_name == from_chr_id:
                # Try without padding
                from_chr_id = f"chr{from_id}"
                from_name = self.loader._get_digimon_name_by_chr_id(from_chr_id)
            if not from_name or from_name in [from_chr_id, f"chr{from_id:03d}", f"chr{from_id}"]:
                from_name = f"Unknown (ID: {from_id})"
            self.deevolution_list.addItem(f"← {from_name} (ID: {from_id})")
        
        # Draw visual evolution tree
        self.draw_evolution_tree(digimon)
    
    def draw_evolution_tree(self, digimon: DigimonData):
        """Draw visual representation of evolution tree"""
        try:
            from PyQt6.QtWidgets import QTextBrowser
            
            # Calculate tree structure
            nodes = []
            
            # Add pre-evolutions (sources)
            for i, deevo in enumerate(digimon.deevolution_sources):
                from_id = deevo.get('from_id', 0)
                from_chr_id = f"chr{from_id:03d}"
                from_name = self.loader._get_digimon_name_by_chr_id(from_chr_id)
                if not from_name or from_name == from_chr_id:
                    from_chr_id = f"chr{from_id}"
                    from_name = self.loader._get_digimon_name_by_chr_id(from_chr_id)
                if not from_name or from_name in [from_chr_id, f"chr{from_id:03d}", f"chr{from_id}"]:
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
                to_chr_id = f"chr{to_id:03d}"
                to_name = self.loader._get_digimon_name_by_chr_id(to_chr_id)
                if not to_name or to_name == to_chr_id:
                    to_chr_id = f"chr{to_id}"
                    to_name = self.loader._get_digimon_name_by_chr_id(to_chr_id)
                if not to_name or to_name in [to_chr_id, f"chr{to_id:03d}", f"chr{to_id}"]:
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
        """Generate HTML representation of evolution tree - QTextBrowser compatible"""
        html = """
        <html>
        <head>
        <style>
            body { 
                font-family: Arial, sans-serif; 
                padding: 20px;
                background-color: #667eea;
                margin: 0;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            td {
                text-align: center;
                vertical-align: middle;
                padding: 10px;
            }
            .node { 
                background-color: #764ba2;
                color: white;
                border: 2px solid white;
                padding: 15px;
                margin: 5px;
                font-weight: bold;
                font-size: 12px;
            }
            .node-current { 
                background-color: #f5576c;
                font-size: 16px;
                padding: 20px;
                border: 3px solid white;
            }
            .node-source { 
                background-color: #a18cd1;
            }
            .node-target { 
                background-color: #84fab0;
            }
            .arrow { 
                color: white;
                font-size: 32px; 
                font-weight: bold;
            }
            .label { 
                color: white;
                font-size: 10px;
                font-weight: bold;
                margin-bottom: 8px;
            }
            .empty-state {
                color: white;
                text-align: center;
                padding: 40px;
                font-size: 14px;
            }
        </style>
        </head>
        <body>
        <table>
        <tr>
        """
        
        # Pre-evolutions column
        sources = [n for n in nodes if n['type'] == 'source']
        current = [n for n in nodes if n['type'] == 'current']
        targets = [n for n in nodes if n['type'] == 'target']
        
        # Check if we have any data
        if not sources and not targets:
            html += '<td colspan="3"><div class="empty-state">'
            html += '<b>No evolution data available</b><br/><br/>'
            html += 'This Digimon has no defined pre-evolutions or evolutions.<br/>'
            html += 'Use the "Add Evolution" button to create evolution paths.'
            html += '</div></td>'
        else:
            # Pre-evolutions column
            if sources:
                html += '<td style="width:30%">'
                html += '<div class="label">PRE-EVOLUTION</div>'
                for node in sources:
                    html += f'<div class="node node-source">{node["name"]}<br/><small>ID: {node["id"]}</small></div>'
                html += '</td>'
                html += '<td style="width:5%"><div class="arrow">→</div></td>'
            
            # Current Digimon
            if current:
                current_node = current[0]
                if not sources:
                    html += '<td style="width:35%"></td><td style="width:5%"></td>'
                html += '<td style="width:30%">'
                html += '<div class="label">CURRENT</div>'
                html += f'<div class="node node-current">{current_node["name"]}<br/><small>ID: {current_node["id"]}</small></div>'
                html += '</td>'
            
            # Evolutions column
            if targets:
                html += '<td style="width:5%"><div class="arrow">→</div></td>'
                html += '<td style="width:30%">'
                html += '<div class="label">EVOLUTION</div>'
                for node in targets:
                    html += f'<div class="node node-target">{node["name"]}<br/><small>ID: {node["id"]}</small></div>'
                html += '</td>'
        
        html += """
        </tr>
        </table>
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
            # Get the name for this chr_id
            name = self.loader._get_digimon_name_by_chr_id(chr_id)
            if name and name != chr_id:  # Only show if we have a proper name
                display_name = f"{name} ({chr_id})"
                digimon_names.append(display_name)
                self.digimon_data[display_name] = chr_id
            else:
                # Fallback to chr_id if no name found
                digimon_names.append(chr_id)
                self.digimon_data[chr_id] = chr_id
        
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
        display_name = self.digimon_list.currentText()
        if display_name and display_name in self.digimon_data:
            chr_id = self.digimon_data[display_name]
            digimon = self.loader.get_digimon_by_chr_id(chr_id)
            if digimon:
                self.load_digimon_data(digimon)
            else:
                QMessageBox.warning(self, "Error", f"Could not load Digimon {display_name}")
    
    def load_digimon_data(self, digimon: DigimonData):
        """Load Digimon data into the editor"""
        self.current_digimon = digimon
        self.current_digimon_label.setText(f"✏️ Editing: {digimon.name} ({digimon.chr_id})")
        
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
        stage_index = self.stage_combo.findData(digimon.stage_id)
        if stage_index >= 0:
            self.stage_combo.setCurrentIndex(stage_index)
        else:
            # If stage_id is 0 or not found, set to index 0 (which should be "-")
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
        
        # Refresh the digimon list if a new Digimon was created
        if wizard.new_digimon:
            self.load_digimon_list()
            # Optionally load the newly created Digimon
            reply = QMessageBox.question(
                self,
                "Digimon Created",
                f"✅ {wizard.new_digimon.name} has been added to DLC!\n\n"
                f"Would you like to load it for editing?",
                QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No
            )
            if reply == QMessageBox.StandardButton.Yes:
                # Switch to DLC source and load the new Digimon
                self.source_combo.setCurrentIndex(1)  # DLC
                self.load_digimon_list()
                # Find and select the new Digimon
                for i in range(self.digimon_list.count()):
                    if wizard.new_digimon.chr_id in self.digimon_list.itemText(i):
                        self.digimon_list.setCurrentIndex(i)
                        self.load_selected_digimon()
                        break
    
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
        
        # Find the next available ID
        existing_ids = self.loader.get_all_digimon_ids()
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
        
        # Update current digimon with form data
        self.update_digimon_from_form()
        
        # Check if this Digimon is from DLC or base game
        is_from_dlc = self.source_combo.currentData()
        
        if is_from_dlc:
            # Save to DLC instead of base game
            dlc_exporter = DLCExporter(self.loader)
            animation_ref = self.animation_ref_edit.text().strip() if self.animation_ref_edit.text().strip() else self.current_digimon.chr_id
            
            if dlc_exporter.save_digimon_to_dlc(self.current_digimon, animation_ref):
                QMessageBox.information(self, "Success", "Digimon data saved to DLC successfully!")
                # Refresh the digimon list to show any changes
                self.load_digimon_list()
            else:
                QMessageBox.warning(self, "Error", "Failed to save Digimon data to DLC")
        else:
            # Save to base game files
            if self.loader.save_digimon_data(self.current_digimon):
                QMessageBox.information(self, "Success", "Digimon data saved successfully!")
                # Refresh the digimon list to show any changes
                self.load_digimon_list()
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
        layout = QVBoxLayout(dialog)
        
        layout.addWidget(QLabel("Select target Digimon:"))
        target_combo = QComboBox()
        
        # Populate with all Digimon
        chr_ids = self.loader.get_all_digimon_chr_ids()
        for chr_id in chr_ids:
            name = self.loader._get_digimon_name_by_chr_id(chr_id)
            target_combo.addItem(f"{name} ({chr_id})", chr_id)
        
        layout.addWidget(target_combo)
        
        buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel)
        buttons.accepted.connect(dialog.accept)
        buttons.rejected.connect(dialog.reject)
        layout.addWidget(buttons)
        
        if dialog.exec() == QDialog.DialogCode.Accepted:
            target_chr_id = target_combo.currentData()
            # Get target ID from chr_id
            target_digimon = self.loader.get_digimon_by_chr_id(target_chr_id)
            if target_digimon:
                # Add to evolution paths
                new_evo = {
                    'evolution_id': 0,  # Will be assigned when saved
                    'from_id': self.current_digimon.id,
                    'to_id': target_digimon.id,
                    'condition_flags': ['0', '-1', '-1', '-1', '-1', '-1'],
                    'raw_data': []
                }
                self.current_digimon.evolution_paths.append(new_evo)
                
                # Refresh the evolution tab
                self.update_evolution_tab(self.current_digimon)
                QMessageBox.information(self, "Success", f"Added evolution to {target_digimon.name}")
    
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
        
        # Create detailed evolution requirements dialog
        dialog = QDialog(self)
        dialog.setWindowTitle("✏️ Edit Evolution Requirements")
        dialog.setMinimumWidth(550)
        dialog.setStyleSheet("""
            QDialog {
                background-color: #f8f9fa;
            }
        """)
        layout = QVBoxLayout(dialog)
        
        # Target Digimon info
        to_id = evo['to_id']
        to_chr_id = f"chr{to_id:03d}"
        to_name = self.loader._get_digimon_name_by_chr_id(to_chr_id)
        if not to_name or to_name == to_chr_id:
            to_chr_id = f"chr{to_id}"
            to_name = self.loader._get_digimon_name_by_chr_id(to_chr_id)
        if not to_name:
            to_name = f"ID {to_id}"
        
        info_label = QLabel(f"🎯 Editing evolution to: <b>{to_name}</b>")
        info_label.setStyleSheet("""
            QLabel {
                font-size: 13pt;
                font-weight: bold;
                padding: 15px;
                background: qlineargradient(x1:0, y1:0, x2:1, y2:0,
                    stop:0 #667eea, stop:1 #764ba2);
                color: white;
                border-radius: 8px;
            }
        """)
        layout.addWidget(info_label)
        
        # Requirements form
        form_layout = QFormLayout()
        
        # Parse existing requirements from raw_data if available
        raw_data = evo.get('raw_data', [])
        
        # Level requirement
        level_spin = QSpinBox()
        level_spin.setRange(0, 99)
        level_spin.setValue(int(raw_data[2]) if len(raw_data) > 2 and str(raw_data[2]).isdigit() else 0)
        form_layout.addRow("⭐ Level Required:", level_spin)
        
        # Stat requirements
        stats_group = QGroupBox("📊 Stat Requirements")
        stats_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #667eea;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 10px;
                background-color: white;
            }
            QGroupBox::title {
                color: #667eea;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 5px;
            }
        """)
        stats_layout = QFormLayout(stats_group)
        
        atk_spin = QSpinBox()
        atk_spin.setRange(0, 9999)
        atk_spin.setValue(int(raw_data[3]) if len(raw_data) > 3 and str(raw_data[3]).isdigit() else 0)
        stats_layout.addRow("ATK:", atk_spin)
        
        def_spin = QSpinBox()
        def_spin.setRange(0, 9999)
        def_spin.setValue(int(raw_data[4]) if len(raw_data) > 4 and str(raw_data[4]).isdigit() else 0)
        stats_layout.addRow("DEF:", def_spin)
        
        int_spin = QSpinBox()
        int_spin.setRange(0, 9999)
        int_spin.setValue(int(raw_data[5]) if len(raw_data) > 5 and str(raw_data[5]).isdigit() else 0)
        stats_layout.addRow("INT:", int_spin)
        
        spd_spin = QSpinBox()
        spd_spin.setRange(0, 9999)
        spd_spin.setValue(int(raw_data[6]) if len(raw_data) > 6 and str(raw_data[6]).isdigit() else 0)
        stats_layout.addRow("SPD:", spd_spin)
        
        form_layout.addRow(stats_group)
        
        # Special requirements
        special_group = QGroupBox("✨ Special Requirements")
        special_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #f093fb;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 10px;
                background-color: white;
            }
            QGroupBox::title {
                color: #c967cc;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 5px;
            }
        """)
        special_layout = QFormLayout(special_group)
        
        cam_spin = QSpinBox()
        cam_spin.setRange(0, 100)
        cam_spin.setValue(int(raw_data[7]) if len(raw_data) > 7 and str(raw_data[7]).isdigit() else 0)
        special_layout.addRow("CAM (Camaraderie):", cam_spin)
        
        abi_spin = QSpinBox()
        abi_spin.setRange(0, 100)
        abi_spin.setValue(int(raw_data[8]) if len(raw_data) > 8 and str(raw_data[8]).isdigit() else 0)
        special_layout.addRow("ABI (Ability):", abi_spin)
        
        item_spin = QSpinBox()
        item_spin.setRange(-1, 9999)
        item_spin.setSpecialValueText("None")
        item_spin.setValue(int(raw_data[9]) if len(raw_data) > 9 and str(raw_data[9]).isdigit() else -1)
        special_layout.addRow("Item Required (-1=None):", item_spin)
        
        form_layout.addRow(special_group)
        
        # Quick preset buttons
        preset_group = QGroupBox("⚙️ Quick Presets")
        preset_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #84fab0;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 10px;
                background-color: white;
            }
            QGroupBox::title {
                color: #2c9558;
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 5px;
            }
        """)
        preset_layout = QHBoxLayout(preset_group)
        
        def apply_easy():
            level_spin.setValue(max(1, level_spin.value() // 2))
            atk_spin.setValue(atk_spin.value() // 2)
            def_spin.setValue(def_spin.value() // 2)
            int_spin.setValue(int_spin.value() // 2)
            spd_spin.setValue(spd_spin.value() // 2)
            cam_spin.setValue(max(10, cam_spin.value() // 2))
            abi_spin.setValue(max(0, abi_spin.value() // 2))
        
        def apply_hard():
            level_spin.setValue(min(99, level_spin.value() * 2))
            atk_spin.setValue(min(9999, int(atk_spin.value() * 1.5)))
            def_spin.setValue(min(9999, int(def_spin.value() * 1.5)))
            int_spin.setValue(min(9999, int(int_spin.value() * 1.5)))
            spd_spin.setValue(min(9999, int(spd_spin.value() * 1.5)))
            cam_spin.setValue(min(100, int(cam_spin.value() * 1.5)))
            abi_spin.setValue(min(100, int(abi_spin.value() * 1.5)))
        
        def apply_instant():
            level_spin.setValue(1)
            atk_spin.setValue(0)
            def_spin.setValue(0)
            int_spin.setValue(0)
            spd_spin.setValue(0)
            cam_spin.setValue(0)
            abi_spin.setValue(0)
            item_spin.setValue(-1)
        
        easy_btn = QPushButton("⬇️ Make Easier (÷2)")
        easy_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #84fab0, stop:1 #8fd3f4);
                color: white;
                border: none;
                border-radius: 6px;
                padding: 10px 15px;
                font-weight: bold;
                font-size: 10pt;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #6ee89f, stop:1 #7bc9e8);
            }
        """)
        easy_btn.clicked.connect(apply_easy)
        preset_layout.addWidget(easy_btn)
        
        hard_btn = QPushButton("⬆️ Make Harder (×1.5)")
        hard_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #fa709a, stop:1 #fee140);
                color: white;
                border: none;
                border-radius: 6px;
                padding: 10px 15px;
                font-weight: bold;
                font-size: 10pt;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #e85c89, stop:1 #ecd32f);
            }
        """)
        hard_btn.clicked.connect(apply_hard)
        preset_layout.addWidget(hard_btn)
        
        instant_btn = QPushButton("⚡ Instant Evolution")
        instant_btn.setStyleSheet("""
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
        """)
        instant_btn.clicked.connect(apply_instant)
        preset_layout.addWidget(instant_btn)
        
        form_layout.addRow(preset_group)
        
        layout.addLayout(form_layout)
        
        # Info text
        info_text = QLabel(
            "💡 <b>Tip:</b> Set values to 0 for no requirement. "
            "<b>CAM</b> = friendship (0-100), <b>ABI</b> = training ability (0-100)"
        )
        info_text.setWordWrap(True)
        info_text.setStyleSheet("""
            QLabel {
                color: #495057;
                font-size: 10pt;
                padding: 12px;
                background-color: #e7f5ff;
                border-radius: 6px;
                border-left: 4px solid #339af0;
            }
        """)
        layout.addWidget(info_text)
        
        # Buttons
        buttons = QDialogButtonBox(
            QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel
        )
        buttons.accepted.connect(dialog.accept)
        buttons.rejected.connect(dialog.reject)
        layout.addWidget(buttons)
        
        # Show dialog and update if accepted
        if dialog.exec() == QDialog.DialogCode.Accepted:
            # Update evolution requirements
            # Note: This updates raw_data if available
            if 'raw_data' not in evo or not evo['raw_data']:
                # Create new raw_data array
                evo['raw_data'] = [
                    self.current_digimon.id,  # from_id
                    to_id,  # to_id
                    level_spin.value(),  # level
                    atk_spin.value(),  # atk
                    def_spin.value(),  # def
                    int_spin.value(),  # int
                    spd_spin.value(),  # spd
                    cam_spin.value(),  # cam
                    abi_spin.value(),  # abi
                    item_spin.value(),  # item
                    'false'  # special flag
                ]
            else:
                # Update existing raw_data
                if len(evo['raw_data']) > 2:
                    evo['raw_data'][2] = level_spin.value()
                if len(evo['raw_data']) > 3:
                    evo['raw_data'][3] = atk_spin.value()
                if len(evo['raw_data']) > 4:
                    evo['raw_data'][4] = def_spin.value()
                if len(evo['raw_data']) > 5:
                    evo['raw_data'][5] = int_spin.value()
                if len(evo['raw_data']) > 6:
                    evo['raw_data'][6] = spd_spin.value()
                if len(evo['raw_data']) > 7:
                    evo['raw_data'][7] = cam_spin.value()
                if len(evo['raw_data']) > 8:
                    evo['raw_data'][8] = abi_spin.value()
                if len(evo['raw_data']) > 9:
                    evo['raw_data'][9] = item_spin.value()
            
            # Refresh the evolution tab
            self.update_evolution_tab(self.current_digimon)
            
            QMessageBox.information(
                self,
                "Success",
                f"Updated evolution requirements for {to_name}!\n\n"
                f"Level: {level_spin.value()}, ATK: {atk_spin.value()}, DEF: {def_spin.value()}, "
                f"INT: {int_spin.value()}, SPD: {spd_spin.value()}\n"
                f"CAM: {cam_spin.value()}, ABI: {abi_spin.value()}, Item: {item_spin.value()}"
            )
    
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
            
            if self.exporter.export_all_csv_files(output_path):
                QMessageBox.information(self, "Success", 
                    f"Successfully exported all CSV files to {directory}")
            else:
                QMessageBox.warning(self, "Error", "Failed to export CSV files")
    
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
        for i in range(10):  # Stages 0-9
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
    
    
    def populate_skill_browser(self):
        """Populate the skill browser list with all available skills"""
        try:
            # Get all skills from the loader
            skills_file = self.loader.data_path / "battle_skill.mbe" / "00_battle_skill_list.csv"
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
                self.advanced_skill_name_label.setText(f"Skill: {clean_name}")
                
                # Update all form fields with loaded data
                self.skill_power_edit.setValue(skill_data.get("power", 0))
                self.skill_sp_cost_edit.setValue(skill_data.get("sp_cost", 0))
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
                self.advanced_skill_name_label.setText("Skill not found")
        else:
            self.advanced_skill_name_label.setText("")
    
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
        
        # Save to file
        if self.loader.save_skill_data(skill_data):
            QMessageBox.information(self, "Success", f"Skill {skill_id} saved successfully!")
        else:
            QMessageBox.critical(self, "Error", "Failed to save skill data")


def main():
    app = QApplication(sys.argv)
    
    # Set application properties
    app.setApplicationName("DTS Creator")
    app.setApplicationVersion("1.0")
    
    # Create and show main window
    window = DigimonEditor()
    window.show()
    
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
