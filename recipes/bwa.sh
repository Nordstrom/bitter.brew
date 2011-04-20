
local URL="https://bio-bwa.svn.sourceforge.net/svnroot/bio-bwa"
local tb_file=`basename $URL`
local seed_name="bwa"
local install_files=(bwa solid2fastq.pl)
local deps=("subversion-1.6.13")

do_install()
{
  cd $LOCAL_DIR
  log "svn: checking out $URL"
  svn co $URL $seed_name &> $LOG_DIR/${seed_name}.svn_co.log.txt
  mv $seed_name/trunk/$seed_name ./b
  rm -rf $seed_name
  mv ./b $seed_name
  cd $seed_name
  log "autogen"
  sh ./autogen.sh &> $LOG_DIR/${seed_name}.autogen.log.txt
  make_tool $seed_name $make_j
  link_from_stage $recipe ${install_files[@]}
}

do_remove()
{
  remove_recipe $seed_name
  remove_from_stage $seed_name ${install_files[@]}
}

source "$MAIN_DIR/lib/case.sh"
