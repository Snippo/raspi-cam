#!/bin/sh
DIR=/home/pi/raspi-cam/mjpgstreamer
USR=user
PWD=password
PORT=1010
export LD_LIBRARY_PATH=$DIR
$DIR/mjpg_streamer -o "$DIR/output_http.so -w $DIR/www -p $PORT" -i "$DIR/input_file.so -f /tmp/stream" &

# Authenication disabled because it doesn't work in Internet Explorer, to enable use:
# $DIR/mjpg_streamer -o "$DIR/output_http.so -w $DIR/www -c $USR:$PWD -p $PORT" -i "$DIR/input_file.so -f /tmp/stream" &
