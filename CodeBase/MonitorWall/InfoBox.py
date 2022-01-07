'''
Created on 7 Jan 2022

@author: Tinka
'''

from tkinter import Frame, Text
from tkinter import N, W, E, S

import socket

def getHostname():
    return socket.gethostname()

class InfoBox(Frame):
    '''
    A simple place to make information visible.
    Used for testing
    '''


    def __init__(self, master):
        '''
        Constructor
        '''
        super.__init__(master)
        self.master = master
        self.text = Text(master, height=10, width=30, wrap="none")
        self.text.grid(column=0, row=0, sticky=(N, W, E, S))
        self.Hostname = getHostname()
        self.text.insert("end", f"Host name is '{self.Hostname}'\n")
        self.master.set_geometry("200x200+200+200") # widthxheight±x±y
        screen_width = self.master.winfo_screenwidth()
        self.text.insert("end", f"Screen width is '{screen_width}'\n")
        screen_height = self.master.winfo_screenheight()
        self.text.insert("end", f"Screen height is '{screen_height}'\n")
        return