#find and replace using grep and sed
  gg_replace() {
    if [[ "$#" == "0" ]]; then
      echo 'Usage:'
      echo '  gg_replace term replacement file_mask'
      echo
      echo 'Example:'
      echo '  gg_replace cappuchino cappuccino *.html'
      echo
    else
      find=$1; shift
      replace=$1; shift
 
      ORIG_GLOBIGNORE=$GLOBIGNORE
      GLOBIGNORE=*.*
      
      if [[ "$#" = "0" ]]; then
        set -- ' ' $@
      fi
 
      while [[ "$#" -gt "0" ]]; do
        for file in `git grep -l $find -- $1`; do
          sed -i '' -e"s/$find/$replace/g" $file
        done
        shift
      done
 
      GLOBIGNORE=$ORIG_GLOBIGNORE
    fi
  }
  gg_dasherize() {
    gg_replace $1 `echo $1 | sed -e 's/_/-/g'` $2
  }

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# function using_gcc() {
#   env CC="/usr/bin/gcc" ARCHFLAGS="-arch x86_64" ARCHS="x86_64" $*
# }

function git_current_branch() {
  git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///'
}

# to add current git branch in prompt

export PS1="\[\e[33;40m\][\[\w\] \[\e[m\\e[0;36m\]***\[\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\]***]\[\e[m\\e[35;40m\] \$ ︻┳テ=一 \$\[ \e[m\]"
# ------------------------

# Load RVM function

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

# load NVM

. ~/nvm/nvm.sh

# from cbuzz bash_profile test to install sql
export PATH=$PATH:/usr/local/git/bin:/usr/local/mysql/bin:./node_modules/.bin
# export CC=gcc-4.2 #set gcc compiler (no longer excode default)

# for leiningen
export PATH=$PATH:$HOME/.lein/bin

# for postgres
PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

# BELOW IS FOR MYSQL
export MYSQL=/usr/local/mysql/bin
export PATH=$PATH:$MYSQL
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

# bundle editor
export BUNDLER_EDITOR=mvim

# Aliases

# Navigating directories

alias lsa="ls $LS_OPTIONS -a ~/"
alias ls="ls $LS_OPTIONS -GF" # color + / after directory etc
alias ll="ls $LS_OPTIONS -GlhF" # all above + long form + unit suffixes
alias l="ls $LS_OPTIONS -GlAhF" # all above + ALL ENTRIES including hidden
alias clr="clear"
alias ..="cd .."
alias ...="cd ../.."
alias code="cd /Users/andrewritchie/Dropbox/code"

# sublime
alias s.="subl ."

# vim
alias m.="mvim ."
alias v.="vi ."

# Mongo

# alias mdbs="./mongodb-osx-x86_64-2.0.4/bin/mongod"
# alias mdbc="./mongodb-osx-x86_64-2.0.4/bin/mongo"

# Rails

alias bex="bundle exec"
alias routeme="bundle exec rake routes"
alias rg="rails generate"

# Rails 2

alias rserver="./script/server"
alias rconsole="./script/console"

# bash_profile

alias reload="source ~/.bash_profile"
alias editp="vi ~/.bash_profile"

# solr

alias solrstartdev="rake sunspot:solr:start RAILS_ENV=development"
alias bexsolrstartdev="bundle exec rake sunspot:solr:start RAILS_ENV=development"
alias solrstarttest="rake sunspot:solr:start RAILS_ENV=test"
alias solrstoptest="rake sunspot:solr:stop RAILS_ENV=test"
alias solrstopdev="rake sunspot:solr:stop RAILS_ENV=development"
alias bexsolrstopdev="bundle exec rake sunspot:solr:stop RAILS_ENV=development"

# clojure

alias cdclo="cd /Users/andrewritchie/Dropbox/code/clojure-1.4.0"
alias clojure="java -cp clojure-1.4.0.jar clojure.main"

# elastic
alias es='/usr/local/elasticsearch-0.20.6/bin/elasticsearch -f'
# unicorn
alias unicorn='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist; unicorn_rails -c config/unicorn.conf.rb'

# git

alias gclo="git clone"
alias gbegin="git checkout -b"
alias gadd="git add"
alias gst="git status"
alias gpsh="git push origin git_current_branch"
alias gpll="git pull"
alias gco="git checkout"
alias gmrg="git merge"
alias gcm="git commit -m"
alias gbr="git branch"
alias grb="git rebase -i"
alias gtool="git mergetool"
alias push_tprod='git push heroku-prod master'
alias push_tstag='git push heroku-stag staging:master'
# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
