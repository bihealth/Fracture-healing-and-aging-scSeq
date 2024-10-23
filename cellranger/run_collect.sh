#!/bin/bash

for library_name in $(ls cellranger_count/*csv | sed 's/\.csv//' | sed 's/cellranger_count\///'); do ./collect.sh /fast/work/groups/cubi/milekm/mireille/de/rerun/cellranger/cellranger_count/${library_name} ${library_name} count /fast/work/groups/cubi/milekm/mireille/de/rerun/cellranger/cellranger_collect; done
