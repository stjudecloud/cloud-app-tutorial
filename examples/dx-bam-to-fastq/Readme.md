<!-- dx-header -->
# BAM to FastQ (DNAnexus Platform App)

Convert BAM to FastQ files

This is the source code for an app that runs on the DNAnexus Platform.
For more information about how to run or modify it, see
https://wiki.dnanexus.com/.
<!-- /dx-header -->

<!-- Insert a description of your app here -->
This is an example application that uses samtools (http://www.htslib.org/) 
and Picard Tools (https://broadinstitute.github.io/picard/) to convert 
a BAM file back to FastQ files. It provides some basic quality control 
of the input BAM. It then splits the BAM by read group. The per-read 
group BAMs are then converted to paired FastQ files. This app provides 
an example of returning an array of files. 
<!--
TODO: This app directory was automatically generated by dx-app-wizard;
please edit this Readme.md file to include essential documentation about
your app that would be helpful to users. (Also see the
Readme.developer.md.) Once you're done, you can remove these TODO
comments.

For more info, see https://wiki.dnanexus.com/Developer-Portal.
-->