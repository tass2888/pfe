# Index des figures — PFE Neurodynamique (Butler & Shacklock)

**Dossier :** `08_Figures_Tables/`
**Date :** 25 novembre 2026
**Statut global :** ⚠️ **Spécification complète, images non générées.** Le service de génération d'images a refusé les 16 premières demandes avec `Invalid credential` (identifiant du fournisseur d'images invalide sur cette machine). Aucun fichier image n'a donc été écrit. Relire `Prompts_generation_images.md` pour regenerer des que l'acces image est rétabli.

## Conventions

- **Nom de fichier :** `Fig_<chapitre>.<numero>_<nom_court>.png` (ex. `Fig_3.1_Glisseur_neural.png`).
- **Style imposé :** illustration médicale vectorielle 2D, fond blanc, palette clinique sobre, étiquettes françaises courtes, pas de photorealisme. Voir le style commun dans `Prompts_generation_images.md`.
- **Tags :** mots-clés entre `#` dans la colonne `Tags`, repris dans `Figures_tags.csv` (importable Excel).
- **Statut :** `À générer` | `Modèle — données réelles requises` (chapitre 7 uniquement ; aucune donnée patient inventée).
- **Règle éthique :** ne pas copier de figures entières des ouvrages Butler/Shacklock ni des supports de cours propriétaires. Toute figure doit être originale et citee si elle s'inspire d'une source.

---

## Partie I — Cadre théorique

### Chapitre 1 — Cervicalgie (`Ch1_Cervicalgie/`)

| ID | Fichier prévu | Légende française | Tags | Relation avec le projet | Statut |
|---|---|---|---|---|---|
| 1.1 | `Fig_1.1_Anatomie_rachis_cervical.png` | Anatomie du rachis cervical : C1–C7, disques, facettes et lordose. | `#Ch1 #Anatomie #RachisCervical #C1C7 #Lordose` | Cadre anatomique de la cervicalgie ; situe les structures à l'origine de la douleur. | À générer |
| 1.2 | `Fig_1.2_Racines_plexus_brachial.png` | Racines C5–T1, foramens et plexus brachial. | `#Ch1 #Anatomie #Racines #PlexusBrachial #C5T1` | Explique l'irradiation des symptômes cervicalges vers le membre supérieur. | À générer |
| 1.3 | `Fig_1.3_Radiculopathie_cervicale.png` | Comparaison racine normale / racine comprimée ou irritée. | `#Ch1 #Pathologie #Radiculopathie #Compression #DiagnosticDifferentiel` | Soutient la distinction entre cervicalgie commune et cervicalgie avec composante neurodynamique (critère d'inclusion). | À générer |
| 1.4 | `Fig_1.4_Dermatomes_C5_T1.png` | Dermatomes C5 à T1 du membre supérieur. | `#Ch1 #Anatomie #Dermatomes #ExamenNeurologique` | Aide à l'examen neurologique standardisé décrit en Ch5. | À générer |

### Chapitre 2 — Neurophysiologie (`Ch2_Neurophysiologie/`)

| ID | Fichier prévu | Légende française | Tags | Relation avec le projet | Statut |
|---|---|---|---|---|---|
| 2.1 | `Fig_2.1_Structure_nerf_peripherique.png` | Coupe d'un nerf périphérique : épinèvre, périnèvre, endonèvre, fascicules, axones. | `#Ch2 #Neurophysiologie #NerfPeripherique #Epinevre #Perinevre #Endonevre` | Support anatomique des mécanismes de contrainte nerveuse de Butler/Shacklock. | À générer |
| 2.2 | `Fig_2.2_Physiologie_nerveuse.png` | Myéline, nœuds de Ranvier, conduction saltatoire et transport axonal. | `#Ch2 #Myeline #Conduction #TransportAxonal` | Explique pourquoi allongement et compression modifient la fonction neurale. | À générer |
| 2.3 | `Fig_2.3_Circulation_intraneurale.png` | Vasa nervorum et microcirculation intraneurale. | `#Ch2 #VasaNervorum #Microcirculation #Ischemie` | Lien entre charge mécanique, microcirculation et symptômes. | À générer |
| 2.4 | `Fig_2.4_Mecanosensibilite_neurale.png` | Glissement, allongement, compression et charge mécanique accrue. | `#Ch2 #Mecanosensibilite #Glissement #Elongation #Compression` | Fondement scientifique direct de la mobilisation neurodynamique. | À générer |

### Chapitre 3 — Butler & Shacklock (`Ch3_Butler_Shacklock/`) — **chapitre prioritaire**

| ID | Fichier prévu | Légende française | Tags | Relation avec le projet | Statut |
|---|---|---|---|---|---|
| 3.1 | `Fig_3.1_Glisseur_neural.png` | Glisseur neural : mouvements opposés des articulations, excursion du nerf à faible contrainte. | `#Ch3 #Butler #Slider #Glisseur #ExcursionNeurale` | Définit visuellement la technique expérimentale du protocole (Ch6). **À rendre très claire.** | À générer |
| 3.2 | `Fig_3.2_Tenseur_neural.png` | Tenseur neural : allongement simultané aux deux extrémités, contrainte accrue. | `#Ch3 #Butler #Tensioner #Tenseur #Contrainte` | Définit la progression vers les tenseurs et ses précautions (Ch6). **À opposer visuellement à 3.1.** | À générer |
| 3.3 | `Fig_3.3_ULNT1_median.png` | ULNT1 du nerf médian : abduction, supination, extension du poignet/doigts, extension du coude. | `#Ch3 #ULNT1 #Median #TestNeurodynamique #Shacklock` | Test utilisé comme critère d'inclusion et critère d'évaluation (Ch5, annexe fiche). | À générer |
| 3.4 | `Fig_3.4_Tests_median_radial_ulnaire.png` | Tests neurodynamiques médian (ULNT1), radial (ULNT2), ulnaire (ULNT3). | `#Ch3 #ULNT #Median #Radial #Ulnaire` | Standardise les tests pour l'évaluateur aveugle. | À générer |
| 3.5 | `Fig_3.5_Interface_mecanique_Shacklock.png` | Interface mécanique de Shacklock : ouverture/fermeture foraminale et contrainte nerveuse. | `#Ch3 #Shacklock #InterfaceMecanique #Foramen` | Cadre conceptuel central du mémoire ; relie position cervicale et contrainte nerveuse. | À générer |

### Chapitre 4 — Application clinique (`Ch4_Application_clinique/`)

| ID | Fichier prévu | Légende française | Tags | Relation avec le projet | Statut |
|---|---|---|---|---|---|
| 4.1 | `Fig_4.1_Examen_clinique.png` | Kinésithérapeute réalisant un test neurodynamique du membre supérieur. | `#Ch4 #ExamenClinique #Neurodynamique #Pratique` | Illustre la passation réelle des tests. | À générer |
| 4.2 | `Fig_4.2_Glissement_lateral_cervical.png` | Glissement latéral cervical : position du thérapeute et direction du mouvement. | `#Ch4 #Technique #GlissementLateral #Cervicale` | Technique conventionnelle administrée dans les deux groupes (contrôle). | À générer |
| 4.3 | `Fig_4.3_Algorithme_decisionnel.png` | Algorithme : évaluation → diagnostic différentiel → tests → choix du traitement → réévaluation. | `#Ch4 #Algorithme #DecisionClinique #SelectionPatients` | Traduit la restriction d'inclusion aux cervicalgies avec composante neurodynamique. | À générer |

---

## Partie II — Étude pratique

### Chapitre 5 — Matériel et méthodes (`Ch5_Materiel_methodes/`)

| ID | Fichier prévu | Légende française | Tags | Relation avec le projet | Statut |
|---|---|---|---|---|---|
| 5.1 | `Fig_5.1_Design_etude.png` | Deux groupes parallèles : kiné conventionnelle vs kiné + mobilisation neurodynamique. | `#Ch5 #Methodologie #ECR #DeuxGroupes #CONSORT` | Schéma directeur de l'étude contrôlée randomisée. | À générer |
| 5.2 | `Fig_5.2_Mesure_AMC_cervicale.png` | Mesure de l'amplitude cervicale par inclinomètre. | `#Ch5 #Mesure #Inclinometre #ROM` | Critère de jugement secondaire : mobilité cervicale. | À générer |
| 5.3 | `Fig_5.3_Evaluation_douleur_EVA.png` | Évaluation de la douleur par échelle visuelle analogique. | `#Ch5 #Mesure #EVA #Douleur` | Critère de jugement principal : douleur. | À générer |
| 5.4 | `Fig_5.4_Procedures_ULNT.png` | Procédure ULNT standardisée : positions et variables mesurées. | `#Ch5 #Mesure #ULNT #Standardisation` | Reproductibilité du test par évaluateur aveugle. | À générer |

### Chapitre 6 — Protocole de rééducation (`Ch6_Protocole_reeducation/`)

| ID | Fichier prévu | Légende française | Tags | Relation avec le projet | Statut |
|---|---|---|---|---|---|
| 6.1 | `Fig_6.1_Glisseur_median.png` | Glisseur du nerf médian, étapes 1 à 3. | `#Ch6 #Protocole #Slider #Median #Seance` | Intervention expérimentale concrète (S1–S3). | À générer |
| 6.2 | `Fig_6.2_Mobilisation_radial.png` | Mobilisation du nerf radial : positionnement et séquence. | `#Ch6 #Protocole #Radial #Mobilisation` | Variante de progression du protocole. | À générer |
| 6.3 | `Fig_6.3_Mobilisation_ulnaire.png` | Mobilisation du nerf ulnaire : épaule, coude, poignet. | `#Ch6 #Protocole #Ulnaire #Mobilisation` | Variante de progression du protocole. | À générer |
| 6.4 | `Fig_6.4_Glissement_lateral_technique.png` | Glissement latéral cervical : mains du thérapeute, direction, position patient. | `#Ch6 #Protocole #GlissementLateral #Therapeute` | Traitement commun aux deux groupes. | À générer |
| 6.5 | `Fig_6.5_Progression_5_semaines.png` | Progression S1–S10 sur 5 semaines (2 séances/semaine). | `#Ch6 #Protocole #Progression #S1S10 #5Semaines` | Plan de traitement : 10 séances, progression selon irritabilité et réponse symptomatique. | À générer |

### Chapitre 7 — Résultats (`Ch7_Resultats/`) — **données réelles obligatoires**

| ID | Fichier prévu | Légende française | Tags | Relation avec le projet | Statut |
|---|---|---|---|---|---|
| 7.1 | `Fig_7.1_CONSORT_flow.png` | Diagramme de flux CONSORT des participants. | `#Ch7 #Resultats #CONSORT #Flowchart #MODELE` | Modèle à remplir avec le recrutement réel. | Modèle — données réelles requises |
| 7.2 | `Fig_7.2_Evolution_EVA.png` | Évolution de l'EVA entre T0, T1 et T2. | `#Ch7 #Resultats #EVA #T0T1T2 #MODELE` | Graphique à générer à partir des données réelles. **Aucune donnée inventée.** | Modèle — données réelles requises |
| 7.3 | `Fig_7.3_Evolution_NDI.png` | Évolution du NDI entre les deux groupes. | `#Ch7 #Resultats #NDI #MODELE` | Graphique à générer à partir des données réelles. | Modèle — données réelles requises |
| 7.4 | `Fig_7.4_AMC_ULNT.png` | Comparaison amplitude cervicale et ULNT. | `#Ch7 #Resultats #ROM #ULNT #MODELE` | Graphique à générer à partir des données réelles. | Modèle — données réelles requises |

---

## Partie III — Discussion et conclusion

### Chapitre 8 — Discussion (`Ch8_Discussion/`)

| ID | Fichier prévu | Légende française | Tags | Relation avec le projet | Statut |
|---|---|---|---|---|---|
| 8.1 | `Fig_8.1_Comparaison_preuves.png` | Techniques Butler/Shacklock vs kinésithérapie conventionnelle dans la littérature. | `#Ch8 #Discussion #Evidence #ButlerShacklock #Conventionnel` | Compare les résultats de l'étude aux revues systématiques de la bibliographie. | À générer |
| 8.2 | `Fig_8.2_Synthese_certitude_GRADE.png` | Synthèse des preuves et niveau de certitude (GRADE). | `#Ch8 #Discussion #GRADE #Certitude #Revue` | Cadre l'interprétation prudente des bénéfices surtout à court terme. | À générer |
| 8.3 | `Fig_8.3_Mecanisme_propose.png` | Excursion neurale → interfaces mécaniques → symptômes → fonction. | `#Ch8 #Discussion #Mecanisme #ExcursionNeurale #Fonction` | Relie les résultats au cadre conceptuel de Butler/Shacklock. | À générer |

### Chapitre 9 — Conclusion (`Ch9_Conclusion/`)

| ID | Fichier prévu | Légende française | Tags | Relation avec le projet | Statut |
|---|---|---|---|---|---|
| 9.1 | `Fig_9.1_Graphical_abstract.png` | Résumé graphique : question, intervention, comparateur, principaux résultats. | `#Ch9 #Conclusion #GraphicalAbstract` | Synthèse visuelle de la question de recherche. | À générer |
| 9.2 | `Fig_9.2_Algorithme_pratique.png` | Algorithme de pratique clinique : sélection, progression, réévaluation. | `#Ch9 #Conclusion #Algorithme #PratiqueClinique` | Recommandation finale pour la pratique kinésithérapique. | À générer |

---

## Annexes (`Annexes/`)

| ID | Fichier prévu | Légende française | Tags | Relation avec le projet | Statut |
|---|---|---|---|---|---|
| A.1 | `Fig_A.1_Fiche_evaluation_vierge.png` | Maquette vierge de la fiche d'évaluation patient. | `#Annexes #FicheEvaluation #Vierge #T0T1T2` | Correspond à `04_Annexes/Fiches_evaluation/00_Fiche_evaluation.md`. | À générer |
| A.2 | `Fig_A.2_Tableau_10_seances.png` | Tableau récapitulatif des 10 séances avec mini-illustrations. | `#Annexes #Protocole #10Seances #Illustrations` | Annexe récapitulative du protocole du Ch6. | À générer |
| A.3 | `Fig_A.3_CONSORT_checklist.png` | Checklist CONSORT et diagramme de flux. | `#Annexes #CONSORT #Checklist` | Annexe méthodologique pour la soumission. | À générer |

---

## Total

**37 figures prévues** : Ch1 (4) + Ch2 (4) + Ch3 (5) + Ch4 (3) + Ch5 (4) + Ch6 (5) + Ch7 (4 modèles) + Ch8 (3) + Ch9 (2) + Annexes (3).

### Points de vigilance

- **Ch3 et Ch6 sont prioritaires** : l'examinateur doit comprendre immédiatement la différence glisseur/tensionneur et l'application clinique.
- **Ch7 ne doit jamais contenir de résultats fictifs.** Remplacer les 4 modèles par des graphiques issus des données anonymisées réelles.
- **Droits d'auteur** : illustres originalement ; ne pas intégrer de figures copiées des livres Butler/Shacklock, diaporamas de formation ou questionnaires propriétaires (NDI inclus).
- **Vérification scientifique** : faire valider les schémas anatomiques et les positions de tests par le directeur de mémoire avant insertion définitive.
