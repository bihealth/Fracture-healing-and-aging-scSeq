#!/bin/bash

input_rmd_fig1="'Scripts/fig1.Rmd'"
output_html_fig1="'fig1.html'"
title="'fig1'"

Rscript -e "rmarkdown::render(input = ${input_rmd_fig1}, output_file = ${output_html_fig1}, knit_root_dir='./',params = list(title = ${title}))"

input_rmd_fig2="'Scripts/fig2.Rmd'"
output_html_fig2="'fig2.html'"
title="'fig2'"

Rscript -e "rmarkdown::render(input = ${input_rmd_fig2}, output_file = ${output_html_fig2}, knit_root_dir='./',params = list(title = ${title}))"


input_rmd_fig3="'Scripts/fig3.Rmd'"
output_html_fig3="'fig3.html'"
title="'fig3'"

Rscript -e "rmarkdown::render(input = ${input_rmd_fig3}, output_file = ${output_html_fig3}, knit_root_dir='./',params = list(title = ${title}))"


input_rmd_fig4="'Scripts/fig4.Rmd'"
output_html_fig4="'fig4.html'"
title="'fig4'"

Rscript -e "rmarkdown::render(input = ${input_rmd_fig4}, output_file = ${output_html_fig4}, knit_root_dir='./',params = list(title = ${title}))"
