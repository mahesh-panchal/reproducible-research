process BWA_INDEX {

    input:
    path fasta

    output:
    path "bwa", emit: index

    script:
    def args = task.ext.args ?: ''
    """
    mkdir bwa
    bwa index \\
        $args \\
        -p bwa/${fasta.baseName} \\
        $fasta
    """
}

process BWA_ALIGN {
    
    input:
    tuple val( id ), path( fastqs )
    path index

    output:
    tuple val( id ), path( "*.bam" )     , emit: bam
    tuple val( id ), path( "*.flagstat" ), emit: flagstat
    tuple val( id ), path( "*.stats" )   , emit: stats 

    script:
    def args   = task.ext.args   ?: ''
    def args2  = task.ext.args2  ?: ''
    def prefix = task.ext.prefix ?: id
    """
    INDEX=\$( basename bwa/*.amb .amb )
    bwa mem $args \\
        -t $task.cpus \\
        \$INDEX \\
        $fastqs | \\
        samtools sort $args2 \\
            --threads $task.cpus \\
            -o ${prefix}.bam -
    samtools flagstat ${prefix}.bam > ${prefix}.bam.flagstat
    samtools stats ${prefix}.bam > ${prefix}.bam.stats
}