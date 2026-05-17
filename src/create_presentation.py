from fpdf import FPDF
import os

class SentinelPDF(FPDF):
    DEEP_SPACE_BLUE = (10, 25, 45)
    MATRIX_GREEN = (0, 255, 100)

    def set_theme_colors(self):
        self.set_fill_color(*self.DEEP_SPACE_BLUE)
        self.set_text_color(*self.MATRIX_GREEN)

    def header(self):
        # Header implementation if needed, currently leaving empty for clean slides
        pass

    def add_slide(self, title):
        self.add_page()
        self.set_fill_color(*self.DEEP_SPACE_BLUE)
        self.rect(0, 0, 210, 297, 'F')
        self.set_text_color(*self.MATRIX_GREEN)
        self.set_font('helvetica', 'B', 24)
        self.cell(0, 20, title, ln=True, align='C')
        self.ln(10)

    def create_table(self, data):
        self.set_font('helvetica', '', 12)
        self.set_draw_color(*self.MATRIX_GREEN)
        for row in data:
            for item in row:
                self.cell(90, 10, item, border=1, align='C')
            self.ln()

def create_presentation():
    pdf = SentinelPDF()
    pdf.set_auto_page_break(auto=False) # Disable auto-break for custom layout

    # Slide 1: Autonomous Vision
    pdf.add_slide('The Future of Mobile Security is Autonomous')
    pdf.set_font('helvetica', '', 16)
    pdf.multi_cell(0, 10, "\n\nSelbstheilende Systeme fuer mobile Endgeraete.\n\nKein menschlicher Eingriff notwendig.\nSentinelBridge agiert im Hintergrund.", align='C')

    # Slide 2: Traditional Broken
    pdf.add_slide('Traditional Termux is Broken')
    table_data = [["Metrik", "Vergleich"], ["Herkömmlich", "45 Minuten (Timeout)"], ["Sentinel-Bridge", "45 Sekunden (Echtzeit)"]]
    pdf.create_table(table_data)

    # Slide 3: Bridge Components
    pdf.add_slide('Real-Time Sentinel Bridge')
    pdf.set_font('helvetica', '', 14)
    pdf.multi_cell(0, 10, "[ICON: NPU - Optimized Offloading]\n[ICON: GPU - Adreno Boost]\n[ICON: Cloud - Hybrid Safe-Sync]", align='C')

    # Slide 4: Roadmap v2.0
    pdf.add_slide('The Path to v2.0')
    pdf.set_font('helvetica', '', 12)
    roadmap = [["Phase", "Status"], ["v1.x", "Operational"], ["v2.0", "Predictive Autonomy"]]
    pdf.create_table(roadmap)

    output_path = "/sdcard/Download/Sentinel_Showcase_v1_7.pdf"
    pdf.output(output_path)
    print(f"\n[Erfolg!] Präsentation erstellt: {output_path}")

if __name__ == "__main__":
    create_presentation()
