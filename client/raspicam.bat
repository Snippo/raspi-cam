D:
cd gstreamer\1.0\x86_64\bin
gst-launch-1.0 udpsrc port=5000 ! application/x-rtp, payload=96 ! rtpjitterbuffer ! rtph264depay ! avdec_h264 ! fpsdisplaysink sync=false text-overlay=false
