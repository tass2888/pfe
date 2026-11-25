# -*- coding: utf-8 -*-
"""Build the PFE presentation PPTX, inspired by the 15-slide Stitch demo."""
import csv
import os
from pathlib import Path

from PIL import Image
from pptx import Presentation
from pptx.dml.color import RGBColor
from pptx.enum.shapes import MSO_SHAPE
from pptx.enum.text import MSO_ANCHOR, PP_ALIGN
from pptx.util import Inches, Pt

ROOT = Path(r"C:\Users\LENOVO\Documents\PFE\PFE_Neurodynamique")
FIG = ROOT / "08_Figures_Tables"
OUT_DIR = ROOT / "09_Presentation"
OUT = OUT_DIR / "Presentation_PFE_Neurodynamique.pptx"

NAVY = RGBColor(11, 31, 51)
TEAL = RGBColor(14, 124, 134)
AMBER = RGBColor(232, 163, 61)
LIGHT = RGBColor(242, 245, 247)
GREY = RGBColor(92, 106, 118)
DARK = RGBColor(27, 42, 58)
WHITE = RGBColor(255, 255, 255)
MIDS = RGBColor(207, 218, 225)

W, H = 13.333, 7.5
N_SLIDES = 15

# ---- credits from the repo attribution CSV ---------------------------------
CREDITS = {}
csv_path = FIG / "00_INDEX" / "Images_open_access_attributions.csv"
if csv_path.exists():
    with open(csv_path, encoding="utf-8-sig", newline="") as fh:
        for row in csv.DictReader(fh):
            CREDITS[row["Fichier"]] = (
                f"{row['Titre_Commons']} — {row['Auteur'] or 'auteur non renseigne'} "
                f"— {row['Licence']} — {row['URL_source']}"
            )

prs = Presentation()
prs.slide_width = Inches(W)
prs.slide_height = Inches(H)
BLANK = prs.slide_layouts[6]


# ---- helpers ---------------------------------------------------------------
def new_slide():
    return prs.slides.add_slide(BLANK)


def rect(slide, x, y, w, h, fill, line=None, rounded=False):
    shp = slide.shapes.add_shape(
        MSO_SHAPE.ROUNDED_RECTANGLE if rounded else MSO_SHAPE.RECTANGLE,
        Inches(x), Inches(y), Inches(w), Inches(h),
    )
    shp.fill.solid()
    shp.fill.fore_color.rgb = fill
    if line is None:
        shp.line.fill.background()
    else:
        shp.line.color.rgb = line
        shp.line.width = Pt(0.8)
    return shp


def textbox(slide, x, y, w, h, text, size=13, color=DARK, bold=False,
            align=PP_ALIGN.LEFT, font="Calibri", space=4, italic=False):
    tb = slide.shapes.add_textbox(Inches(x), Inches(y), Inches(w), Inches(h))
    tf = tb.text_frame
    tf.word_wrap = True
    tf.margin_left = Inches(0.03)
    tf.margin_right = Inches(0.03)
    tf.margin_top = Inches(0.02)
    tf.margin_bottom = Inches(0.02)
    for i, line in enumerate(text.split("\n")):
        p = tf.paragraphs[0] if i == 0 else tf.add_paragraph()
        p.text = line
        p.alignment = align
        p.space_after = Pt(space)
        for r in p.runs:
            r.font.name = font
            r.font.size = Pt(size)
            r.font.bold = bold
            r.font.italic = italic
            r.font.color.rgb = color
    return tb


def base(slide, num, title, subtitle=""):
    rect(slide, 0, 0, W, 0.11, TEAL)
    textbox(slide, 0.55, 0.25, 8.5, 0.28,
            "PFE · KINÉSITHÉRAPIE & NEURORÉÉDUCATION · UPSAT TUNISIE",
            size=9, color=GREY, bold=True)
    textbox(slide, 10.7, 0.25, 2.05, 0.28, f"SLIDE {num:02d} / {N_SLIDES}",
            size=9, color=GREY, bold=True, align=PP_ALIGN.RIGHT)
    textbox(slide, 0.55, 0.62, 12.2, 0.58, title, size=27, color=NAVY, bold=True)
    if subtitle:
        textbox(slide, 0.57, 1.22, 12.0, 0.42, subtitle, size=13, color=GREY)
    rect(slide, 0.55, 7.03, 12.23, 0.012, MIDS)
    textbox(slide, 0.55, 7.09, 10.5, 0.24,
            "Neurodynamique et cervicalgie · Butler & Shacklock · Mémoire PFE 2025–2026",
            size=8, color=GREY)
    textbox(slide, 11.9, 7.09, 0.9, 0.24, f"{num:02d}", size=8, color=GREY,
            align=PP_ALIGN.RIGHT)


def card(slide, x, y, w, h, title, body, accent=TEAL, title_size=12.5, body_size=10.5):
    rect(slide, x, y, w, h, LIGHT, rounded=True)
    rect(slide, x, y, 0.07, h, accent)
    textbox(slide, x + 0.20, y + 0.14, w - 0.35, 0.32, title,
            size=title_size, color=NAVY, bold=True)
    textbox(slide, x + 0.20, y + 0.52, w - 0.38, h - 0.62, body,
            size=body_size, color=DARK, space=3)


def image_contain(slide, rel, x, y, w, h, caption=None, credit_key=None):
    p = FIG / rel
    if not p.exists():
        return
    iw, ih = Image.open(p).size
    scale = min(w / iw, h / ih)
    nw, nh = iw * scale, ih * scale
    px, py = x + (w - nw) / 2, y + (h - nh) / 2
    slide.shapes.add_picture(str(p), Inches(px), Inches(py),
                             width=Inches(nw), height=Inches(nh))
    if caption:
        textbox(slide, x, y + h + 0.03, w, 0.24, caption,
                size=8.5, color=GREY, italic=True)
    if credit_key and credit_key in CREDITS:
        add_notes(slide, "Image : " + CREDITS[credit_key])


def add_notes(slide, text):
    try:
        slide.notes_slide.notes_text_frame.text = text
    except Exception:
        pass


def bullet_list(slide, x, y, w, items, size=12, color=DARK, gap=0.44):
    for i, item in enumerate(items):
        rect(slide, x, y + i * gap + 0.10, 0.09, 0.09, TEAL, rounded=True)
        textbox(slide, x + 0.22, y + i * gap, w - 0.22, gap, item,
                size=size, color=color)


# ============================================================================
# 01 — Couverture
# ============================================================================
s = new_slide()
rect(s, 0, 0, W, H, NAVY)
rect(s, 0, 0, 0.16, H, TEAL)
rect(s, 0.55, 0.55, 2.9, 0.06, AMBER)
textbox(s, 0.55, 0.78, 7.4, 0.35, "SOUTENANCE · PROJET DE FIN D'ÉTUDES",
        size=12, color=AMBER, bold=True)
textbox(s, 0.55, 1.35, 7.3, 1.5, "Neurodynamique\net cervicalgie",
        size=42, color=WHITE, bold=True, space=2)
textbox(s, 0.57, 3.05, 7.0, 1.35,
        "Place de la mobilisation neurodynamique selon Butler et Shacklock "
        "dans la prise en charge kinésithérapique de la cervicalgie avec "
        "composante neurodynamique",
        size=15, color=MIDS, space=4)
rect(s, 0.55, 4.65, 6.7, 0.02, TEAL)
textbox(s, 0.55, 4.85, 7.0, 0.9,
        "Étude contrôlée randomisée · deux groupes parallèles\n"
        "Présenté par [Nom et prénom] · sous la direction de [Directeur de mémoire]",
        size=12, color=WHITE, space=6)
textbox(s, 0.55, 6.35, 7.0, 0.5, "UPSAT — Tunisie · Année universitaire 2025–2026",
        size=10.5, color=MIDS)
image_contain(s, "Ch1_Cervicalgie/Fig_1.1_Anatomie_rachis_cervical.png",
              8.35, 1.25, 4.35, 4.9,
              "Fig. 01 — Rachis cervical (C1–C7)", "Fig_1.1_Anatomie_rachis_cervical.png")
textbox(s, 8.35, 6.45, 4.35, 0.3, "01 / 15", size=10, color=MIDS, align=PP_ALIGN.RIGHT)
add_notes(s, "Diaporama de soutenance — 15 diapositives, structure inspiree du demo Stitch. "
             "Toutes les donnees de resultats restent a saisir apres l'etude.")

# ============================================================================
# 02 — Contexte scientifique
# ============================================================================
s = new_slide()
base(s, 2, "Contexte scientifique", "La cervicalgie : un enjeu clinique, fonctionnel et de santé publique")
card(s, 0.55, 1.85, 3.85, 1.55, "01 · Motif fréquent",
     "Consultation courante en kinésithérapie ; intrication des composantes articulaire, musculaire et neurale.")
card(s, 4.62, 1.85, 3.85, 1.55, "02 · Composante neurale",
     "Une part des tableaux associe une mécanosensibilité nerveuse à identifier par l'examen clinique.", AMBER)
card(s, 8.69, 1.85, 4.05, 1.55, "03 · Retentissement",
     "Limitation des activités, risque de chronicisation et répercussions professionnelles.")
textbox(s, 0.55, 3.72, 7.6, 0.35, "Ce que la littérature impose de prendre en compte",
        size=14, color=NAVY, bold=True)
bullet_list(s, 0.55, 4.15, 7.4, [
    "Le rachis cervical, les racines C1–C8 et le plexus brachial forment un continuum mécanique.",
    "Une approche uniquement musculo-articulaire néglige l'interface mécanique du tissu nerveux.",
    "La distinction cervicalgie commune / cervicalgie avec composante neurodynamique conditionne l'inclusion.",
], size=12)
image_contain(s, "Ch1_Cervicalgie/Fig_1.3_Radiculopathie_cervicale.png",
              8.55, 3.72, 4.15, 2.65, "Fig. 02 — Radiculopathie cervicale (soutien)",
              "Fig_1.3_Radiculopathie_cervicale.png")
textbox(s, 0.55, 6.35, 7.6, 0.35,
        "Prévalence et proportion de composante neurale : valeurs à renseigner selon les références retenues.",
        size=10, color=GREY, italic=True)

# ============================================================================
# 03 — Problématique
# ============================================================================
s = new_slide()
base(s, 3, "Problématique de recherche", "Question centrale et justification")
rect(s, 0.55, 1.85, 12.2, 1.45, NAVY, rounded=True)
rect(s, 0.55, 1.85, 0.08, 1.45, AMBER)
textbox(s, 0.85, 2.02, 11.5, 0.3, "QUESTION DE RECHERCHE", size=10, color=AMBER, bold=True)
textbox(s, 0.85, 2.38, 11.5, 0.85,
        "Dans quelle mesure l'intégration de la mobilisation neurodynamique, selon les concepts "
        "de Butler et Shacklock, dans un programme de rééducation conventionnelle contribue-t-elle "
        "à l'amélioration de la douleur, de la mobilité cervicale et du handicap fonctionnel chez "
        "des patients présentant une cervicalgie avec composante neurodynamique ?",
        size=13.5, color=WHITE)
card(s, 0.55, 3.62, 3.85, 2.35, "CONSTAT 01 · Continuum",
     "Les contraintes cervicales modifient la mise en tension, le glissement et l'excursion des racines nerveuses et du plexus brachial.")
card(s, 4.62, 3.62, 3.85, 2.35, "CONSTAT 02 · Pratiques",
     "Hétérogénéité des protocoles : glisseurs (sliders) et tenseurs (tensioners) sont appliqués selon des logiques différentes.", AMBER)
card(s, 8.69, 3.62, 4.05, 2.35, "CONSTAT 03 · Validation",
     "Besoin d'évaluer la valeur ajoutée d'un protocole structuré dans une population clairement définie.")
textbox(s, 0.55, 6.25, 12.1, 0.45,
        "Population cible : cervicalgie avec composante neurodynamique / cervico-brachialgie — "
        "non extrapolation aux cervicalgies non spécifiques.",
        size=11, color=TEAL, bold=True)

# ============================================================================
# 04 — Hypothèses
# ============================================================================
s = new_slide()
base(s, 4, "Hypothèses de recherche", "Formulation statistique et clinique")
card(s, 0.55, 1.85, 5.95, 3.35, "H0 · Hypothèse nulle",
     "L'ajout de mobilisations neurodynamiques à la rééducation conventionnelle n'entraîne aucune "
     "différence significative sur les critères évalués.\n\n"
     "• Douleur (EVA) : évolution comparable entre groupes.\n"
     "• Mobilité cervicale et NDI : gain supérieur non démontré.\n\n"
     "Seuil : α = 0,05", accent=GREY, body_size=11.5)
card(s, 6.78, 1.85, 5.95, 3.35, "H1 · Hypothèse alternative",
     "L'intégration d'un protocole neurodynamique ciblé améliore significativement douleur, "
     "amplitudes cervicales et incapacité fonctionnelle.\n\n"
     "• Effet antalgique : baisse de l'EVA et de la mécanosensibilité.\n"
     "• Effet mécanique : excursion nerveuse et cinématique cervicale améliorées.\n\n"
     "Critère principal : EVA (douleur)", accent=TEAL, body_size=11.5)
rect(s, 0.55, 5.55, 12.18, 0.95, LIGHT, rounded=True)
textbox(s, 0.8, 5.72, 11.7, 0.6,
        "Critères secondaires : NDI (version française validée), inclinométrie cervicale, "
        "tests ULNT, examen neurologique · GPE / PSFS optionnels.",
        size=12, color=DARK)

# ============================================================================
# 05 — Objectifs
# ============================================================================
s = new_slide()
base(s, 5, "Objectifs de l'étude", "Critères cliniques et fonctionnels")
rect(s, 0.55, 1.85, 12.2, 1.0, NAVY, rounded=True)
textbox(s, 0.85, 2.0, 11.6, 0.3, "OBJECTIF PRINCIPAL", size=10, color=AMBER, bold=True)
textbox(s, 0.85, 2.33, 11.6, 0.45,
        "Évaluer l'efficacité de l'ajout d'un protocole de mobilisation neurodynamique à la "
        "rééducation conventionnelle (10 séances, T0 → T1 → T2).", size=13, color=WHITE)
card(s, 0.55, 3.18, 5.95, 1.42, "01 · Douleur",
     "Quantifier l'évolution de la douleur cervicale et irradiée par EVA / EN.")
card(s, 6.78, 3.18, 5.95, 1.42, "02 · Mobilité et mécanosensibilité",
     "Mesurer les amplitudes cervicales (inclinomètre) et la réponse aux ULNT.", AMBER)
card(s, 0.55, 4.88, 5.95, 1.42, "03 · Fonction",
     "Évaluer l'incapacité perçue avec l'Indice de Dysfonctionnement Cervical (NDI).")
card(s, 6.78, 4.88, 5.95, 1.42, "04 · Standardisation",
     "Proposer une progression structurée glisseur → tenseur selon l'irritabilité.", AMBER)
textbox(s, 0.55, 6.55, 12.1, 0.3,
        "Le NDI doit être utilisé dans sa version française validée (aucune traduction artisanale).",
        size=10, color=GREY, italic=True)

# ============================================================================
# 06 — Cadre théorique
# ============================================================================
s = new_slide()
base(s, 6, "Cadre théorique", "Partie I · Fondements anatomiques et cliniques")
image_contain(s, "Ch1_Cervicalgie/Fig_1.2_Racines_plexus_brachial.png",
              8.35, 1.85, 4.35, 3.5, "Fig. 03 — Racines et plexus brachial",
              "Fig_1.2_Racines_plexus_brachial.png")
card(s, 0.55, 1.85, 7.5, 1.25, "Ch1 · Cervicalgie",
     "Anatomie fonctionnelle C1–C7, disques, facettes, foramens et origine des symptômes cervicaux.")
card(s, 0.55, 3.28, 7.5, 1.25, "Ch2 · Neurophysiologie",
     "Continuum neural, structure du nerf périphérique, mécanosensibilité et microcirculation.", AMBER)
card(s, 0.55, 4.71, 7.5, 1.25, "Ch3 · Butler & Shacklock",
     "Modèles de tension neurale et de neurodynamique clinique ; glisseurs, tenseurs et interface mécanique.")
textbox(s, 0.55, 6.25, 7.6, 0.5,
        "Ch4 · Application clinique : examen neurodynamique, différenciation structurelle et décision thérapeutique.",
        size=11.5, color=TEAL, bold=True)

# ============================================================================
# 07 — Neurophysiologie
# ============================================================================
s = new_slide()
base(s, 7, "Neurophysiologie & biomécanique neurale", "Le système nerveux comme continuum mécanique et physiologique")
image_contain(s, "Ch2_Neurophysiologie/Fig_2.1_Structure_nerf_peripherique.jpg",
              0.55, 3.55, 3.7, 2.55, "Fig. 04a — Coupe d'un nerf périphérique",
              "Fig_2.1_Structure_nerf_peripherique.jpg")
image_contain(s, "Ch2_Neurophysiologie/Fig_2.2_Physiologie_nerveuse.png",
              4.45, 3.55, 3.7, 2.55, "Fig. 04b — Conduction et myéline",
              "Fig_2.2_Physiologie_nerveuse.png")
card(s, 8.35, 1.85, 4.35, 1.35, "Glissement & excursion",
     "Déplacement longitudinal et transversal du tronc nerveux par rapport à son interface, sans tension excessive.")
card(s, 8.35, 3.35, 4.35, 1.35, "Mécanosensibilité",
     "Réponse nociceptive accrue du tissu nerveux à la compression, l'étirement ou l'ischémie locale.", AMBER)
card(s, 8.35, 4.85, 4.35, 1.35, "Microcirculation & flux axoplasmique",
     "Les mobilisations douces favorisent le drainage intraneural et l'oxygénation des fibres.")
textbox(s, 0.55, 1.95, 7.4, 1.2,
        "Le rachis cervical et le membre supérieur imposent au tissu nerveux des contraintes "
        "de mouvement permanentes : c'est le socle biomécanique de la mobilisation neurodynamique.",
        size=13, color=DARK)

# ============================================================================
# 08 — Butler vs Shacklock
# ============================================================================
s = new_slide()
base(s, 8, "Butler vs Shacklock", "Analyse conceptuelle des modèles neurodynamiques")
card(s, 0.55, 1.85, 5.95, 3.05, "David S. Butler · Tension neurale",
     "• Concept initial : « adverse neural tension » puis mobilisation du système nerveux.\n"
     "• Logique biomécanique : mise en tension séquentielle pour tester et traiter la mobilité du nerf.\n"
     "• Intégration neurobiologique : douleur neurogène, sensibilisation centrale et perception.",
     accent=NAVY, body_size=11.5)
card(s, 6.78, 1.85, 5.95, 3.05, "Michael Shacklock · Neurodynamique clinique",
     "• Concept clé : interaction entre interface mécanique, structures neurales et tissus innervés.\n"
     "• Distinction technique systématique : sliders (glissement) / tensioners (mise en tension).\n"
     "• Dosage clinique adapté à l'irritabilité et au mécanisme pathomécanique.",
     accent=TEAL, body_size=11.5)
rect(s, 0.55, 5.22, 12.18, 1.35, LIGHT, rounded=True)
textbox(s, 0.8, 5.36, 5.6, 0.3, "SLIDER · GLISSEUR", size=11, color=TEAL, bold=True)
textbox(s, 0.8, 5.72, 5.6, 0.7,
        "Un pôle se met en tension pendant que l'autre se relâche : excursion maximale, contrainte faible.",
        size=11, color=DARK)
textbox(s, 6.85, 5.36, 5.6, 0.3, "TENSIONER · TENSEUR", size=11, color=AMBER, bold=True)
textbox(s, 6.85, 5.72, 5.6, 0.7,
        "Les deux extrémités s'allongent simultanément : contrainte accrue, à introduire progressivement.",
        size=11, color=DARK)

# ============================================================================
# 09 — Application clinique
# ============================================================================
s = new_slide()
base(s, 9, "Application clinique", "De l'examen neurodynamique à la décision thérapeutique")
card(s, 0.55, 1.85, 6.35, 1.45, "01 · Tests ULNT du membre supérieur",
     "Évaluation sélective du médian (ULNT1), du radial (ULNT2) et de l'ulnaire (ULNT3) avec reproduction des symptômes.")
card(s, 0.55, 3.48, 6.35, 1.45, "02 · Différenciation structurelle",
     "Modification des symptômes par un mouvement à distance : inclinaison cervicale controlatérale vs homolatérale.", AMBER)
card(s, 0.55, 5.11, 6.35, 1.45, "03 · Traitement selon irritabilité",
     "Ouverture de l'interface et glissements indolores en phase irritable ; mise en tension progressive ensuite.")
image_contain(s, "Ch3_Butler_Shacklock/Fig_3.3_ULNT1_median.jpg",
              7.25, 1.85, 2.45, 2.05, "Fig. 05a — Nerf médian",
              "Fig_3.3_ULNT1_median.jpg")
image_contain(s, "Ch4_Application_clinique/Fig_4.1_Examen_clinique.jpg",
              9.95, 1.85, 2.75, 2.05, "Fig. 05b — Examen clinique",
              "Fig_4.1_Examen_clinique.jpg")
rect(s, 7.25, 4.35, 5.45, 2.15, NAVY, rounded=True)
textbox(s, 7.5, 4.52, 4.95, 0.3, "RÈGLE D'INTERPRÉTATION", size=10, color=AMBER, bold=True)
textbox(s, 7.5, 4.88, 4.95, 1.4,
        "Un test neurodynamique positif n'est pas un diagnostic : il s'intègre à un faisceau "
        "d'arguments (Spurling, distraction, rotation limitée, examen neurologique, imagerie si nécessaire).",
        size=11.5, color=WHITE)

# ============================================================================
# 10 — Matériel et méthodes
# ============================================================================
s = new_slide()
base(s, 10, "Matériel et méthodes", "Schéma d'étude, population, critères et déroulement")
card(s, 0.55, 1.82, 5.9, 1.15, "Design",
     "ECR en deux groupes parallèles · évaluateur aveugle · T0 / T1 / T2.")
card(s, 6.7, 1.82, 6.03, 1.15, "Population",
     "Cervicalgie avec composante neurodynamique · adulte · n = 40 (pragmatique) à 50 (idéal).", AMBER)
textbox(s, 0.55, 3.18, 6.2, 0.3, "DEUX GROUPES PARALLÈLES", size=12, color=NAVY, bold=True)
rect(s, 0.55, 3.55, 3.0, 0.95, LIGHT, rounded=True)
textbox(s, 0.72, 3.68, 2.7, 0.7, "Groupe contrôle\nKinésithérapie conventionnelle", size=11, color=DARK)
rect(s, 3.72, 3.55, 3.0, 0.95, LIGHT, rounded=True)
rect(s, 3.72, 3.55, 0.07, 0.95, TEAL)
textbox(s, 3.9, 3.68, 2.7, 0.7, "Groupe expérimental\nConventionnelle + neurodynamique", size=11, color=DARK)
textbox(s, 0.55, 4.72, 6.2, 0.3, "CRITÈRES DE JUGEMENT", size=12, color=NAVY, bold=True)
bullet_list(s, 0.55, 5.08, 6.2, [
    "Principal : douleur (EVA).",
    "Secondaires : NDI, inclinométrie cervicale, ULNT, examen neurologique.",
    "Optionnels : GPE, PSFS.",
], size=11, gap=0.42)
image_contain(s, "Ch5_Materiel_methodes/Fig_5.1_Design_etude.png",
              7.1, 3.18, 5.6, 1.65, "Fig. 06 — Flux CONSORT à deux groupes",
              "Fig_5.1_Design_etude.png")
image_contain(s, "Ch5_Materiel_methodes/Fig_5.3_Evaluation_douleur_EVA.png",
              7.1, 5.15, 5.6, 1.2, "Fig. 06b — Échelle visuelle analogique",
              "Fig_5.3_Evaluation_douleur_EVA.png")

# ============================================================================
# 11 — Protocole de rééducation
# ============================================================================
s = new_slide()
base(s, 11, "Protocole de rééducation", "10 séances · 2 par semaine · 45 min · sur 5 semaines")
# timeline
for i in range(10):
    x = 0.62 + i * 1.23
    fill = TEAL if i < 3 else (AMBER if i < 7 else NAVY)
    rect(s, x, 1.92, 1.05, 0.55, fill, rounded=True)
    textbox(s, x, 2.02, 1.05, 0.3, f"S{i+1}", size=12, color=WHITE,
            bold=True, align=PP_ALIGN.CENTER)
textbox(s, 0.62, 2.58, 3.6, 0.3, "Phase 1 · S1–S3 · Antalgie & interface",
        size=10.5, color=TEAL, bold=True)
textbox(s, 4.31, 2.58, 4.9, 0.3, "Phase 2 · S4–S7 · Glisseurs (sliders)",
        size=10.5, color=AMBER, bold=True)
textbox(s, 9.26, 2.58, 3.4, 0.3, "Phase 3 · S8–S10 · Tenseurs",
        size=10.5, color=NAVY, bold=True)
card(s, 0.55, 3.15, 3.85, 2.1, "S1–S3 · Ouverture",
     "Détente myofasciale, mobilisations articulaires douces et positionnement d'ouverture foraminale, sans tension neurale.")
card(s, 4.62, 3.15, 3.85, 2.1, "S4–S7 · Glissement",
     "Glissements neuralux cervico-brachiaux (médian, ulnaire, radial) en amplitude indolore et renforcement des fléchisseurs profonds.", AMBER)
card(s, 8.69, 3.15, 4.05, 2.1, "S8–S10 · Tension & autonomie",
     "Introduction progressive des tenseurs selon tolérance, réentraînement postural et auto-exercices à domicile.")
image_contain(s, "Ch4_Application_clinique/Fig_4.2_Glissement_lateral_cervical.jpg",
              0.55, 5.5, 3.6, 1.15, "Fig. 07 — Mouvements cervicaux (soutien)",
              "Fig_4.2_Glissement_lateral_cervical.jpg")
rect(s, 4.4, 5.5, 8.33, 1.15, NAVY, rounded=True)
textbox(s, 4.65, 5.65, 7.85, 0.85,
        "La progression dépend de l'irritabilité et de la réponse symptomatique, "
        "pas du seul numéro de séance. Réévaluation à chaque séance.",
        size=12, color=WHITE)

# ============================================================================
# 12 — Résultats (sans données inventées)
# ============================================================================
s = new_slide()
base(s, 12, "Résultats", "Données cliniques et comparaisons statistiques — à renseigner après l'étude")
textbox(s, 0.55, 1.82, 7.4, 0.3, "Tableau 01 · Comparaison T0 / T1 / T2",
        size=13, color=NAVY, bold=True)
rows, cols = 5, 4
tbl_shape = s.shapes.add_table(rows, cols, Inches(0.55), Inches(2.22), Inches(7.5), Inches(3.0))
tbl = tbl_shape.table
headers = ["Paramètre", "T0", "T1", "T2 / p"]
data = [
    ["Douleur (EVA)", "[à saisir]", "[à saisir]", "[Δ / p]"],
    ["Incapacité (NDI)", "[à saisir]", "[à saisir]", "[Δ / p]"],
    ["Mobilité cervicale (°)", "[à saisir]", "[à saisir]", "[Δ / p]"],
    ["Tests ULNT", "[à saisir]", "[à saisir]", "[Δ / p]"],
]
for c, h in enumerate(headers):
    cell = tbl.cell(0, c)
    cell.text = h
    cell.fill.solid()
    cell.fill.fore_color.rgb = NAVY
    for p in cell.text_frame.paragraphs:
        for r in p.runs:
            r.font.size = Pt(10.5); r.font.bold = True; r.font.color.rgb = WHITE
for r_i, row in enumerate(data, start=1):
    for c_i, val in enumerate(row):
        cell = tbl.cell(r_i, c_i)
        cell.text = val
        cell.fill.solid()
        cell.fill.fore_color.rgb = LIGHT if r_i % 2 else WHITE
        for p in cell.text_frame.paragraphs:
            for r in p.runs:
                r.font.size = Pt(10); r.font.color.rgb = DARK
rect(s, 8.35, 2.22, 4.35, 3.0, LIGHT, rounded=True)
rect(s, 8.35, 2.22, 4.35, 0.06, AMBER)
textbox(s, 8.62, 2.45, 3.8, 0.35, "FIGURE 06 · ZONE GRAPHIQUE",
        size=11, color=NAVY, bold=True)
textbox(s, 8.62, 2.95, 3.8, 1.9,
        "Emplacement réservé au graphique comparatif (EVA, NDI ou amplitudes) "
        "issu de l'analyse statistique des données réelles anonymisées.",
        size=11.5, color=DARK)
textbox(s, 0.55, 5.55, 12.1, 0.75,
        "Moyennes ± écarts-types (ou médianes [IQR]) selon la normalité des distributions. "
        "Aucune valeur n'est présentée tant que les données de l'étude ne sont pas disponibles.",
        size=11, color=GREY, italic=True)

# ============================================================================
# 13 — Discussion
# ============================================================================
s = new_slide()
base(s, 13, "Discussion", "Interprétation, littérature et limites")
card(s, 0.55, 1.85, 7.6, 1.1, "01 · Principaux enseignements",
     "Interprétation de l'évolution observée et cohérence avec H0 / H1.")
card(s, 0.55, 3.1, 7.6, 1.1, "02 · Littérature scientifique",
     "Revue 2024 : gain de mobilité avec mobilisation neurale, bénéfice douleur non significatif ; certitude faible à très faible.", AMBER)
card(s, 0.55, 4.35, 7.6, 1.1, "03 · Biais & contraintes",
     "Effectif, absence possible d'aveugle et suivi court imposent une interprétation prudente.")
card(s, 0.55, 5.6, 7.6, 1.1, "04 · Perspectives",
     "ECR multicentrique, suivi à moyen terme et stratification selon le profil d'irritabilité.", AMBER)
image_contain(s, "Ch8_Discussion/Fig_8.1_Comparaison_preuves.png",
              8.45, 1.85, 4.25, 3.3, "Fig. 08 — Hiérarchie des preuves",
              "Fig_8.1_Comparaison_preuves.png")
rect(s, 8.45, 5.5, 4.25, 1.2, NAVY, rounded=True)
textbox(s, 8.7, 5.65, 3.75, 0.85,
        "Ne pas généraliser les résultats de radiculopathie à toutes les cervicalgies non spécifiques.",
        size=11, color=WHITE)

# ============================================================================
# 14 — Conclusion
# ============================================================================
s = new_slide()
base(s, 14, "Conclusion", "Messages clés pour la pratique clinique")
card(s, 0.55, 1.9, 3.85, 3.3, "01 · Évaluation systématique",
     "Les tests ULNT et la différenciation structurelle affinent le raisonnement clinique "
     "devant une cervicalgie à composante neurale.\n\nRaisonnement clinique")
card(s, 4.62, 1.9, 3.85, 3.3, "02 · Progression raisonnée",
     "Respecter l'irritabilité tissulaire : glissement indolore d'abord, mise en tension "
     "progressive ensuite.\n\nDosage thérapeutique", AMBER)
card(s, 8.69, 1.9, 4.05, 3.3, "03 · Approche multimodale",
     "La neurodynamique complète thérapie manuelle cervicale et contrôle moteur dans une "
     "prise en charge centrée sur le patient.\n\nPratique fondée sur les preuves")
rect(s, 0.55, 5.55, 12.18, 0.95, NAVY, rounded=True)
textbox(s, 0.85, 5.75, 11.5, 0.55,
        "Synthèse du travail de fin d'études — conclusion définitive à valider selon les résultats obtenus.",
        size=12.5, color=WHITE)

# ============================================================================
# 15 — Remerciements
# ============================================================================
s = new_slide()
rect(s, 0, 0, W, H, NAVY)
rect(s, 0, 0, 0.16, H, TEAL)
rect(s, 0.55, 0.75, 2.9, 0.06, AMBER)
textbox(s, 0.55, 1.2, 11.5, 0.35, "CLÔTURE DE SOUTENANCE", size=12, color=AMBER, bold=True)
textbox(s, 0.55, 1.85, 11.8, 1.0, "Merci pour votre attention", size=40, color=WHITE, bold=True)
textbox(s, 0.57, 3.15, 10.9, 1.2,
        "Je reste à la disposition des membres du jury pour répondre à vos questions "
        "et approfondir les aspects cliniques ou méthodologiques de ce travail.",
        size=15, color=MIDS)
rect(s, 0.55, 4.75, 5.6, 0.02, TEAL)
textbox(s, 0.55, 5.0, 5.9, 1.0,
        "Candidat(e) : [Nom et prénom · contact]\nEncadrement : [Nom du directeur de mémoire]",
        size=12, color=WHITE, space=8)
textbox(s, 0.55, 6.45, 11.8, 0.35,
        "UPSAT — Tunisie · PFE Kinésithérapie & Neurorééducation · 2025–2026",
        size=10.5, color=MIDS)
textbox(s, 0.55, 6.85, 11.8, 0.25,
        "Illustrations : Wikimedia Commons (licences CC BY / CC BY-SA / CC0 / domaine public) — crédits détaillés dans les notes des diapositives.",
        size=8.5, color=MIDS, italic=True)
textbox(s, 12.0, 6.45, 0.75, 0.3, "15 / 15", size=10, color=MIDS, align=PP_ALIGN.RIGHT)

# ---- save ------------------------------------------------------------------
OUT_DIR.mkdir(parents=True, exist_ok=True)
prs.save(str(OUT))
print(f"Saved: {OUT}")
print(f"Slides: {len(prs.slides._sldIdLst)}")
print(f"Size: {OUT.stat().st_size} bytes")
