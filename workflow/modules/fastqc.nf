process FASTQC {

    tag "$id"

    input:
    tuple val( id ), path( fastqs )

    output:
    tuple val( id ), path( "*.html" ), emit: html
    tuple val( id ), path( "*.zip" ) , emit: zip

    script:
    """
    fastqc --threads $task.cpus $fastqs
    """
}