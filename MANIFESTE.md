# Manifeste du dossier PFE_Neurodynamique

Généré le 25/11/2026. Arborescence conforme au plan final validé.

## Contenu
- 50 dossiers (front matter, 9 chapitres, annexes, dossiers bibliographiques, brouillons, données, figures, présentation).
- 124 fichiers au total (état courant) : 9 PDF valides (en-tête %PDF vérifié), pages HTML officielles, abstracts PubMed, JSON ClinicalTrials, notes de cadrage, modèles d'annexes, 22 images open access et la présentation PPTX de soutenance.
- Script de téléchargement conservé dans `06_Brouillons_redaction\_setup_pfe_neurodynamique.ps1` pour reproductibilité.

## Téléchargements réussis (principaux)
- Livres/chapitres : Noigroup (chapter summaries PDF), Elsevier/GoogleBooks/InternetArchive pages, Noigroup handbook & pack.
- Concepts : Nee & Butler 2006, Shacklock Level 3 notes, HandPT slides, nerve regeneration PDF, Brighton blog, Zac Cupples Ch7, Physiotutors wiki, Coppieters 2008 abstract.
- Reviews : JOSPT 2025, Gillot 2025, Paraskevopoulos 2022, Xu & Ling 2025 (abstract + PMC HTML), MDPI 2021 PDF.
- Trials : Rafiq 2022, PMC9725158, Butler vs Maitland PDF, EJM acute effects PDF, Salt 2016 SCIRP page, Allison 2002 abstract, ClinicalTrials NCT06663592 JSON.
- Diagnostic : diagnostic accuracy 2026 PMC, Wainner 2003 abstract, modified ULNT 2024, ULNTT biomechanics 2025.
- Pratique : BSR nerve glides, IPTA brochure, NDS home + cours upper quarter, ECU seminar, Somatic Senses.
- Céphalée cervicogénique : myodural bridge PMC, dural tube protocol, Omnicuris.

## Échecs de téléchargement (liens conservés dans 00_Liens_utiles.md)
- Thoomes 2018 PDF (403) — lien conservé.
- Salt 2016 PDF openrepository (403/522) — page SCIRP conservée.
- Kineziterapijos Klinika course page (522) — contenu similaire disponible dans ECU/NDS/Somatic Senses.
- MDPI 2021 page HTML (403) — PDF téléchargé avec succès.

## Règle de provenance
Aucun livre intégral sous droit d'auteur n'a été copié. Les ouvrages payants sont représentés par des pages officielles et des liens annotés.

## Ajout du 25/11/2026 — bibliographie par chapitre
- Nouveau dossier `05_Bibliographie\09_Biblio_par_chapitre\` : 22 fichiers répartis en Ch1, Ch2, Ch3, Ch4, Ch5, Ch8 + index.
- `00_INDEX\INDEX_Vancouver_par_chapitre.md` : 34 références Vancouver avec DOI, PMID, lien de texte intégral et chemin du fichier local.
- `00_INDEX\telechargements_log.txt` : journal complet (succès, pages Cloudflare supprimées, remplacements).
- Textes intégraux ajoutés : CPG 2025 (PMC12620902), Lopez-Pardo 2024 (PMC11203317), Rafiq 2022 × 2 (PMC9725158, PMC9556173), Borrella-Andrés 2021 (PMC8195637), Kuligowski 2021 (PMC8201115), Mallard 2022 (PMC9422871), Zanwar 2024 (PMC10949103), Geoghegan 2022 (PMC9977990), goniométrie 2024 (Springer).
- Résumés ajoutés : Shacklock 1995, Albert-Lucena 2025, Shen 2023, Koulidis 2019, Grondin 2021, Xu & Ling 2025, García-Juez 2025, épidémiologie 2020, Rafiq 2022.
- Pages Cloudflare éliminées et remplacées par des notes fiables : Shacklock 1995 (ScienceDirect), Wiley 2022 (→ PMC9556173), diagnostic accuracy 2025 (→ résumé PubMed + note).

## Ajout du 25/11/2026 — figures et tableaux
- Dossier `08_Figures_Tables\` peuplé : 11 sous-dossiers (00_INDEX, Ch1 à Ch9, Annexes). Auparavant vide et donc non suivi par Git.
- Spécification complète de 37 figures : `00_INDEX\INDEX_Figures.md` (légendes françaises, tags, relation avec le projet), `Figures_tags.csv`, `Prompts_generation_images.md`.
- 22 images open access téléchargées depuis Wikimedia Commons (licences CC BY, CC BY-SA, CC0, domaine public), signatures vérifiées, 4,5 Mo.
- Attributions obligatoires : `00_INDEX\Images_open_access_attributions.csv` et `Rapport_images_open_access.md`.
- 15 figures restent à créer, notamment 3.1/3.2 (glisseur/tensionneur) et 7.2–7.4 (résultats à partir de données réelles). La génération IA a échoué avec `Invalid credential` (16 demandes rejetées) ; les prompts sont conservés.
- Aucune figure copiée d'ouvrages sous droit d'auteur ni de supports de cours propriétaires.

## Ajout du 25/11/2026 — présentation de soutenance
- Dossier `09_Presentation\` créé avec `Presentation_PFE_Neurodynamique.pptx` (15 diapositives, 16:9, 2,7 Mo), `_build_presentation.py` et `README.md`.
- Structure inspirée du démo ZIP `stitch_neurodynamics_in_cervicalgia_pfe.zip` fourni par l'utilisateur, mais contenu réécrit pour le protocole validé du PFE (Butler/Shacklock, ECR deux groupes, 10 séances, T0/T1/T2).
- Aucune image de la démo n'a été réutilisée ; seules les images open access déjà présentes dans `08_Figures_Tables\` sont intégrées, avec crédits dans les notes orateur.
- Résultats volontairement laissés sous forme de tableau/zone graphique à compléter avec les données réelles anonymisées.

## Actions suggérées
1. Remplacer les `00_Notes_*.md` par les chapitres rédigés.
2. Déplacer/copier les documents utiles dans le dossier du chapitre qui les cite.
3. Renseigner les `Fiches_evaluation` et anonymiser les données dans `07_Donnees`.
4. Générer le diagramme CONSORT dans `04_Annexes\CONSORT`.
