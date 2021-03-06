#!/bin/bash

set -e -x

main() {
    echo "Value of bam_file: '$bam_file'"

    # Downloads file from project to virtual machine workspace
    dx download "$bam_file"

    # Creating output directory for FastQC
    mkdir ~/fastqc-out

    # Runs FastQC on BAM file
    /FastQC/fastqc "$bam_file_name" -o ~/fastqc-out

    # Renames the FastQC reports to include the BAM file prefix
    mv ~/fastqc-out/*.html ~/fastqc-out/fastqc-report.html
    mv ~/fastqc-out/*.zip ~/fastqc-out/fastqc-report.zip

    # Uploads the respective HTML and Zip file
    fastqc_html=$(dx upload ~/fastqc-out/fastqc-report.html --brief)
    fastqc_zip=$(dx upload ~/fastqc-out/fastqc-report.zip --brief)

    # Adds and formats appropriate output variables for your app
    dx-jobutil-add-output fastqc_html "$fastqc_html" --class=file
    dx-jobutil-add-output fastqc_zip "$fastqc_zip" --class=file
}
