# MonitorWall
  Use a wall of monitors to look like a very large single (multiuser) monitor.

## Goal
  Each computer in the grid will respond to mouse (and keyboard) input 
  and move a "mouse" cursor over the extended grid by magnifying those actions
  by informing the rest (or just the relevant) computers of what is happening
  and those computers will action the display and function of that mouse.
  The communication will be by UDP (fast but insecure), allowing the latest information
  to supercede older information.  The comms will include a source identifier to allow
  multiple (identifiable) mouse cursors to move around the grid.

## The hardware
  It is assumed that:
* All the monitors are the same size
* They are arranged in a rectangular grid
* They are controlled by computors looking after one or two monitors each
* If the computer have two monitors then they are side by side
* All the computors are similarly configured

The set up I am using is:
* Raspberry Pi V4 
* Running RaspberryPi OS
* Booting into the gui and then running in that gui a fixed file (script) from the code base
* Two monitors per Pi
* Current configuration is 2 blocks of 3 vertically mounted Pi with two monitors on each
* This gives 4 (wide) by 3 (high) monitors

## The ideas as they come ...
  Potentially we have a lot (more than 1) computers to maintain:
* Want to have a way that they stay up to date and in sync
* Initially that means:
  * When they boot, they will check if there has been an update to the code base and clone it
    * Does not look like github permits the extraction of a single file (easily)
    * May have to make the check just a clone, but no more often that a defined period (hourly?)
  * May be good to (daily) check for system (OS and apps) updates too
  * The periods for these updates will be hard-coded in the code base
  * The last update and last clone date / time will be temp files and their absence imply and inital update or clone
* They will be agnostic of each other and must self discover and configure
* To aid this:
  * Monitors and computers are numbered left to right and top to bottom:
    * So top left computer / monitor is (0, 0)
    * And bottom right is (w - 1, h - 1), where w is the number in a row and h is the number of rows
    * So the monitor (singular) of computer (x, y) would be monitor (x, y)
    * Or the the monitors (dual) of computer (x, y) would be left: (2 * x, y) and right: (2 * x + 1, y)
  * Computers will be "named" as <prefix><x><y> (assuming no more than 10 in each direction ...)
  * All the computers will have the same prefix, so they can find their neightbours
  * Their name is all the pre-configuration they will need
  * It can be assumed by computer with name "NameXY" that at least the following (X + 1) * (Y + 1) computers named "NameWH" should exist:
    * Name00 to NameWH where: 
      * 0 <= W <= X 
      * 0 <= H <= Y
