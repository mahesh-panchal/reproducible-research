#! /usr/bin/env nextflow

// Enable DSL2 syntax
nextflow.enable.dsl = 2

// import Nextflow modules
include { FASTQC as PRE_FASTQC; 
          FASTQC as POST_FASTQC } from ''
include { FASTP                 } from ''
include {                       } from ''

// Default workflow parameters are provided in the file 'nextflow.config'.

// Default workflow
workflow {

    // Stage input files
    Channel.fromFilePairs ( params.illumina_fastq, checkIfExists: true )
        .ifEmpty { exit 1, "Please supply valid path(s) to illumina fastq read pairs: ${params.illumina_fastq}!\n" }
        .set { reads }
    Channel.fromPath ( params.reference, checkIfExists: true )
        .ifEmpty { exit 1, "Please supply valid path(s) to a reference genome: ${params.reference}!\n" }
        .set { reference }

    // Quality Check reads
    PRE_FASTQC ( reads )
    FASTP ( reads )
    POST_FASTQC ( FASTP.out.trimmed_reads )

    // Alignment
    BWA_INDEX ( reference.collect() )
    BWA_ALIGN ( 
        FASTP.out.trimmed_reads, 
        BWA_INDEX.out.indices.collect() 
    )
}