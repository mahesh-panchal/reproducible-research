#! /usr/bin/env nextflow

// Enable DSL2 syntax
nextflow.enable.dsl = 2

// import Nextflow modules
include { FASTQC as PRE_FASTQC; 
          FASTQC as POST_FASTQC } from './modules/fastqc'
include { FASTP                 } from './modules/fastp'
include { BWA_INDEX; 
          BWA_ALIGN             } from './modules/bwa'

// Default workflow parameters are provided in the file 'nextflow.config'.

// Default workflow
workflow {

    // Stage input files
    Channel.fromFilePairs ( params.illumina_fastq, checkIfExists: true )
        .ifEmpty { exit 1, "Please supply valid path(s) to illumina fastq read pairs: ${params.illumina_fastq}!\n" }
        .set { reads_ch }
    Channel.fromPath ( params.reference, checkIfExists: true )
        .ifEmpty { exit 1, "Please supply valid path(s) to a reference genome: ${params.reference}!\n" }
        .set { reference_ch }

    // Quality Check reads
    PRE_FASTQC ( reads_ch )
    FASTP ( reads_ch )
    POST_FASTQC ( FASTP.out.reads )

    // Alignment
    BWA_INDEX ( reference_ch.collect() )
    BWA_ALIGN (
        FASTP.out.reads,
        BWA_INDEX.out.index.collect()
    )
}