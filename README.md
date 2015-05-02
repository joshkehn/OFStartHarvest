# OmniFocus Start Harvest

This is a script for [OmniFocus 2 Pro for Mac][of2] and [Harvest][harvest]. It might work on earlier versions.

## What does it do?

[![See it in action][video preview]][video]

This script enables you to one-click start a timer for a selected OmniFocus task or project. It can be configured (see **Configuring**) to handle figuring out what kind of project or task should be entered. It can customize the note based on the task, it's notes, or the project. Out of the box it will open a New Timer dialog with the task name entered as the note.

This script uses System Events to control Harvest through Accessibility APIs. You'll probably need to configure that by adding Script Editor to the apps allowed to control your computer.

![Security & Privacy Settings][accessibility]

## Usage

This script can be executed two ways. First is via Script Editor. This is useful for configuring, testing, and debugging items. After the script has been configured it's easy to add the script to the toolbar in OmniFocus in order to quickly access it. Then simply clicking on the icon launches and executes the script.

## Setup

1. Open OmniFocus.
2. Open the Scripts Folder from the Help menu.
![Open Scripts Folder][open scripts folder]
3. Copy script into folder.
4. Proceed to **Configuring**.

## Configuring

There are two main functions that are readily customizable. They are responsible for figuring out which Harvest Project and Task to select for any given item fed into the script.

`figureProject` has an example of searching the name and note of the task and project to see if a string matches.

`figureTask` has an example of matching contexts to a task and conditionally checking a project before setting a task.

To make this script truly useful you will need to customize both of these functions.

## Disclaimer

This script is in no way affiliated with, authorized, maintained, or sponsored by OmniGroup or Harvest.

### About Harvest

Harvest is a web-based time tracking and invoicing application relied on by creative businesses in over 100 countries. Interested in trying out? [Here's $10 off your first month, free trial included][harvest referral].


### About OmniFocus

OmniFocus is an incredible task management platform for Mac, iPad, and iPhone. I can't recommend it enough.


## License

[MIT License][mit]

Copyright (c) 2015 Joshua Kehn

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


[open scripts folder]: http://f.cl.ly/items/1H2j2v0m2H082O042B0m/Screen%20Shot%202015-05-02%20at%2012.02.08%20PM.png
[accessibility]: http://f.cl.ly/items/0g2C403B1E3F2Z2A3r44/Screen%20Shot%202015-05-02%20at%2012.08.52%20PM.png
[video preview]: http://f.cl.ly/items/2L0n2s41090m0e3t021J/Screen%20Shot%202015-05-02%20at%2012.25.25%20PM.png
[video]: http://l.kehn.io/0G0z01040T2U
[of2]: https://www.omnigroup.com/omnifocus
[of icon]: http://f.cl.ly/items/2u420w2M1i323t0e0y29/OmniFocus-for-Mac-128.png
[mit]: http://opensource.org/licenses/MIT
[harvest]: http://www.getharvest.com/
[harvest referral]: http://try.hrv.st/8-96604
[harvest icon]: http://f.cl.ly/items/1V3i0A3s0P2B3c252n1j/harvest-logo-icon-128px-6fc2a505f413234ce34001ced2f7b4f9.png