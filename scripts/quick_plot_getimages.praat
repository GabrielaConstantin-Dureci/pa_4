###############################################################################
# Quick plotter                                                               #
# Joseph V. Casillas                                                          #
# Last update: 11/08/2016                                                     #
#                                                                             #
# Overview                                                                    #
# - This script provides a quick and dirty way to create a quality plot of a  #
#   sound file in Praat                                                       #
# - You can zoom in on a specific region, as well as highlight areas of       #
#   interest                                                                  #
# - The script will also allow you to save the output in the directory of     #
#   your choice, in the format of your choice                                 #
# TODO                                                                        #
# - FIX: If no areas of interest are selected, verticle lines appear in the   #
#   middle of the plot                                                        #
#                                                                             #
###############################################################################


# Did you select a sound?
beginPause ("Plot sound file")
	comment ("Make sure you select the sound file you would like to plot (just the sound file).")
clicked = endPause ("Cancel", "Next", 2, 1)
if clicked = 1
	exit The plot was not created
endif

###############
# PLOT THINGS #
###############

# Prepare viewport for oscillogram
Erase all
Select outer viewport: 0, 6, 0, 2.5

# Select sound and areas of interest
# and draw oscillogram
name$ = selected$("Sound")
Edit
	editor Sound 'name$'
		pause Select area if you would like to zoom in
		Zoom to selection
		pause Select area of interest
		Move start of selection to nearest zero crossing
		Move end of selection to nearest zero crossing
# Draw oscillogram
		Draw visible sound: "no", "yes", 0, 0, "no", "no", "yes", "no"
	endeditor

# Put box around oscillogram
Draw inner box

# Prepare viewport for spectrogram
Select outer viewport: 0, 6, 1.5, 4

# Select sound and areas of interest
# and draw oscillogram
	editor Sound 'name$'
		Paint visible spectrogram: "no", "no", "no", "yes", "yes"
		Close
	endeditor

# Select entire image
Select outer viewport: 0, 6, 0, 4

# Add title
Text top: "no", name$


###############
# Save things #
###############

# Save file prompt with opt out
beginPause ("Save file")
	comment ("Would you like to save the file?")
clicked = endPause ("No", "Yes", 2, 1)
if clicked = 1
	exit The plot was not saved
endif

# Where to save
dir$ = chooseDirectory$ ("Where you woud like to save the file?")
if dir$ = ""
	exit The experiment file was not created.
endif

# File format with opt out
beginPause ("Save file")
	comment ("What is your preferred file format?")
clicked = endPause ("PDF", "PNG (300-dpi)", "PNG (600-dpi)", 3)
if clicked = 1
	Save as PDF file:  "'dir$'/'name$'.pdf"
elsif clicked = 2
	Save as 300-dpi PNG file:  "'dir$'/'name$'.png"
elsif clicked = 3
	Save as 600-dpi PNG file:  "'dir$'/'name$'.png"
endif


