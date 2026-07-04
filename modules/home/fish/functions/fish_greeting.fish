# https://www.asciiart.eu/art/5cbdf6e95fc805f7
set -l message_day  (string join -- '\n'\
  '           ^^                  @@@@@@@@@                              ' \
  '      ^^       ^^           @@@@@@@@@@@@@@@                           ' \
  '                           @@@@@@@@@@@@@@@@@              ^^          ' \
  '      i love you          @@@@@@@@@@@@@@@@@@@                         ' \
  '~~~~ ~~ ~~~~~ ~~~~~~~~ ~~ &&&&&&&&&&&&&&&&&&& ~~~~~~~ ~~~~~~~~~~~ ~~~ ' \
  '~         ~~   ~  ~       ~~~~~~~~~~~~~~~~~~~ ~       ~~     ~~ ~     ' \
  '  ~      ~~      ~~ ~~ ~~  ~~~~~~~~~~~~ ~~~~  ~     ~~~    ~ ~~~  ~ ~~' \
  '  ~  ~~     ~         ~     ~~~~~~  ~~ ~~~       ~~ ~ ~~  ~~ ~        ' \
  '~  ~       ~ ~      ~          ~~ ~~~~~~  ~      ~~  ~             ~~ ' \
  '      ~             ~       ~      ~      ~~   ~             ~        ' \
  'peter bier (pjb), reshaped, text added'
)

# normally i'd never use "
# https://www.asciiart.eu/art/ec00171f6c37d765
set -l message_night (string join -- '\n' \
  "        _    .  ,   .     stay strong,                 " \
  "    *  / \_ *  / \_      _ my beloved.   /\'__        *" \
  "      /    \  /    \,   ((        .    _/  /  \  *'.   " \
  " .   /\/\  /\/ :' __ \_  `          _^/  ^/    `--.    " \
  "    /    \/  \  _/  \-'\      *    /.' ^_   \_   .'\  *" \
  "  /\  .-   `. \/     \ /==~=-=~=-=-;.  _/ \ -. `_/   \ " \
  " /  `-.__ ^   / .-'.--\ =-=~_=-=~=^/  _ `--./ .-'  `-  " \
  "/        `.  / /       `.~-^=-=~=^=.-'      '-._ `._   " \
  "Joan G. Stark (Spunk) (jgs), text added"
)

set -l hour (date '+%-H')
if test $hour -lt 6; or test $hour -gt 22
  printf $message_night
else
  printf $message_day
end

printf '\n\n'
date '+it\'s %H:%M:%S, %a %-d %B %Y'
printf '\n'
