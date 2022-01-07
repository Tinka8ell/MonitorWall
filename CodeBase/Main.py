'''
Created on 7 Jan 2022

This is the main entry point for the Monitor Wall
Once the code base has been validated (e.g. updated),
Main will be called and execute the code below.

@author: Tinka
'''

from tkinter import Tk
from MonitorWall import InfoBox

if __name__ == '__main__':
    print("For now this is just a place holder ...")
    root = Tk()
    info = InfoBox() # display some info
    root.mainloop()  # wait for the box to close ...
