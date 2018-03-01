#!/bin/sh
#
#
APP_DIR=/home/app/amp
APP_NAME=amp-ah-services-1.0.0.RELEASE
APP_CONF=$APP_DIR/application.properties

#set java home
export JAVA_HOME=/usr/java/jdk1.8.0_151

usage() {
    echo "Usage: sh amp-ah.sh [start|stop|deploy]"
    exit 1
}

kills(){
    tpid=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
    if [[ $tpid ]]; then
        echo 'Kill Process!'
        kill -9 $tpid
    fi
}

start(){
    rm -f $APP_DIR/tpid
    #nohup java -jar amp-ah-services-1.0.0.RELEASE.jar -Dspring.config.location /opt/amp/application.properties > /dev/null 2>&1 &
    nohup java -jar $APP_DIR/"$APP_NAME".jar > /dev/null 2>&1 &
    echo $! > $APP_DIR/tpid
    echo Start Success!
}

stop(){
        tpid1=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
    echo tpid1-$tpid1
        if [[ $tpid1 ]]; then
        echo 'Stop Process...'
        kill -15 $tpid1
    fi
    sleep 5
    tpid2=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
        echo tpid2-$tpid2
    if [[ $tpid2 ]]; then
        echo 'Kill Process!'
        kill -9 $tpid2
    else
        echo 'Stop Success!'
    fi

}

check(){
    tpid=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
    if [[ tpid ]]; then
        echo 'App is running.'
    else
        echo 'App is NOT running.'
    fi
}

deploy() {
    kills
    rm -rf $APP_DIR/"$APPNAME".jar
    cp "$APP_NAME".jar $APP_DIR
}

case "$1" in
    "start")
        start
        ;;
    "stop")
        stop
        ;;
    "kill")
        kills
        ;;
    "deploy")
        deploy
        ;;
    *)
        usage
        ;;
esac
