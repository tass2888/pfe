# Présentation de soutenance — PFE Neurodynamique

## Fichiers

- `Presentation_PFE_Neurodynamique.pptx` — diaporama final, **15 diapositives**, format 16:9.
- `_build_presentation.py` — script Python reproductible (python-pptx + Pillow).
- `README.md` — ce fichier.

## Inspiration : démo ChatGPT / Stitch

Source examinée : `C:\Users\LENOVO\Downloads\stitch_neurodynamics_in_cervicalgia_pfe.zip`
(15 pages HTML `code.html`, une par diapositive).

La structure de la démo a été conservée :

| # | Diapo de la démo | Diapo générée | Adaptation apportée |
|---|---|---|---|
| 1 | Couverture | Couverture | Titre exact du mémoire, ECR annoncé, image cervicale open access |
| 2 | Contexte scientifique | Contexte scientifique | Prévalence laissée à renseigner, pas de chiffre inventé |
| 3 | Problématique | Problématique | Question formulée autour de Butler / Shacklock et de la population ciblée |
| 4 | Hypothèses | Hypothèses | H0 / H1, EVA comme critère principal, α = 0,05 |
| 5 | Objectifs | Objectifs | 10 séances, T0 / T1 / T2, NDI en version française validée |
| 6 | Cadre théorique | Cadre théorique | Chapitres Ch1–Ch4 du PFE, plexus brachial en image |
| 7 | Neurophysiologie | Neurophysiologie & biomécanique neurale | Coupe de nerf et conduction saltatoire |
| 8 | Butler vs Shacklock | Butler vs Shacklock | Slider / tensioneur explicitement définis |
| 9 | Application clinique | Application clinique | ULNT1/2/3, différenciation structurelle, règle d'interprétation |
| 10 | Matériel et méthodes | Matériel et méthodes | ECR deux groupes, effectif indicatif, critères de jugement |
| 11 | Protocole | Protocole de rééducation | Frise S1–S10 et 3 phases thérapeutiques |
| 12 | Résultats | Résultats | Tableau et zone graphique **sans données inventées** |
| 13 | Discussion | Discussion | Niveaux de preuve et limites méthodologiques |
| 14 | Conclusion | Conclusion | Trois messages cliniques, conclusion à valider selon résultats |
| 15 | Remerciements | Remerciements | Contact et encadrement à compléter |

## Choix importants

- **Aucune image intégrée de la démo Stitch n'a été réutilisée** : son origine/licence n'était pas documentée.
- Les illustrations viennent exclusivement du dossier `08_Figures_Tables/` et sont accompagnées de leurs crédits complets dans les **notes orateur** des diapositives concernées.
- Le tableau d'attributions détaillé reste dans `08_Figures_Tables/00_INDEX/Images_open_access_attributions.csv`.
- Les champs `[Nom et prénom]`, `[Directeur de mémoire]`, `[à saisir]`, `[Δ / p]` et les pourcentages de prévalence sont des **emplacements à compléter** avant la soutenance.
- Les figures 7.2–7.4 du rapport (résultats EVA / NDI / amplitudes) ne sont pas pré-remplies : les données réelles anonymisées sont requises.

## Régénération

```powershell
& 'C:\Users\LENOVO\AppData\Local\Programs\Python\Python312\python.exe' `
  'C:\Users\LENOVO\Documents\PFE\PFE_Neurodynamique\09_Presentation\_build_presentation.py'
```

Dépendances : `python-pptx` et `Pillow` (déjà installées sur cette machine).

## Vérification effectuée

- 15 diapositives générées sans erreur.
- 11 images intégrées à partir des fichiers open access du projet.
- Notes orateur présentes sur toutes les diapositives illustrées.
- Taille du fichier : environ 2,7 Mo.
