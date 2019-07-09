# FastQC Example Application

This application uses FastQC to generate quality control reports on raw sequence data in the cloud.

FastQC supports a variety of file formats (BAM, SAM, FastQ, etc.), and outputs a HTML report and a zip file that contain all the quality control graphs and data. This application will allow us to run FastQC on any of the St. Jude next generation sequencing data in the cloud.

## Requirements

| Requirement                                                          | Website                                                               | Version  |
| -------------------------------------------------------------------- | --------------------------------------------------------------------- | -------- |
| [dx-toolkit](https://documentation.dnanexus.com/downloads)           | [DNAnexus](https://www.dnanexus.com/)                                 | v0.276.0 |
| [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) | [Babraham Bioinformatics](https://www.bioinformatics.babraham.ac.uk/) | v0.11.8  |

## Usage

To build and run this application:
```bash
$ dx build dx-fastqc-example-app
$ dx run dx-fastqc-example-app -i bam_file=/path/to/<bam-file>.bam
```

### Prerequisites

You will need some familiarity with how to work with St. Jude Cloud Platform from the command line. For additional information on how to select a project or how to upload and download data, refer to the [command line documentation](https://www.stjude.cloud/docs/guides/data/command-line/).

This project also includes the necessary executables in the resources folder. It is not necessary to download FastQC and move it into the resources folder. All that is required is dx-toolkit and a project with sample data that you can run FastQC on.

## Additional Resources

* [St. Jude Cloud Documentation](https://www.stjude.cloud/docs/)
* [FastQC Documentation](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/)
* [DNAnexus Wiki](https://documentation.dnanexus.com/)
