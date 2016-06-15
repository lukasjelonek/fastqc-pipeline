#!/usr/bin/env nextflow

params.file

if (!params.file) {
    println "No input provided."
    exit(1)
}

def input_fastq = Channel.fromPath(params.file)

process qualityControl {

    publishDir "qc", mode:"copy"

    input:
    file(fastq) from input_fastq

    output:
    set file("*.zip"), file("*.html") into reports

    script:
    """
    fastqc $fastq
    """
}
