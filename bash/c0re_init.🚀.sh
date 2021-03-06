
## * * * *// 
#* Purpose: imports standard bash behaviors
#*          for consistent handling of parameters
#*
## * * * *//




function checkOS() {
    IS_supported=`cat /etc/os-release | grep "Ubuntu 20.04.2 LTS"`
    if [ -z "$IS_supported" ] ; then
        cat /etc/os-release
        echo "ð½ä¸æ¯æ  OS not yet supported." && exit 0
    fi
    return "ð"
}
checkOS_result="$(checkOS)"
echo "checkOS_result: $checkOS_result"

#func(){
#    echo "Username: $USER"
#    echo "    EUID: $EUID"
#}
# ð¤ "Exporting" export -f creates an env variable with the function body.
# export -f func

##* * * * * *\\
if [ "$EUID" -ne 0 ]
  then echo "ð½ Please run as root, use sudo or enter root password" 
  # su "$SUDO_USER" -c 'func'
fi
##* * * * * *//


## å½ä»¤ \\
# MÃ¬nglÃ¬ng // Command   (mkdir)
function mkdir_å½ä»¤() {
    dir=$1
    cmd="/bin/mkdir -p \"$dir\""
    result=$( "$cmd" )
    echo "ð $cmd"
    
    if [ ! -d "$dir" ] ; then 
        log_ð¢_è®°å½ "ð½:ä¸æ¯æ failed. probably requires permission!" 

        log_ð¢_è®°å½ "ð.run: sudo $cmd"
        `/usr/bin/sudo $cmd`
        if [ ! -d "$dir" ] ; then 
            log_ð¢_è®°å½ "ð½:ä¸æ¯æ sudo didn't work either."
        fi
    fi
    }
export mkdir_å½ä»¤
mkdir_å½ä»¤ "$HOME/._b00t_"
mkdir_å½ä»¤ "$HOME/._b00t_/c0re"
chmod 711 "$HOME/._b00t_/c0re"
## å½ä»¤ // 

## å¥½ä¸å¥½ \\
## HÇo bÃ¹ hÇo :: Good / Not Good 
## is_file readable? 
# n0t_file_ð_å¥½ä¸å¥½ result: 
#   0 : file is okay
#   1 : file is NOT okay
function n0ta_file_ð_å¥½ä¸å¥½() {

    if [ ! -f "$1" ] ; then
        log_ð¢_è®°å½ "ð½:ä¸æ¯æ $1 is both required AND missing. ð½:éå¸¸è¦!"
        return 0
    elif [ ! -x "$1" ] ; then
        log_ð¢_è®°å½ "ð½:ä¸æ¯æ $1 is not executable. ð½:éå¸¸è¦!"
        return 0
    else
        # success
        log_ð¢_è®°å½ "ð $1"
        return 1
    fi
}
## å¥½ä¸å¥½ // 

### - -   is_WSLv2_ð§ððªv2   - - \\
## Microsoft Windows Linux Subsystem II  WSL2
## ð¤ https://docs.microsoft.com/en-us/windows/wsl/install-win10
#
function is_WSLv2_ð§ððªv2() {
    return `cat /proc/version | grep -c "microsoft-standard-WSL2"`
}
### - -   is_WSLv2_ð§ððªv2   - - //



##* * * * * *\\
# Install Some Tooling
# ð° fzf - menu, file choose  https://github.com/junegunn/fzf#using-git
# ð° jq  - JSON config i/o    https://stedolan.github.io/jq/
# ð° wget- HTTP i/o 
# ð° curl- HTTP i/o 

sudo apt-get install -y fzf jq wget curl

# ð° yq  - YAML config i/o    https://github.com/mikefarah/yq
if n0ta_file_ð_å¥½ä¸å¥½ "/usr/bin/yq" ; then
    systemctl status snapd.service
    snap install
fi

# yq, part II - Windows
## For WSL - snapd won't work 
if n0ta_file_ð_å¥½ä¸å¥½ "/usr/bin/yq" ; then
    sudo apt-get update && sudo apt-get install -yqq daemonize dbus-user-session fontconfig
fi

if n0ta_file_ð_å¥½ä¸å¥½ "/usr/bin/yq" ; then
    YQ_VERSION="v4.7.0"
    YQ_BINARY="yq_linux_amd64"
    wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}.tar.gz -O - |\
        tar xz && cp ${YQ_BINARY} /usr/bin/yq

    if n0ta_file_ð_å¥½ä¸å¥½ "/usr/bin/yq" ; then
        log_ð¢_è®°å½ "ð© STILL missing /usr/bin/yq"
        exit
    fi
fi

##* * * * * *//


##* * * * * *\\
## generates a random number between 0 and \$1
# usage: 
# rand0_result="$(rand0 100)"
# echo \$rand0_result

function rand0() {
    max="$1"
    rand0=$( bc <<< "scale=2; $(printf '%d' $(( $RANDOM % $max)))" ) ;
    # rand0=$( echo $RANDOM % $max ) ; 
    echo $rand0
}

##* * * * * *//

