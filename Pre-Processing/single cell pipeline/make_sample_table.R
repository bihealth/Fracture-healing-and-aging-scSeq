#!/usr/bin/env Rscript

suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(optparse))

parser = OptionParser(description='Creates sample table for sc-batch-analysis starting from directory containing h5 files')
parser = add_option(parser, '--h5_path', default = NULL, type = "character", help = "directory with h5 files (required)")
parser = add_option(parser, '--regexp_filename', default = '[de]_feature_bc_matrix.h5$', type = "character", help = "regular expression for looking up h5 files, if not specified '[de]_feature_bc_matrix.h5$' will be used")
parser = add_option(parser, '--afile', default = NULL, type = "character", help = "isa-tab assay file (required)")
parser = add_option(parser, '--sfile', default = NULL, type = "character", help = "isa-tab study file (required)")
parser = add_option(parser, '--out', default = 'sample_table.txt', type = "character", help = "output sample table filename")
parser = add_option(parser, '--raw_h5_path', default = NULL, type = "character", help = "directory with h5 files, if not specified, raw h5 files will not be included in the sample table/analysis (optional)")
parser = add_option(parser, '--regexp_filename_raw', default = 'raw_feature_bc_matrix.h5$', type = "character", help = "regular expression for looking up raw h5 files, default raw_feature_bc_matrix.h5$'")

args <- parse_args(parser)
cat("Arguments used:\n", file = stdout())
args

if (is.null(args$h5_path)){
	stop("h5 path not provided.", .call = FALSE)
}

if (any(c(is.null(args$afile),is.null(args$sfile)))){
  stop("Isa Tab files not provided.", .call = FALSE)
}

#args <- list(h5_path = "/fast/groups/cubi/work/projects/2023-03-13-Christian_Klose_ilc2_neurons_Miha/cellbender/final/drg", regexp_filename = 'filtered.h5$', afile = "/fast/groups/cubi/work/projects/2023-03-13-Christian_Klose_ilc2_neurons_Miha/sample_sheet/a_sample_sheet_transcription_profiling_nucleotide_sequencing.txt", sfile = "/fast/groups/cubi/work/projects/2023-03-13-Christian_Klose_ilc2_neurons_Miha/sample_sheet/s_sample_sheet.txt", out = "sample_test.txt", raw_h5_path = "/fast/groups/cubi/work/projects/2023-03-13-Christian_Klose_ilc2_neurons_Miha/cellranger_collect_test", regexp_filename_raw = 'raw_feature_bc_matrix.h5$')

h5_files <- list.files(path = normalizePath(args$h5_path), recursive = T, pattern = args$regexp_filename, full.names = T)

if (!is.null(args$raw_h5_path)){
	raw_h5_files <- list.files(path = normalizePath(args$raw_h5_path), recursive = T, pattern = args$regexp_filename_raw, full.names = T)
}

a_file <- read.delim(args$afile, header = T)
s_file <- read.delim(args$sfile, header = T)
library_name_col <- colnames(a_file)[grepl("Library.[Nn]ame", colnames(a_file))]
sample_name_col <- colnames(a_file)[grepl("Sample.[Nn]ame", colnames(a_file))]
multiplex_col <- colnames(a_file)[grepl("Multiplex.[Oo]ligo", colnames(a_file))]

source_name_col <- colnames(s_file)[grepl("Source.[Nn]ame", colnames(s_file))]
group_col <- colnames(s_file)[grepl("Group", colnames(s_file))]
source_type_col <- colnames(s_file)[grepl("Source.[Tt]ype", colnames(s_file))]
condition_col <- colnames(s_file)[grepl("[Cc]ondition", colnames(s_file))]
treatment_col <- colnames(s_file)[grepl("[Tt]reatment", colnames(s_file))]
treatment_index <- which(colnames(s_file) %in% treatment_col)

if (!is.null(treatment_index) & ncol(s_file)>treatment_index){
  remaining_cols <- colnames(s_file)[(treatment_index+1):ncol(s_file)]
	remaining_df <- s_file[,remaining_cols]
}


if (length(library_name_col)==0){
	  stop("ISA Tab a file does not contain Library Name column. Please correct a file.", call. = FALSE)
} 

library_name <- unique(a_file[,library_name_col])

found_library_names <- sapply(library_name, function(x) h5_files[grepl(paste0("/",x,"/"), h5_files)]) 

found_library_names <- unlist(found_library_names[sapply(found_library_names, function(x) length(x) ==1)])


cat("Found library names:\n", file = stdout())
names(found_library_names)

if (!is.null(args$raw_h5_path)){
	found_library_names_raw <- sapply(library_name, function(x) raw_h5_files[grepl(paste0("/",x,"/"), raw_h5_files)]) 

	found_library_names_raw <- unlist(found_library_names_raw[sapply(found_library_names_raw, function(x) length(x) ==1)])
  cat("Found library names raw:\n", file = stdout())
	names(found_library_names_raw)
	if (any(!names(found_library_names) %in% names(found_library_names_raw))){
		stop("found library names of h5 files and raw h5 files do not match.", call. = FALSE)
	}
}


if (length(found_library_names)==0){
			stop("No Library Names from a file found in the directory. Please check your input.", call. = FALSE) 
}

if (!is.null(args$raw_h5_path)){
  sample_df <- data.frame(library=names(found_library_names),file=found_library_names, raw_file = found_library_names_raw)
} else {
  sample_df <- data.frame(library=names(found_library_names),file=found_library_names)
}

metadata <- data.frame(sample=a_file[,sample_name_col],
											 library=a_file[,library_name_col],
											 multiplex=a_file[,multiplex_col]) %>%
distinct()

sample_metadata <- data.frame(sample=s_file[,sample_name_col],
															source_name=s_file[,source_name_col],
                              group=s_file[,group_col],  
															source_type=s_file[,source_type_col],
															condition=s_file[,condition_col],
															treatment=s_file[,treatment_col]) 

if (!is.null(treatment_index) & ncol(s_file)>treatment_index){
	sample_metadata <- cbind(sample_metadata, remaining_df)
}

sample_metadata <- sample_metadata %>%
	distinct()

sample_df <- sample_df %>%
	left_join(metadata) %>%
	left_join(sample_metadata)

cols <- colnames(sample_df)[!apply(is.na(sample_df), 2, all)]
cols <- c(cols, "multiplex")

sample_df <- sample_df %>%
	select(all_of(cols))

write.table(sample_df, args$out, quote = F, sep = "\t", row.names=F)

cat(paste0("Successfully created ",args$out, " with the following content\n"), file =stdout())
print(sample_df)
