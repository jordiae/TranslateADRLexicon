#!/bin/bash
#SBATCH --job-name=pubmed_translate2
#SBATCH --workdir=/gpfs/scratch/bsc88/bsc88251/PubMedTranslate
#SBATCH --output=/gpfs/scratch/bsc88/bsc88251/PubMedTranslate/translate2.log
#SBATCH --error=/gpfs/scratch/bsc88/bsc88251/PubMedTranslate/translate2.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=48:00:00
#SBATCH --gres=gpu:1

module load ffmpeg/4.0.2
module load cuda/9.1
module load cudnn/7.1.3 atlas/3.10.3 scalapack/2.0.2 fftw/3.3.7 szip/2.1.1 opencv/3.4.1
module load python/3.6.5_ML

export omp_num_threads=40

bash tokenize_SP.sh -d /gpfs/projects/bsc88/_old/Resources/NMT_WMT19 -s en -t es -f /gpfs/scratch/bsc88/bsc88251/PubMedTranslate/all_sentences.src

source /gpfs/projects/bsc88/Environments_P9/OpenNMT-tf/bin/activate


python3 /gpfs/projects/bsc88/_old/ExternalTools/OpenNMT-py/translate.py -gpu 0 -model /gpfs/projects/bsc88/_old/Resources/NMT_WMT19/pten_es_model.pt \
-src /gpfs/scratch/bsc88/bsc88251/PubMedTranslate/all_sentences.src.tok.part.2 -replace_unk \
-output /gpfs/scratch/bsc88/bsc88251/PubMedTranslate/all_sentences.src.translated.part.2 -batch_size 60