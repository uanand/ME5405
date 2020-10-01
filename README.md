# ME5405
Computer Vision module codes in [MATLAB](https://www.mathworks.com)/[Octave](https://www.gnu.org/software/octave/).

To process [Image 1](https://github.com/uanand/ME5405/blob/master/charact1.txt), run the code 'processTextFile.m'.
To process [Image 2](https://github.com/uanand/ME5405/blob/master/charact2.bmp), run the code 'processPngFile.m'.

# Objective
[Image 1](https://github.com/uanand/ME5405/blob/master/charact1.txt) (charact1.txt) is a 64x64 image. [Image 2](https://github.com/uanand/ME5405/blob/master/charact2.bmp) (charact2.bmp) is a bitmap image of a label on a microschip. For each image, the following tasks need to be performed.

1. Display the original image.
2. Create a binary image using thresholding.
3. Segment the original image to separate and identify the different characters.
4. Rotate the characters in the image avout their own respective centroids by 90 degrees clockwise.
5. Rotate the characters in the image from step 4 about their oqn respective centroids by 35 degrees counterclockwise.
6. Determine the outline(s) of characters of the image from Step 3.
7. Determine a one-pixel thin image of the characters from Step 3.
6. Scale and display the characters of Image 1 in one line with the sequence 1A2B3C.
7. Scale and display the characters of Image 2 in one line with the sequence 7M2HD44780A00.

# Approach
In order to develop a better understanding, all the algorithms have been implemented using the first principle calculations using loops. Due to this the run-time is much longer (especially in Octave). However, the idea is to understand how the basic image processing algorithms work.

For loading images into the system memory, inbuilt functions [fileread](https://in.mathworks.com/help/matlab/ref/fileread.html) and [imread](https://in.mathworks.com/help/matlab/ref/imread.html) are used. In addition to this [bwlabel](https://in.mathworks.com/help/images/ref/bwlabel.html) is used to label different connected components in the segmented binary image. The same functions are available in Octave package [Image](https://octave.sourceforge.io/image/index.html).

The detais of implemented algorithms can be found [here](https://github.com/uanand/ME5405/blob/master/A0191623H_A0147589J_ProjectReport.pdf).

# Requirements
The codes have been tested on Windows 10 (64-bit), Linux Mint Cinnamon 19.2 (64-bit), and Raspbian Buster (32-bit, Octave only). The following programs need to be installed.

1. MATLAB with [image processing toolbox](https://www.mathworks.com/products/image.html)
2. Octave with image package.

# Known issues
1. TODO - implement particle labelling algorithm to label different connected components in a binary image. 
