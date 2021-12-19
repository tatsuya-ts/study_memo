#! /bin/bash

LOCALHOST=127.0.0.1
#6379
PORTS=(7001 7002 7003 7004 6379 7006) #clusterの各port
PORTS_LEN=${#PORTS[*]}                     #6
CURRENT_TIME=$(date +%s)
TIMESTAMP=''
LOGFILE=./redis_batch.log

LOG_TEMP=./tmp/temp.log

check_timestamp() {
    echo ${TIMESTAMP}
    if [ -z "${TIMESTAMP}" ]; then
        echo ' timestampの値が取得できません'
        if [ ${i} -eq 5 ]; then
            echo "redis cluesterからtimestamp取得できませんでした。ここもエラー"
        fi
        continue
    else
        echo  port: ${PORTS[$i]} timestamp値の取得成功、timestamp:${TIMESTAMP}計算開始
        var=$(expr ${CURRENT_TIME} - ${TIMESTAMP})
        #10分以上経過していたらエラー出力
        if [ ${var} -ge 600 ]; then
            echo " エラーログ出力するように。" > redis_batch_error.log
            break
        else
            echo " 正常終了しますログ出力する"
            break;
        fi
    fi
}
echo "Start batch ..."
#redis clusuterの数だけループ。 接続完了 && キューから値が取得できたらbreak, それ以外は次のループ
echo 'Loop start...'
# redis connect command

for ((i = 0; i < ${PORTS_LEN}; i++)); do
    #死活監視
    echo ${LOCALHOST} の port: ${PORTS[$i]} へ接続します
    echo $(nc -vz ${LOCALHOST} ${PORTS[$i]} )
    get_timestamp_cmd=$(redis-cli -h ${LOCALHOST} -p ${PORTS[$i]} -c LINDEX queue 0 | jq -r '.headers[0].timestamp')
    TIMESTAMP=${get_timestamp_cmd}
    echo b${TIMESTAMP}
    # call func
    check_timestamp
done
echo '...Loop end'
echo "End batch."


##### redisの接続確認
#ping でports配列を回す
#成功した場合はそのポート番号を変数に格納。
#全部失敗した場合(変数が0の時)はエラーログとして終了する
