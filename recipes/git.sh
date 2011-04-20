local URL="http://kernel.org/pub/software/scm/git/git-1.7.3.2.tar.bz2"
local tb_file=`basename $URL`
local type="tar.bz2"
local seed_name=$(extract_tool_name $tb_file $type)
local install_files=(bin/git bin/git-upload-pack)

do_install()
{
  cd $TB_DIR
  download $URL $tb_file
  decompress_tool $tb_file $type
  cd $seed_name
  configure_tool $seed_name
  make_tool $seed_name $make_j
  install_tool $seed_name
  link_from_stage $seed_name ${install_files[@]}
}

do_remove()
{
  remove_recipe $seed_name
  remove_from_stage $seed_name ${install_files[@]}
}

source "$MAIN_DIR/lib/case.sh"
