process FASTP {

    tag "$id"

    input:
    tuple val( id ), path( fastqs )

    output:
    tuple val( id ), path( '*.trim.fastq.gz' ), emit: reads
    tuple val( id ), path( '*.json' )         , emit: json
    tuple val( id ), path( '*.html' )         , emit: html
    tuple val( id ), path( '*.log' )          , emit: log

    script:
    def args   = task.ext.args   ?: ''
    def prefix = task.ext.prefix ?: id
    """
    [ ! -f  ${prefix}_1.fastq.gz ] && ln -s ${fastqs[0]} ${prefix}_1.fastq.gz
    [ ! -f  ${prefix}_2.fastq.gz ] && ln -s ${fastqs[1]} ${prefix}_2.fastq.gz
    fastp \\
        --in1 ${prefix}_1.fastq.gz \\
        --in2 ${prefix}_2.fastq.gz \\
        --out1 ${prefix}_1.trim.fastq.gz \\
        --out2 ${prefix}_2.trim.fastq.gz \\
        --json ${prefix}.fastp.json \\
        --html ${prefix}.fastp.html \\
        --thread $task.cpus \\
        --detect_adapter_for_pe \\
        $args \\
        2> ${prefix}.fastp.log
    """
}