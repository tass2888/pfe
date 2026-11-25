$ErrorActionPreference='Continue'
$root='C:\Users\LENOVO\Documents\PFE\PFE_Neurodynamique\05_Bibliographie\09_Biblio_par_chapitre'
$log=Join-Path $root '00_INDEX\telechargements_log.txt'
function Fetch($url,$out){
  $full=Join-Path $root $out
  & curl.exe -L --max-time 45 -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120 Safari/537.36' -o $full $url 2>$null
  if((Test-Path $full) -and ((Get-Item $full).Length -gt 800)){
    "OK   $out ($((Get-Item $full).Length) bytes) <- $url" | Add-Content $log
  } else { "FAIL $out <- $url" | Add-Content $log; if(Test-Path $full){Remove-Item $full -Force} }
}
# Remove JS shells
foreach($f in @('Ch3_Butler_Shacklock\Shacklock_1995_Neurodynamics_abstract_ScienceDirect.html',
                'Ch5_Materiel_methodes\Diagnostic_accuracy_neurodynamic_tests_2025_SciDirect.html')){
  $p=Join-Path $root $f; if(Test-Path $p){Remove-Item $p -Force; "REMOVED JS shell: $f" | Add-Content $log}
}
# Real open-access full text (Elsevier companion site)
Fetch 'https://www.mskscienceandpractice.com/article/S2468-7812(25)00065-7/fulltext' 'Ch5_Materiel_methodes/Diagnostic_accuracy_neurodynamic_tests_2025_fulltext.html'
# PubMed abstracts via NCBI eutils
Fetch 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=40156954&retmode=text&rettype=abstract' 'Ch5_Materiel_methodes/AlbertLucena_2025_diagnostic_accuracy_abstract.txt'
Fetch 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=37356367&retmode=text&rettype=abstract' 'Ch5_Materiel_methodes/Shen_2023_ULNT1_accuracy_abstract.txt'
Fetch 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=30665045&retmode=text&rettype=abstract' 'Ch5_Materiel_methodes/Koulidis_2019_ULNT_accuracy_abstract.txt'
Fetch 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=36246968&retmode=text&rettype=abstract' 'Ch4_Application_clinique/Neurodynamic_QoL_deep_flexors_2022_abstract.txt'
# Correct the wrong file in Ch2 (was Zanwar abstract by mistake)
$p=Join-Path $root 'Ch2_Neurophysiologie\Shacklock_1995_foundations_note_PMID_consult.txt'
if(Test-Path $p){Remove-Item $p -Force}
"FINAL DONE. Files: $((Get-ChildItem $root -Recurse -File).Count)" | Add-Content $log
