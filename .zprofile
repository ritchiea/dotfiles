#source ~/git-completion.bash

function gpsh() {
  git push origin $(git_current_branch)
}

function gpll() {
  git pull origin $(git_current_branch)
}
#alias adack="ack --ignore-dir=public --ignore-file=ext:json"
alias gclo="git clone"
alias gbegin="git checkout -b"
alias gadd="git add"
alias gst="git status"
alias gco="git checkout"
alias gmrg="git merge --ff-only"
alias gcm="git commit -m"
alias gbr="git branch"
alias gdf="git diff -- . ':!package-lock.json'"
alias grb="git rebase -i"
alias gfch="git fetch --all"
alias gtool="git mergetool"
alias graph="git log --decorate --oneline --all --graph"
alias amend="git commit --amend"

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

export BUNDLER_EDITOR=vi


function git_current_branch() {
  git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///'
}

export PATH="/Applications/Postgres.app/Contents/Versions/12/bin:$PATH"
export PATH=:"./node_modules/.bin:$PATH:/usr/local/git/bin"

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

alias v.="vi ."
alias c.="code ."
alias m.="mvim ."

alias reload="source ~/.zprofile"
alias editp="vi ~/.zprofile"
alias editv="vi ~/.vimrc"
