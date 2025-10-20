import sys
import os
import struct
from io import BytesIO

from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QTableWidget, QTabWidget, QFileDialog, 
    QTableWidgetItem, QMenuBar, QMessageBox, QStatusBar, QMenu
)
from PyQt6.QtGui import QAction, QKeySequence
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
        self._setup_ui()
        self._update_title()

    def _setup_ui(self):
        self.tab_widget = QTabWidget()
        self.setCentralWidget(self.tab_widget)
        self.setStatusBar(QStatusBar(self))
        menu_bar = self.menuBar()
        file_menu = menu_bar.addMenu("&File")
        
        open_action = QAction("&Open...", self)
        open_action.setShortcut(QKeySequence.StandardKey.Open)
        open_action.triggered.connect(self.open_file)
        file_menu.addAction(open_action)
        
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
        
        exit_action = QAction("Q&uit", self)
        exit_action.triggered.connect(self.close)
        file_menu.addAction(exit_action)

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
                    table.setItem(r, c, QTableWidgetItem(str(cell_value)))
            
            table.setContextMenuPolicy(Qt.ContextMenuPolicy.CustomContextMenu)
            table.customContextMenuRequested.connect(self._show_table_context_menu)
            
            # **** CORREÇÃO APLICADA AQUI ****
            # Usamos uma lambda para chamar _set_modified sem passar o argumento do sinal.
            table.itemChanged.connect(lambda: self._set_modified())
            
            table.resizeColumnsToContents()
            self.tab_widget.addTab(table, sheet_data['name'])

    # --- Lógica do Menu de Contexto ---

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


if __name__ == "__main__":
    app = QApplication(sys.argv)
    editor = MBEEditor()
    editor.show()
    sys.exit(app.exec())