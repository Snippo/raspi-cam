#!/usr/bin/python
import StringIO
import os
import math
import operator
import time
from datetime import datetime
from PIL import Image

threshold = 1000				# Minimum RMS for motion
filepath = "/tmp/stream"	# Directory where images are located

# Calculate histogram of newest image
def calcHist():
	try:
		files = sorted(os.listdir(filepath),key=lambda p: os.path.getctime(os.path.join(filepath, p)))
		fpath = os.path.join(filepath, files[-4])
		im = Image.open(fpath)
		hist = im.histogram()

		return hist
	except Exception:
		pass

os.system('clear')
print "----------------------------------"
print "RMS for motion = " + str(threshold)
print "Directory where images are loaded from = " + filepath
print "----------------------------------"

# Calculate histogram for first image
hist1 = calcHist()

f = open("/home/pi/motion.txt", "w")

while (True):
	try:
		time.sleep(0.2)
		# Get comparison image
		hist2 = calcHist()

		# Calculates the RMS 
		rms = math.sqrt(reduce(operator.add, map(lambda a,b: (a-b)**2, hist1, hist2))/len(hist1))
		
		# Sets last image as the first histogram for the next iteration
		hist1 = hist2

		if (rms > threshold):
			currentTime = datetime.now()
			print "Motion detected at ", currentTime, rms
			f.write("Motion detected at %s with RMS: %d \n" % ( currentTime, rms))
			f.flush()

	except Exception:
		pass
