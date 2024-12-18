# EVOLUTION OF SARS-CoV-2 VARIANTS IN GEOGRAPHIC LOCATIONS WITH VARYING CASE INCIDENCE

## Claire Fraser - Master's Thesis Project

### Manuscript: [ClaireFraser_MSMicrobiologyThesis2022.pdf](https://github.com/fraserclaire/SARS-CoV-2_evolutionaryAnalysis/blob/main/ClaireFraser_MSMicrobiologyThesis2022.pdf)

**Please see acknowledgements listed in Manuscript**

Steps below describe process for one locality-variant scenario (B.1.1.7 in the State of Hawai'i). 
Additional scenarios included: 
- B.1.243 in Hawai'i
- B.1.1.7 in LA County
- B.1.243 in LA County

_Modify below file names to access data for alternative scenarios._

1. **Sequence Selection**: 
   - Summary: "sequence_counts.csv"

   A) **GISAID**:
      - Locality, Variant
      - FASTAs and Metadata: `hi_b117_allseq.tar`

   B) **Nextstrain**: >27,000 bp
      - Input: 
        - `hi_b117_allseq.yaml`
        - `hi_b117_allseq.tar`
      - Output: 
        - `/fasta/hi_b117/hi_b117.nwk`

2. **Substitution Rate and Effective Reproduction Number (Rt) Estimation**
   
   A) Generate updated fasta and tree files, and table with collection dates
      - Script: "file_cleanup.R"
      - Input: 
        - `/fasta/hi_b117/hi_b117.fasta`
        - `/fasta/hi_b117/hi_b117.nwk`
        - `/fasta/hi_b117/hi_b117_allseq.csv`
      - Output: 
        - `/fasta/hi_b117/hi_b117_cleaned.fasta`
        - `hi_b117_updated.nwk`
        - `/fasta/hi_b117/hi_b117.txt`

   B) **BEAUti 2**: 
      - Make .xml file for BEAST
      - Fixed starting tree, 200M generations, Gamma=4, HKY, Strict clock, Birth Death Skyline Serial, clock.Rate (log normal distribution, mean=0.00135, Mean in Real Space)
      - Set operator weight to 0 for tree elements (see [BEAST2 fix starting tree](https://www.beast2.org/fix-starting-tree/))
      - Include starting tree in newick format, all other settings default
      - Manually input starting date for reference (Wuhan; "12/31/2019")
      - Input: `/fasta/hi_b117/hi_b117.xml`, `/fasta/hi_b117/beast.slurm`
      - Output log files: `/fasta/hi_b117/run0/hi_b117_cleaned.log`, `/fasta/hi_b117/run1/hi_b117_cleaned.log`

   C) Average substitution rates from BEAST runs:
      - Open the log file in Tracer software
      - The substitution rates are listed in the table of estimated means under "clockRate"
      - Calculate the average for the 2 runs, copy to a new spreadsheet ("beastrates.csv")
      - Generate a bar plot to visualize results
      - Script: "substitution_plot.R"
      - Input: `/substitution/beastrates.csv`
      - Output: `/substitution/subrates.pdf`

   D) Generate Rt plots:
      - Read in the log files to generate a table with Rt values
      - Replace time values with dates
      - Read in csv with variant from both localities and generate plot
      - Script: "Rt_analysis.R"
      - Input: `/fasta/hi_b117/hi_b117_cleaned.log`, `/reproduction/b117_rt.csv`
      - Output: `/reproduction/b117_both.pdf`

3. **Division into 2 bins**
   
   A) Generate a table with counts for each day
      - Open table with collection dates, assign a number to each date (make sure dates without cases also have numbers)
      - Make a new table with counts (e.g., if 1/1/2020 is day 3 and has 2 cases, then the number 3 would be present twice)
      - Use output table for next step: `/kdp/hi_b117_counts.csv`

   B) Kernel Density Plots:
      - Identify point where case counts peak and divide sequences based on collection date
      - Script: "kerneldensityplot.R"
      - Output: `/kdp/kdp_B117_hi.pdf`

   C) Prune trees:
      - Use date identified in previous step to divide samples into 2 groups (pull list of names from metadata spreadsheet "hi_b117_allseq.tsv" and save to new text file "hi_b117_expo.txt")
      - Generate new trees and FASTA with only samples from either expo or waning phase
      - Script: "treepruning.R"
      - Input: `/trees/hi_b117.nwk`, `/trees/hi_b117_expo.txt`
      - Output: `/trees/prunedtrees/hi_b117_expo.nwk`, `/updatedfasta/hi_b117_expo_updated.fasta`

4. **Selection Analyses**
   
   A) Trim sequences for each bin:
      - Open alignment in Mesquite
      - Trim 3' end first, make sure to also trim off the stop codon
      - Then trim to right before the start codon
      - 1) **ORF1a**: 266-13483
      - 2) **S**: 21563-25384
      - 3) **ORF7a**: 27394-27759
      - Input: `/updatedfasta/hi_b117_expo_updated.fasta`
      - Output: `/updatedfasta/hi_b117_expo_orf1a.fasta`, `/updatedfasta/hi_b117_expo_spike.fasta`, `/updatedfasta/hi_b117_expo_orf7a.fasta`

   B) Generate .fna files for selection analysis input:
      - .fna files contain the FASTA and phylogeny
      - Same input file is used for FUBAR, MEME, FEL
      - Input: `/updatedfasta/hi_b117_expo_updated.fasta`, `/trees/hi_b117_expo.nwk`
      - Output: `/updatedfasta/hi_b117_expo/hi_b117_expo.fna`

   C) Run FUBAR, MEME, FEL analyses on Hyphy:
      - Default settings used
      - Input: `/updatedfasta/hi_b117_expo/hi_b117_expo.fna`
      - Output: `/updatedfasta/hi_b117_expo/hi_b117_expo_orf1a.fna.FUBAR.json`, `/updatedfasta/hi_b117_expo/hi_b117_expo_orf1a.fna.MEME.json`, `/updatedfasta/hi_b117_expo/hi_b117_expo_orf1a.fna.FEL.json`

   D) Collect all sites from each method on a spreadsheet:
      - Output: `/selection/SitesUnderSelection.xlsx`

   E) Make lollipop plots showing total number of sites under selection:
      - Make tables with number of sites normalized by gene length
      - Each locality and phase will have 2 values, a positive value for the sites under positive selection, and a negative value for sites under negative selection
      - Output: `/lollipop/b117_orf1a_perlength.csv`
      - Script: "lolliplot.R"
      - Output: `/lollipop/b117_lolli.pdf`

5. **Case Incidence Plots**
   
   A) Total Case incidence:
      - Includes counts of all sequences during the time span where either variant was circulating the population
      - Download all sequences on GISAID that fall into the date ranges for each variant within each population (e.g., B.1.1.7 circulated within Hawai'i from 1/21/21 to 7/13/21, so search for all sequences collected from within the state of Hawai'i between these dates)
      - Generate table with 7-day averages and plot
      - Script: "casecounts_breaky.R"
      - Input: `/prevalence/hi_allcases.csv`, `/prevalence/la_allcases.csv`
      - Output: `/prevalence/hi_casecounts.pdf`, `/prevalence/la_casecounts.pdf`

   B) Variant Only Case Incidence:
      - Only includes counts of single variant in a locality
      - Generate table with 7-day averages and plot
      - Script: "case_variant_counts.R"
      - Input: `prevalence/variants/hi_alltime_cases_swap.csv`, `prevalence/variants/hi_alldates_var_swap.csv`
      - Output: `prevalence/variants/hawaii_total_variant_counts.pdf`, `prevalence/variants/both_onlyvar_v3.pdf`

6. **Selective Pressure Heatmap**

   A) Create a spreadsheet for each variant:
      - Sort amino acid sites for each site under selection by region (sites for ORF1a, Spike, ORF7a) listed in column X
      - Include the location-period scenario in column Y
      - Positive, neutral, or negative selected indicated in "Selection" column:
        - Negative selection: -1
        - Neutral: 0
        - Positive selection: 1
      - Output: `b117_heatmap_allsites_swap.csv`

   B) Plot amino acids under selection:
      - Script: "heatmap.R"
      - Input: `/heatmap/b117_heatmap_allsites_swap.csv`
      - Output: `/heatmap/b117_heatmap_allsites.pdf`

   C) Merge and modify heatmaps for both variants:
      - Sites with detected selection across variants: indicate with a blue asterisk
      - Sites with the same type of selection across sites: indicate with a black box
      - Color the sites for each region to improve interpretability.
      - Compile counts of sites under selection.
      - Output: `/heatmap/bothvar_heatmap_withstars.png`
