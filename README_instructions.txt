#####Part 1: Installing Conda and Running SuperFOCUS

####Step 1: Log into deepthought and set up conda
#When we log on to deepthought, we will first change our location to our scratch directory using the below command with your FAN inserted:

cd /scratch/user/'your_fan'

#We will see if we have conda installed by running the following command:

conda --version

#You may see a results such as 'conda 23.7.4'.
#If no version exists we can load it and initialise conda:

module load Miniconda3
conda init bash

####Step 2: create a conda environment where we will install our bioinformatic tools:

conda create -n bioinformatics

#Type "y" when asked to. Now log out of the session. When you log back in you have conda activated, but you can not write to the base install, so before you use it you need to:

conda activate bioinformatics

####Step 3: Installing software super-FOCUS
#You only need to do this step once! When you come back to deepthought you can do 'conda activate bioinformatics' and you have super-FOCUS ready to go!
#We start by activating our conda environment, which we did previously in Step 2 using "conda activate bioinformatics".
#now we can install new software into the 'bininformatics' conda environment:

conda install -y -c bioconda super-focus

#This will figure out all the things that need to be installed, and then install them for you. It should not take too long for the installer to complete.
#At this point, super-FOCUS is installed within the 'bioinformatics' environment, so if you log out of deepthought or deactivate the current environment, you will need to rerun "conda activate bioinformatics"

####Step 4: Obtaining the fastq files
#We will test superfocus on 7 fastq files that are currently stored in a github folder. We use the "git clone" command to copy the files from github to our deepthought (run git --verision to make sure it's installed):

git clone https://github.com/N-falk/Bioinformatics_2023.git

#The folder "Bioinformatics_2023" is now copied to your deepthought with the 7 fastq files, along with a file "superfocus.slurm".
#There are several other files included, but we'll ignore those for now....

####Step 5: Vieiwng and Editing our .slurm file
#To submit jobs to deepthought, we use a .slurm (Simple Linux Usage Resource Manager) file that includes instructions of what we want to do and how much memory we think we need. This helps deepthought organize and allocate its processing power.
#Use the following commands to first enter the folder copied from git hub, and then to view the 'superfocus.slurm' file:

cd Bioinformatics_2023
nano superfocus.slurm

#nano is a text editing option in command line that allows you to view and edit files.
#look at the parameters outlined in the .slurm file; we will discuss what the different lines mean; use ctrl+X to exit the file.

#Step 7: Run super-FOCUS
#We us the 'sbatch' command followed by the name of the .slurm file to submit our job to deepthought:

sbatch superfocus.slurm

#In several minutes you should see output in a 'superfocus_results' folder that was created per the instructions in superfocus.slurm. The output includes .xls files that match gene frequencies to the sequences in your fastq files
#The .xls files have samples as columns and gene categories as rows. The numbers indicate how many sequeunces in each sample matched that specific gene or gene category when compared to databases.
#The superfocus output files increase in gene resolution from subsystem_level1 -> subsystem_level2 -> subsystem_level3 -> output_all_levels_and_function. 

#####Python Side quests

#Use the count_and_qual.py python script to count the number os sequences in all .fastq files in the directory and give the average quality score for all sequeunces in the file
#First install biopython, which contains the instructions required in count_and_qual.py:

pip install biopython

#Next run the python script by one of the following:

python count_and_qual.py
python3 count_and_qual.py

#View the output file either through Mobaxterm or using 'nano sequence_analysis.txt'

#Use the subsam.py python script to sub-sample all .fastq files in the directory to 100 sequeunces only. The parameters can be altered in subsam.py if you choose: 
#Run the python script by one of the following:

python subsam.py
python3 subsam.py

#####Part 2: Installing and Running Kraken2

####Step 1: Install Kraken2 on Deepthought
#Start by activating our conda environment if not already activated:

conda activate bioinformatics

#and now we can install new software

conda install -y -c bioconda kraken2

####Step 2: edit our sample-names.txt file
#The kraken.slurm file that holds the kraken2 intructions is looking for a file named "sample-names.txt" that lists the files to be processed using kraken2.
#Open the 'sample-names.txt' file using 'nano sample-names.txt' (or by opening wihtin mobaXterm) and fill it in with the sample names:

barcode01
barcode02
barcode03
barcode04
barcode05
barcode06
barcode07

####Step 3: Run kraken2
#We us the 'sbatch' command followed by the name of the .slurm file to submit our job to deepthought:

sbatch kraken.slurm

#The results are a .out and .report file for each fastq file that holds the microbial taxonomy information obtained from kraken by comparing the fastq file sequences to databases.
#The kraken2 output includes info at all microbial taxanomic levels (i.e., Domain (D), Phylum (P), Class (C), Order (O), Family (F), Genus (G), Species (S)).
#We can use the python script kraken2otu.py to output microbial taxnomy by sample in a .csv file at a desired taxa level. The following code will output a .csv file with samples as columns and phyla (p) as rows:

python3 ./kraken2otu.py --inputfolder ./ --level p

#We can do the same for genera (g) level using:

python3 ./kraken2otu.py --inputfolder ./ --level g

#See that the --level argument is where you choose the desired taxanomic level

#####Python Side quests

#You'll notice that the .report files from kraken2 include all possible domains of life, including human sequeunces under the domain Eukaryotes, as well as Viruses. 
#When getting our kraken2 output, we may not want to include Eukaryotes or Viruses, or even Archaea, and just want Bacteria hits
#Challenge: use Chatgpt or your own knowledge to create a code that will filter kraken output files for only hits under "Bacteria".




 
