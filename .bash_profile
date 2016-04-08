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

#export PS1="\[\e[33;40m\][\[\w\] \[\e[m\\e[0;36m\]*\[\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\]*]\[\e[m\\e[35;40m\] \$ ︻┳テ=一 \$\[ \e[m\]"
export PS1="\[\e[33;40m\][\[\w\] \[\e[m\\e[0;36m\]*\[\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\]*]\[\e[m\\e[35;40m\] \$\[ \e[m\]"
# ------------------------

# Load RVM function

# from cbuzz bash_profile test to install sql
export PATH=$PATH:/usr/local/git/bin:./node_modules/.bin
#/usr/local/mysql/bin:
#export CC=gcc-4.2 #set gcc compiler (no longer excode default)

# for leiningen
export PATH=$PATH:$HOME/.lein/bin

# for go
export PATH=$PATH:/usr/local/go/bin:/Users/ritchie/code/gocode/bin
export GOROOT=/usr/local/go
export GOPATH=/Users/ritchie/code/gocode

# for postgres
export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"

# BELOW IS FOR MYSQL
#export MYSQL=/usr/local/mysql/bin
#export PATH=$PATH:$MYSQL
#export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

# bundle editor
export BUNDLER_EDITOR=vim

# Aliases

alias fuckoff="kill -9"

#elasticsearch
alias elsearch="elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml"

# Navigating directories

alias lsa="ls $LS_OPTIONS -a"
alias ls="ls $LS_OPTIONS -GF" # color + / after directory etc
alias ll="ls $LS_OPTIONS -GlhF" # all above + long form + unit suffixes
alias l="ls $LS_OPTIONS -GlAhF" # all above + ALL ENTRIES including hidden
alias clr="clear"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cdg='cd $(git rev-parse --show-cdup)'
alias code="cd /Users/ritchie/code"

#flush cache
alias flushcache='sudo discoveryutil mdnsflushcache'

# neo4j
alias neo4j="/Users/ritchie/code/libraries/neo4j-community-1.9.3/bin/neo4j start"
alias stopneo="/Users/ritchie/code/libraries/neo4j-community-1.9.3/bin/neo4j stop"

# sublime
alias s.="subl ."

# vim
alias m.="mvim ."
alias v.="vi ."

# Mongo

# alias mdbs="./mongodb-osx-x86_64-2.0.4/bin/mongod"
# alias mdbc="./mongodb-osx-x86_64-2.0.4/bin/mongo"

# tanooki

alias bowcaprestore="pg_restore --verbose --clean --no-acl --no-owner -h localhost -d bowcap_dev latest.dump"

# docker

export DOCKER_HOST=tcp://127.0.0.1:4243
function dockerForward() {
  for i in {49000..49900}; do
     VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i";
     VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,udp,,$i,,$i";
  done
}

# Rails

alias bex="bundle exec"
alias routeme="bundle exec rake routes"
alias dbmg="bundle exec rake db:migrate"
alias dbmgtest="bundle exec rake db:migrate RAILS_ENV=test"
alias dbprepare="rake db:test:prepare"
alias dorspec="rake db:test:prepare && cdg && bundle exec rspec spec"
alias precom="rake assets:precompile"
alias anno="annotate --exclude tests,fixtures,factories,serializers"

# Rails 2

alias rserver="./script/server"
alias rconsole="./script/console"

# bash_profile

alias reload="source ~/.bash_profile"
alias editp="vi ~/.bash_profile"

# solr

export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
alias solrstart="bundle exec rake sunspot:solr:start RAILS_ENV=development"
alias solrstarttest="bundle exec rake sunspot:solr:start RAILS_ENV=test"
alias solrstop="bundle exec rake sunspot:solr:stop RAILS_ENV=development"
alias solrstoptest="bundle exec rake sunspot:solr:stop RAILS_ENV=test"

# clojure

alias cdclo="cd /Users/ritchie/code/clojure-1.4.0"
alias clojure="java -cp clojure-1.4.0.jar clojure.main"

#bt
alias btrestore='pg_restore --verbose --clean --no-acl --no-owner -h localhost -d bnt_dev latest.dump'
alias btconsole='heroku run rails console -a bookandtable'

# git
function gpsh() {
  git push origin $(git_current_branch)
}

function gpll() {
  git pull origin $(git_current_branch)
}
alias gclo="git clone"
alias gbegin="git checkout -b"
alias gadd="git add"
alias gst="git status"
alias gco="git checkout"
alias gmrg="git merge --ff-only"
alias gcm="git commit -m"
alias gbr="git branch"
alias gdf="git diff"
alias grb="git rebase -i"
alias gtool="git mergetool"
alias graph="git log --decorate --oneline --all --graph"
alias amend="git commit --amend"
#alias push_tprod='git push heroku-prod master'
#alias push_tstag='git push heroku-stag staging:master'
#alias such='git'
#alias very='git'
#alias wow='git status'

alias acspulldb='heroku pg:pull HEROKU_POSTGRESQL_PINK_URL acs_dev -a allcollegestorage'
alias acsdbpull='heroku pg:pull HEROKU_POSTGRESQL_PINK_URL acs_dev -a allcollegestorage'

alias lolpulldb='rake db:drop; heroku pg:pull DATABASE_URL mrloldev'

alias catbp='cat ~/.bash_profile'

#python
alias pipup='pip install -r requirements.txt'
#export PATH=/Library/Frameworks/Python.framework/Versions/3.3/bin:$PATH
#export PATH=/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH
#export PYTHON_CFLAGS='-I/usr/local/Cellar/python/2.7.6_1/Frameworks/Python.framework/Versions/2.7/include/python2.7 -I/usr/local/Cellar/python/2.7.6_1/Frameworks/Python.framework/Versions/2.7/include/python2.7 -fno-strict-aliasing -fno-common -dynamic -I/usr/local/include -I/usr/local/opt/sqlite/include -DNDEBUG -g -fwrapv -O3 -Wall -Wstrict-prototypes'
#export PYTHON_LIBS='-ldl -framework CoreFoundation -lpython2.7'

#suppress unknown compiler flag warnings
export ARCHFLAGS="-arch x86_64 -Wno-error=unused-command-line-argument-hard-error-in-future"
#
## pg
# must pass db & dump name! e.g. -d mydb latest.dump
alias pgimport='pg_restore --verbose --clean --no-acl --no-owner -h localhost'

#brew doctor
export PATH="/usr/local/bin:$PATH"

#node
alias npmnuke="rm -rf node_modules && npm cache clear && npm i"

#tutum
alias tutumserver="./manage.py run_gunicorn --log-level=DEBUG --debug"
alias tutumworker="celery -A tutum-app worker -E -c 4 -l DEBUG -O fair"
alias tutomstart="./manage.py run_gunicorn --log-level=DEBUG --debug"

###########
alias droplet="ssh ar@104.236.89.20"

######
alias flushdns='sudo killall -HUP mDNSResponder'

alias ack='ack --ignore-dir={tmp,log}'

alias bernie='ssh ar@45.55.195.168'

alias pres='pg_restore --verbose --data-only --no-acl --no-owner -h localhost -U'
alias capturedb='heroku pg:backups capture'
alias curlbobdb='curl -o latest.dump `heroku pg:backups public-url -a betteroffbowling2`'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
