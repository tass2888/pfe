# Fetch chapter-organized bibliography documents (user-provided priority list)
$ErrorActionPreference = 'Continue'
$root = 'C:\Users\LENOVO\Documents\PFE\PFE_Neurodynamique\05_Bibliographie\09_Biblio_par_chapitre'
$dirs = @(
  '00_INDEX',
  'Ch1_Cervicalgie',
  'Ch2_Neurophysiologie',
  'Ch3_Butler_Shacklock',
  'Ch4_Application_clinique',
  'Ch5_Materiel_methodes',
  'Ch8_Discussion'
)
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path (Join-Path $root $d) | Out-Null }

$log = Join-Path $root '00_INDEX\telechargements_log.txt'
"LOG - $(Get-Date -Format 'yyyy-MM-dd HH:mm')" | Set-Content $log

function Fetch($url, $out) {
  $full = Join-Path $root $out
  $dir = Split-Path $full -Parent
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  try {
    & curl.exe -L --max-time 45 -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120 Safari/537.36' -o $full $url 2>$null
    if ((Test-Path $full) -and ((Get-Item $full).Length -gt 800)) {
      "OK   $out ($((Get-Item $full).Length) bytes) <- $url" | Add-Content $log
    } else {
      "FAIL $out <- $url" | Add-Content $log
      if (Test-Path $full) { Remove-Item $full -Force }
    }
  } catch {
    "FAIL $out <- $url ($($_.Exception.Message))" | Add-Content $log
  }
}

# --- Ch1 : cervicalgie / guidelines ---
Fetch 'https://pmc.ncbi.nlm.nih.gov/articles/PMC12620902/' 'Ch1_Cervicalgie/CPG_Nonspecific_Neck_Pain_2025_PMC12620902.html'

# --- Ch2 : mechanisms ---
Fetch 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=38510155&retmode=text&rettype=abstract' 'Ch2_Neurophysiologie/Shacklock_1995_foundations_note_PMID_consult.txt'

# --- Ch3 : Butler / Shacklock foundational ---
Fetch 'https://www.physiotherapyjournal.com/article/S0031-9406%2805%2967024-1/fulltext' 'Ch3_Butler_Shacklock/Shacklock_1995_Neurodynamics_article_page.html'
Fetch 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=32710604&retmode=text&rettype=abstract' 'Ch3_Butler_Shacklock/Cervical_radiculopathy_epidemiology_2020_abstract.txt'

# --- Ch4 : efficacy / reviews / RCTs ---
Fetch 'https://pmc.ncbi.nlm.nih.gov/articles/PMC11203317/' 'Ch4_Application_clinique/Routine_PT_with_without_neural_mobilization_2024_PMC11203317.html'
Fetch 'https://pmc.ncbi.nlm.nih.gov/articles/PMC9725158/' 'Ch4_Application_clinique/Neural_mobilization_vs_conservative_2022_PMC9725158.html'
Fetch 'https://pmc.ncbi.nlm.nih.gov/articles/PMC8195637/' 'Ch4_Application_clinique/Manual_therapy_cervical_radiculopathy_2021_PMC8195637.html'
Fetch 'https://onlinelibrary.wiley.com/doi/10.1155/2022/9385459' 'Ch4_Application_clinique/Neurodynamic_QoL_deep_flexors_2022_Wiley.html'
Fetch 'https://pmc.ncbi.nlm.nih.gov/articles/PMC8201115/' 'Ch4_Application_clinique/Manual_therapy_cervical_lumbar_radiculopathy_2021_PMC8201115.html'
Fetch 'https://pmc.ncbi.nlm.nih.gov/articles/PMC9422871/' 'Ch4_Application_clinique/Multimodal_rehab_cervical_radiculopathy_2022_PMC9422871.html'
Fetch 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=40576779&retmode=text&rettype=abstract' 'Ch4_Application_clinique/Articular_neural_mobilization_2025_NMA_abstract.txt'

# --- Ch5 : assessment tools ---
Fetch 'https://pmc.ncbi.nlm.nih.gov/articles/PMC10949103/' 'Ch5_Materiel_methodes/Modified_ULNT_2024_PMC10949103.html'
Fetch 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=34298491&retmode=text&rettype=abstract' 'Ch5_Materiel_methodes/Diagnostic_accuracy_ULNT_cervical_radiculopathy_2021_abstract.txt'
Fetch 'https://www.sciencedirect.com/science/article/pii/S2468781225000657' 'Ch5_Materiel_methodes/Diagnostic_accuracy_neurodynamic_tests_2025_SciDirect.html'
Fetch 'https://pmc.ncbi.nlm.nih.gov/articles/PMC9977990/' 'Ch5_Materiel_methodes/NDI_validation_PMC9977990.html'
Fetch 'https://link.springer.com/article/10.1186/s12891-024-07775-6' 'Ch5_Materiel_methodes/Cervical_goniometry_2024_Springer.html'
Fetch 'https://pubmed.ncbi.nlm.nih.gov/?term=visual+analogue+scale+pain+validation' 'Ch5_Materiel_methodes/VAS_validation_PubMed_search.html'

# --- Ch8 : discussion ---
Fetch 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=40255362&retmode=text&rettype=abstract' 'Ch8_Discussion/Xu_Ling_2025_NMA_abstract.txt'

"DONE. Files: $((Get-ChildItem $root -Recurse -File).Count)" | Add-Content $log
