local version="1.2.08"
local type="tgz"
local URL="http://www.ebi.ac.uk/~zerbino/velvet/velvet_${version}.${type}"
local tb_file=`basename $URL`
local seed_name="velvet_${version}"
local install_files=(velvetg velveth)

do_install()
{
  cd $TB_DIR
  download $URL $tb_file
  decompress_tool $tb_file $type
  mv $TB_DIR/$seed_name $STAGE_DIR/$seed_name
  cd $STAGE_DIR/$seed_name
  make_tool $seed_name $make_j
}

do_activate()
{
  link_from_stage $seed_name ${install_files[@]}
}

do_test()
{
	log "test"
}

do_remove()
{
  remove_recipe $seed_name
  remove_from_stage $seed_name ${install_files[@]}
}

source "$MAIN_DIR/lib/case.sh"
