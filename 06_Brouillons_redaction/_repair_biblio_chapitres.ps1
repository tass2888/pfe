$ErrorActionPreference='Continue'
$root='C:\Users\LENOVO\Documents\PFE\PFE_Neurodynamique\05_Bibliographie\09_Biblio_par_chapitre'
$log=Join-Path $root '00_INDEX\telechargements_log.txt'

# Remove Cloudflare "Just a moment..." placeholder pages
foreach($f in @(
 'Ch3_Butler_Shacklock\Shacklock_1995_Neurodynamics_article_page.html',
 'Ch4_Application_clinique\Neurodynamic_QoL_deep_flexors_2022_Wiley.html')){
  $p=Join-Path $root $f
  if(Test-Path $p){ Remove-Item $p -Force; "REMOVED blocked page: $f" | Add-Content $log }
}

function Fetch($url,$out){
  $full=Join-Path $root $out
  & curl.exe -L --max-time 45 -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120 Safari/537.36' -o $full $url 2>$null
  if((Test-Path $full) -and ((Get-Item $full).Length -gt 800)){
    "OK   $out ($((Get-Item $full).Length) bytes) <- $url" | Add-Content $log
  } else { "FAIL $out <- $url" | Add-Content $log; if(Test-Path $full){Remove-Item $full -Force} }
}

# Open-access replacement for the Wiley reCAPTCHA page (same RCT, PMC full text)
Fetch 'https://pmc.ncbi.nlm.nih.gov/articles/PMC9556173/' 'Ch4_Application_clinique/Neurodynamic_QoL_deep_flexors_2022_PMC9556173.html'
# Shacklock 1995 abstract landing page (ScienceDirect preview is accessible via curl)
Fetch 'https://www.sciencedirect.com/science/article/abs/pii/S0031940605670241' 'Ch3_Butler_Shacklock/Shacklock_1995_Neurodynamics_abstract_ScienceDirect.html'
Fetch 'https://openalex.org/works/W4255364251' 'Ch3_Butler_Shacklock/Shacklock_1995_OpenAlex_record.html'
"REPAIR DONE. Files: $((Get-ChildItem $root -Recurse -File).Count)" | Add-Content $log
