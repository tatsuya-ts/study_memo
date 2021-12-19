#! /bin/bash

HOST=127.0.0.1
PORTS=(7001 7002 7003 7004 6379 7006) #clusterの各port #6379
PORTS_LEN=${#PORTS[*]}                #6
CURRENT_TIME=$(date +%s)
TIMESTAMP=''

# LOGFILE='./log/redis_batch.log'
# ERRORLOGFILE='./log/error/redis_batch_error'
# LOG_TEMP='./tmp/temp.log'

##### func
check_timestamp() {
    echo ${TIMESTAMP}
    if [ -z "${TIMESTAMP}" ]; then
        echo '[INFO] redis timestamp checkbatch :  timestamp値が取得できません'
        if [ ${i} -eq $(expr "${PORTS_LEN}" - 1) ]; then
            echo '[ERROR] redis timestamp checkbatch : redis cluesterからtimestamp取得できませんでした。ここもエラー'
        fi
        continue
    else
        echo port: ${PORTS[$i]} timestamp値の取得成功、timestamp:${TIMESTAMP}
        ERASPED_SECONDS=$(( ${CURRENT_TIME} - ${TIMESTAMP} ))
        echo 現在日時からの経過 : ${ERASPED_SECONDS}秒
        #10分以上経過していた[INFO] redis timestamp checkbatch : エラー出力
        # if [ ${ERASPED_SECONDS} -ge 600 ]; then
        
        if [ ${ERASPED_SECONDS} -ge 600 ]; then
            echo '[ERROR] redis timestamp checkbatch : 10分以上経過しています'
            break
        else
            echo '[INFO] redis timestamp checkbatch :  正常終了します'
            break
        fi
    fi
}
##### 

##### start batch
echo '[INFO] redis timestamp checkbatch : Start batch ...'
#redis clusuterの数だけループ。 接続完了 && キューから値が取得できたらbreak, それ以外は次のループ
echo '[INFO] redis timestamp checkbatch : Loop start...'
for ((i = 0; i < ${PORTS_LEN}; i++)); do
    echo ${HOST} の port: ${PORTS[$i]} へ接続します
    echo $(nc -vz ${HOST} ${PORTS[$i]})
    TIMESTAMP=$(redis-cli -h ${HOST} -p ${PORTS[$i]} -c LINDEX queue 0 | jq -r '.headers[0].timestamp')
    # call func
    check_timestamp
done
echo '[INFO] redis timestamp checkbatch : ...Loop end' &>ddd.log
echo '[INFO] redis timestamp checkbatch : End batch.' &>ddd.log
#end batch