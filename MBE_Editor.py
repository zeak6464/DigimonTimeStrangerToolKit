import sys
import os
import struct
import csv
from io import BytesIO

from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QTableWidget, QTabWidget, QFileDialog, 
    QTableWidgetItem, QMenuBar, QMessageBox, QStatusBar, QMenu, QDialog,
    QVBoxLayout, QHBoxLayout, QLineEdit, QPushButton, QCheckBox, QLabel,
    QInputDialog, QComboBox
)
from PyQt6.QtGui import QAction, QKeySequence, QColor
from PyQt6.QtCore import Qt

# --- Definições de Tipos de Coluna ---
COLUMN_TYPES_BY_CODE = {
    0x2: {'name': 'int',      'code': 0x2, 'size': 4, 'format': '<i'},
    0x3: {'name': 'short',    'code': 0x3, 'size': 2, 'format': '<h'},
    0x4: {'name': 'byte',     'code': 0x4, 'size': 1, 'format': '<b'},
    0x5: {'name': 'float',    'code': 0x5, 'size': 4, 'format': '<f'},
    0x6: {'name': 'string3',  'code': 0x6, 'size': 8, 'format': '<q'},
    0x7: {'name': 'string',   'code': 0x7, 'size': 8, 'format': '<q'},
    0x8: {'name': 'string2',  'code': 0x8, 'size': 8, 'format': '<q'},
    0x9: {'name': 'bool',     'code': 0x9, 'size': 4, 'format': '<i'},
    0xA: {'name': 'empty',    'code': 0xA, 'size': 0, 'format': '<i'},
}
COLUMN_INFO_BY_NAME = {v['name']: v for k, v in COLUMN_TYPES_BY_CODE.items()}


class MBEEditor(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("MBE Editor")
        self.setGeometry(100, 100, 1024, 768)
        self.sheets_data = []
        self.current_filepath = None
        self.is_modified = False
        self.search_results = []
        self.current_search_index = -1
        self._setup_ui()
        self._update_title()

    def _setup_ui(self):
        self.tab_widget = QTabWidget()
        self.setCentralWidget(self.tab_widget)
        self.setStatusBar(QStatusBar(self))
        menu_bar = self.menuBar()
        file_menu = menu_bar.addMenu("&File")
        
        open_action = QAction("&Open MBE...", self)
        open_action.setShortcut(QKeySequence.StandardKey.Open)
        open_action.triggered.connect(self.open_file)
        file_menu.addAction(open_action)
        
        open_csv_action = QAction("Open &CSV...", self)
        open_csv_action.triggered.connect(self.open_csv_file)
        file_menu.addAction(open_csv_action)
        
        self.add_csv_sheet_action = QAction("Add Sheet from CSV...", self)
        self.add_csv_sheet_action.triggered.connect(self.add_csv_sheet)
        self.add_csv_sheet_action.setEnabled(False)
        file_menu.addAction(self.add_csv_sheet_action)
        
        self.save_action = QAction("&Save", self)
        self.save_action.setShortcut(QKeySequence.StandardKey.Save)
        self.save_action.triggered.connect(self.save_file)
        self.save_action.setEnabled(False)
        file_menu.addAction(self.save_action)
        
        self.save_as_action = QAction("Save &as...", self)
        self.save_as_action.setShortcut(QKeySequence.StandardKey.SaveAs)
        self.save_as_action.triggered.connect(self.save_file_as)
        self.save_as_action.setEnabled(False)
        file_menu.addAction(self.save_as_action)
        
        file_menu.addSeparator()
        
        self.export_csv_action = QAction("Export Current Sheet to CSV...", self)
        self.export_csv_action.triggered.connect(self.export_current_sheet_to_csv)
        self.export_csv_action.setEnabled(False)
        file_menu.addAction(self.export_csv_action)
        
        self.export_all_csv_action = QAction("Export All Sheets to CSV...", self)
        self.export_all_csv_action.triggered.connect(self.export_all_sheets_to_csv)
        self.export_all_csv_action.setEnabled(False)
        file_menu.addAction(self.export_all_csv_action)
        
        file_menu.addSeparator()
        
        exit_action = QAction("Q&uit", self)
        exit_action.triggered.connect(self.close)
        file_menu.addAction(exit_action)
        
        # Edit menu
        edit_menu = menu_bar.addMenu("&Edit")
        
        self.search_action = QAction("&Find...", self)
        self.search_action.setShortcut(QKeySequence.StandardKey.Find)
        self.search_action.triggered.connect(self.show_search_dialog)
        self.search_action.setEnabled(False)
        edit_menu.addAction(self.search_action)
        
        self.find_next_action = QAction("Find &Next", self)
        self.find_next_action.setShortcut(QKeySequence.StandardKey.FindNext)
        self.find_next_action.triggered.connect(self.find_next)
        self.find_next_action.setEnabled(False)
        edit_menu.addAction(self.find_next_action)
        
        self.find_prev_action = QAction("Find &Previous", self)
        self.find_prev_action.setShortcut(QKeySequence.StandardKey.FindPrevious)
        self.find_prev_action.triggered.connect(self.find_previous)
        self.find_prev_action.setEnabled(False)
        edit_menu.addAction(self.find_prev_action)

    def _update_title(self):
        title = "MBE Editor"
        if self.current_filepath:
            filename = os.path.basename(self.current_filepath)
            title = f"{filename}{'*' if self.is_modified else ''} - {title}"
        self.setWindowTitle(title)
        
    def _set_modified(self, modified=True):
        if self.is_modified == modified: return
        self.is_modified = modified
        self.save_action.setEnabled(modified)
        self._update_title()

    # --- Lógica de Abertura/Parsing ---
    
    def open_csv_file(self):
        if not self.check_unsaved_changes(): return
        filepath, _ = QFileDialog.getOpenFileName(self, "Open CSV file", "", "CSV Files (*.csv);;All files (*)")
        if not filepath: return

        try:
            # Get sheet name from filename (without extension)
            sheet_name = os.path.splitext(os.path.basename(filepath))[0]
            
            with open(filepath, 'r', encoding='utf-8') as f:
                parsed_data = self._parse_csv_data(f, sheet_name)
            
            self.sheets_data = parsed_data
            self.current_filepath = None  # No MBE file loaded yet
            self._populate_tabs()
            self.save_action.setEnabled(False)
            self.save_as_action.setEnabled(True)
            self.search_action.setEnabled(True)
            self.add_csv_sheet_action.setEnabled(True)
            self.export_csv_action.setEnabled(True)
            self.export_all_csv_action.setEnabled(True)
            self._set_modified(True)  # Mark as modified so user can save as MBE
            self.statusBar().showMessage(f"CSV file '{os.path.basename(filepath)}' loaded. Use 'Save as...' to save as MBE.", 5000)
        except Exception as e:
            import traceback
            error_details = traceback.format_exc()
            QMessageBox.critical(self, "CSV Reading Error", f"It was not possible to read CSV:\n{e}\n\nDetails:\n{error_details}")
            self.clear_all()
    
    def add_csv_sheet(self):
        """Add an additional sheet from a CSV file"""
        filepath, _ = QFileDialog.getOpenFileName(self, "Add Sheet from CSV", "", "CSV Files (*.csv);;All files (*)")
        if not filepath:
            return

        try:
            # Get sheet name from filename (without extension)
            sheet_name = os.path.splitext(os.path.basename(filepath))[0]
            
            # Check if sheet name already exists
            existing_names = [sheet['name'] for sheet in self.sheets_data]
            if sheet_name in existing_names:
                # Add a number suffix to make it unique
                counter = 1
                base_name = sheet_name
                while sheet_name in existing_names:
                    sheet_name = f"{base_name}_{counter}"
                    counter += 1
            
            with open(filepath, 'r', encoding='utf-8') as f:
                parsed_data = self._parse_csv_data(f, sheet_name)
            
            # Add the new sheet to existing data
            self.sheets_data.extend(parsed_data)
            
            # Repopulate all tabs
            self._populate_tabs()
            
            self._set_modified(True)
            self.statusBar().showMessage(f"Added sheet '{sheet_name}' from CSV. Total sheets: {len(self.sheets_data)}", 5000)
        except Exception as e:
            import traceback
            error_details = traceback.format_exc()
            QMessageBox.critical(self, "CSV Reading Error", f"It was not possible to add CSV sheet:\n{e}\n\nDetails:\n{error_details}")
    
    def _parse_csv_data(self, f, sheet_name="Sheet1"):
        reader = csv.reader(f)
        rows = list(reader)
        
        if len(rows) < 2:
            raise ValueError("CSV file must have at least a header row and one data row.")
        
        # Parse header row to get column types
        header_row = rows[0]
        columns = []
        
        # Map CSV type names to internal type names
        type_mapping = {
            'int8': 'byte',
            'int16': 'short',
            'int32': 'int',
            'float': 'float',
            'string': 'string',
            'string2': 'string2',
            'string3': 'string3',
            'bool': 'bool',
            'empty': 'empty',
        }
        
        for col_header in header_row:
            # Parse format: "type index" e.g., "string2 0", "float 5"
            parts = col_header.strip().split()
            if len(parts) < 1:
                raise ValueError(f"Invalid column header format: '{col_header}'")
            
            csv_type = parts[0]
            internal_type = type_mapping.get(csv_type)
            
            if internal_type is None:
                raise ValueError(f"Unknown column type: '{csv_type}'")
            
            if internal_type not in COLUMN_INFO_BY_NAME:
                raise ValueError(f"Internal type '{internal_type}' not found in column definitions.")
            
            columns.append(COLUMN_INFO_BY_NAME[internal_type])
        
        # Parse data rows
        data_rows = []
        for row_idx, row in enumerate(rows[1:], start=2):
            if len(row) != len(columns):
                raise ValueError(f"Row {row_idx} has {len(row)} columns but expected {len(columns)}.")
            
            parsed_row = []
            for col_idx, (cell_value, col) in enumerate(zip(row, columns)):
                # CSV reader automatically handles quoted strings
                # Empty cells come as empty strings
                
                # Handle different types
                if col['name'] == 'empty':
                    parsed_row.append('')
                elif 'string' in col['name']:
                    # CSV reader removes outer quotes automatically
                    # Empty cells or "" in CSV will be empty strings
                    if cell_value == '':
                        parsed_row.append('""')  # Use '""' to represent empty strings
                    else:
                        parsed_row.append(cell_value)
                elif col['name'] == 'float':
                    try:
                        parsed_row.append(float(cell_value) if cell_value else 0.0)
                    except ValueError:
                        parsed_row.append(0.0)
                elif col['name'] == 'bool':
                    # Parse bool - 1, true, True -> 1, everything else -> 0
                    if cell_value:
                        parsed_row.append(1 if cell_value.lower() in ['1', 'true'] else 0)
                    else:
                        parsed_row.append(0)
                else:  # int, short, byte
                    try:
                        parsed_row.append(int(cell_value) if cell_value else 0)
                    except ValueError:
                        parsed_row.append(0)
            
            data_rows.append(parsed_row)
        
        # Create a single sheet (CSV is a single table) with the provided name
        return [{'name': sheet_name, 'columns': columns, 'rows': data_rows}]
    
    def open_file(self):
        if not self.check_unsaved_changes(): return
        filepath, _ = QFileDialog.getOpenFileName(self, "Open MBE file", "", "MBE Files (*.mbe);;All files (*)")
        if not filepath: return

        try:
            with open(filepath, 'rb') as f:
                parsed_data = self._parse_mbe_data(f)
            
            self.sheets_data = parsed_data
            self.current_filepath = filepath
            self._populate_tabs()
            self.save_action.setEnabled(False)
            self.save_as_action.setEnabled(True)
            self.search_action.setEnabled(True)
            self.add_csv_sheet_action.setEnabled(True)
            self.export_csv_action.setEnabled(True)
            self.export_all_csv_action.setEnabled(True)
            self._set_modified(False)
            self.statusBar().showMessage(f"File '{os.path.basename(filepath)}' loaded.", 5000)
        except Exception as e:
            QMessageBox.critical(self, "Reading Error", f"It was not possible to read:\n{e}")
            self.clear_all()
    
    def _parse_mbe_data(self, f):
        if f.read(4) != b'EXPA': raise ValueError("Magic Number 'EXPA' not found.")
        num_expa_regions, = struct.unpack('<i', f.read(4))
        all_sheets, string_map = [], {}
        offset = 8

        for sheet_idx in range(num_expa_regions):
            # Align to 8-byte boundary
            offset = (offset + 7) & ~7
            f.seek(offset)
            
            sheet_name_size, = struct.unpack('<i', f.read(4))
            sheet_name = self._read_padded_string_from_file(f, sheet_name_size)
            
            num_cols, = struct.unpack('<i', f.read(4))
            col_codes = struct.unpack(f'<{num_cols}i', f.read(4 * num_cols))
            columns = [COLUMN_TYPES_BY_CODE[code] for code in col_codes]
            
            area_size, num_areas = struct.unpack('<ii', f.read(8))
            
            # Calculate total header size and align
            header_size = 4 + sheet_name_size + 4 + 4 * num_cols + 8
            header_size = (header_size + 7) & ~7
            offset += header_size
            
            rows = []
            for row_idx in range(num_areas):
                # Align to 8-byte boundary for each row
                offset = (offset + 7) & ~7
                f.seek(offset)
                
                row_start_offset = f.tell()
                row_bytes = f.read(area_size)
                
                parsed_row, offset_in_row = [], 0
                bit_offset = 0
                bool_value = 0  # Separate variable for bool bit extraction
                
                for col_idx, col in enumerate(columns):
                    if col['name'] == 'bool':
                        if bit_offset == 0:
                            # Align to 4-byte boundary for bool
                            offset_in_row = (offset_in_row + 3) & ~3
                            val_bytes = row_bytes[offset_in_row:offset_in_row + 4]
                            bool_value, = struct.unpack('<i', val_bytes)
                            offset_in_row += 4
                        # Extract bit from the 32-bit value
                        bit_val = (bool_value >> bit_offset) & 1
                        parsed_row.append(bit_val)
                        bit_offset += 1
                        if bit_offset >= 32:
                            bit_offset = 0
                    elif col['name'] == 'empty':
                        parsed_row.append('')
                    elif 'string' in col['name']:
                        # Align to 8-byte boundary for strings
                        offset_in_row = (offset_in_row + 7) & ~7
                        string_map[row_start_offset + offset_in_row] = (sheet_idx, row_idx, col_idx)
                        parsed_row.append('')
                        offset_in_row += 8
                    else:
                        # Handle other types with proper alignment
                        if col['name'] == 'short':
                            offset_in_row = (offset_in_row + 1) & ~1
                        elif col['name'] in ['int', 'float']:
                            offset_in_row = (offset_in_row + 3) & ~3
                        
                        val_bytes = row_bytes[offset_in_row:offset_in_row + col['size']]
                        val, = struct.unpack(col['format'], val_bytes)
                        parsed_row.append(val)
                        offset_in_row += col['size']
                
                # Handle remaining bool bits
                if bit_offset > 0:
                    offset_in_row += 4
                
                rows.append(parsed_row)
                offset += area_size + ((area_size + 7) & ~7) - area_size
            
            all_sheets.append({'name': sheet_name, 'columns': columns, 'rows': rows})
        
        # Align to 8-byte boundary before CHNK section
        offset = (offset + 7) & ~7
        f.seek(offset)
        
        if f.read(4) == b'CHNK':
            num_strings, = struct.unpack('<i', f.read(4))
            for _ in range(num_strings):
                offset, size = struct.unpack('<ii', f.read(8))
                text = self._read_padded_string_from_file(f, size)
                if offset in string_map:
                    s_idx, r_idx, c_idx = string_map[offset]
                    all_sheets[s_idx]['rows'][r_idx][c_idx] = text
        
        # Convert empty string fields to '""' for display
        for sheet in all_sheets:
            for row in sheet['rows']:
                for c_idx, col in enumerate(sheet['columns']):
                    if 'string' in col['name'] and row[c_idx] == '':
                        row[c_idx] = '""'
        
        return all_sheets

    def _populate_tabs(self):
        self.tab_widget.clear()
        for i, sheet_data in enumerate(self.sheets_data):
            table = QTableWidget(len(sheet_data['rows']), len(sheet_data['columns']))
            headers = [f"{col['name']}_{j}" for j, col in enumerate(sheet_data['columns'])]
            table.setHorizontalHeaderLabels(headers)
            
            for r, row_list in enumerate(sheet_data['rows']):
                for c, cell_value in enumerate(row_list):
                    # Format float values for better display
                    if sheet_data['columns'][c]['name'] == 'float' and isinstance(cell_value, float):
                        # Round to 6 decimal places and remove trailing zeros
                        display_value = f"{cell_value:.6f}".rstrip('0').rstrip('.')
                    else:
                        display_value = str(cell_value)
                    table.setItem(r, c, QTableWidgetItem(display_value))
            
            table.setContextMenuPolicy(Qt.ContextMenuPolicy.CustomContextMenu)
            table.customContextMenuRequested.connect(self._show_table_context_menu)
            
            # Enable context menu on horizontal header (column headers)
            table.horizontalHeader().setContextMenuPolicy(Qt.ContextMenuPolicy.CustomContextMenu)
            table.horizontalHeader().customContextMenuRequested.connect(
                lambda pos, t=table: self._show_column_context_menu(pos, t)
            )
            
            # **** CORREÇÃO APLICADA AQUI ****
            # Usamos uma lambda para chamar _set_modified sem passar o argumento do sinal.
            table.itemChanged.connect(lambda: self._set_modified())
            
            table.resizeColumnsToContents()
            self.tab_widget.addTab(table, sheet_data['name'])

    # --- Lógica do Menu de Contexto ---

    def _show_column_context_menu(self, position, table):
        if not table:
            return
        
        # Get the column index from the position
        col_index = table.horizontalHeader().logicalIndexAt(position)
        if col_index < 0:
            return
        
        menu = QMenu()
        
        fill_action = QAction(f"Fill Column '{table.horizontalHeaderItem(col_index).text()}'...", self)
        fill_action.triggered.connect(lambda: self._fill_column(table, col_index))
        menu.addAction(fill_action)
        
        formula_action = QAction(f"Apply Formula to Column '{table.horizontalHeaderItem(col_index).text()}'...", self)
        formula_action.triggered.connect(lambda: self._apply_formula_to_column(table, col_index))
        menu.addAction(formula_action)
        
        menu.exec(table.horizontalHeader().mapToGlobal(position))

    def _show_table_context_menu(self, position):
        table = self.tab_widget.currentWidget()
        if not table: return
        row_index = table.rowAt(position.y())
        
        menu = QMenu()
        
        if row_index >= 0:
            insert_above_action = QAction("Insert Line above", self)
            insert_above_action.triggered.connect(lambda: self._insert_row(row_index))
            menu.addAction(insert_above_action)

            insert_below_action = QAction("Insert Line Below", self)
            insert_below_action.triggered.connect(lambda: self._insert_row(row_index + 1))
            menu.addAction(insert_below_action)
            
            menu.addSeparator()

            remove_action = QAction("Remove Line", self)
            remove_action.triggered.connect(lambda: self._remove_row(row_index))
            menu.addAction(remove_action)
            
            menu.exec(table.viewport().mapToGlobal(position))

    def _insert_row(self, row_index):
        table = self.tab_widget.currentWidget()
        if not table: return
        table.insertRow(row_index)
        for col in range(table.columnCount()):
            table.setItem(row_index, col, QTableWidgetItem(""))
        self._set_modified()

    def _remove_row(self, row_index):
        table = self.tab_widget.currentWidget()
        if not table: return
        table.removeRow(row_index)
        self._set_modified()

    # --- Column Editing Functions ---
    
    def _fill_column(self, table, col_index):
        """Fill all cells in a column with a specific value"""
        col_name = table.horizontalHeaderItem(col_index).text()
        
        # Get the column type
        col_type = col_name.split('_')[0]
        
        # Ask user for the value
        value, ok = QInputDialog.getText(
            self,
            "Fill Column",
            f"Enter value to fill column '{col_name}':\n\n"
            f"Column type: {col_type}\n"
            f"This will replace all {table.rowCount()} cells in this column.",
            text=""
        )
        
        if ok:
            # Validate based on type
            if not self._validate_cell_value(value, col_type):
                QMessageBox.warning(
                    self,
                    "Invalid Value",
                    f"The value '{value}' is not valid for type '{col_type}'."
                )
                return
            
            # Disconnect itemChanged signal temporarily to avoid multiple modified triggers
            table.itemChanged.disconnect()
            
            # Fill all cells
            for row in range(table.rowCount()):
                item = table.item(row, col_index)
                if item:
                    item.setText(value)
                else:
                    table.setItem(row, col_index, QTableWidgetItem(value))
            
            # Reconnect signal
            table.itemChanged.connect(lambda: self._set_modified())
            
            self._set_modified()
            self.statusBar().showMessage(f"Filled {table.rowCount()} cells in column '{col_name}'.", 3000)
    
    def _apply_formula_to_column(self, table, col_index):
        """Apply a formula/expression to all cells in a column"""
        dialog = FormulaDialog(self, table, col_index)
        if dialog.exec() == QDialog.DialogCode.Accepted:
            formula = dialog.formula_input.text().strip()
            if not formula:
                return
            
            col_name = table.horizontalHeaderItem(col_index).text()
            col_type = col_name.split('_')[0]
            
            # Disconnect itemChanged signal temporarily
            table.itemChanged.disconnect()
            
            success_count = 0
            error_count = 0
            
            # Apply formula to each cell
            for row in range(table.rowCount()):
                item = table.item(row, col_index)
                if not item:
                    continue
                
                try:
                    # Get current value
                    current_text = item.text()
                    
                    # Try to parse as number for numeric types
                    if col_type in ['float', 'int', 'short', 'byte']:
                        try:
                            if col_type == 'float':
                                x = float(current_text) if current_text and current_text != '""' else 0.0
                            else:
                                x = int(current_text) if current_text and current_text != '""' else 0
                        except ValueError:
                            x = 0
                        
                        # Evaluate formula (x is the current value)
                        result = eval(formula, {"__builtins__": {}}, {"x": x, "abs": abs, "round": round, "min": min, "max": max, "int": int, "float": float})
                        
                        # Format result based on type
                        if col_type == 'float':
                            new_value = str(float(result))
                        else:
                            new_value = str(int(result))
                        
                        if self._validate_cell_value(new_value, col_type):
                            item.setText(new_value)
                            success_count += 1
                        else:
                            error_count += 1
                    else:
                        error_count += 1
                
                except Exception as e:
                    error_count += 1
            
            # Reconnect signal
            table.itemChanged.connect(lambda: self._set_modified())
            
            if success_count > 0:
                self._set_modified()
            
            message = f"Applied formula to {success_count} cell(s) in column '{col_name}'."
            if error_count > 0:
                message += f" {error_count} cell(s) had errors."
            self.statusBar().showMessage(message, 5000)
    
    def _validate_cell_value(self, value, col_type):
        """Validate a cell value based on its column type"""
        if not value or value == '""':
            return True  # Empty values are generally allowed
        
        try:
            if col_type == 'float':
                float(value)
                return True
            elif col_type in ['int', 'short', 'byte']:
                int(value)
                return True
            elif col_type == 'bool':
                return value in ['0', '1', 'True', 'False', 'true', 'false']
            elif 'string' in col_type or col_type == 'empty':
                return True
            return True
        except ValueError:
            return False

    # --- Search Functions ---
    
    def show_search_dialog(self):
        dialog = SearchDialog(self)
        if dialog.exec() == QDialog.DialogCode.Accepted:
            search_text = dialog.search_text.strip()
            if search_text:
                self.perform_search(search_text, dialog.case_sensitive, dialog.search_all_sheets)
    
    def perform_search(self, search_text, case_sensitive=False, search_all_sheets=True):
        self.search_results = []
        
        # Determine which sheets to search
        if search_all_sheets:
            sheet_indices = range(self.tab_widget.count())
        else:
            sheet_indices = [self.tab_widget.currentIndex()]
        
        # Search through sheets
        for sheet_idx in sheet_indices:
            table = self.tab_widget.widget(sheet_idx)
            if not table:
                continue
            
            for row in range(table.rowCount()):
                for col in range(table.columnCount()):
                    item = table.item(row, col)
                    if item:
                        cell_text = item.text()
                        compare_text = cell_text if case_sensitive else cell_text.lower()
                        search_compare = search_text if case_sensitive else search_text.lower()
                        
                        if search_compare in compare_text:
                            self.search_results.append((sheet_idx, row, col))
        
        # Update UI based on results
        if self.search_results:
            self.current_search_index = 0
            self.find_next_action.setEnabled(True)
            self.find_prev_action.setEnabled(True)
            self._highlight_search_result()
            self.statusBar().showMessage(f"Found {len(self.search_results)} result(s). Use F3/Shift+F3 to navigate.", 5000)
        else:
            self.current_search_index = -1
            self.find_next_action.setEnabled(False)
            self.find_prev_action.setEnabled(False)
            self.statusBar().showMessage("No results found.", 3000)
            QMessageBox.information(self, "Search", f"No matches found for '{search_text}'.")
    
    def find_next(self):
        if not self.search_results:
            return
        
        self.current_search_index = (self.current_search_index + 1) % len(self.search_results)
        self._highlight_search_result()
    
    def find_previous(self):
        if not self.search_results:
            return
        
        self.current_search_index = (self.current_search_index - 1) % len(self.search_results)
        self._highlight_search_result()
    
    def _highlight_search_result(self):
        if not self.search_results or self.current_search_index < 0:
            return
        
        sheet_idx, row, col = self.search_results[self.current_search_index]
        
        # Switch to the correct sheet
        self.tab_widget.setCurrentIndex(sheet_idx)
        
        # Get the table and select the cell
        table = self.tab_widget.widget(sheet_idx)
        if table:
            table.setCurrentCell(row, col)
            table.scrollToItem(table.item(row, col))
            
            # Update status bar
            self.statusBar().showMessage(
                f"Result {self.current_search_index + 1} of {len(self.search_results)} "
                f"(Sheet: {self.tab_widget.tabText(sheet_idx)}, Row: {row + 1}, Col: {col + 1})",
                3000
            )

    # --- Lógica de Salvamento/Repacking (sem alterações) ---
    
    def save_file(self):
        if not self.is_modified: return
        if not self.current_filepath: self.save_file_as()
        else:
            try:
                self._repack_mbe_file(self.current_filepath)
                self._set_modified(False)
                self.statusBar().showMessage(f"File saved with success in '{self.current_filepath}'.", 5000)
            except Exception as e:
                import traceback
                error_details = traceback.format_exc()
                QMessageBox.critical(self, "Error at Saving", f"Not possible to save file:\n{e}\n\nDetails:\n{error_details}")

    def save_file_as(self):
        filepath, _ = QFileDialog.getSaveFileName(self, "Save MBE as...", "", "MBE Files(*.mbe);;All Files (*)")
        if not filepath: return
        
        # Update filepath and force save
        self.current_filepath = filepath
        try:
            self._repack_mbe_file(self.current_filepath)
            self._set_modified(False)
            self._update_title()
            self.statusBar().showMessage(f"File saved with success in '{self.current_filepath}'.", 5000)
        except Exception as e:
            import traceback
            error_details = traceback.format_exc()
            QMessageBox.critical(self, "Error at Saving", f"Not possible to save file:\n{e}\n\nDetails:\n{error_details}")

    def export_current_sheet_to_csv(self):
        """Export the current sheet to a CSV file"""
        current_index = self.tab_widget.currentIndex()
        if current_index < 0:
            QMessageBox.warning(self, "No Sheet", "No sheet is currently selected.")
            return
        
        # Get the sheet name for default filename
        sheet_name = self.tab_widget.tabText(current_index)
        default_filename = f"{sheet_name}.csv"
        
        filepath, _ = QFileDialog.getSaveFileName(
            self, 
            "Export Sheet to CSV", 
            default_filename,
            "CSV Files (*.csv);;All Files (*)"
        )
        
        if not filepath:
            return
        
        try:
            table = self.tab_widget.widget(current_index)
            self._write_table_to_csv(table, filepath)
            self.statusBar().showMessage(f"Sheet '{sheet_name}' exported to '{os.path.basename(filepath)}'.", 5000)
        except Exception as e:
            import traceback
            error_details = traceback.format_exc()
            QMessageBox.critical(self, "Export Error", f"Could not export to CSV:\n{e}\n\nDetails:\n{error_details}")
    
    def export_all_sheets_to_csv(self):
        """Export all sheets to separate CSV files in a selected directory"""
        if self.tab_widget.count() == 0:
            QMessageBox.warning(self, "No Sheets", "There are no sheets to export.")
            return
        
        directory = QFileDialog.getExistingDirectory(
            self,
            "Select Directory to Export All Sheets"
        )
        
        if not directory:
            return
        
        try:
            exported_count = 0
            for i in range(self.tab_widget.count()):
                table = self.tab_widget.widget(i)
                sheet_name = self.tab_widget.tabText(i)
                
                # Clean the sheet name for use as filename
                safe_name = "".join(c if c.isalnum() or c in (' ', '_', '-') else '_' for c in sheet_name)
                filepath = os.path.join(directory, f"{safe_name}.csv")
                
                self._write_table_to_csv(table, filepath)
                exported_count += 1
            
            self.statusBar().showMessage(f"Exported {exported_count} sheet(s) to '{directory}'.", 5000)
            QMessageBox.information(self, "Export Complete", f"Successfully exported {exported_count} sheet(s) to:\n{directory}")
        except Exception as e:
            import traceback
            error_details = traceback.format_exc()
            QMessageBox.critical(self, "Export Error", f"Could not export sheets:\n{e}\n\nDetails:\n{error_details}")
    
    def _write_table_to_csv(self, table, filepath):
        """Write a table widget to a CSV file"""
        # Map internal types back to CSV type names
        type_mapping = {
            'byte': 'int8',
            'short': 'int16',
            'int': 'int32',
            'float': 'float',
            'string': 'string',
            'string2': 'string2',
            'string3': 'string3',
            'bool': 'bool',
            'empty': 'empty',
        }
        
        with open(filepath, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            
            # Write header row with type information
            headers = []
            for col in range(table.columnCount()):
                header_item = table.horizontalHeaderItem(col)
                if header_item:
                    # Extract type from header (e.g., "string2_0" -> "string2")
                    internal_type = header_item.text().split('_')[0]
                    csv_type = type_mapping.get(internal_type, internal_type)
                    headers.append(f"{csv_type} {col}")
                else:
                    headers.append(f"unknown {col}")
            
            writer.writerow(headers)
            
            # Write data rows
            for row in range(table.rowCount()):
                row_data = []
                for col in range(table.columnCount()):
                    item = table.item(row, col)
                    if item:
                        cell_text = item.text()
                        
                        # Get column type
                        header_item = table.horizontalHeaderItem(col)
                        if header_item:
                            col_type = header_item.text().split('_')[0]
                            
                            # Handle string types - CSV writer will add quotes as needed
                            if 'string' in col_type:
                                # If it's '""' (empty string marker), write empty string
                                if cell_text == '""':
                                    row_data.append('')
                                else:
                                    row_data.append(cell_text)
                            else:
                                row_data.append(cell_text)
                        else:
                            row_data.append(cell_text)
                    else:
                        row_data.append('')
                
                writer.writerow(row_data)
    
    def _repack_mbe_file(self, filepath):
        all_sheets = []
        for i in range(self.tab_widget.count()):
            table = self.tab_widget.widget(i)
            headers = [table.horizontalHeaderItem(j).text() for j in range(table.columnCount())]
            # Handle None items (empty cells or newly inserted rows)
            rows = []
            for r in range(table.rowCount()):
                row = []
                for c in range(table.columnCount()):
                    item = table.item(r, c)
                    cell_text = item.text() if item else ""
                    
                    # For string columns, empty cells should be stored as '""'
                    # Check if this column is a string type
                    col_type = headers[c].split('_')[0]
                    if 'string' in col_type and not cell_text:
                        cell_text = '""'
                    
                    row.append(cell_text)
                rows.append(row)
            
            all_sheets.append({
                'name': self.tab_widget.tabText(i),
                'columns': [COLUMN_INFO_BY_NAME[h.split('_')[0]] for h in headers],
                'rows': rows
            })

        chnk_strings = []
        with open(filepath, 'wb') as f:
            f.write(b'EXPA' + struct.pack('<i', len(all_sheets)))
            
            for sheet in all_sheets:
                # Align to 8-byte boundary
                self._write_alignment_padding(f, 8, b'\xcc')
                
                # Write table header
                name_size = (len(sheet['name']) + 4) & ~3  # Align to 4-byte boundary
                f.write(struct.pack('<i', name_size))
                name_bytes = sheet['name'].encode('utf-8') + b'\x00' * (name_size - len(sheet['name']))
                f.write(name_bytes)
                
                f.write(struct.pack('<i', len(sheet['columns'])))
                f.write(struct.pack(f'<{len(sheet["columns"])}i', *[c['code'] for c in sheet['columns']]))
                
                area_size = self._calculate_expa_area_size(sheet['columns'])
                f.write(struct.pack('<ii', area_size, len(sheet['rows'])))
                
                # Align header to 8-byte boundary
                header_size = 4 + name_size + 4 + 4 * len(sheet['columns']) + 8
                header_padding = (8 - (header_size % 8)) % 8
                f.write(b'\xcc' * header_padding)
                
                # Write rows
                for row_data in sheet['rows']:
                    # Align each row to 8-byte boundary
                    self._write_alignment_padding(f, 8, b'\xcc')
                    row_start_offset = f.tell()
                    
                    bit_offset = 0
                    bool_value = 0
                    
                    for c_idx, val_str in enumerate(row_data):
                        col = sheet['columns'][c_idx]
                        
                        if col['name'] == 'bool':
                            if bit_offset == 0:
                                # Align to 4-byte boundary for bool
                                self._write_alignment_padding(f, 4, b'\xcc')
                                bool_value = 0
                            
                            # Parse bool value - handle various formats
                            try:
                                bool_val = 1 if (val_str and str(val_str).strip() not in ['0', '', '""']) else 0
                            except:
                                bool_val = 0
                            
                            bool_value |= (bool_val << bit_offset)
                            bit_offset += 1
                            
                            if bit_offset >= 32:
                                # Ensure value is within valid range for signed 32-bit int
                                bool_value = bool_value & 0xFFFFFFFF
                                if bool_value > 0x7FFFFFFF:
                                    bool_value = bool_value - 0x100000000
                                f.write(struct.pack('<i', bool_value))
                                bit_offset = 0
                                bool_value = 0
                        elif col['name'] == 'empty':
                            # Empty type - no data written
                            pass
                        elif 'string' in col['name']:
                            # Align to 8-byte boundary for strings
                            self._write_alignment_padding(f, 8, b'\xcc')
                            # Only write non-empty strings (skip '""' which represents empty)
                            if val_str and val_str != '""':
                                chnk_strings.append((f.tell(), val_str))
                            f.write(b'\x00' * 8)
                        else:
                            # Handle other types with proper alignment
                            if col['name'] == 'short':
                                self._write_alignment_padding(f, 2, b'\xcc')
                            elif col['name'] in ['int', 'float']:
                                self._write_alignment_padding(f, 4, b'\xcc')
                            
                            value = 0
                            if val_str:
                                try:
                                    if col['name'] == 'float':
                                        value = float(val_str)
                                    else:
                                        value = int(val_str)
                                except (ValueError, TypeError):
                                    value = 0  # Default to 0 for invalid values
                            f.write(struct.pack(col['format'], value))
                    
                    # Write remaining bool bits
                    if bit_offset > 0:
                        # Ensure value is within valid range for signed 32-bit int
                        bool_value = bool_value & 0xFFFFFFFF
                        if bool_value > 0x7FFFFFFF:
                            bool_value = bool_value - 0x100000000
                        f.write(struct.pack('<i', bool_value))
                    
                    # Pad row to area_size
                    current_pos = f.tell()
                    row_padding = area_size - (current_pos - row_start_offset)
                    if row_padding > 0:
                        f.write(b'\xcc' * row_padding)
            
            # Align to 8-byte boundary before CHNK section
            self._write_alignment_padding(f, 8, b'\xcc')
            f.write(b'CHNK' + struct.pack('<i', len(chnk_strings)))
            
            for offset, text in chnk_strings:
                f.write(struct.pack('<i', offset))
                text_size = (len(text) + 4) & ~3  # Align to 4-byte boundary
                f.write(struct.pack('<i', text_size))
                text_bytes = text.encode('utf-8') + b'\x00' * (text_size - len(text))
                f.write(text_bytes)

    # --- Funções Auxiliares e de Eventos (sem alterações) ---

    def _read_padded_string_from_file(self, f, size):
        if size <= 0: return ""
        return f.read(size).decode('utf-8', errors='ignore').rstrip('\x00')

    def _write_padded_string_to_file(self, f, text):
        if not text: data = b'\x00\x00\x00\x00'
        else:
            encoded = text.encode('utf-8') + b'\x00\x00'
            data = encoded.ljust((len(encoded) + 3) & ~3, b'\x00')
        f.write(data)
        return len(data)

    def _skip_alignment_padding(self, f, alignment):
        pos = f.tell()
        pad = (alignment - (pos % alignment)) % alignment
        if pad > 0: f.read(pad)

    def _write_alignment_padding(self, f, alignment, pad_byte=b'\x00'):
        pos = f.tell()
        pad = (alignment - (pos % alignment)) % alignment
        if pad > 0: f.write(pad_byte * pad)

    def _align_buffer_position(self, buf, alignment, pad_byte=b'\x00'):
        pos = buf.tell()
        pad = (alignment - (pos % alignment)) % alignment
        if pad > 0: buf.write(pad_byte * pad)

    def _calculate_expa_area_size(self, columns):
        size = 0
        bit_offset = 0
        
        for col in columns:
            if col['name'] == 'bool':
                if bit_offset == 0:
                    size = (size + 3) & ~3  # Align to 4-byte boundary
                    size += 4
                bit_offset += 1
                if bit_offset >= 32:
                    bit_offset = 0
            elif col['name'] == 'empty':
                # Empty type takes no space
                pass
            elif 'string' in col['name']:
                size = (size + 7) & ~7  # Align to 8-byte boundary
                size += 8
            else:
                if col['name'] == 'short':
                    size = (size + 1) & ~1  # Align to 2-byte boundary
                elif col['name'] in ['int', 'float']:
                    size = (size + 3) & ~3  # Align to 4-byte boundary
                size += col['size']
        
        # Handle remaining bool bits
        if bit_offset > 0:
            size += 4
        
        # Align final size to 8-byte boundary
        return size

    def clear_all(self):
        self.tab_widget.clear()
        self.sheets_data = []
        self.current_filepath = None
        self.save_action.setEnabled(False)
        self.save_as_action.setEnabled(False)
        self.search_action.setEnabled(False)
        self.find_next_action.setEnabled(False)
        self.find_prev_action.setEnabled(False)
        self.add_csv_sheet_action.setEnabled(False)
        self.export_csv_action.setEnabled(False)
        self.export_all_csv_action.setEnabled(False)
        self._set_modified(False)

    def check_unsaved_changes(self):
        if not self.is_modified: return True
        reply = QMessageBox.question(self, "Modifications unsaved",
            "You have unsaved changes. Do you want to save them before continuing?",
            QMessageBox.StandardButton.Save | QMessageBox.StandardButton.Discard | QMessageBox.StandardButton.Cancel)

        if reply == QMessageBox.StandardButton.Save:
            self.save_file()
            return not self.is_modified
        elif reply == QMessageBox.StandardButton.Cancel:
            return False
        return True

    def closeEvent(self, event):
        if self.check_unsaved_changes():
            event.accept()
        else:
            event.ignore()


class FormulaDialog(QDialog):
    def __init__(self, parent=None, table=None, col_index=0):
        super().__init__(parent)
        self.setWindowTitle("Apply Formula")
        self.setModal(True)
        self.resize(500, 300)
        
        col_name = table.horizontalHeaderItem(col_index).text() if table else "column"
        col_type = col_name.split('_')[0]
        
        layout = QVBoxLayout()
        
        # Info label
        info_label = QLabel(
            f"Apply formula to column '{col_name}' (type: {col_type})\n\n"
            f"Use 'x' to represent the current cell value.\n"
            f"Formulas are applied to each row individually."
        )
        info_label.setWordWrap(True)
        layout.addWidget(info_label)
        
        # Formula input
        formula_layout = QHBoxLayout()
        formula_layout.addWidget(QLabel("Formula:"))
        self.formula_input = QLineEdit()
        self.formula_input.setPlaceholderText("e.g., x * 2, x + 10, round(x, 2)")
        self.formula_input.returnPressed.connect(self.accept)
        formula_layout.addWidget(self.formula_input)
        layout.addLayout(formula_layout)
        
        # Examples section
        examples_label = QLabel("<b>Examples:</b>")
        layout.addWidget(examples_label)
        
        examples_text = QLabel(
            "• x * 2         (multiply by 2)\n"
            "• x + 10        (add 10)\n"
            "• x / 100       (divide by 100)\n"
            "• x * 1.5 + 5   (multiply by 1.5 then add 5)\n"
            "• round(x, 2)   (round to 2 decimals)\n"
            "• abs(x)        (absolute value)\n"
            "• max(x, 0)     (set minimum to 0)\n"
            "• min(x, 100)   (set maximum to 100)\n"
            "• int(x * 10)   (multiply by 10 and convert to int)"
        )
        examples_text.setStyleSheet("color: gray; font-family: monospace;")
        layout.addWidget(examples_text)
        
        # Buttons
        button_layout = QHBoxLayout()
        button_layout.addStretch()
        
        apply_button = QPushButton("Apply")
        apply_button.setDefault(True)
        apply_button.clicked.connect(self.accept)
        button_layout.addWidget(apply_button)
        
        cancel_button = QPushButton("Cancel")
        cancel_button.clicked.connect(self.reject)
        button_layout.addWidget(cancel_button)
        
        layout.addLayout(button_layout)
        self.setLayout(layout)
        
        self.formula_input.setFocus()


class SearchDialog(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("Find")
        self.setModal(True)
        self.resize(400, 150)
        
        # Properties to store user choices
        self.search_text = ""
        self.case_sensitive = False
        self.search_all_sheets = True
        
        # Layout
        layout = QVBoxLayout()
        
        # Search text input
        search_layout = QHBoxLayout()
        search_layout.addWidget(QLabel("Find:"))
        self.search_input = QLineEdit()
        self.search_input.returnPressed.connect(self.accept)
        search_layout.addWidget(self.search_input)
        layout.addLayout(search_layout)
        
        # Options
        self.case_checkbox = QCheckBox("Case sensitive")
        layout.addWidget(self.case_checkbox)
        
        self.all_sheets_checkbox = QCheckBox("Search all sheets")
        self.all_sheets_checkbox.setChecked(True)
        layout.addWidget(self.all_sheets_checkbox)
        
        # Buttons
        button_layout = QHBoxLayout()
        button_layout.addStretch()
        
        find_button = QPushButton("Find")
        find_button.setDefault(True)
        find_button.clicked.connect(self.accept)
        button_layout.addWidget(find_button)
        
        cancel_button = QPushButton("Cancel")
        cancel_button.clicked.connect(self.reject)
        button_layout.addWidget(cancel_button)
        
        layout.addLayout(button_layout)
        self.setLayout(layout)
        
        # Focus on search input
        self.search_input.setFocus()
    
    def accept(self):
        self.search_text = self.search_input.text()
        self.case_sensitive = self.case_checkbox.isChecked()
        self.search_all_sheets = self.all_sheets_checkbox.isChecked()
        super().accept()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    editor = MBEEditor()
    editor.show()
    sys.exit(app.exec())