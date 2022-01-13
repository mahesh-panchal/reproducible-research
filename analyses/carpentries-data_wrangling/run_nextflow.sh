#! /usr/bin/env bash

PROFILE=${PROFILE:-docker}
BASEDIR=${BASEDIR:-/workspace/reproducible-research}
NXF_SCRIPT=${NXF_SCRIPT:-$BASEDIR/workflow/main.nf}
WORKDIR=${WORKDIR:-/workspace/nxf-work}

nextflow run -resume \
    -ansi-log false \
    -params-file params.yml \
    -profile "$PROFILE" \
    -work-dir "$WORKDIR" \
    "$NXF_SCRIPT"