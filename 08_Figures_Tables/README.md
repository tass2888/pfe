# 08_Figures_Tables — Figures et tableaux du mémoire

Ce dossier accueille les **37 figures prévues** par le plan d'illustration du PFE
« Place de la mobilisation neurodynamique selon Butler et Shacklock dans la
prise en charge kinésithérapique de la cervicalgie avec composante neurodynamique ».

## État actuel

**22 images open access téléchargées** (Wikimedia Commons, licences libres) sur
37 figures prévues, avec attributions complètes. **15 figures restent à créer**.

Le service de génération d'images a rejeté les 16 premières demandes avec
`Invalid credential` ; les prompts sont néanmoins conservés dans
`00_INDEX/Prompts_generation_images.md`.

- Bilan détaillé figure par figure : `00_INDEX/Rapport_images_open_access.md`
- Attributions / licences : `00_INDEX/Images_open_access_attributions.csv`
- Journal de téléchargement : `00_INDEX/telechargement_images_log.txt`
- Script reproductible : `../06_Brouillons_redaction/_download_commons_images.ps1`

⚠️ Plusieurs images sont des **illustrations de soutien partiel** (anatomie ou
scène générique), pas la démonstration exacte du geste. Les figures 3.1 et 3.2
(glisseur / tensionneur) et 7.2–7.4 (résultats réels) sont particulièrement
importantes à produire.

## Contenu

```
08_Figures_Tables/
├── 00_INDEX/
│   ├── INDEX_Figures.md              ← 37 figures : légendes, tags, lien avec le projet
│   ├── Prompts_generation_images.md  ← prompts complets + style commun
│   ├── Figures_tags.csv              ← table importable (Excel) avec tags et relations
│   ├── Rapport_images_open_access.md ← bilan : 22 images, 15 manquantes, licences
│   ├── Images_open_access_attributions.csv ← auteur / licence / URL source
│   └── telechargement_images_log.txt ← journal des téléchargements
├── Ch1_Cervicalgie/                  (4 figures)
├── Ch2_Neurophysiologie/             (4 figures)
├── Ch3_Butler_Shacklock/             (5 figures — chapitre prioritaire)
├── Ch4_Application_clinique/         (3 figures)
├── Ch5_Materiel_methodes/            (4 figures)
├── Ch6_Protocole_reeducation/        (5 figures)
├── Ch7_Resultats/                    (4 modèles — données réelles obligatoires)
├── Ch8_Discussion/                   (3 figures)
├── Ch9_Conclusion/                   (2 figures)
└── Annexes/                          (3 figures)
```

## Règles

1. **Convention de nommage** : `Fig_<chapitre>.<numéro>_<nom_court>.png`.
2. **Ch7 ne contient jamais de résultats inventés.** Les quatre modèles doivent
   être remplacés par des graphiques issus des données anonymisées réelles.
3. **Aucune figure copiée** des ouvrages Butler/Shacklock, diaporamas de cours
   propriétaires ou questionnaires sous licence (NDI compris).
4. **Validation** : faire vérifier les schémas anatomiques et les positions de
   tests par le directeur de mémoire avant insertion définitive.
5. **Légende + source** : chaque figure insérée dans le mémoire doit avoir une
   légende numérotée et, si elle s'inspire d'une source, la citation correspondante.
