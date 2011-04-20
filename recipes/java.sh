
# This recipe is special, please read: https://jdk-distros.dev.java.net/developer.html
local URL="http://download.java.net/dlj/binaries/jdk-6u22-dlj-linux-amd64.bin"
local construct='https://jdk-distros.dev.java.net/source/browse/*checkout*/jdk-distros/trunk/utils/construct.sh?content-type=text%2Fplain'
local tb_file=`basename $URL`
local seed_name="java"
local install_files=(bin/java bin/javac)

do_install()
{
  # pwd: tarball
  cd $TB_DIR
  download $URL $tb_file
  mkdir $recipe
  mv $tb_file $recipe
  # pwd: tarball/java
  cd $recipe
  sh $tb_file --accept-license &> $LOG_DIR/$recipe.unpack.txt
  # pwd: tarball
  cd ..
  log "downloading construst.sh"
  curl -sL $construct > construct.sh
  sh ./construct.sh $recipe linux-jdk linux-jre &>/dev/null
  rm -rf linux-jre
  mv linux-jdk ../local/java
  link_from_stage $recipe ${install_files[@]}
}

do_remove()
{
  remove_recipe $seed_name
  remove_from_stage $seed_name ${install_files[@]}
}

source "$MAIN_DIR/lib/case.sh"
