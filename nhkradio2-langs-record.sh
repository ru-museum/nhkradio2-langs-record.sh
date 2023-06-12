#!/bin/bash

set -euo pipefail

# --------------------------------------------------
# 
# NHKラジオ第2放送　語学講座番組録音 - 汎用版　
# 
# --------------------------------------------------
# 放送波URL: 以下で取得出来ます（2021）。 
# https://www.nhk.or.jp/radio/config/config_web.xml

FILECSV="languages.csv"

# 【対応言語講座】
# NHKラジオ語学講座リスト
LANGUAGE_COURSES=(
  "0,まいにちロシア語,初級編 応用編,月〜水 木・金,8:50-9:05,00:15:00,1-2-3 4-5"
  "1,まいにちフランス語,初級編 応用編,月〜水 木・金,7:30-7:45,00:15:00,1-2-3 4-5"
  "2,まいにちドイツ語,初級編 応用編,月〜水 木・金,7:00-7:15,00:15:00,1-2-3 4-5"
  "3,まいにちイタリア語,初級編 応用編,月〜水 木・金,7:45-8:00,00:15:00,1-2-3 4-5"
  "4,まいにちスペイン語,初級編 応用編,月〜水 木・金,7:15-7:30,00:15:00,1-2-3 4-5"
  "5,まいにち中国語,,月〜金,8:15-8:30,00:15:00,1-2-3-4-5"
  "6,ステップアップ中国語,,月・火,10:30-10:45,00:15:00,1-2"
  "7,小学生の基礎英語,,月・水・金,18:35-18:45,00:10:00,1-3-5"
  "8,中学生の基礎英語レベル1,,月〜金,6:00-6:15,00:15:00,1-2-3-4-5"
  "9,中学生の基礎英語レベル2,,月〜金,6:15-6:30,00:15:00,1-2-3-4-5"
  "10,中高生の基礎英語inEnglish,,月〜金,6:30-6:45,00:15:00,1-2-3-4-5"
  "11,ラジオ英会話,,月〜金,6:45-7:00,00:15:00,1-2-3-4-5"
  "12,ボキャブライダー,,月〜金,9:05-9:10,00:05:00,1-2-3-4-5"
  "13,エンジョイ・シンプル・イングリッシュ,,月〜金,9:10-9:15,00:05:00,1-2-3-4-5"
  "14,英会話タイムトライアル,,月〜金,8:30-8:40,00:10:00,1-2-3-4-5"
  "15,ラジオビジネス英語,,月〜金,7:45-8:00,00:15:00,1-2-3-4-5"
  "16,ニュースで学ぶ「現代英語」,,月〜金,9:30-9:45,00:05:00,1-2-3-4-5"
  "17,まいにちハングル講座,,月〜金,8:00-8:15,00:15:00,1-2-3-4-5"
  "18,ステップアップ ハングル講座,,木・金,10:30-10:45,00:15:00,4-5"
  "19,アラビア語講座,,日,9:30-10:00,00:30:00,0"
  "20,ポルトガル語入門,,土,18:45-19:00,00:15:00,6"  
)

# HELP 表示用リスト：ファイルへ出力
cat <<EOM > ${FILECSV}
 0,まいにちロシア語,初級編 応用編,月〜水 木・金,8:50-9:05,00:15:00,1-2-3 4-5
 1,まいにちフランス語,初級編 応用編,月〜水 木・金,7:30-7:45,00:15:00,1-2-3 4-5
 2,まいにちドイツ語,初級編 応用編,月〜水 木・金,7:00-7:15,00:15:00,1-2-3 4-5
 3,まいにちイタリア語,初級編 応用編,月〜水 木・金,7:45-8:00,00:15:00,1-2-3 4-5
 4,まいにちスペイン語,初級編 応用編,月〜水 木・金,7:15-7:30,00:15:00,1-2-3 4-5
 5,まいにち中国語,,月〜金,8:15-8:30,00:15:00,1-2-3-4-5
 6,ステップアップ中国語,,月・火,10:30-10:45,00:15:00,1-2
 7,小学生の基礎英語,,月・水・金,18:35-18:45,00:10:00,1-3-5
 8,中学生の基礎英語レベル1,,月〜金,6:00-6:15,00:15:00,1-2-3-4-5
 9,中学生の基礎英語レベル2,,月〜金,6:15-6:30,00:15:00,1-2-3-4-5
 10,中高生の基礎英語inEnglish,,月〜金,6:30-6:45,00:15:00,1-2-3-4-5
 11,ラジオ英会話,,月〜金,6:45-7:00,00:15:00,1-2-3-4-5
 12,ボキャブライダー,,月〜金,9:05-9:10,00:05:00,1-2-3-4-5
 13,エンジョイ・シンプル・イングリッシュ,,月〜金,9:10-9:15,00:05:00,1-2-3-4-5
 14,英会話タイムトライアル,,月〜金,8:30-8:40,00:10:00,1-2-3-4-5
 15,ラジオビジネス英語,,月〜金,7:45-8:00,00:15:00,1-2-3-4-5
 16,ニュースで学ぶ「現代英語」,,月〜金,9:30-9:45,00:05:00,1-2-3-4-5
 17,まいにちハングル講座,,月〜金,8:00-8:15,00:15:00,1-2-3-4-5
 18,ステップアップ ハングル講座,,木・金,10:30-10:45,00:15:00,4-5
 19,アラビア語講座,,日,9:30-10:00,00:30:00,0
 20,ポルトガル語入門,,土,18:45-19:00,00:15:00,6  
EOM

# このスクリプトファイルが存在する作業ディレクトリ PATH を取得。
SCRIPT_DIR=$(cd $(dirname $0) && pwd)

# 日時生成
arr=("日" "月" "火" "水" "木" "金" "土")
DAY=`date '+%w'`
_DAY="(${arr[$DAY]})"
YEAR=`date '+%Y'`
DATE1=`date '+%m%d'`
DATE2=`date '+%H:%M'`
DATE="${YEAR}${DATE1}${_DAY}-${DATE2}"

# --------------------------------------------------
# 基本変数初期化
# ストリーミング配信 URL
M3U8URL="https://radio-stream.nhk.jp/hls/live/2023501/nhkradiruakr2/master.m3u8"
# 2021年9月現在 URL が変更されています。
# 旧URL：上記で動作しない場合は試して下さい。
# M3U8URL="https://nhkradioakr2-i.akamaihd.net/hls/live/511929/1-r2/1-r2-01.m3u8"
COURSE=""
COURSENUM=""
COURSENAME=""
SLPSECONDS=0 # 開始時刻遅延初期値： 秒 -- 変更可能。

# 番組リストファイル
DATAFILE="${SCRIPT_DIR}/${FILECSV}" # 番組リストファイル

# --------------------------------------------------
# 番組リスト表示：column 6,7 は非表示
function dsp_list {
   echo "-------------------------------------------------------------------------------"
   echo "ID|講座名                              |コース分類   |放送曜日     |放送時間"
   echo "-------------------------------------------------------------------------------"
   cat $DATAFILE | column -H 6,7 -t -s ',' -o '|'
   echo "-------------------------------------------------------------------------------"
   echo "  "
  exit 3
}

# --------------------------------------------------
# helpを作成
function dspHelp {
  cat <<EOM
Usage: $(basename "$0") -i [ID] -c [ p | a ]
  -h            ヘルプを表示します。
  -i [VALUE]    講座 ID 番号を指定します。
  -c [VALUE]    講座が複数(初級編、応用編)あり何れか一方のみを録音する場合：
                初級編 [p] | 応用編 [a]　で指定します。
                ※ オプションを無記入の場合、初級編及び応用編共に録音されます。
  -s [VALUE]    開始時刻を遅延させる： 秒              
                
【NHKラジオ第二放送 語学講座番組】(2023年度6月) *講座のID番号を選択します。
EOM
   dsp_list # 番組リスト表示
   exit 2
}

# --------------------------------------------------
# OPTION 引数別の処理定義
while getopts ":c:i:s:h" optKey; do
  case "$optKey" in
    i)
      COURSENUM="${OPTARG}"  # 指定講座 ID の OPTION 入力値
      ;;
    c)
      COURSENAME="${OPTARG}" # 初級編・応用編の OPTION 入力値
      ;;
    s)
      SLPSECONDS="${OPTARG}" # 開始時刻遅延の OPTION 入力値
      ;;
    '-h'|'--help'|* )
      dspHelp
      ;;
  esac
done

# --------------------------------------------------
# 初級編又は応用編何れかのみに限定する（曜日設定）には CRON( [] 部分 ) で行います。
# 初級編：1-3　応用編：4-5　　【例】 50 8 * * [1-5]	
# ID 0-4 までの講座に付加
if [ ${COURSENUM} -lt 5 ]; then
  if [ $DAY -ge 1 -a $DAY -le 3 ];then
        COURSE="【初級編】"
  elif [ $DAY -eq 4 -o $DAY -eq 5 ];then
        COURSE="【応用編】"
  fi
fi

# --------------------------------------------------
# 講座名の取得
getCourseName () {
    list="${LANGUAGE_COURSES[$1]}" # 指定ID 
    str=(${list//,/ })             # コンマ区切りで配列にする
    echo "${str[1]}"
}

# --------------------------------------------------
# 前処理
# --------------------------------------------------
# 通常は講座名が入ります：変更可
# 指定が無ければ選択された講座名が設定されます。
TITLE=""
if [ "$TITLE" = "" ]; then
   # TITLE="${LANG_COURSES[${COURSENUM},name]}"
   TITLE=`getCourseName $COURSENUM`
fi

# 作業ディレクトリに「講座名」の保存ディレクトリを作成します。
DIRNAME=`getCourseName $COURSENUM`

# ファイルの保存ディレクトリ設定：絶対 PATH を指定 -- 変更可能。
# 通常は /root/ 或いは /home/username/ から始まります
SAVEDIR="${SCRIPT_DIR}/${DIRNAME}"

# 保存ファイル名 ＋ コース ＋ 日付
SAVEFILE="${TITLE}${COURSE}-${DATE}"

dir="${SAVEDIR}" # 一時変数

# 保存ディレクトリ ＋ 保存ファイル名
SAVEFILE_PATH="${dir}/${SAVEFILE}"

# 保存ディレクトリが無ければ作成。
makeDirctory(){
  if [[ ! -e $1 ]]; then
      mkdir $1
  elif [[ ! -d $1 ]]; then
      echo "$1 already exists but is not a directory" 1>&2
  fi
}

# 録音時間設定：　時：分：秒 -- 変更可能。　
# 秒で設定する場合： "900"（15分 x 60秒） 
REC_TIME="00:15:00" 

# 開始時刻を遅延させる： 秒 -- 変更可能。
# sleep 5m 50s （分：秒）
sleep $SLPSECONDS

# 録音したファイルを保存
if [ COURSENUM ]; then

  # 保存ディレクトリが無ければ作成。
  makeDirctory $dir
  
  # 録音して保存
  ffmpeg -i "${M3U8URL}" -t "${REC_TIME}" -c copy "${SAVEFILE_PATH}".m4a

else
  echo "OPTION: -i [ID] で番号を指定して下さい" 1>&2
  exit 1
fi

exit
