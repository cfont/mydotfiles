export JAVA_HOME=`/usr/libexec/java_home -v 1.6`
# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,exports,aliases,functions,extra}; do
   [ -r "$file" ] && source "$file"
done
unset file



#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/cfonteno/.gvm/bin/gvm-init.sh" && -z $(which gvm-init.sh | grep '/gvm-init.sh') ]] && source "/Users/cfonteno/.gvm/bin/gvm-init.sh"
