
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
source ~/.zer0prompt
zer0prompt
unset zer0prompt
#PS1='\n\[\033[0;32m\]\u@\h \[\033[1;33m\]\w\> '
PS2='\\ '
#set show-all-if-ambiguous on
complete -cf sudo


export GREP_COLOR="1;33"
export EDITOR=vim
export VISUAL=gvim
export MAIL=/home/bharani/.Maildir/inbox
export MAILDIR=/home/bharani/.Maildir/inbox
export LESS="-R"
if [ -n "$DISPLAY" ]; then
	BROWSER=firefox
else
	BROWSER=links
fi
eval $(dircolors -b)


# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.  #139609
shopt -s histappend
shopt -s cdspell
export HISTCONTROL=ignoredups

alias inbox="offlineimap -a Gmail -f INBOX"
alias svim="sudo vim"
alias sgvim="sudo gvim"
alias km="killall mplayer"
alias rt="ping -c 3 8.8.8.8" # Check Network
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias exit="clear; exit"
alias show_pac_cache="ls /var/cache/pacman/pkg | sed 's/-[0-9].*//' | uniq -c | sort -g"
alias pacsearch="pacman -Sl | cut -d' ' -f2 | grep "
alias pacup="sudo pacman -Syu"
alias pacout='sudo pacman -Rns'   
alias pacin="sudo pacman -S"
#alias pacman32="pacman --root /opt/arch32 --cachedir /opt/arch32/var/cache/pacman/pkg --config /opt/arch32/pacman.conf"
alias yt="yaourt"
alias clr="clear"
alias e="exo-open"
alias encrypt="gpg -e "
#alias shutnow="sudo shutdown -h now"
alias ks="killall slock"
alias sps="ps aux | grep -v grep | grep"  #search process
alias f="find | grep"                       # quick search
alias sudo="sudo "
alias mysleep="sudo pm-suspend"
alias sshkiwi="ssh bharani@auriga.kiwilight.com"



# cd
alias home='cd ~'
alias back='cd $OLDPWD'
alias cd..='cd ..'
alias ..='cd ..'


# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'



extract() {
    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1

        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
        *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
               c='bsdtar xvf';;
        *.7z)  c='7z x';;
        *.Z)   c='uncompress';;
        *.bz2) c='bunzip2';;
        *.exe) c='cabextract';;
        *.gz)  c='gunzip';;
        *.rar) c='unrar x';;
        *.xz)  c='unxz';;
        *.zip) c='unzip';;
        *)     echo "$0: unrecognized file extension: \`$i'" >&2
               continue;;
        esac

        command $c "$i"
        e=$?
    done

    return $e
}
define() {
  local LNG=$(echo $LANG | cut -d '_' -f 1)
  local CHARSET=$(echo $LANG | cut -d '.' -f 2)
  lynx -accept_all_cookies -dump -hiddenlinks=ignore -nonumbers -assume_charset="$CHARSET" -display_charset="$CHARSET" "http://www.google.com/search?hl=${LNG}&q=define%3A+${1}&btnG=Google+Search" | grep -m 5 -C 2 -A 5 -w "*" > /tmp/define
  if [ ! -s /tmp/define ]; then
    echo "Sorry, google doesn't know this one..."
    rm -f /tmp/define
    return 1
  else
    cat /tmp/define | grep -v Search
    echo ""
  fi
  rm -f /tmp/define
  return 0
}
thumbit() {
  if [ -z $1 ]; then
    echo "please supply a file to shrink"
    return 1 
  fi

  case $1 in
    *.jpg)
      thumb=$(echo "$1" | sed s/.jpg/-thumb.jpg/g)
      cp $1 $thumb
      mogrify -resize 20% $thumb
    ;;
    *.jpeg)
      thumb=$(echo "$1" | sed s/.jpeg/-thumb.jpeg/g)
      cp $1 $thumb
      mogrify -resize 20% $thumb
    ;;
    *.png)
      thumb=$(echo "$1" | sed s/.png/-thumb.png/g)
      cp $1 $thumb
      mogrify -resize 20% $thumb
    ;;
    *)
      echo "Image must be .jpg, .jpeg, or .png"
      return 1
    ;;
  esac
}
calc() {
  echo "scale=3; $@" | bc
}
if ! systemd-notify --booted; then # not using systemd
  start() {
    sudo rc.d start $1
  }

  restart() {
    sudo rc.d restart $1
  }

  stop() {
    sudo rc.d stop $1
  }
else
  start() {
    sudo systemctl start $1.service
  }

  restart() {
    sudo systemctl restart $1.service
  }

  stop() {
    sudo systemctl stop $1.service
  }

  enable() {
    sudo systemctl enable $1.service
  }

  status() {
    sudo systemctl status $1.service
  }

  disable() {
    sudo systemctl disable $1.service
  }
fi
