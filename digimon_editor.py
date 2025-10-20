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
    QHeaderView, QSplitter, QListWidget, QDoubleSpinBox, QFormLayout,
    QDialog, QDialogButtonBox
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
        self.setGeometry(100, 100, 1200, 700)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QHBoxLayout(central_widget)
        
        # Left panel - Digimon list
        left_panel = self.create_left_panel()
        main_layout.addWidget(left_panel, 1)
        
        # Right panel - Editor
        right_panel = self.create_right_panel()
        main_layout.addWidget(right_panel, 3)
    
    def create_left_panel(self) -> QWidget:
        """Create the left panel with Digimon list"""
        panel = QWidget()
        layout = QVBoxLayout(panel)
        
        # Title
        title = QLabel("Digimon List")
        title.setFont(QFont("Arial", 14, QFont.Weight.Bold))
        layout.addWidget(title)
        
        # Source selector (Base Game vs DLC)
        source_layout = QHBoxLayout()
        source_layout.addWidget(QLabel("Source:"))
        self.source_combo = QComboBox()
        self.source_combo.addItem("Base Game", False)
        self.source_combo.addItem("DLC (addcont_17)", True)
        self.source_combo.currentIndexChanged.connect(self.load_digimon_list)
        source_layout.addWidget(self.source_combo)
        layout.addLayout(source_layout)
        
        # Search box
        search_layout = QHBoxLayout()
        search_layout.addWidget(QLabel("Search:"))
        self.search_box = QLineEdit()
        self.search_box.textChanged.connect(self.filter_digimon_list)
        search_layout.addWidget(self.search_box)
        layout.addLayout(search_layout)
        
        # Digimon list
        self.digimon_list = QComboBox()
        self.digimon_list.currentTextChanged.connect(self.on_digimon_selected)
        layout.addWidget(self.digimon_list)
        
        # Buttons
        button_layout = QVBoxLayout()
        
        self.load_button = QPushButton("Load Selected")
        self.load_button.clicked.connect(self.load_selected_digimon)
        button_layout.addWidget(self.load_button)
        
        self.new_button = QPushButton("Create New")
        self.new_button.clicked.connect(self.create_new_digimon)
        button_layout.addWidget(self.new_button)
        
        self.save_button = QPushButton("Save Changes")
        self.save_button.clicked.connect(self.save_current_digimon)
        self.save_button.setEnabled(False)
        button_layout.addWidget(self.save_button)
        
        self.export_dlc_button = QPushButton("Export to DLC")
        self.export_dlc_button.clicked.connect(self.export_to_dlc)
        self.export_dlc_button.setEnabled(False)
        self.export_dlc_button.setStyleSheet("background-color: #4CAF50; color: white; font-weight: bold;")
        button_layout.addWidget(self.export_dlc_button)
        
        self.export_button = QPushButton("Export CSV")
        self.export_button.clicked.connect(self.export_csv)
        button_layout.addWidget(self.export_button)
        
        self.repack_button = QPushButton("Repack to MBE Files")
        self.repack_button.clicked.connect(self.repack_mbe_files)
        button_layout.addWidget(self.repack_button)
        
        self.repack_dlc_button = QPushButton("Repack DLC to MBE")
        self.repack_dlc_button.clicked.connect(self.repack_dlc_mbe_files)
        self.repack_dlc_button.setStyleSheet("background-color: #2196F3; color: white; font-weight: bold;")
        button_layout.addWidget(self.repack_dlc_button)
        
        layout.addLayout(button_layout)
        layout.addStretch()
        
        return panel
    
    def create_right_panel(self) -> QWidget:
        """Create the right panel with editor tabs"""
        panel = QWidget()
        layout = QVBoxLayout(panel)
        
        # Current Digimon info
        info_layout = QHBoxLayout()
        self.current_digimon_label = QLabel("No Digimon loaded")
        self.current_digimon_label.setFont(QFont("Arial", 12, QFont.Weight.Bold))
        info_layout.addWidget(self.current_digimon_label)
        info_layout.addStretch()
        layout.addLayout(info_layout)
        
        # Tab widget
        self.tab_widget = QTabWidget()
        
        # Basic Info Tab
        self.basic_tab = self.create_basic_tab()
        self.tab_widget.addTab(self.basic_tab, "Basic Info")
        
        # Stats Tab
        self.stats_tab = self.create_stats_tab()
        self.tab_widget.addTab(self.stats_tab, "Stats")
        
        # Skills Tab
        self.skills_tab = self.create_skills_tab()
        self.tab_widget.addTab(self.skills_tab, "Skills")
        
        # Advanced Skills Tab
        self.advanced_skills_tab = self.create_advanced_skills_tab()
        self.tab_widget.addTab(self.advanced_skills_tab, "Advanced Skills")
        
        # Traits Tab
        self.traits_tab = TraitsEditor(self.loader)
        self.tab_widget.addTab(self.traits_tab, "Traits")
        
        # Model Tab
        self.model_tab = self.create_model_tab()
        self.tab_widget.addTab(self.model_tab, "Model & Animation")
        
        # Evolution Tab
        self.evolution_tab = self.create_evolution_tab()
        self.tab_widget.addTab(self.evolution_tab, "Evolution")
        
        # Battle Tab
        self.battle_tab = self.create_battle_tab()
        self.tab_widget.addTab(self.battle_tab, "Battle Data")
        
        
        # Files Tab - show all 9 required files
        self.files_tab = self.create_files_tab()
        self.tab_widget.addTab(self.files_tab, "Complete Files")
        
        layout.addWidget(self.tab_widget)
        
        return panel
    
    def create_basic_tab(self) -> QWidget:
        """Create basic information tab"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        
        # Form layout
        form_layout = QGridLayout()
        
        # ID
        form_layout.addWidget(QLabel("ID:"), 0, 0)
        self.id_spin = QSpinBox()
        self.id_spin.setRange(0, 99999)
        form_layout.addWidget(self.id_spin, 0, 1)
        
        # Character Key
        form_layout.addWidget(QLabel("Character Key:"), 1, 0)
        self.char_key_edit = QLineEdit()
        form_layout.addWidget(self.char_key_edit, 1, 1)
        
        # Chr ID
        form_layout.addWidget(QLabel("Chr ID:"), 2, 0)
        self.chr_id_edit = QLineEdit()
        form_layout.addWidget(self.chr_id_edit, 2, 1)
        
        # Name
        form_layout.addWidget(QLabel("Name:"), 3, 0)
        self.name_edit = QLineEdit()
        form_layout.addWidget(self.name_edit, 3, 1)
        
        # Stage with dropdown
        form_layout.addWidget(QLabel("Stage:"), 4, 0)
        self.stage_combo = QComboBox()
        self.populate_stage_dropdown()
        form_layout.addWidget(self.stage_combo, 4, 1)
        
        # Type ID with dropdown
        form_layout.addWidget(QLabel("Type:"), 5, 0)
        self.type_combo = QComboBox()
        self.populate_type_dropdown()
        form_layout.addWidget(self.type_combo, 5, 1)
        
        # Personality with dropdown
        form_layout.addWidget(QLabel("Personality:"), 6, 0)
        self.personality_combo = QComboBox()
        self.populate_personality_dropdown()
        form_layout.addWidget(self.personality_combo, 6, 1)
        
        layout.addLayout(form_layout)
        
        # Flags Group
        flags_group = QGroupBox("Flags (Note: These are editable but don't load existing values yet)")
        flags_layout = QHBoxLayout(flags_group)
        
        # Can Mount checkbox
        self.can_mount_check = QCheckBox("Can Mount (Rideable)")
        flags_layout.addWidget(self.can_mount_check)
        
        # Is Boss checkbox
        self.is_boss_check = QCheckBox("Is Boss Variant")
        flags_layout.addWidget(self.is_boss_check)
        
        flags_layout.addStretch()
        layout.addWidget(flags_group)
        
        # Profile/Description Group
        profile_group = QGroupBox("Profile / Description")
        profile_layout = QVBoxLayout(profile_group)
        
        self.profile_text_edit = QTextEdit()
        self.profile_text_edit.setPlaceholderText("Enter Digimon description/profile text...")
        self.profile_text_edit.setMaximumHeight(100)
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
        resist_group = QGroupBox("Elemental Resistances")
        resist_layout = QGridLayout(resist_group)
        
        # Create resistance spinboxes with element names
        self.resist_widgets = {}
        resistances = ["Null", "Fire", "Water", "Ice", "Grass", "Wind", "Elec", "Ground", "Steel", "Light", "Dark"]
        
        for i, resist in enumerate(resistances):
            row = i // 2
            col = (i % 2) * 2
            # Get localized element name
            element_name = self.loader.get_element_name(i)
            clean_name = self.loader.clean_ui_text(element_name)
            resist_layout.addWidget(QLabel(f"{clean_name}:"), row, col)
            spin = QSpinBox()
            spin.setRange(0, 5)
            self.resist_widgets[resist.lower()] = spin
            resist_layout.addWidget(spin, row, col + 1)
        
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
        layout = QVBoxLayout(tab)
        
        # Title
        title = QLabel("Advanced Skill System Editor")
        title.setFont(QFont("Arial", 14, QFont.Weight.Bold))
        layout.addWidget(title)
        
        # Skill selection
        skill_selection_group = QGroupBox("Skill Selection")
        skill_selection_layout = QHBoxLayout(skill_selection_group)
        
        skill_selection_layout.addWidget(QLabel("Skill ID:"))
        self.advanced_skill_id_edit = QSpinBox()
        self.advanced_skill_id_edit.setRange(0, 99999)
        self.advanced_skill_id_edit.valueChanged.connect(self.update_advanced_skill_display)
        skill_selection_layout.addWidget(self.advanced_skill_id_edit)
        
        self.advanced_skill_name_label = QLabel("")
        self.advanced_skill_name_label.setStyleSheet("font-weight: bold; color: #0066cc;")
        skill_selection_layout.addWidget(self.advanced_skill_name_label)
        
        skill_selection_layout.addStretch()
        layout.addWidget(skill_selection_group)
        
        # Basic skill properties
        basic_group = QGroupBox("Basic Properties")
        basic_layout = QFormLayout(basic_group)
        
        self.skill_power_edit = QSpinBox()
        self.skill_power_edit.setRange(0, 9999)
        basic_layout.addRow("Power:", self.skill_power_edit)
        
        self.skill_sp_cost_edit = QSpinBox()
        self.skill_sp_cost_edit.setRange(0, 999)
        basic_layout.addRow("SP Cost:", self.skill_sp_cost_edit)
        
        self.skill_accuracy_edit = QSpinBox()
        self.skill_accuracy_edit.setRange(0, 100)
        basic_layout.addRow("Accuracy:", self.skill_accuracy_edit)
        
        self.skill_crit_rate_edit = QSpinBox()
        self.skill_crit_rate_edit.setRange(0, 100)
        basic_layout.addRow("Critical Rate:", self.skill_crit_rate_edit)
        
        layout.addWidget(basic_group)
        
        # Damage and targeting
        damage_group = QGroupBox("Damage & Targeting")
        damage_layout = QFormLayout(damage_group)
        
        self.skill_damage_type_combo = QComboBox()
        damage_types = ["None/Self", "Physical", "Magic", "Fixed damage at", "Fixed %", "Buff", "Major Damage"]
        self.skill_damage_type_combo.addItems(damage_types)
        damage_layout.addRow("Damage Type:", self.skill_damage_type_combo)
        
        self.skill_element_combo = QComboBox()
        for i in range(11):  # Elements 0-10
            element_name = self.loader.get_element_name(i)
            clean_name = self.loader.clean_ui_text(element_name)
            self.skill_element_combo.addItem(clean_name, i)
        damage_layout.addRow("Element:", self.skill_element_combo)
        
        self.skill_min_hits_edit = QSpinBox()
        self.skill_min_hits_edit.setRange(1, 10)
        damage_layout.addRow("Min Hits:", self.skill_min_hits_edit)
        
        self.skill_max_hits_edit = QSpinBox()
        self.skill_max_hits_edit.setRange(1, 10)
        damage_layout.addRow("Max Hits:", self.skill_max_hits_edit)
        
        layout.addWidget(damage_group)
        
        # Advanced properties
        advanced_group = QGroupBox("Advanced Properties")
        advanced_layout = QFormLayout(advanced_group)
        
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
        advanced_layout.addRow("Additional Property 1:", self.skill_additional_prop1_combo)
        
        self.skill_additional_prop2_combo = QComboBox()
        additional_effects = [
            "None", "No Effect", "Nullifies unfavorable compatibility",
            "Inverts stat changes", "Steals stat changes", "Recovers beyond Max HP",
            "Consumes all SP", "Nullifies attribute compatibility",
            "Attack as Vaccine", "Attack as Data", "Attack as Virus",
            "Attack as Free", "Attack as Variable"
        ]
        self.skill_additional_prop2_combo.addItems(additional_effects)
        advanced_layout.addRow("Additional Property 2:", self.skill_additional_prop2_combo)
        
        layout.addWidget(advanced_group)
        
        # Conditional effects
        conditional_group = QGroupBox("Conditional Effects")
        conditional_layout = QFormLayout(conditional_group)
        
        self.skill_conditional_type_combo = QComboBox()
        conditional_types = [
            "None", "User has (de)buff", "Target has (de)buff", "Target attribute",
            "Target element", "Target higher generation", "Target lower generation",
            "Target acted", "Target hasn't acted", "Target HP ≥ 50%",
            "Target HP ≤ X%", "Target SP ≥ X%", "Target SP ≤ X%", "Target KO'd"
        ]
        self.skill_conditional_type_combo.addItems(conditional_types)
        conditional_layout.addRow("Conditional Type:", self.skill_conditional_type_combo)
        
        self.skill_conditional_effect_combo = QComboBox()
        conditional_effects = [
            "None", "+X% damage", "Increased Damage", "CRT Rate up",
            "Restore HP", "Restore SP", "Restore SP/HP", "Reduce Target SP"
        ]
        self.skill_conditional_effect_combo.addItems(conditional_effects)
        conditional_layout.addRow("Conditional Effect:", self.skill_conditional_effect_combo)
        
        self.skill_conditional_arg_edit = QSpinBox()
        self.skill_conditional_arg_edit.setRange(0, 100)
        conditional_layout.addRow("Conditional Argument:", self.skill_conditional_arg_edit)
        
        layout.addWidget(conditional_group)
        
        # Buff sets
        buff_group = QGroupBox("Buff Sets (up to 5)")
        buff_layout = QVBoxLayout(buff_group)
        
        self.buff_set_widgets = []
        for i in range(5):
            buff_widget = QWidget()
            buff_widget_layout = QHBoxLayout(buff_widget)
            
            buff_widget_layout.addWidget(QLabel(f"Buff Set {i+1}:"))
            buff_set_edit = QSpinBox()
            buff_set_edit.setRange(0, 9999)
            buff_set_edit.setObjectName(f"buff_set_{i}")
            buff_widget_layout.addWidget(buff_set_edit)
            
            self.buff_set_widgets.append(buff_set_edit)
            buff_layout.addWidget(buff_widget)
        
        layout.addWidget(buff_group)
        
        # Special effects
        special_group = QGroupBox("Special Effects")
        special_layout = QFormLayout(special_group)
        
        self.skill_hp_drain_edit = QSpinBox()
        self.skill_hp_drain_edit.setRange(0, 100)
        special_layout.addRow("HP Drain %:", self.skill_hp_drain_edit)
        
        self.skill_sp_drain_edit = QSpinBox()
        self.skill_sp_drain_edit.setRange(0, 100)
        special_layout.addRow("SP Drain %:", self.skill_sp_drain_edit)
        
        self.skill_recoil_edit = QSpinBox()
        self.skill_recoil_edit.setRange(0, 100)
        special_layout.addRow("Recoil %:", self.skill_recoil_edit)
        
        self.skill_always_hits_check = QCheckBox("Always Hits")
        special_layout.addRow("", self.skill_always_hits_check)
        
        layout.addWidget(special_group)
        
        # Save button
        save_skill_button = QPushButton("Save Skill Data")
        save_skill_button.clicked.connect(self.save_advanced_skill)
        layout.addWidget(save_skill_button)
        
        layout.addStretch()
        return tab
    
    def create_evolution_tab(self) -> QWidget:
        """Create evolution management tab"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        
        # Title
        title = QLabel("Evolution & De-evolution Management")
        title.setFont(QFont("Arial", 14, QFont.Weight.Bold))
        layout.addWidget(title)
        
        # Evolution paths (what this Digimon can evolve into)
        evo_group = QGroupBox("Evolution Paths")
        evo_layout = QVBoxLayout(evo_group)
        
        self.evolution_list = QListWidget()
        evo_layout.addWidget(QLabel("Can evolve into:"))
        evo_layout.addWidget(self.evolution_list)
        
        evo_buttons = QHBoxLayout()
        self.add_evo_btn = QPushButton("Add Evolution")
        self.add_evo_btn.clicked.connect(self.add_evolution)
        self.edit_evo_btn = QPushButton("Edit Evolution")
        self.edit_evo_btn.clicked.connect(self.edit_evolution)
        self.remove_evo_btn = QPushButton("Remove Evolution")
        self.remove_evo_btn.clicked.connect(self.remove_evolution)
        evo_buttons.addWidget(self.add_evo_btn)
        evo_buttons.addWidget(self.edit_evo_btn)
        evo_buttons.addWidget(self.remove_evo_btn)
        evo_layout.addLayout(evo_buttons)
        
        layout.addWidget(evo_group)
        
        # De-evolution sources (what can evolve into this Digimon)
        deevo_group = QGroupBox("De-evolution Sources")
        deevo_layout = QVBoxLayout(deevo_group)
        
        self.deevolution_list = QListWidget()
        deevo_layout.addWidget(QLabel("Can be evolved from:"))
        deevo_layout.addWidget(self.deevolution_list)
        
        deevo_buttons = QHBoxLayout()
        deevo_info = QLabel("(Read-only - These are automatically determined by other Digimon's evolution paths)")
        deevo_info.setStyleSheet("color: gray; font-style: italic;")
        deevo_buttons.addWidget(deevo_info)
        deevo_layout.addLayout(deevo_buttons)
        
        layout.addWidget(deevo_group)
        
        # Evolution conditions
        cond_group = QGroupBox("Evolution Conditions")
        cond_layout = QVBoxLayout(cond_group)
        
        self.evolution_conditions_list = QListWidget()
        cond_layout.addWidget(QLabel("Evolution requirements:"))
        cond_layout.addWidget(self.evolution_conditions_list)
        
        cond_buttons = QHBoxLayout()
        self.add_cond_btn = QPushButton("Add Condition")
        self.add_cond_btn.clicked.connect(self.add_evolution_condition)
        self.edit_cond_btn = QPushButton("Edit Condition")
        self.edit_cond_btn.clicked.connect(self.edit_evolution_condition)
        self.remove_cond_btn = QPushButton("Remove Condition")
        self.remove_cond_btn.clicked.connect(self.remove_evolution_condition)
        cond_buttons.addWidget(self.add_cond_btn)
        cond_buttons.addWidget(self.edit_cond_btn)
        cond_buttons.addWidget(self.remove_cond_btn)
        cond_layout.addLayout(cond_buttons)
        
        layout.addWidget(cond_group)
        
        return tab
    
    def create_battle_tab(self) -> QWidget:
        """Create battle data management tab"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        
        # Title
        title = QLabel("Battle & Enemy Data")
        title.setFont(QFont("Arial", 14, QFont.Weight.Bold))
        layout.addWidget(title)
        
        # Battle enemy parameters
        enemy_group = QGroupBox("Enemy Parameters (44 columns)")
        enemy_layout = QFormLayout(enemy_group)
        
        self.enemy_id_edit = QLineEdit()
        self.base_digimon_id_edit = QLineEdit()
        self.ai_level_edit = QSpinBox()
        self.ai_level_edit.setRange(0, 50)
        
        # Battle stats (columns 17-23)
        self.battle_hp_edit = QSpinBox()
        self.battle_hp_edit.setRange(1, 99999)
        self.battle_sp_edit = QSpinBox()
        self.battle_sp_edit.setRange(1, 9999)
        self.battle_attack_edit = QSpinBox()
        self.battle_attack_edit.setRange(1, 9999)
        self.battle_defense_edit = QSpinBox()
        self.battle_defense_edit.setRange(1, 9999)
        self.battle_intelligence_edit = QSpinBox()
        self.battle_intelligence_edit.setRange(1, 9999)
        self.battle_spirit_edit = QSpinBox()
        self.battle_spirit_edit.setRange(1, 9999)
        self.battle_speed_edit = QSpinBox()
        self.battle_speed_edit.setRange(1, 9999)
        
        # AI behavior parameters
        self.ai_skill_id_edit = QSpinBox()
        self.ai_skill_id_edit.setRange(0, 99999)
        self.ai_aggression_edit = QSpinBox()
        self.ai_aggression_edit.setRange(0, 100)
        
        enemy_layout.addRow("Enemy ID (Col 0):", self.enemy_id_edit)
        enemy_layout.addRow("Base Digimon ID (Col 2):", self.base_digimon_id_edit)
        enemy_layout.addRow("AI Level (Col 10):", self.ai_level_edit)
        enemy_layout.addRow("Battle HP (Col 17):", self.battle_hp_edit)
        enemy_layout.addRow("Battle SP (Col 18):", self.battle_sp_edit)
        enemy_layout.addRow("Battle ATK (Col 19):", self.battle_attack_edit)
        enemy_layout.addRow("Battle DEF (Col 20):", self.battle_defense_edit)
        enemy_layout.addRow("Battle INT (Col 21):", self.battle_intelligence_edit)
        enemy_layout.addRow("Battle SPI (Col 22):", self.battle_spirit_edit)
        enemy_layout.addRow("Battle SPD (Col 23):", self.battle_speed_edit)
        enemy_layout.addRow("AI Skill ID (Col 36):", self.ai_skill_id_edit)
        enemy_layout.addRow("AI Aggression (Col 32):", self.ai_aggression_edit)
        
        layout.addWidget(enemy_group)
        
        # Encounter groups
        encounter_group = QGroupBox("Encounter Groups")
        encounter_layout = QVBoxLayout(encounter_group)
        
        self.encounter_list = QListWidget()
        encounter_layout.addWidget(QLabel("Appears in encounter groups:"))
        encounter_layout.addWidget(self.encounter_list)
        
        encounter_buttons = QHBoxLayout()
        encounter_buttons.addWidget(QPushButton("Add to Group"))
        encounter_buttons.addWidget(QPushButton("Remove from Group"))
        encounter_layout.addLayout(encounter_buttons)
        
        layout.addWidget(encounter_group)
        
        # Battle formation
        formation_group = QGroupBox("Battle Formation")
        formation_layout = QFormLayout(formation_group)
        
        self.formation_id_edit = QLineEdit()
        self.formation_type_edit = QLineEdit()
        
        formation_layout.addRow("Formation ID:", self.formation_id_edit)
        formation_layout.addRow("Formation Type:", self.formation_type_edit)
        
        layout.addWidget(formation_group)
        
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
        self.evolution_conditions_list.clear()
        
        # Populate evolution paths
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
            self.evolution_list.addItem(f"→ {to_name} (ID: {to_id})")
        
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
        
        # Populate evolution conditions
        for cond in digimon.evolution_conditions:
            level_req = cond.get('level_req', 0)
            hp_req = cond.get('hp_req', 0)
            cond_text = f"Evolution {cond['evolution_id']}: Level {level_req}"
            if hp_req > 0:
                cond_text += f", HP {hp_req}"
            self.evolution_conditions_list.addItem(cond_text)
    
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
        self.current_digimon_label.setText(f"Editing: {digimon.name} ({digimon.chr_id})")
        
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
        
        # Flags
        self.can_mount_check.setChecked(digimon.can_mount)
        self.is_boss_check.setChecked(digimon.is_boss_variant)
        
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
        
        # Update files tab
        self.update_files_tab(digimon)
        
        # Update extended tabs
        self.update_evolution_tab(digimon)
        self.update_battle_tab(digimon)
        
        self.save_button.setEnabled(True)
        self.export_dlc_button.setEnabled(True)
    
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
        
        # Don't sync chr_id - they are separate now!
        # chr_id = unique ID for this Digimon (e.g., chr1000)
        # animation_ref = which chr_id to use for animations (e.g., chr805)
        
        # Save to files
        if self.loader.save_digimon_data(self.current_digimon):
            QMessageBox.information(self, "Success", "Digimon data saved successfully!")
            # Refresh the digimon list to show any changes
            self.load_digimon_list()
        else:
            QMessageBox.warning(self, "Error", "Failed to save Digimon data")
    
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
        
        # Flags
        self.current_digimon.can_mount = self.can_mount_check.isChecked()
        self.current_digimon.is_boss_variant = self.is_boss_check.isChecked()
        
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
        """Edit selected evolution path"""
        if not self.current_digimon:
            return
        
        current_index = self.evolution_list.currentRow()
        if current_index < 0:
            QMessageBox.warning(self, "Warning", "Please select an evolution to edit")
            return
        
        QMessageBox.information(self, "Info", "Evolution editing coming soon!\nFor now, remove and re-add the evolution.")
    
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
    
    def add_evolution_condition(self):
        """Add evolution condition"""
        QMessageBox.information(self, "Info", "Evolution conditions are complex and require careful editing.\nThis feature is not yet implemented.")
    
    def edit_evolution_condition(self):
        """Edit evolution condition"""
        QMessageBox.information(self, "Info", "Evolution conditions are complex and require careful editing.\nThis feature is not yet implemented.")
    
    def remove_evolution_condition(self):
        """Remove evolution condition"""
        QMessageBox.information(self, "Info", "Evolution conditions are complex and require careful editing.\nThis feature is not yet implemented.")
    
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
