# Telechargement d'images open access (Wikimedia Commons) pour 08_Figures_Tables
# Chaque image est accompagnee de son auteur, licence et URL source dans un CSV.
# Reproductible : powershell.exe -NoProfile -ExecutionPolicy Bypass -File '...\_download_commons_images.ps1'
# Fichier volontairement en ASCII seul (PowerShell 5.1 sans BOM).

$ua = 'PFE-Neurodynamique-Research/1.0 (educational thesis; contact: tass2888@users.noreply.github.com)'
$base = 'C:\Users\LENOVO\Documents\PFE\PFE_Neurodynamique\08_Figures_Tables'
$log  = Join-Path $base '00_INDEX\telechargement_images_log.txt'

$items = @(
  [pscustomobject]@{Id='1.1'; Folder='Ch1_Cervicalgie'; Title='Cervical Spine Lateral View.png'; File='Fig_1.1_Anatomie_rachis_cervical'; Note='Vue laterale du rachis cervical'},
  [pscustomobject]@{Id='1.2'; Folder='Ch1_Cervicalgie'; Title='Brachial plexus 2 es.svg'; File='Fig_1.2_Racines_plexus_brachial'; Note='Plexus brachial - etiquettes espagnoles'},
  [pscustomobject]@{Id='1.3'; Folder='Ch1_Cervicalgie'; Title='Radiculopathy.png'; File='Fig_1.3_Radiculopathie_cervicale'; Note='Radiculopathie - soutien partiel'},
  [pscustomobject]@{Id='1.4'; Folder='Ch1_Cervicalgie'; Title='An introduction to dermatology (1905) Diagrams of the areas served by the nerve fibers passing through the several spinal root ganglia.png'; File='Fig_1.4_Dermatomes_C5_T1'; Note='Cartographie des dermatomes - planche historique'},
  [pscustomobject]@{Id='2.1'; Folder='Ch2_Neurophysiologie'; Title='Peripheral nerve, cross section.jpg'; File='Fig_2.1_Structure_nerf_peripherique'; Note='Coupe de nerf peripherique'},
  [pscustomobject]@{Id='2.2'; Folder='Ch2_Neurophysiologie'; Title='Propagation of action potential along myelinated nerve fiber en.svg'; File='Fig_2.2_Physiologie_nerveuse'; Note='Conduction saltatoire et gaine de myeline'},
  [pscustomobject]@{Id='3.3'; Folder='Ch3_Butler_Shacklock'; Title='Median-Nerve.jpg'; File='Fig_3.3_ULNT1_median'; Note='Anatomie du median - soutien partiel, pas la manoeuvre ULNT'},
  [pscustomobject]@{Id='3.4'; Folder='Ch3_Butler_Shacklock'; Title='Nerves of the left upper extremity.gif'; File='Fig_3.4_Tests_median_radial_ulnaire'; Note='Nerfs du membre superieur - soutien anatomique partiel'},
  [pscustomobject]@{Id='3.5'; Folder='Ch3_Butler_Shacklock'; Title='Projectional radiograph of cervical foraminal stenosis, annotated.jpg'; File='Fig_3.5_Interface_mecanique_Shacklock'; Note='Stenose foraminale - soutien partiel au concept d interface'},
  [pscustomobject]@{Id='4.1'; Folder='Ch4_Application_clinique'; Title='Physical therapy 150408-F-XP707-029.jpg'; File='Fig_4.1_Examen_clinique'; Note='Scene de kinesitherapie - illustration generique'},
  [pscustomobject]@{Id='4.2'; Folder='Ch4_Application_clinique'; Title='Cervical XrayFlexionExtension.jpg'; File='Fig_4.2_Glissement_lateral_cervical'; Note='Mouvements cervicaux - soutien partiel, radiographie'},
  [pscustomobject]@{Id='5.1'; Folder='Ch5_Materiel_methodes'; Title='CONSORT 2010 flow diagram for a two-group parallel randomized trial.svg'; File='Fig_5.1_Design_etude'; Note='Diagramme CONSORT a deux groupes'},
  [pscustomobject]@{Id='5.2'; Folder='Ch5_Materiel_methodes'; Title='Goniometer-en.svg'; File='Fig_5.2_Mesure_AMC_cervicale'; Note='Goniometre - soutien partiel a la mesure d amplitude'},
  [pscustomobject]@{Id='5.3'; Folder='Ch5_Materiel_methodes'; Title='VAS.png'; File='Fig_5.3_Evaluation_douleur_EVA'; Note='Echelle visuelle analogique'},
  [pscustomobject]@{Id='6.1'; Folder='Ch6_Protocole_reeducation'; Title='Median-Nerve.jpg'; File='Fig_6.1_Glisseur_median'; Note='Anatomie du median - soutien partiel au protocole'},
  [pscustomobject]@{Id='6.2'; Folder='Ch6_Protocole_reeducation'; Title='Radial Nerves Extent.jpg'; File='Fig_6.2_Mobilisation_radial'; Note='Anatomie du radial - soutien partiel'},
  [pscustomobject]@{Id='6.3'; Folder='Ch6_Protocole_reeducation'; Title='Branches of the ulnar nerve in hand.jpg'; File='Fig_6.3_Mobilisation_ulnaire'; Note='Anatomie de l ulnaire - soutien partiel'},
  [pscustomobject]@{Id='6.4'; Folder='Ch6_Protocole_reeducation'; Title='Physical therapy 150408-F-XP707-029.jpg'; File='Fig_6.4_Glissement_lateral_technique'; Note='Scene de kinesitherapie - illustration generique'},
  [pscustomobject]@{Id='7.1'; Folder='Ch7_Resultats'; Title='CONSORT 2010 flow diagram for a two-group parallel randomized trial.svg'; File='Fig_7.1_CONSORT_flow'; Note='Modele CONSORT - a remplir avec les donnees reelles'},
  [pscustomobject]@{Id='8.1'; Folder='Ch8_Discussion'; Title='Hierarchy of Evidence-en.svg'; File='Fig_8.1_Comparaison_preuves'; Note='Hierarchie des preuves - soutien a la discussion'},
  [pscustomobject]@{Id='8.2'; Folder='Ch8_Discussion'; Title='Level of evidence pyramid.png'; File='Fig_8.2_Synthese_certitude_GRADE'; Note='Pyramide des niveaux de preuve - soutien partiel a GRADE'},
  [pscustomobject]@{Id='A.3'; Folder='Annexes'; Title='CONSORT 2010 flow diagram for a two-group parallel randomized trial.svg'; File='Fig_A.3_CONSORT_checklist'; Note='Diagramme CONSORT pour l annexe methodologique'}
)

function Strip-Html([string]$s) { if(-not $s){return ''}; return ([regex]::Replace($s,'<[^>]+>',' ') -replace '\s+',' ').Trim() }

$rows = @()
$header = '=== Telechargement Commons - ' + (Get-Date -Format 'yyyy-MM-dd HH:mm') + ' ==='
$header | Tee-Object -FilePath $log

foreach($it in $items){
  $t = [uri]::EscapeDataString('File:' + $it.Title)
  $api = 'https://commons.wikimedia.org/w/api.php?action=query&titles=' + $t + '&prop=imageinfo&iiprop=url%7Cextmetadata&iiurlwidth=1200&format=json'
  try {
    $r = Invoke-RestMethod -Uri $api -Headers @{'User-Agent'=$ua} -TimeoutSec 40
    $page = $r.query.pages.PSObject.Properties.Value | Select-Object -First 1
    if(-not $page -or -not $page.imageinfo){
      ('MANQUE ' + $it.Id + ' introuvable: ' + $it.Title) | Tee-Object -FilePath $log -Append
      continue
    }
    $ii = $page.imageinfo[0]
    if($ii.thumburl){ $src = $ii.thumburl } else { $src = $ii.url }
    $ext = [System.IO.Path]::GetExtension(([uri]$src).AbsolutePath)
    if(-not $ext){ $ext = '.png' }
    $destDir = Join-Path $base $it.Folder
    $dest = Join-Path $destDir ($it.File + $ext)
    Invoke-WebRequest -Uri $src -OutFile $dest -Headers @{'User-Agent'=$ua} -TimeoutSec 60
    $meta = $ii.extmetadata
    $rows += [pscustomobject]@{
      ID=$it.Id
      Fichier=[System.IO.Path]::GetFileName($dest)
      Titre_Commons=$it.Title
      Auteur=(Strip-Html $meta.Artist.value)
      Licence=$meta.LicenseShortName.value
      URL_licence=$meta.LicenseUrl.value
      URL_source=$ii.descriptionurl
      Pertinence=$it.Note
      Taille_octets=(Get-Item $dest).Length
    }
    ('OK   ' + $it.Id + ' -> ' + [System.IO.Path]::GetFileName($dest) + ' [' + $meta.LicenseShortName.value + ']') | Tee-Object -FilePath $log -Append
  } catch {
    ('ERREUR ' + $it.Id + ' : ' + $_.Exception.Message) | Tee-Object -FilePath $log -Append
  }
}

$csv = Join-Path $base '00_INDEX\Images_open_access_attributions.csv'
$rows | Export-Csv -Path $csv -NoTypeInformation -Encoding UTF8
('TOTAL telecharge: ' + $rows.Count + ' sur ' + $items.Count) | Tee-Object -FilePath $log -Append
