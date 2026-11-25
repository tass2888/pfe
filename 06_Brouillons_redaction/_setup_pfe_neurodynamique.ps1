$ErrorActionPreference = 'Continue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$root = 'C:\Users\LENOVO\Documents\PFE\PFE_Neurodynamique'

$folders = @(
  '00_Front_Matter',
  '01_Partie_I_Cadre_theorique\Ch1_Cervicalgie',
  '01_Partie_I_Cadre_theorique\Ch2_Neurophysiologie',
  '01_Partie_I_Cadre_theorique\Ch3_Butler_Shacklock',
  '01_Partie_I_Cadre_theorique\Ch4_Application_clinique',
  '02_Partie_II_Etude_pratique\Ch5_Materiel_methodes',
  '02_Partie_II_Etude_pratique\Ch6_Protocole_reeducation',
  '02_Partie_II_Etude_pratique\Ch7_Resultats',
  '03_Partie_III_Discussion\Ch8_Discussion',
  '03_Partie_III_Discussion\Ch9_Conclusion',
  '04_Annexes\Consentement_FR_AR',
  '04_Annexes\Fiches_evaluation',
  '04_Annexes\NDI',
  '04_Annexes\Protocole_seances',
  '04_Annexes\CONSORT',
  '05_Bibliographie\01_Livres_et_chapitres',
  '05_Bibliographie\02_Concepts_et_mecanismes',
  '05_Bibliographie\03_Reviews_et_metaanalyses',
  '05_Bibliographie\04_Etudes_cliniques',
  '05_Bibliographie\05_Diagnostic_accuracy',
  '05_Bibliographie\06_Ressources_pratiques',
  '05_Bibliographie\07_Cervicogenic_headache',
  '06_Brouillons_redaction',
  '07_Donnees',
  '08_Figures_Tables'
)

foreach ($f in $folders) {
  New-Item -ItemType Directory -Force -Path (Join-Path $root $f) | Out-Null
}

$ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0 Safari/537.36'
$log = @()

function Save-Text($rel, $content) {
  $dest = Join-Path $root $rel
  $dir = Split-Path $dest -Parent
  if (!(Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  Set-Content -Path $dest -Value $content -Encoding UTF8
  $log += "NOTE  $rel"
}

function Get-Remote($rel, $url) {
  $dest = Join-Path $root $rel
  $dir = Split-Path $dest -Parent
  if (!(Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  if (Test-Path $dest) { Remove-Item $dest -Force }
  try {
    & curl.exe -L --fail --silent --show-error --retry 2 --connect-timeout 20 --max-time 180 -A $ua -o $dest $url
    if ($LASTEXITCODE -eq 0 -and (Test-Path $dest) -and ((Get-Item $dest).Length -gt 0)) {
      $log += "OK    $rel  [$((Get-Item $dest).Length) bytes]"
    } else {
      $log += "FAIL  $rel  exit=$LASTEXITCODE"
      if (Test-Path $dest) { Remove-Item $dest -Force }
    }
  } catch {
    $log += "ERR   $rel  $($_.Exception.Message)"
  }
}

function Get-Pubmed($rel, $pmid) {
  $url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=$pmid&retmode=text&rettype=abstract"
  try {
    $txt = Invoke-RestMethod -Uri $url -TimeoutSec 90
    Save-Text $rel $txt
  } catch {
    $log += "ERR   $rel  PubMed $($_.Exception.Message)"
  }
}

# ---------------- LIVRES / CHAPITRES ----------------
Get-Remote '05_Bibliographie\01_Livres_et_chapitres\Butler_Sensitive_Nervous_System_Chapter_Summaries.pdf' 'https://www.noigroup.com/wp-content/uploads/2024/06/sensitive-nervous-system-chapter-summaries.pdf'
Get-Remote '05_Bibliographie\01_Livres_et_chapitres\Shacklock_Clinical_Neurodynamics_Elsevier_inspection.html' 'https://inspectioncopy.elsevier.com/book/details/9780750654562'
Get-Remote '05_Bibliographie\01_Livres_et_chapitres\Butler_Sensitive_Nervous_System_GoogleBooks.html' 'https://books.google.com/books/about/The_Sensitive_Nervous_System.html?id=_YXC03J8NYoC'
Get-Remote '05_Bibliographie\01_Livres_et_chapitres\Butler_Mobilisation_Nervous_System_1991_Elsevier.html' 'https://shop.elsevier.com/books/mobilisation-of-the-nervous-system/butler/978-0-443-04400-7'
Get-Remote '05_Bibliographie\01_Livres_et_chapitres\Shacklock_Clinical_Neurodynamics_InternetArchive.html' 'https://archive.org/details/clinicalneurodyn0000shac'
Get-Remote '05_Bibliographie\01_Livres_et_chapitres\Butler_Mobilisation_1991_InternetArchive.html' 'https://archive.org/details/mobilisationofne0000butl'
Get-Remote '05_Bibliographie\01_Livres_et_chapitres\Noigroup_Neurodynamic_Techniques_handbook.html' 'https://www.noigroup.com/product/neurodynamic-techniques-handbook-videos'
Get-Remote '05_Bibliographie\01_Livres_et_chapitres\Noigroup_Neurodynamics_Pack.html' 'https://www.noigroup.com/product/neurodynamics-pack-pal'

# ---------------- CONCEPTS / MECANISMES ----------------
Get-Remote '05_Bibliographie\02_Concepts_et_mecanismes\Nee_Butler_2006_peripheral_neuropathic_pain.pdf' 'https://www.lastsite.ca/wp-content/uploads/2017/03/Nee-and-butler-neurodynamics.pdf'
Get-Remote '05_Bibliographie\02_Concepts_et_mecanismes\Shacklock_Level3_lower_course_notes.pdf' 'https://www.orthodiv.org/wp-content/uploads/2013/11/CLINICAL-NEURODYNAMICS-LEVEL-3-LOWER-2011.pdf'
Get-Remote '05_Bibliographie\02_Concepts_et_mecanismes\HandPT_Neurodynamics_2.0_slides.pdf' 'https://www.handpt.org/docs/csm/neurodynamics_2.0.pdf'
Get-Remote '05_Bibliographie\02_Concepts_et_mecanismes\Neurodynamic_mobilization_peripheral_nerve_regeneration.pdf' 'https://pdfs.semanticscholar.org/b360/a25c30b63b2b9b8a6a25e7ce7281d6816218.pdf'
Get-Remote '05_Bibliographie\02_Concepts_et_mecanismes\Brighton_sliders_tensioners_blog.html' 'https://blogs.brighton.ac.uk/musculoskeletalphysiotherapy/2021/07/29/are-nerve-sliders-and-tensioners-effective-for-sciatica-part-1'
Get-Remote '05_Bibliographie\02_Concepts_et_mecanismes\ZacCupples_Ch7_Standard_Neurodynamic_Testing.html' 'https://zaccupples.com/chapter-7-standard-neurodynamic-testing'
Get-Remote '05_Bibliographie\02_Concepts_et_mecanismes\Physiotutors_Upper_Limb_Sliders_Tensioners.html' 'https://www.physiotutors.com/wiki/upper-limb-nerve-sliders-tensioners'
Get-Pubmed '05_Bibliographie\02_Concepts_et_mecanismes\Coppieters_2008_sliders_tensioners_abstract.txt' '17398140'

# ---------------- REVIEWS / META-ANALYSES ----------------
Get-Pubmed '05_Bibliographie\03_Reviews_et_metaanalyses\JOSPT_2025_NMA_abstract.txt' '40576779'
Get-Pubmed '05_Bibliographie\03_Reviews_et_metaanalyses\Gillot_2025_SR_MA_abstract.txt' '40968604'
Get-Pubmed '05_Bibliographie\03_Reviews_et_metaanalyses\Paraskevopoulos_2022_SR_MA_abstract.txt' '36395760'
Get-Pubmed '05_Bibliographie\03_Reviews_et_metaanalyses\Xu_Ling_2025_NMA_abstract.txt' '40255362'
Get-Remote '05_Bibliographie\03_Reviews_et_metaanalyses\Xu_Ling_2025_NMA_PMC12008560.html' 'https://pmc.ncbi.nlm.nih.gov/articles/PMC12008560'
Get-Remote '05_Bibliographie\03_Reviews_et_metaanalyses\MDPI_2021_Manual_Therapy_Cervical_Lumbar_Radiculopathy.pdf' 'https://mdpi-res.com/d_attachment/ijerph/ijerph-18-06176/article_deploy/ijerph-18-06176.pdf'
Get-Remote '05_Bibliographie\03_Reviews_et_metaanalyses\MDPI_2021_Manual_Therapy_Cervical_Lumbar_Radiculopathy_page.html' 'https://www.mdpi.com/1660-4601/18/11/6176'

# ---------------- ETUDES CLINIQUES ----------------
Get-Remote '05_Bibliographie\04_Etudes_cliniques\Rafiq_2022_RCT_PMC9556173.html' 'https://pmc.ncbi.nlm.nih.gov/articles/PMC9556173'
Get-Remote '05_Bibliographie\04_Etudes_cliniques\Neural_mobilization_vs_conservative_PMC9725158.html' 'https://pmc.ncbi.nlm.nih.gov/articles/PMC9725158'
Get-Remote '05_Bibliographie\04_Etudes_cliniques\Butler_vs_Maitland_SaudiJournals.pdf' 'https://saudijournals.com/media/articles/SJMPS_410_1221-1235_c.pdf'
Get-Remote '05_Bibliographie\04_Etudes_cliniques\Acute_effects_neural_mobilization_EJM.pdf' 'https://pdf.journalagent.com/ejm/pdfs/EJM-08941-ORIGINAL_ARTICLE-SEVGIN.pdf'
Get-Remote '05_Bibliographie\04_Etudes_cliniques\Salt_2016_CLG_RCT.pdf' 'https://mider.openrepository.com/bitstreams/01191e58-bb3f-4598-9aee-3de265da8176/download'
Get-Remote '05_Bibliographie\04_Etudes_cliniques\Salt_2016_SCIRP_page.html' 'https://www.scirp.net/journal/paperinformation?paperid=69402'
Get-Pubmed '05_Bibliographie\04_Etudes_cliniques\Allison_2002_pilot_RCT_abstract.txt' '12151246'
try {
  $ct = Invoke-RestMethod -Uri 'https://clinicaltrials.gov/api/v2/studies/NCT06663592?format=json' -TimeoutSec 90
  Save-Text '05_Bibliographie\04_Etudes_cliniques\ClinicalTrials_NCT06663592.json' ($ct | ConvertTo-Json -Depth 30)
} catch { $log += "ERR   ClinicalTrials_NCT06663592.json  $($_.Exception.Message)" }

# ---------------- DIAGNOSTIC ACCURACY ----------------
Get-Remote '05_Bibliographie\05_Diagnostic_accuracy\Diagnostic_accuracy_2026_PMC13088722.html' 'https://pmc.ncbi.nlm.nih.gov/articles/PMC13088722'
Get-Pubmed '05_Bibliographie\05_Diagnostic_accuracy\Wainner_2003_abstract.txt' '12544957'
Get-Remote '05_Bibliographie\05_Diagnostic_accuracy\Thoomes_2018_physical_tests_CR.pdf' 'https://research.vu.nl/files/80445700/Value_of_physical_tests_in_diagnosing_cervical_radiculopathy.pdf'
Get-Remote '05_Bibliographie\05_Diagnostic_accuracy\Grondin_2021_ULNT_accuracy.html' 'https://www.mskscienceandpractice.com/article/S2468-7812(21)00111-9/abstract'
Get-Remote '05_Bibliographie\05_Diagnostic_accuracy\Modified_ULNT_2024_PMC10949103.html' 'https://pmc.ncbi.nlm.nih.gov/articles/PMC10949103'
Get-Remote '05_Bibliographie\05_Diagnostic_accuracy\ULNTT_biomechanics_2025_PMC12108813.html' 'https://pmc.ncbi.nlm.nih.gov/articles/PMC12108813'

# ---------------- RESSOURCES PRATIQUES ----------------
Get-Remote '05_Bibliographie\06_Ressources_pratiques\BSR_Nerve_Gliding_Exercises.html' 'https://www.bsrphysicaltherapy.com/2024/01/01/nerve-gliding-exercises-neck-pain'
Get-Remote '05_Bibliographie\06_Ressources_pratiques\IPTA_Mobilization_Nervous_System_brochure.pdf' 'https://cdn.ymaws.com/www.ipta.org/resource/resmgr/2012_CE_Ad_Brochures/Mobilization_of_Nervous_Syst.pdf'
Get-Remote '05_Bibliographie\06_Ressources_pratiques\NeurodynamicSolutions_home.html' 'https://neurodynamicsolutions.com'
Get-Remote '05_Bibliographie\06_Ressources_pratiques\NDS_Online_Upper_Quarter_course.html' 'https://neurodynamicsolutions.com/products/online-neurodynamics-course-upper-quarter'
Get-Remote '05_Bibliographie\06_Ressources_pratiques\ECU_Shacklock_seminar.html' 'https://www.chiropractic-ecu.org/seminars/neurodynamics-upper-lower-quarter-level-1-prof-michael-shacklock'
Get-Remote '05_Bibliographie\06_Ressources_pratiques\Kineziterapijos_Shacklock_course.html' 'https://www.kineziterapijosklinika.com/en/product/clinical-neurodynamics-with-michael-shacklock'
Get-Remote '05_Bibliographie\06_Ressources_pratiques\SomaticSenses_Upper_Quarter.html' 'https://somaticsenses.com/products/clinical-neurodynamic-solutions-upper'

# ---------------- CERVICOGENIC HEADACHE ----------------
Get-Remote '05_Bibliographie\07_Cervicogenic_headache\Myodural_bridge_review_PMC4025088.html' 'https://pmc.ncbi.nlm.nih.gov/articles/PMC4025088'
Get-Remote '05_Bibliographie\07_Cervicogenic_headache\Dural_tube_release_CGH_protocol.html' 'https://physioquart.awf.wroc.pl/Effectiveness-of-dural-tube-myofascial-release-on-suboccipital-muscle-thickness-cervical,209188,0,2.html'
Get-Remote '05_Bibliographie\07_Cervicogenic_headache\Omnicuris_neural_mobilization_CGH.html' 'https://www.omnicuris.com/medshots/daily_updates/neural-mobilization-cervicogenic-headache-evidence_03-Oct-26_18-19'

# ---------------- INDEX / NOTES ----------------
Save-Text 'README.md' @'
# PFE Neurodynamique -- Cervicalgie (Butler & Shacklock)

Workspace structure following the validated thesis plan.

## Arborescence
- 00_Front_Matter : introduction, resume, abstract, abbreviations
- 01_Partie_I_Cadre_theorique : Ch1 cervicalgie, Ch2 neurophysiologie, Ch3 Butler/Shacklock, Ch4 application clinique
- 02_Partie_II_Etude_pratique : Ch5 materiel et methodes, Ch6 protocole, Ch7 resultats
- 03_Partie_III_Discussion : Ch8 discussion, Ch9 conclusion
- 04_Annexes : consentement, fiches d evaluation, NDI, protocole de seances, CONSORT
- 05_Bibliographie : documents telecharges par theme + Liens_utiles.md
- 06_Brouillons_redaction : versions de travail
- 07_Donnees : donnees brutes (a anonymiser)
- 08_Figures_Tables : figures et tableaux

## Regle de provenance
- Les PDF/HTML telecharges sont soit open access (PMC, PubMed, universites, revues OA), soit des pages officielles (Noigroup, Elsevier, Shacklock, Physiotutors, etc.).
- Les ouvrages integraux payants ou sous droit d auteur ne sont PAS copies : voir 05_Bibliographie\00_Liens_utiles.md pour les liens et mentions "a consulter via bibliotheque".
-telechargements_log.txt liste le resultat de chaque telechargement.

## Prochaine etape
Remplacer les fichiers 00_Notes_*.md par les chapitres reels, puis deplacer les documents utiles dans le dossier du chapitre qui les cite.
'@

Save-Text '00_Front_Matter\00_Identite_et_questions.md' @'
TITRE RETENU
Place de la mobilisation neurodynamique selon les concepts de Butler et Shacklock dans la prise en charge kinesthesique de la cervicalgie avec composante neurodynamique : etude controlee randomisee.

QUESTION DE RECHERCHE
Dans quelle mesure l ajout d une mobilisation neurodynamique (Butler/Shacklock) a un programme de kinesitherapie conventionnelle ameliorle-t-il la douleur, la mobilite cervicale et le handicap fonctionnel chez des patients presentant une cervicalgie avec composante neurodynamique, comparativement a la kinesitherapie conventionnelle seule ?

HYPOTHESES
H1 : le groupe experimental presente une reduction significativement plus importante de l EVA et du NDI, et une amelioration significativement plus importante de la mobilite cervicale et des ULNT a 5 semaines.
H0 : aucune difference significative entre les deux groupes.

OBJECTIFS SPECIFIQUES
1. Evaluer la douleur (EVA).
2. Mesurer la mobilite cervicale (inclinometrie).
3. Evaluer le handicap fonctionnel (NDI).
4. Evaluer la mecanosensibilite neurale (ULNT).
5. Comparer kinesitherapie conventionnelle vs conventionnelle + neurodynamique.
'@

Save-Text '01_Partie_I_Cadre_theorique\Ch3_Butler_Shacklock\00_Notes_Ch3.md' @'
CHAPITRE 3 -- FONDEMENTS DE LA MOBILISATION NEURODYNAMIQUE

A traiter en priorite (coeur du memoire) :
1. Historique : Elvey -> Butler (Mobilisation of the Nervous System, 1991 ; The Sensitive Nervous System, 2000) -> Shacklock (Clinical Neurodynamics, 2005).
2. Butler : mecanosensibilite, mobilite du tissu neural, sliders vs tensioners, tests comme evaluation ET traitement, education.
3. Shacklock : interfaces mecaniques et physiologiques, neurodynamique normale/anormale, classification des dysfonctions (tension, glissement, ouverture/fermeture foraminale, instabilite), neurodynamic sequencing, progressions du pathophysiologique au pathomecanique, modele de soin aigu de la racine cervicale.
4. Tests ULNT : ULTT1 median, ULTT2 (variantes median/radial), ULTT3 ulnair ; reproduction des symptomes + differenciation structurale.
5. Indications, contre-indications et precautions (myelopathie, red flags, dysfonction arterielle cervicale, irritabilite).

Documents locaux utiles :
- 05_Bibliographie\01_Livres_et_chapitres\Butler_Sensitive_Nervous_System_Chapter_Summaries.pdf
- 05_Bibliographie\01_Livres_et_chapitres\Shacklock_Clinical_Neurodynamics_Elsevier_inspection.html
- 05_Bibliographie\02_Concepts_et_mecanismes\Nee_Butler_2006_peripheral_neuropathic_pain.pdf
- 05_Bibliographie\02_Concepts_et_mecanismes\Coppieters_2008_sliders_tensioners_abstract.txt
- 05_Bibliographie\02_Concepts_et_mecanismes\Shacklock_Level3_lower_course_notes.pdf
- 05_Bibliographie\06_Ressources_pratiques\ECU_Shacklock_seminar.html
'@

Save-Text '01_Partie_I_Cadre_theorique\Ch4_Application_clinique\00_Notes_Ch4.md' @'
CHAPITRE 4 -- APPLICATION DANS LA CERVICALGIE

Points cle :
- Ne pas generaliser les resultats de la radiculopathie a toute cervicalgie non specifique.
- Identifier les patients avec composante neurodynamique : ULNT positif avec reproduction + modification par inclinaison cervicale controlaterale.
- Choix du test selon le territoire : median (C6/C7), radial (C7), ulnaire (C8/T1).
- Butler : sliders d abord, tensioners si faible irritabilite ; cervical lateral glide.
- Shacklock : ouverture foraminale en phase irritable puis fermeture ; progressions ; sequencing.
- Dose : 3 series de 10, 2 a 3 fois/seance, symptoms <= 3/10 et retour a la baseline en < 5-10 min.
- Preuves : effets surtout court terme, certitude faible a tres faible.

Documents locaux utiles :
- 05_Bibliographie\02_Concepts_et_mecanismes\Brighton_sliders_tensioners_blog.html
- 05_Bibliographie\02_Concepts_et_mecanismes\ZacCupples_Ch7_Standard_Neurodynamic_Testing.html
- 05_Bibliographie\03_Reviews_et_metaanalyses\*.txt
- 05_Bibliographie\04_Etudes_cliniques\*
'@

Save-Text '02_Partie_II_Etude_pratique\Ch5_Materiel_methodes\00_Notes_Ch5.md' @'
CHAPITRE 5 -- MATERIEL ET METHODES

Design : RCT parallele, 2 groupes, evaluateur en aveugle, monocentrique.
Population : adultes 18-60 ans, cervicalgie avec composante neurodynamique, >= 4 semaines, EVA >= 3/10.
Exclusion : myelopathie, deficit moteur progressif, red flags, chirurgie recente, instabilite, dysfonction arterielle cervicale, grossesse.
Echantillon : n=40 pragmatique (20/groupe) ; ideal n=50 (25/groupe), d~0.8, alpha 0.05, puissance 80%.
Randomisation : enveloppes opaques numerotees.
Mesures : T0, T1 (S5), T2 (3 mois si faisable).
Outils : EVA, NDI, inclinometre, ULNT, examen neuro, GPE/PSFS optionnel.
Stats : ANCOVA ajustee sur T0, test t appari/Wilcoxon, effect sizes d/g avec IC95%, ITT, p<0.05.
Ethique : comite d ethique, consentement FR/AR, anonymie.
'@

Save-Text '02_Partie_II_Etude_pratique\Ch6_Protocole_reeducation\00_Notes_Ch6.md' @'
CHAPITRE 6 -- PROTOCOLE DE REEDUCATION

Commun aux 2 groupes : 10 seances, 2x/semaine, 45 min, sur 5 semaines.
Groupe A : kinesitherapie conventionnelle seule.
Groupe B : conventionnelle + 10-15 min de mobilisation neurodynamique/seance.
S1-S3 : sliders median + cervical lateral glide I-II, 3x10, 2-3 fois/seance.
S4-S7 : sliders radial/ulnaire selon territoire ; ouverture foraminale puis progression vers fermeture (Shacklock).
S8-S10 : tensioners doux si faible irritabilite ; integration fonctionnelle et auto-mobilisation.
Regles : symptomes <= 3/10, retour baseline < 5-10 min ; arret si peripheralisation, deficit, douleur > 24h.
Voir 04_Annexes\Protocole_seances pour le tableau seance par seance.
'@

Save-Text '05_Bibliographie\00_Liens_utiles.md' @'
# Liens utiles -- a consulter selon les droits d acces

## Ouvrages / contenus payants ou sous droit d auteur (liens seulement)
- Shacklock M. Clinical Neurodynamics (2005) -- inspection : https://inspectioncopy.elsevier.com/book/details/9780750654562
- Shacklock M. Clinical Neurodynamics -- archive record : https://archive.org/details/clinicalneurodyn0000shac
- Butler DS. The Sensitive Nervous System -- Google Books : https://books.google.com/books/about/The_Sensitive_Nervous_System.html?id=_YXC03J8NYoC
- Butler DS. The Sensitive Nervous System -- texte OCR (acces selon conditions Internet Archive) : https://archive.org/stream/thesensitivenervoussystem/The%20Sensitive%20Nervous%20System_djvu.txt
- Butler DS, Jones MA, Gore R. Mobilisation of the Nervous System (1991) : https://shop.elsevier.com/books/mobilisation-of-the-nervous-system/butler/978-0-443-04400-7
- Butler 1991 Internet Archive : https://archive.org/details/mobilisationofne0000butl
- Noigroup Neurodynamic Techniques handbook + videos : https://www.noigroup.com/product/neurodynamic-techniques-handbook-videos
- Noigroup Neurodynamics Pack : https://www.noigroup.com/product/neurodynamics-pack-pal

## Concepts / mecanismes
- Physiopedia Neurodynamic Treatment : https://www.physio-pedia.com/Neurodynamic_Treatment
- Physiopedia Neurodynamic Assessment : https://www.physio-pedia.com/Neurodynamic_Assessment
- Physiopedia ULTTs : https://www.physio-pedia.com/Upper_Limb_Tension_Tests_(ULTTs)
- Video Physiotutors sliders/tensioners : https://www.youtube.com/watch?v=Fv_EJV8q2E0
- Video Physiotutors lower limb : https://www.youtube.com/watch?v=WXzf8gxYQ2o
- Slideshare Butler & Shacklock : https://www.slideshare.net/slideshow/neural-mobilisation-techniques-butler-and-shacklock/285292389
- Slideshare Neurodynamics I : https://www.slideshare.net/slideshow/neurodynamics-i/231088588

## Reviews / evidence
- JOSPT 2025 NMA (publisher, 403 selon IP) : https://www.jospt.org/doi/10.2519/jospt.2025.12757
- JOSPT 2012 validity ULNT : https://www.jospt.org/doi/10.2519/jospt.2012.3988
- SR mapping report (ResearchGate) : https://www.researchgate.net/publication/354682298_Effectiveness_of_Neural_Mobilization_Techniques_in_the_Management_of_Musculoskeletal_Neck_Disorders_with_Nerve-Related_Symptoms_A_Systematic_Review_and_Meta-Analysis_with_a_Mapping_Report
- Slider vs tensioner upper quadrant SR (ScienceDirect) : https://www.sciencedirect.com/science/article/abs/pii/S1360859222000444
- Comparative SNS RCT (PMC) : https://pmc.ncbi.nlm.nih.gov/articles/PMC11396284

## Etudes cliniques diverses
- CLG waiting-list RCT (ResearchGate) : https://www.researchgate.net/publication/315335764_Cervical_Lateral_Glide_Neural_Mobilization_Is_Effective_in_Treating_Cervicobrachial_Pain_A_Randomized_Waiting_List_Controlled_Clinical_Trial
- Martin-Vera 2021 (pas de benefice ajoute) : https://portalcientifico.universidadeuropea.com/documentos/618f9d194fa218568b4dadb3
- Saudi Journals article page : https://saudijournals.com/articles/8505

## Cours Shacklock / formations
- Neurodynamic Solutions : https://neurodynamicsolutions.com
- Online Upper Quarter : https://neurodynamicsolutions.com/products/online-neurodynamics-course-upper-quarter
- Precision Performance PT : https://precisionperformancept.com/neurodynamics-upper-quarter-course

## Cervicogenic headache
- Caring Medical myodural bridge : https://caringmedical.com/prolotherapy-news/myodural-bridge-2
'@

$log | Set-Content -Path (Join-Path $root 'telechargements_log.txt') -Encoding UTF8
Write-Output "DONE. Root: $root"
Write-Output ($log -join "`n")
