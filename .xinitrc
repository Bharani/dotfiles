if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
        eval "$(dbus-launch --sh-syntax --exit-with-session)"
 fi
if [ -d /etc/X11/xinit/xinitrc.d ]; then
 for f in /etc/X11/xinit/xinitrc.d/*; do
   [ -x "$f" ] && . "$f"
  done
  unset f
fi

(dbus-launch  /usr/bin/thunar --daemon)&
#xrdb -merge ~/.Xresources &
ck-launch-session dbus-launch devmon --unmount-on-exit &
#conky | while read -r; do wmfs -s -name "$REPLY"; done &
xcompmgr&
#dropboxd&
setxkbmap -option terminate:ctrl_alt_bksp&
xbindkeys&
(mpd && mpc pause)&
#stjerm&
#/usr/bin/autocutsel&
#/usr/bin/autocutsel -selection PRIMARY -fork &
./.fehbg&
#trayer --expand true --widthtype request --transparent true --alpha 255 --edge top --align right&
#exec startxfce4
#exec  openbox-session
#xsetroot -solid \#3f3f3f
xsetroot -cursor_name left_ptr
urxvtd -q -f -o &
#exec ck-launch-session awesome
#exec wmfs
#lxpanel&
#dminiwm
#exec ck-launch-session  awesome
dwmstart
#/usr/local/bin/dwm
#exec  ck-launch-session gnome-session
#dzconky | while read -r; do xsetroot -name "$REPLY" > /dev/null 2>&1 ; done &
#conky | while read -r; do xsetroot -name "$REPLY" > /dev/null 2>&1 ; done &
#conky | dzen2 -e - -h '16' -w '600' -ta r  -fn Sans 12
#exec ck-launch-session awesome 
#exec ck-launch-session dbus-launch dwm

#exec ck-launch-session catwm
#tint2&
#exec evilwm -snap 10 -bw 2 -fg black -term sakura  -mask1 mod4 
#exec xfwm
#exec ck-launch-session openbox-session
#exec musca
#exec awesome
#exec wmii
#exec scrotwm
#XMONAD
#xsetroot -cursor_name left_ptr
#exec xmonad
#exec fvwm-themes-start



