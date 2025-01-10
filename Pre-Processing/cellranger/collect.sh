#!/bin/bash

set -euxo pipefail

path=$1
library=$2
libtype=$3
outpath=$4
output="$(date +"%Y%m%d")_cellranger_${libtype}"

echo "collecting up output from ${path} to folder ${library}/${output}"
cd $outpath
mkdir -p ${library}

cp -r ${path}/outs ${library}/${output}

#first tar the subdirectories

for subdir in raw_feature_bc_matrix filtered_feature_bc_matrix analysis
do
  dir=$(find ${library}/${output} -type d -name ${subdir})
  cd ${dir}
  cd ..
  [ -d ${subdir} ] && tar -czhf ${subdir}.tgz ${subdir} && rm -rf ${subdir}
  cd $outpath 
done


# then move the directories into the irods structure

#mv ${library}/${output}/multi/count ${library}/${output}
#rm -rf ${library}/${output}/multi/

#mv ${library}/${output}/per_sample_outs/cellranger_multi_${library}/count/* ${library}/${output}/count
#rm -rf ${library}/${output}/per_sample_outs/cellranger_multi_${library}/count
#mv ${library}/${output}/per_sample_outs/cellranger_multi_${library}/* ${library}/${output}
#rm -rf ${library}/${output}/per_sample_outs


#finally tar the cellranger logs

tar -czhf ${library}/${output}/cellranger_logs.tgz --exclude "./outs" --exclude "./velocyto" --exclude "./SC*" -C ${path} .

#make md5sums for sodar
#files=$(find -L ${library}/${output}/ -type f ! -name *.md5)

#for file in files
#do
#        echo $file
#        pushd $(dirname $file)
#        x=$(basename $file)
#        [ ! -s ${x}.md5 ] && md5sum $x > ${x}.md5
#        popd
#done
