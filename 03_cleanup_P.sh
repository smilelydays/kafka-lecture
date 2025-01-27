#! /bin/sh


#shutdown all brokers
bash ./02_self/util/shutdown_broker.sh 1
bash ./02_self/util/shutdown_broker.sh 2
bash ./02_self/util/shutdown_broker.sh 3

#delete all logs
rm -rf /tmp/kraft-combined-logs-*

#delete server logs
rm -rf $KAFKA_HOME/logs/server_1
rm -rf $KAFKA_HOME/logs/server_2
rm -rf $KAFKA_HOME/logs/server_3

#remove all variables from `.bashrc`
if grep -q "NICK_NAME" ~/.bashrc ; then
    sed -i "/$(grep -P "NICK_NAME" ~/.bashrc)/d" ~/.bashrc
    
fi          
if grep -q "SERVER_IP" ~/.bashrc ; then
    sed -i "/$(grep -P "SERVER_IP" ~/.bashrc)/d" ~/.bashrc
    
fi
if grep -q "KAFKA_HOME" ~/.bashrc ; then    
    sed -i "/KAFKA_HOME/d" ~/.bashrc    
fi

#unset all environments
unset NICK_NAME
unset SERVER_IP
unset KAFKA_HOME

#apply the changes
source ~/.bashrc
