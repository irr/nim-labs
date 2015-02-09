# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias n='nautilus &> /dev/null'
alias nt='sudo netstat -antp'
alias perm='sudo chown -R irocha:'
alias perms='find . -type f -exec chmod 644 {} \; && find . -type d -exec chmod 755 {} \;'
alias uoldns='echo -e "nameserver 200.221.11.100\nnameserver 200.221.11.101"|sudo tee /etc/resolv.conf '
alias opendns='echo -e "nameserver 208.67.222.222\nnameserver 208.67.220.220"|sudo tee /etc/resolv.conf '
alias gdns='echo -e "nameserver 8.8.8.8\nnameserver 8.8.4.4"|sudo tee /etc/resolv.conf '
alias rsvn='find . -name ".svn" -exec rm -rf {} \;'
alias gc='git clone'
alias gcn='GIT_SSL_NO_VERIFY=1 git clone'
alias ic='iconv -f UTF8 -t ISO885915//TRANSLIT < '
alias mget='wget --mirror -p --html-extension --convert-links'
alias mp='mplayer -loop 0'
alias mpv='mplayer -loop 0 -vo null'
alias v='vlc'
alias id3rename='for file in *.mp3 ; do id3v2 -t "${file%.mp3}" "${file}"; done'
alias chmods='find . -type f -exec chmod 644 {} \; && find . -type d -exec chmod 755 {} \;'
alias rarbk='rar a -r -rr -tk'

alias json='python -mjson.tool'

alias centos='ssh -p 2222 root@localhost'
alias ocean='ssh -p 443 root@37.139.17.122'

alias reps='repos; reposf'
alias repos='(cd $HOME/git; for i in *;do cd $HOME/git/$i; echo "====================================================================================================";echo `pwd`;git status; git pull;done)'
alias reposf='(cd $HOME/gitf; for i in *;do cd $HOME/gitf/$i; echo "====================================================================================================";echo `pwd`;git status; git fetch upstream && git merge upstream/master && git push;done)'
alias reposfs='(echo "====================================================================================================";echo `pwd`;git status; git fetch upstream && git merge upstream/master && git push)'

function repofork {
    cd "$1"
    git remote add upstream "$2" && git fetch upstream && git merge upstream/master && cd ..
}

function gsync() {
    git commit -m "$1" -a && git push
    local gs=$?
    echo $gs
    return $gs
}

function data {
    find "$@" -name "*.jpg" -type f |sort -u
}

function g {
    /usr/bin/gvim -p "$@" &> /dev/null &
}

source ~/git/configs/github/.git-completion.sh

alias psg='ps -ef|grep nginx'

function ng {
    $(nginx_cmd) -c "$(echo `pwd`)/$1"
}

function ngr {
    ngs; ng "$1" && ngt
}

function ngs {
    $(nginx_cmd) -s stop
}

function ngc {
    rm -rf $(nginx_logs)*
    mkdir -p $(nginx_logs)
}

function ngt {
    tail -f $(nginx_logs)/*.log
}

function nginx {
    $(nginx_cmd) "$@"
}

function nginx_cmd {
    echo "/opt/lua/openresty/nginx/sbin/nginx";
}

function nginx_logs {
    echo "/opt/lua/openresty/nginx/logs";
}

function j2x {
    cat ~/git/configs/java/stub.sh $1 > ${1%.jar}.run && chmod +x ${1%.jar}.run
}

function l2c {
    luac -o /tmp/luac.out $1
    ~/lua/bin2c/bin2c /tmp/luac.out > /tmp/code.c
    gcc -o $2 ~/lua/bin2c/main.c -llua
    echo "$2 compiled ok."
}

function lj2c {
    luajit -b $1 /tmp/luac.out
    ~/lua/bin2c/bin2c /tmp/luac.out > /tmp/code.c
    gcc -I/opt/lua/openresty/luajit/include/luajit-2.1 -L/opt/lua/openresty/luajit/lib -o $2 ~/lua/bin2c/main.c -lluajit-5.1
    echo "$2 compiled ok."
}

function nmc {
    nim c -d:release "$@"
    rm -rf nimcache
}

function nms {
    nim c -d:quick --opt:size "$@"
    rm -rf nimcache
}

alias rmn='rm -rf nimcache'

export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

alias mkenv='virtualenv -p /usr/local/bin/python2.7'
alias dev='source ~/dev/bin/activate'
alias devbak='rm -rf /opt/python/dev.bak; cp -r ~/dev /opt/python/dev.bak'
alias devres='if [ -d /opt/python/dev.bak ]; then rm -rf ~/dev; cp -r /opt/python/dev.bak ~/dev; fi'

alias luaj='rlwrap -H /dev/null luajit'

if [ -f $HOME/.pythonrc ]; then
    export PYTHONSTARTUP=~/.pythonrc
fi

export LUA_INIT=@$HOME/lua/configs/init.lua

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.31-1.b13.el6_6.x86_64

export HADOOP_USER_NAME=admin
export HADOOP_CONF_DIR=/home/irocha/scala/hadoop-conf
export YARN_CONF_DIR=/home/irocha/scala/yarn-conf

export PATH=$PATH:/opt/java/hadoop/bin:/opt/java/spark/bin

