#!/usr/bin/bash -l
#sbatch -N 1 -n 32 --mem 40gb --out logs/native_relocate2.%a.log --time 48:00:00

module load relocate2
# module load bwa
# module load samtools
# module load bowtie2
# module load kent-tools
# module load bedtools
# module load seqtk

# Assign CPUs available on slurm node
CPU=2
if [ "$SLURM_CPUS_ON_NODE" ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi
N=${SLURM_ARRAY_TASK_ID}


# 
if [ -z "$N" ]; then
  N=$1
fi


if [ -z "$N" ]; then
  echo "cannot run without a number provided either cmdline or --array in sbatch"
  exit
fi


# Loop through the array task IDs from 98 to 105
# for N in {98..99}; do
#for N in {98..105}; do
SAMPLES=samples.csv
repeat=te_lib/RiceTE.fa
genome=genome/MSU7.Chr3_2M.fa
#indir=$(realpath input)
origin=input/reloc2_test_data/MSU7.Chr3_2M.ALL_reads
outdir=relocate2_results_raw
ref_te=repeatmasker/MSU7.Chr3_2M.fa.RepeatMasker.out
aligner=blat
size=500

if [ ! -f "$genome.sa" ]; then
   bwa index "$genome"
fi

# Setup tracking for performance metrics
start=$(date +%s)
initial_disk_usage=$(df / | tail -1 | awk '{print $3}')

# Track maximum memory usage in the background
max_memory_used=0
(
  while true; do
    current_memory=$(ps --no-headers -o rss -p $$ | awk '{print $1}')
    if [ "$current_memory" -gt "$max_memory_used" ]; then
      max_memory_used=$current_memory
    fi
    sleep 1
  done
) &
memory_monitor_pid=$!



IFS=,
# Extract only the line corresponding to task ID N
tail -n +2 $SAMPLES | sed -n "${N}p" | while read LINE FILEBASE; do
    mkdir -p "$outdir/$LINE"

    # mkdir -p $SCRATCH/$LINE
    # 
    # ln -s $origin/$FILEBASE $SCRATCH/$LINE
    #

    relocaTE2.py --te_fasta "$repeat" --genome_fasta "$genome" --fq_dir "$origin" --mate_1_id _1 --mate_2_id _2 \
        --outdir "$outdir/$LINE" --sample "$LINE" --reference_ins "$ref_te" --split --run \
        --size $size --step 1234567 --mismatch 2 --cpu "$CPU" --aligner $aligner --verbose 4


done

end=$(date +%s)
runtime=$(("end - start"))

# Kill the memory monitoring background process
kill $memory_monitor_pid
wait $memory_monitor_pid 2>/dev/null

# Final disk usage
final_disk_usage=$(df $outdir | tail -1 | awk '{print $3}')

# Calculate disk space used
disk_space_used=$((final_disk_usage - initial_disk_usage))

echo "Start: $start"
echo "End: $end"
echo "Run time: $runtime seconds"
echo "Max memory used: $((max_memory_used / 1024)) MB"
echo "Disk space used: $((disk_space_used / 1024)) MB"
