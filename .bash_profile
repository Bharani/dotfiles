. $HOME/.bashrc
export MPD_HOST=127.0.0.1
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
  startx
  logout
fi
#export PATH=$PATH:/home/bharani/.bin
