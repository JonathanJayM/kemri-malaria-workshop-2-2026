## PFDHFR–Pyrimethamine Molecular Docking Workshop

## Python-Based Structure-Guided Drug Discovery Workflow

This repository contains the practical workflow used in a molecular docking workshop to investigate the interaction of **pyrimethamine** with **Plasmodium falciparum dihydrofolate reductase (PfDHFR)**.

The workshop follows a complete computational workflow, beginning with the biological target and ligand acquisition and progressing through ligand modification, molecular docking, and protein–ligand interaction fingerprint (PLIF) analysis.

The workflow was implemented primarily in **Python**.


### Workshop Objective

The objective of this practical is to demonstrate how computational drug-discovery tools can be combined into a reproducible Python workflow to investigate ligand binding to a protein target.

The workflow compares pyrimethamine docking against:

* **Wild-type PfDHFR — PDB: 3QGT**
* **Mutant PfDHFR — PDB: 1J3J**

The resulting docking poses are subsequently analyzed using **Protein–Ligand Interaction Fingerprints (PLIFs)**.

---

# Overall Workflow

```text
PfDHFR Biological Target
          │
          ▼
   Protein Structures
      3QGT / 1J3J
          │
          ▼
   Receptor Preparation
          │
          │
          └──────────────────┐
                             │
Pyrimethamine                │
    │                        │
    ▼                        │
   PubChem                   │
    │                        │
    ▼                        │
    RDKit                    │
    │                        │
    ▼                        │
Ligand Modification         │
    │                        │
    ▼                        │
Ligand Preparation           │
    │                        │
    └──────────────┬─────────┘
                   ▼
            Molecular Docking
                   │
          ┌────────┴────────┐
          ▼                 ▼
       WT 3QGT           Mutant 1J3J
          │                 │
          └────────┬────────┘
                   ▼
             Docking Poses
                   │
                   ▼
              PLIF Analysis
                   │
                   ▼
        2D Interaction Maps
                   │
                   ▼
       Comparative Interpretation
```

---

## 1. Biological Target — PfDHFR

The workshop begins with the **PFDHFR gene**, which encodes the *Plasmodium falciparum* dihydrofolate reductase (PfDHFR) target.

PfDHFR is an important antimalarial drug target because it participates in folate metabolism and nucleotide biosynthesis.

The workflow uses protein structures representing different PfDHFR states to investigate how pyrimethamine interacts with the target.

---

## 2. Protein Structures

Two receptor structures are investigated:

| Structure | Role             |
| --------- | ---------------- |
| **3QGT**  | Wild-type PfDHFR |
| **1J3J**  | Mutant PfDHFR    |

The structures are prepared independently before docking.

Typical receptor preparation includes:

* Structure inspection
* Removal of unwanted molecules where appropriate
* Hydrogen addition
* Atom/charge preparation
* Structure validation
* Conversion into a docking-compatible representation

### Important principle

The **wild-type and mutant receptors must remain separate throughout the workflow**.

Each receptor is independently prepared and docked with the ligand.

---

## 3. Obtaining Pyrimethamine

The ligand used in this workshop is **pyrimethamine**.

The compound structure is obtained from **PubChem** and imported into the Python workflow.

The ligand can initially be represented using a standard chemical structure format such as:

```text
SDF
```

The structure is then processed using **RDKit**.

---

## 4. Ligand Modification Using RDKit

RDKit is used to manipulate and prepare the pyrimethamine structure programmatically.

The workflow demonstrates how Python can be used to:

* Load the ligand
* Inspect molecular properties
* Modify the molecular structure
* Generate molecular representations
* Add/handle hydrogens
* Generate 3D coordinates where required
* Prepare the ligand for subsequent docking

The exact modification applied during the workshop is retained in the corresponding notebook/script.

---

## 5. Ligand Preparation for Docking

After modification, the ligand is converted into a docking-compatible representation.

The preparation stage ensures that the ligand contains the required:

* Atomic coordinates
* Hydrogen atoms
* Bond information
* Partial charges
* Atom types
* Rotatable-bond information

The prepared ligand is then used for docking against both receptor structures.

```text
Pyrimethamine
      │
      ▼
    RDKit
      │
      ▼
Modified ligand
      │
      ▼
Ligand preparation
      │
      ▼
Docking-ready ligand
```

---

## 6. Receptor Preparation

The two protein structures are prepared independently.

```text
3QGT
 │
 └──► Wild-type receptor ──► Docking

1J3J
 │
 └──► Mutant receptor ─────► Docking
```

This allows the docking results to be compared between the wild-type and mutant systems.

---

## 7. Molecular Docking

The prepared pyrimethamine ligand is docked against both receptor structures.

### Wild-type

```text
3QGT + pyrimethamine
        ↓
     Docking
        ↓
   WT docking poses
```

### Mutant

```text
1J3J + pyrimethamine
        ↓
     Docking
        ↓
 Mutant docking poses
```

The docking stage produces multiple possible ligand poses, which can subsequently be ranked and analyzed.

---

## 8. Docking Pose Analysis

Docking results should not be interpreted from the docking score alone.

For each system, examine:

* Docking affinity/score
* Binding pose
* Ligand orientation
* Binding-site location
* Hydrogen-bond interactions
* Hydrophobic interactions
* Residue contacts
* Differences between wild-type and mutant receptors

A useful comparison is:

| Feature                 | Wild-type 3QGT | Mutant 1J3J |
| ----------------------- | -------------- | ----------- |
| Docking score           | —              | —           |
| Binding pose            | —              | —           |
| H-bond interactions     | —              | —           |
| Hydrophobic contacts    | —              | —           |
| Key residues            | —              | —           |
| Interaction differences | —              | —           |

---

## 9. Protein–Ligand Interaction Fingerprints (PLIF)

Following docking, the predicted complexes are analyzed using **Protein–Ligand Interaction Fingerprints (PLIFs)**.

PLIF analysis converts the 3D protein–ligand interaction pattern into a representation that can be compared between docking poses or different protein systems.

The analysis can identify interactions such as:

* Hydrogen bonds
* Hydrophobic interactions
* π-interactions
* Ionic interactions
* Other protein–ligand contacts

---

Visualization
```
# Repository Structure

```text
pfdhfr-pyrimethamine-docking/
│
├── README.md
│
├── data/
│   ├── protein/
│   │   ├── 3QGT.pdb
│   │   └── 1J3J.pdb
│   │
│   └── ligand/
│       ├── pyrimethamine.sdf
│       └── pyrimethamine_modified.sdf
│
├── notebooks/
│   ├── 01_pfdhfr_introduction.ipynb
│   ├── 02_rdkit_ligand_modification.ipynb
│   ├── 03_molecule preparation
│   ├── 04_docking.ipynb
│   └── 05_plif_analysis.ipynb
│
```

---

# Tools & Technologies

| Tool                 | Application                             |
| -------------------- | --------------------------------------- |
| **Python**           | Workflow automation and analysis        |
| **RDKit**            | Cheminformatics and ligand manipulation |
| **PubChem**          | Ligand structure acquisition            |
| **AutoDock Vina**    | Molecular docking                       |
| **PLIF**             | Protein–ligand interaction analysis     |
| **PyMOL / ChimeraX** | Optional structural inspection          |

---

# Getting Started

Clone the repository:

```bash
cd Desktop
git clone https://github.com/petermargaret/kemri-malaria-workshop-2-2026.git
cd kemri-malaria-workshop-2-2026
```
Create a Python environment:

```bash
conda deactivate
conda create -n vina python=3.12
conda activate vina
```

Install the required Python packages:

```bash
pip install rdkit nglview meeko MDAnalysis plip jupyter lab
```

Run the notebooks sequentially:

```text
01 → 02 → 03 → 04 → 05
```

---

### Learning Outcomes

After completing the workshop, participants should be able to:

* Explain the biological relevance of PfDHFR as a drug target
* Obtain molecular structures from public databases
* Manipulate ligands using RDKit
* Prepare ligands for molecular docking
* Prepare protein receptors
* Perform docking against wild-type and mutant receptors
* Analyze docking poses
* Identify protein–ligand interactions
* Generate 2D interaction maps using PLIF
* Compare ligand interactions between different receptor structures
* Build reproducible Python-based drug-discovery workflows

---

# Key Concept

The workshop demonstrates the transition from:

**Biological target → Chemical structure → Molecular modification → Docking → Interaction analysis**

rather than treating molecular docking as an isolated step.

```text

```
## Reproducibility

All computational steps are designed to be reproducible through Python scripts and Jupyter notebooks.

The repository provides the computational workflow used during the workshop so that participants can reproduce the analysis and subsequently adapt the workflow to other:

* Protein targets
* Ligands
* Mutations
* Binding pockets
* Docking experiments

---

## ⚠️ Interpretation

Molecular docking provides **computational predictions** of possible binding modes and relative docking scores. Docking results should not be interpreted as direct experimental measurements of binding affinity or biological activity.

Experimental validation and additional computational analyses may be required to establish the biological significance of predicted interactions.

---

## Workshop Theme

> **From Gene to Molecular Interaction**

**PfDHFR → Pyrimethamine → RDKit → Docking → PLIF**

A reproducible Python workflow for introducing computational drug discovery and structure-based ligand analysis.
