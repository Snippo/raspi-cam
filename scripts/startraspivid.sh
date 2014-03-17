#!/bin/sh
CLIENTS="192.168.3.2:5000,192.168.3.250:5000"
mkdir /tmp/stream &
sudo mount -t tmpfs -o size=32m tmpfs /tmp/stream & # Creates ramdisk
sudo raspivid -ex night -t 0 -w 1280 -h 720 -fps 10 -rot 90 -b 2000000 -o - | gst-launch-1.0 -e -vvv fdsrc ! tee name="splitter" ! queue ! h264parse ! rtph264pay pt=96 config-interval=5 ! multiudpsink clients=$CLIENTS splitter. ! queue !  video/x-h264,framerate=10/1,stream-format=byte-stream,width=800,height=600 ! decodebin ! videorate ! videoscale ! video/x-raw,framerate=5/1,width=640,height=480 !  videoconvert ! jpegenc ! multifilesink location=/tmp/stream/img_%07d.jpg &
