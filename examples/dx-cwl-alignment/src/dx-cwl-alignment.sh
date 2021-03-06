#!/bin/bash
# dx-cwl-alignment 0.0.1
# Generated by dx-app-wizard.
#
# Basic execution pattern: Your app will run on a single machine from
# beginning to end.
#
# Your job's input variables (if any) will be loaded as environment
# variables before this script runs.  Any array inputs will be loaded
# as bash arrays.
#
# Any code outside of main() (or any entry point you may add) is
# ALWAYS executed, followed by running the entry point itself.
#
# See https://wiki.dnanexus.com/Developer-Portal for tutorials on how
# to modify this file.

main() {

    echo "Value of genome: '$genome'"
    echo "Value of fastq_one: '$fastq_one'"
    echo "Value of fastq_two: '$fastq_two'"


    # The following line(s) use the dx command-line tool to download your file
    # inputs to the local file system using variable names for the filenames. To
    # recover the original filenames, you can use the output of "dx describe
    # "$variable" --name".

    dx download "$fastq_one" -o $fastq_one_name

    dx download "$fastq_two" -o $fastq_two_name

    # Get reference files for BWA-MEM
    dx download -r project-F5444K89PZxXjBqVJ3Pp79B4:/global/reference/Homo_sapiens/${genome}/BWA

    # Fill in your application code here.
    #
    # To report any recognized errors in the correct format in
    # $HOME/job_error.json and exit this script, you can use the
    # dx-jobutil-report-error utility as follows:
    #
    #   dx-jobutil-report-error "My error message"
    #
    # Note however that this entire bash script is executed with -e
    # when running in the cloud, so any line which returns a nonzero
    # exit code will prematurely exit the script; if no error was
    # reported in the job_error.json file, then the failure reason
    # will be AppInternalError with a generic error message.

    echo "  [*] Creating inputs.yml ..." 
    cat > inputs.yml <<EOF
read_one:
  class: File
  path: $fastq_one_name 
read_two:
  class: File
  path: $fastq_two_name
genome: ${genome}.fa
reference:
  class: Directory
  path: BWA
EOF

    echo "  [*] Loading container image ..."
    image_tarfile_path=/docker/bio-base-docker.tar
    if [ -e $image_tarfile_path.gz ]
    then gunzip $image_tarfile_path.gz
    fi
    docker load -i $image_tarfile_path
    
    echo "  [*] Running workflow ..."
    cwl-runner --parallel --outdir outputs /cwl/workflow.cwl inputs.yml

    # The following line(s) use the dx command-line tool to upload your file
    # outputs after you have created them on the local file system.  It assumes
    # that you have used the output field name for the filename for each output,
    # but you can change that behavior to suit your needs.  Run "dx upload -h"
    # to see more options to set metadata.

    bam=$(dx upload outputs/out.sorted.bam --brief)
    bam_index=$(dx upload outputs/out.sorted.bam.bai --brief)
    flagstat=$(dx upload outputs/out.sorted.bam.flagstat.txt --brief)

    # The following line(s) use the utility dx-jobutil-add-output to format and
    # add output variables to your job's output as appropriate for the output
    # class.  Run "dx-jobutil-add-output -h" for more information on what it
    # does.

    dx-jobutil-add-output bam "$bam" --class=file
    dx-jobutil-add-output bam_index "$bam_index" --class=file
    dx-jobutil-add-output flagstat "$flagstat" --class=file
}
