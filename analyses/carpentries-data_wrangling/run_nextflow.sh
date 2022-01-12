#! /usr/bin/env bash

PROFILE=${PROFILE:-docker}
BASEDIR=${BASEDIR:-/workspace/reproducible-research}
NXF_SCRIPT=${NXF_SCRIPT:-$BASEDIR/workflow/main.nf}
WORKDIR=${WORKDIR:-/workspace/nxf-work}

nextflow run -ansi-log false -resume \
    -profile "$PROFILE" \
    -work-dir "$WORKDIR" \
    -params-file params.yml \
    "$NXF_SCRIPT"