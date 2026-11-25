# Présentation de soutenance — PFE Neurodynamique

## Fichier à utiliser

```text
Presentation_PFE_Neurodynamique_COMPLETE.pptx
```

- **17 diapositives**, format 16:9.
- **22 images open access** intégrées, chacune à sa place thématique.
- Crédits complets (titre, auteur, licence, URL) dans les **notes orateur** des diapositives illustrées.

L'ancien fichier `Presentation_PFE_Neurodynamique.pptx` (15 diapositives, 11 images) est conservé à titre historique. Il était verrouillé par un autre processus au moment de la régénération, donc le nouveau fichier porte le suffixe `_COMPLETE`.

## Autres fichiers

- `_build_presentation.py` — script Python reproductible (python-pptx + Pillow).
- `README.md` — ce fichier.

## Inspiration : démo ChatGPT / Stitch

Source examinée : `C:\Users\LENOVO\Downloads\stitch_neurodynamics_in_cervicalgia_pfe.zip`
(15 pages HTML `code.html`, une par diapositive).

La structure de la démo a été conservée et complétée par 2 diapositives pour loger toutes les images téléchargées.

| # | Diapo | Images intégrées | Remarque |
|---|---|---|---|
| 1 | Couverture | 1.1 | Rachis cervical |
| 2 | Contexte scientifique | 1.3, 1.4 | Radiculopathie + dermatomes |
| 3 | Problématique | — | Question centrale Butler / Shacklock |
| 4 | Hypothèses | — | H0 / H1, EVA, α = 0,05 |
| 5 | Objectifs | — | 10 séances, T0 / T1 / T2 |
| 6 | Cadre théorique | 1.2 | Racines et plexus brachial |
| 7 | Neurophysiologie | 2.1, 2.2 | Coupe de nerf + conduction saltatoire |
| 8 | Butler vs Shacklock | 3.5 | Interface foraminale (Shacklock) |
| 9 | Application clinique | 3.3, 3.4, 4.1 | Médian / 3 nerfs / examen clinique |
| 10 | Matériel et méthodes | 5.1, 5.2, 5.3 | CONSORT, goniomètre, EVA |
| 11 | Protocole — progression | 4.2 | Frise S1–S10 et 3 phases |
| 12 | Protocole — repères anatomiques | 6.1, 6.2, 6.3, 6.4 | Médian, radial, ulnaire, scène clinique |
| 13 | Résultats | 7.1 | Tableau à compléter + modèle CONSORT |
| 14 | Discussion | 8.1, 8.2 | Hiérarchie et niveaux de preuve |
| 15 | Conclusion | — | Trois messages cliniques |
| 16 | Remerciements | — | Contact et encadrement à compléter |
| 17 | Annexe CONSORT | A.3 | Diagramme à adapter aux effectifs réels |

## Choix importants

- **Aucune image intégrée de la démo Stitch n'a été réutilisée** : son origine/licence n'était pas documentée.
- Toutes les illustrations proviennent de `08_Figures_Tables/` et sont créditées dans les notes orateur.
- Les figures 6.1–6.4 et 4.2 sont des **repères anatomiques ou scènes génériques**, pas des démonstrations techniques.
- Les champs `[Nom et prénom]`, `[Directeur de mémoire]`, `[à saisir]`, `[Δ / p]` et les pourcentages de prévalence restent à compléter.
- Aucune donnée clinique n'a été inventée.

## Régénération

```powershell
& 'C:\Users\LENOVO\AppData\Local\Programs\Python\Python312\python.exe' `
  'C:\Users\LENOVO\Documents\PFE\PFE_Neurodynamique\09_Presentation\_build_presentation.py'
```

Dépendances : `python-pptx` et `Pillow` (déjà installées sur cette machine).

## Vérification effectuée

- 17 diapositives générées sans erreur.
- **22 / 22 images** présentes dans le fichier.
- Notes orateur présentes sur toutes les diapositives illustrées.
- Taille du fichier : environ 3,8 Mo.
