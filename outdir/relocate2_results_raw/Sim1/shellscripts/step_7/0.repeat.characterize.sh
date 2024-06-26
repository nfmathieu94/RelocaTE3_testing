cat /bigdata/wesslerlab/shared/Rice/Nathan/rice/tool_testing/relocate2_improvement/relocate2_results_raw/Sim1/repeat/results/*.all_nonref_insert.gff > /bigdata/wesslerlab/shared/Rice/Nathan/rice/tool_testing/relocate2_improvement/relocate2_results_raw/Sim1/repeat/results/ALL.all_nonref_insert.gff
cat /bigdata/wesslerlab/shared/Rice/Nathan/rice/tool_testing/relocate2_improvement/relocate2_results_raw/Sim1/repeat/results/*.all_nonref_insert.txt | grep "^TE" -v > /bigdata/wesslerlab/shared/Rice/Nathan/rice/tool_testing/relocate2_improvement/relocate2_results_raw/Sim1/repeat/results/ALL.all_nonref_insert.txt
python /opt/linux/rocky/8.x/x86_64/pkgs/relocate2/2.0.1/scripts/clean_false_positive.py --input /bigdata/wesslerlab/shared/Rice/Nathan/rice/tool_testing/relocate2_improvement/relocate2_results_raw/Sim1/repeat/results/ALL.all_nonref_insert.gff --refte /bigdata/wesslerlab/shared/Rice/Nathan/rice/tool_testing/relocate2_improvement/relocate2_results_raw/Sim1/repeat/existingTE.bed --bedtools /bigdata/operations/pkgadmin/opt/linux/centos/8.x/x86_64/pkgs/relocate2/2.0.1/bin/bedtools
cat /bigdata/wesslerlab/shared/Rice/Nathan/rice/tool_testing/relocate2_improvement/relocate2_results_raw/Sim1/repeat/results/*.all_ref_insert.txt > /bigdata/wesslerlab/shared/Rice/Nathan/rice/tool_testing/relocate2_improvement/relocate2_results_raw/Sim1/repeat/results/ALL.all_ref_insert.txt
cat /bigdata/wesslerlab/shared/Rice/Nathan/rice/tool_testing/relocate2_improvement/relocate2_results_raw/Sim1/repeat/results/*.all_ref_insert.gff > /bigdata/wesslerlab/shared/Rice/Nathan/rice/tool_testing/relocate2_improvement/relocate2_results_raw/Sim1/repeat/results/ALL.all_ref_insert.gff
perl /opt/linux/rocky/8.x/x86_64/pkgs/relocate2/2.0.1/scripts/characterizer.pl -s /bigdata/wesslerlab/shared/Rice/Nathan/rice/tool_testing/relocate2_improvement/relocate2_results_raw/Sim1/repeat/results/ALL.all_nonref_insert.txt -b  -g /bigdata/wesslerlab/shared/Rice/Nathan/rice/tool_testing/relocate2_improvement/genome/MSU7.Chr3_2M.fa --samtools /bigdata/operations/pkgadmin/opt/linux/centos/8.x/x86_64/pkgs/relocate2/2.0.1/bin/samtools
