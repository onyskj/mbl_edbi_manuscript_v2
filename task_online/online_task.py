#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
This experiment was created using PsychoPy3 Experiment Builder (v2020.1.2),
    on Wed Jun 24 12:10:37 2020
If you publish work using this script the most relevant publication is:

    Peirce J, Gray JR, Simpson S, MacAskill M, Höchenberger R, Sogo H, Kastman E, Lindeløv JK. (2019) 
        PsychoPy2: Experiments in behavior made easy Behav Res 51: 195. 
        https://doi.org/10.3758/s13428-018-01193-y

"""

from __future__ import absolute_import, division

import psychopy
psychopy.useVersion('2020.1')


from psychopy import locale_setup
from psychopy import prefs
from psychopy import sound, gui, visual, core, data, event, logging, clock
from psychopy.constants import (NOT_STARTED, STARTED, PLAYING, PAUSED,
                                STOPPED, FINISHED, PRESSED, RELEASED, FOREVER)

import numpy as np  # whole numpy lib is available, prepend 'np.'
from numpy import (sin, cos, tan, log, log10, pi, average,
                   sqrt, std, deg2rad, rad2deg, linspace, asarray)
from numpy.random import random, randint, normal, shuffle
import os  # handy system and path functions
import sys  # to get file system encoding

from psychopy.hardware import keyboard



# Ensure that relative paths start from the same directory as this script
_thisDir = os.path.dirname(os.path.abspath(__file__))
os.chdir(_thisDir)

# Store info about the experiment session
psychopyVersion = '2020.1.2'
expName = 'novel_task'  # from the Builder filename that created this script
expInfo = {'participant': '', 'session': '001'}
dlg = gui.DlgFromDict(dictionary=expInfo, sortKeys=False, title=expName)
if dlg.OK == False:
    core.quit()  # user pressed cancel
expInfo['date'] = data.getDateStr()  # add a simple timestamp
expInfo['expName'] = expName
expInfo['psychopyVersion'] = psychopyVersion

# Data file name stem = absolute path + name; later add .psyexp, .csv, .log, etc
filename = _thisDir + os.sep + u'data/%s_%s_%s' % (expInfo['participant'], expName, expInfo['date'])

# An ExperimentHandler isn't essential but helps with data saving
thisExp = data.ExperimentHandler(name=expName, version='',
    extraInfo=expInfo, runtimeInfo=None,
    originPath='/Users/onyskj/Google Drive/Academia/University of Edinburgh/MSc Cognitive Science/Semester2/DISS_novel_task/novel_task/novel_implementation.py',
    savePickle=True, saveWideText=True,
    dataFileName=filename)
# save a log file for detail verbose info
logFile = logging.LogFile(filename+'.log', level=logging.EXP)
logging.console.setLevel(logging.WARNING)  # this outputs to the screen, not a file

endExpNow = False  # flag for 'escape' or other condition => quit the exp
frameTolerance = 0.001  # how close to onset before 'same' frame

# Start Code - component code to be run before the window creation

# Setup the Window
win = visual.Window(
    size=[1440, 900], fullscr=True, screen=0, 
    winType='pyglet', allowGUI=False, allowStencil=False,
    monitor='testMonitor', color=[0,0,0], colorSpace='rgb',
    blendMode='avg', useFBO=True, 
    units='height')
# store frame rate of monitor if we can measure it
expInfo['frameRate'] = win.getActualFrameRate()
if expInfo['frameRate'] != None:
    frameDur = 1.0 / round(expInfo['frameRate'])
else:
    frameDur = 1.0 / 60.0  # could not measure, so guess

# create a default keyboard (e.g. to check for escape)
defaultKeyboard = keyboard.Keyboard()

# Initialize components for Routine "instructions"
instructionsClock = core.Clock()
text_5 = visual.TextStim(win=win, name='text_5',
    text="Read through instructions and complete practice task.\n\nTo continue, press 'c'.\n\nThank you.\n\nTest.",
    font='Arial',
    pos=(0, 0), height=0.05, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
key_resp_3 = keyboard.Keyboard()

# Initialize components for Routine "initialise"
initialiseClock = core.Clock()
task_warn = visual.TextStim(win=win, name='task_warn',
    text='The task will begin shortly. Get rdy!',
    font='Arial',
    pos=(0, 0), height=0.06, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);

# Initialize components for Routine "wait"
waitClock = core.Clock()
wait_bg = visual.ImageStim(
    win=win,
    name='wait_bg', units='norm', 
    image='jpg/empty.jpg', mask=None,
    ori=0, pos=(0, 0), size=(3, 3),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)

# Initialize components for Routine "stage1"
stage1Clock = core.Clock()
s1_right = visual.ImageStim(
    win=win,
    name='s1_right', 
    image=None, mask=None,
    ori=0, pos=(0.35,-0.075), size=(0.5, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
s1_left = visual.ImageStim(
    win=win,
    name='s1_left', 
    image=None, mask=None,
    ori=0, pos=(-0.35, -0.075), size=(0.5, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-1.0)
bg_s1 = visual.ImageStim(
    win=win,
    name='bg_s1', 
    image=None, mask=None,
    ori=0, pos=(0, 0), size=(1, 1),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-2.0)
stage_1 = keyboard.Keyboard()

# Initialize components for Routine "post_stage1"
post_stage1Clock = core.Clock()
s1_right_post = visual.ImageStim(
    win=win,
    name='s1_right_post', 
    image=None, mask=None,
    ori=0, pos=(0.35,-0.075), size=(0.5, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
s1_left_post = visual.ImageStim(
    win=win,
    name='s1_left_post', 
    image=None, mask=None,
    ori=0, pos=(-0.35,-0.075), size=(0.5, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-1.0)
bg_s1_post = visual.ImageStim(
    win=win,
    name='bg_s1_post', 
    image=None, mask=None,
    ori=0, pos=(0, 0), size=(1, 1),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-2.0)

# Initialize components for Routine "stage2"
stage2Clock = core.Clock()
bg_s2 = visual.ImageStim(
    win=win,
    name='bg_s2', units='norm', 
    image=None, mask=None,
    ori=0, pos=(0,0), size=(2, 2),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
prev_s1 = visual.ImageStim(
    win=win,
    name='prev_s1', 
    image=None, mask=None,
    ori=0, pos=(0, 0.35), size=(0.15, 0.15),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-1.0)
s2 = visual.ImageStim(
    win=win,
    name='s2', 
    image=None, mask=None,
    ori=0, pos=(0,-0.075), size=(0.5, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-2.0)
stage_2 = keyboard.Keyboard()

# Initialize components for Routine "post_stage2"
post_stage2Clock = core.Clock()
bg_post_s2 = visual.ImageStim(
    win=win,
    name='bg_post_s2', units='norm', 
    image=None, mask=None,
    ori=0, pos=(0, 0), size=(2, 2),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
prev_s1_again = visual.ImageStim(
    win=win,
    name='prev_s1_again', 
    image=None, mask=None,
    ori=0, pos=(0, 0.35), size=(0.15, 0.15),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-1.0)
s2_post = visual.ImageStim(
    win=win,
    name='s2_post', 
    image=None, mask=None,
    ori=0, pos=(0,-0.075), size=(0.5, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-2.0)

# Initialize components for Routine "reward"
rewardClock = core.Clock()
bg_reward = visual.ImageStim(
    win=win,
    name='bg_reward', units='norm', 
    image=None, mask=None,
    ori=0, pos=(0, 0), size=(2, 2),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
reward_img = visual.ImageStim(
    win=win,
    name='reward_img', 
    image=None, mask=None,
    ori=0, pos=(0,-0.075), size=(0.5, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-1.0)
reward_text = visual.TextStim(win=win, name='reward_text',
    text='default text',
    font='Arial',
    pos=(-0.03, -0.075), height=0.08, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);
prev_s2 = visual.ImageStim(
    win=win,
    name='prev_s2', 
    image=None, mask=None,
    ori=0, pos=(0, 0.35), size=(0.15, 0.15),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-6.0)

# Initialize components for Routine "new_cond"
new_condClock = core.Clock()
text = visual.TextStim(win=win, name='text',
    text="To continue to a next condition press 'c'.",
    font='Arial',
    pos=(0, 0), height=0.07, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
key_resp = keyboard.Keyboard()

# Initialize components for Routine "initialise_tr"
initialise_trClock = core.Clock()
sigma = 2 #sigma for GRW
prob_rew = {"13": Math.round(((Math.random() * ((- 1*0) + 4)) - 4)), "24": Math.round(((Math.random() * (5 - 1*0)) + 1))};

t_count=0 #trial counter
#bg_color = util.Color(-1,-1,-1])
text_6 = visual.TextStim(win=win, name='text_6',
    text='The new conditions starts soon. Get ready!',
    font='Arial',
    pos=(0, 0), height=0.06, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-2.0);

# Initialize components for Routine "wait_tr"
wait_trClock = core.Clock()
wait_tr_bg = visual.ImageStim(
    win=win,
    name='wait_tr_bg', units='norm', 
    image='jpg/empty.jpg', mask=None,
    ori=0, pos=(0, 0), size=(3, 3),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)

# Initialize components for Routine "stage1_tr"
stage1_trClock = core.Clock()
s1_right_2 = visual.ImageStim(
    win=win,
    name='s1_right_2', 
    image=None, mask=None,
    ori=0, pos=(0.35,-0.075), size=(0.5, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
s1_left_2 = visual.ImageStim(
    win=win,
    name='s1_left_2', 
    image=None, mask=None,
    ori=0, pos=(-0.35, -0.075), size=(0.5, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-1.0)
bg_s1_2 = visual.ImageStim(
    win=win,
    name='bg_s1_2', 
    image=None, mask=None,
    ori=0, pos=(0, 0), size=(1, 1),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-2.0)
stage_1_2 = keyboard.Keyboard()

# Initialize components for Routine "post_stage1_tr"
post_stage1_trClock = core.Clock()
s1_right_post_2 = visual.ImageStim(
    win=win,
    name='s1_right_post_2', 
    image=None, mask=None,
    ori=0, pos=(0.35,-0.075), size=(0.5, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
s1_left_post_2 = visual.ImageStim(
    win=win,
    name='s1_left_post_2', 
    image=None, mask=None,
    ori=0, pos=(-0.35,-0.075), size=(0.5, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-1.0)
bg_s1_post_2 = visual.ImageStim(
    win=win,
    name='bg_s1_post_2', 
    image=None, mask=None,
    ori=0, pos=(0, 0), size=(1, 1),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-2.0)

# Initialize components for Routine "stage2_tr"
stage2_trClock = core.Clock()
bg_s2_2 = visual.ImageStim(
    win=win,
    name='bg_s2_2', units='norm', 
    image=None, mask=None,
    ori=0, pos=(0,0), size=(2, 2),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
prev_s1_2 = visual.ImageStim(
    win=win,
    name='prev_s1_2', 
    image=None, mask=None,
    ori=0, pos=(0, 0.35), size=(0.15, 0.15),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-1.0)
s2_2 = visual.ImageStim(
    win=win,
    name='s2_2', 
    image=None, mask=None,
    ori=0, pos=(0,-0.075), size=(0.5, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-2.0)
stage_2_2 = keyboard.Keyboard()

# Initialize components for Routine "post_stage2_tr"
post_stage2_trClock = core.Clock()
bg_post_s2_2 = visual.ImageStim(
    win=win,
    name='bg_post_s2_2', units='norm', 
    image=None, mask=None,
    ori=0, pos=(0, 0), size=(2, 2),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
prev_s1_again_2 = visual.ImageStim(
    win=win,
    name='prev_s1_again_2', 
    image=None, mask=None,
    ori=0, pos=(0, 0.35), size=(0.15, 0.15),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-1.0)
s2_post_2 = visual.ImageStim(
    win=win,
    name='s2_post_2', 
    image=None, mask=None,
    ori=0, pos=(0,-0.075), size=(0.5, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-2.0)

# Initialize components for Routine "reward_tr"
reward_trClock = core.Clock()
bg_reward_2 = visual.ImageStim(
    win=win,
    name='bg_reward_2', units='norm', 
    image=None, mask=None,
    ori=0, pos=(0, 0), size=(2, 2),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
reward_img_2 = visual.ImageStim(
    win=win,
    name='reward_img_2', 
    image=None, mask=None,
    ori=0, pos=(0,-0.075), size=(0.5, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-1.0)
reward_text_2 = visual.TextStim(win=win, name='reward_text_2',
    text='default text',
    font='Arial',
    pos=(-0.03, -0.075), height=0.08, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);
prev_s2_2 = visual.ImageStim(
    win=win,
    name='prev_s2_2', 
    image=None, mask=None,
    ori=0, pos=(0, 0.35), size=(0.15, 0.15),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=-6.0)

# Initialize components for Routine "unique_code"
unique_codeClock = core.Clock()
text_3 = visual.TextStim(win=win, name='text_3',
    text='default text',
    font='Arial',
    pos=(0, 0), height=0.07, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
key_resp_2 = keyboard.Keyboard()

# Create some handy timers
globalClock = core.Clock()  # to track the time since experiment started
routineTimer = core.CountdownTimer()  # to track time remaining of each (non-slip) routine 

# ------Prepare to start Routine "instructions"-------
continueRoutine = True
# update component parameters for each repeat
key_resp_3.keys = []
key_resp_3.rt = []
_key_resp_3_allKeys = []
# keep track of which components have finished
instructionsComponents = [text_5, key_resp_3]
for thisComponent in instructionsComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
instructionsClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1

# -------Run Routine "instructions"-------
while continueRoutine:
    # get current time
    t = instructionsClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=instructionsClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *text_5* updates
    if text_5.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        text_5.frameNStart = frameN  # exact frame index
        text_5.tStart = t  # local t and not account for scr refresh
        text_5.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(text_5, 'tStartRefresh')  # time at next scr refresh
        text_5.setAutoDraw(True)
    
    # *key_resp_3* updates
    waitOnFlip = False
    if key_resp_3.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        key_resp_3.frameNStart = frameN  # exact frame index
        key_resp_3.tStart = t  # local t and not account for scr refresh
        key_resp_3.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(key_resp_3, 'tStartRefresh')  # time at next scr refresh
        key_resp_3.status = STARTED
        # keyboard checking is just starting
        waitOnFlip = True
        win.callOnFlip(key_resp_3.clock.reset)  # t=0 on next screen flip
        win.callOnFlip(key_resp_3.clearEvents, eventType='keyboard')  # clear events on next screen flip
    if key_resp_3.status == STARTED and not waitOnFlip:
        theseKeys = key_resp_3.getKeys(keyList=['c'], waitRelease=False)
        _key_resp_3_allKeys.extend(theseKeys)
        if len(_key_resp_3_allKeys):
            key_resp_3.keys = _key_resp_3_allKeys[-1].name  # just the last key pressed
            key_resp_3.rt = _key_resp_3_allKeys[-1].rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in instructionsComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "instructions"-------
for thisComponent in instructionsComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
thisExp.addData('text_5.started', text_5.tStartRefresh)
thisExp.addData('text_5.stopped', text_5.tStopRefresh)
# the Routine "instructions" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "initialise"-------
continueRoutine = True
routineTimer.add(1.000000)
# update component parameters for each repeat
t1=1.5
t2=0.25
t3=1.5
t4=0.25
t5=1
# keep track of which components have finished
initialiseComponents = [task_warn]
for thisComponent in initialiseComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
initialiseClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1

# -------Run Routine "initialise"-------
while continueRoutine and routineTimer.getTime() > 0:
    # get current time
    t = initialiseClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=initialiseClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *task_warn* updates
    if task_warn.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        task_warn.frameNStart = frameN  # exact frame index
        task_warn.tStart = t  # local t and not account for scr refresh
        task_warn.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(task_warn, 'tStartRefresh')  # time at next scr refresh
        task_warn.setAutoDraw(True)
    if task_warn.status == STARTED:
        # is it time to stop? (based on global clock, using actual start)
        if tThisFlipGlobal > task_warn.tStartRefresh + 1-frameTolerance:
            # keep track of stop time/frame for later
            task_warn.tStop = t  # not accounting for scr refresh
            task_warn.frameNStop = frameN  # exact frame index
            win.timeOnFlip(task_warn, 'tStopRefresh')  # time at next scr refresh
            task_warn.setAutoDraw(False)
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in initialiseComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "initialise"-------
for thisComponent in initialiseComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
thisExp.addData('task_warn.started', task_warn.tStartRefresh)
thisExp.addData('task_warn.stopped', task_warn.tStopRefresh)

# set up handler to look after randomisation of conditions etc
neutral = data.TrialHandler(nReps=15, method='sequential', 
    extraInfo=expInfo, originPath=-1,
    trialList=[None],
    seed=None, name='neutral')
thisExp.addLoop(neutral)  # add the loop to the experiment
thisNeutral = neutral.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisNeutral.rgb)
if thisNeutral != None:
    for paramName in thisNeutral:
        exec('{} = thisNeutral[paramName]'.format(paramName))

for thisNeutral in neutral:
    currentLoop = neutral
    # abbreviate parameter names if possible (e.g. rgb = thisNeutral.rgb)
    if thisNeutral != None:
        for paramName in thisNeutral:
            exec('{} = thisNeutral[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "wait"-------
    continueRoutine = True
    routineTimer.add(0.250000)
    # update component parameters for each repeat
    # keep track of which components have finished
    waitComponents = [wait_bg]
    for thisComponent in waitComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    waitClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "wait"-------
    while continueRoutine and routineTimer.getTime() > 0:
        # get current time
        t = waitClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=waitClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *wait_bg* updates
        if wait_bg.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            wait_bg.frameNStart = frameN  # exact frame index
            wait_bg.tStart = t  # local t and not account for scr refresh
            wait_bg.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(wait_bg, 'tStartRefresh')  # time at next scr refresh
            wait_bg.setAutoDraw(True)
        if wait_bg.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > wait_bg.tStartRefresh + 0.25-frameTolerance:
                # keep track of stop time/frame for later
                wait_bg.tStop = t  # not accounting for scr refresh
                wait_bg.frameNStop = frameN  # exact frame index
                win.timeOnFlip(wait_bg, 'tStopRefresh')  # time at next scr refresh
                wait_bg.setAutoDraw(False)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in waitComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "wait"-------
    for thisComponent in waitComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    neutral.addData('wait_bg.started', wait_bg.tStartRefresh)
    neutral.addData('wait_bg.stopped', wait_bg.tStopRefresh)
    
    # ------Prepare to start Routine "stage1"-------
    continueRoutine = True
    # update component parameters for each repeat
    #set states and stimuli
    stage1_state = Math.floor(Math.random()*2)+1
    stage1_left = Math.floor(Math.random()*2)+1 + 2 * (stage1_state - 1)
    
    stage1_right = 0;
    if stage1_left == 1: 
        stage1_right = 2
    if stage1_left == 2:
        stage1_right = 1
    if stage1_left == 3:
        stage1_right = 4
    if stage1_left == 4:
        stage1_right = 3
        
    
    stage_1.keys = []
    stage_1.rt = []
    _stage_1_allKeys = []
    # keep track of which components have finished
    stage1Components = [s1_right, s1_left, bg_s1, stage_1]
    for thisComponent in stage1Components:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    stage1Clock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "stage1"-------
    while continueRoutine:
        # get current time
        t = stage1Clock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=stage1Clock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *s1_right* updates
        if s1_right.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            s1_right.frameNStart = frameN  # exact frame index
            s1_right.tStart = t  # local t and not account for scr refresh
            s1_right.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(s1_right, 'tStartRefresh')  # time at next scr refresh
            s1_right.setAutoDraw(True)
        if s1_right.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > s1_right.tStartRefresh + t1-frameTolerance:
                # keep track of stop time/frame for later
                s1_right.tStop = t  # not accounting for scr refresh
                s1_right.frameNStop = frameN  # exact frame index
                win.timeOnFlip(s1_right, 'tStopRefresh')  # time at next scr refresh
                s1_right.setAutoDraw(False)
        
        # *s1_left* updates
        if s1_left.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            s1_left.frameNStart = frameN  # exact frame index
            s1_left.tStart = t  # local t and not account for scr refresh
            s1_left.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(s1_left, 'tStartRefresh')  # time at next scr refresh
            s1_left.setAutoDraw(True)
        if s1_left.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > s1_left.tStartRefresh + t1-frameTolerance:
                # keep track of stop time/frame for later
                s1_left.tStop = t  # not accounting for scr refresh
                s1_left.frameNStop = frameN  # exact frame index
                win.timeOnFlip(s1_left, 'tStopRefresh')  # time at next scr refresh
                s1_left.setAutoDraw(False)
        
        # *bg_s1* updates
        if bg_s1.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            bg_s1.frameNStart = frameN  # exact frame index
            bg_s1.tStart = t  # local t and not account for scr refresh
            bg_s1.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(bg_s1, 'tStartRefresh')  # time at next scr refresh
            bg_s1.setAutoDraw(True)
        if bg_s1.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > bg_s1.tStartRefresh + t1-frameTolerance:
                # keep track of stop time/frame for later
                bg_s1.tStop = t  # not accounting for scr refresh
                bg_s1.frameNStop = frameN  # exact frame index
                win.timeOnFlip(bg_s1, 'tStopRefresh')  # time at next scr refresh
                bg_s1.setAutoDraw(False)
        
        # *stage_1* updates
        waitOnFlip = False
        if stage_1.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            stage_1.frameNStart = frameN  # exact frame index
            stage_1.tStart = t  # local t and not account for scr refresh
            stage_1.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(stage_1, 'tStartRefresh')  # time at next scr refresh
            stage_1.status = STARTED
            # keyboard checking is just starting
            waitOnFlip = True
            win.callOnFlip(stage_1.clock.reset)  # t=0 on next screen flip
            win.callOnFlip(stage_1.clearEvents, eventType='keyboard')  # clear events on next screen flip
        if stage_1.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > stage_1.tStartRefresh + t1-frameTolerance:
                # keep track of stop time/frame for later
                stage_1.tStop = t  # not accounting for scr refresh
                stage_1.frameNStop = frameN  # exact frame index
                win.timeOnFlip(stage_1, 'tStopRefresh')  # time at next scr refresh
                stage_1.status = FINISHED
        if stage_1.status == STARTED and not waitOnFlip:
            theseKeys = stage_1.getKeys(keyList=['left', 'right'], waitRelease=False)
            _stage_1_allKeys.extend(theseKeys)
            if len(_stage_1_allKeys):
                stage_1.keys = _stage_1_allKeys[0].name  # just the first key pressed
                stage_1.rt = _stage_1_allKeys[0].rt
                # a response ends the routine
                continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in stage1Components:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "stage1"-------
    for thisComponent in stage1Components:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    neutral.addData('s1_right.started', s1_right.tStartRefresh)
    neutral.addData('s1_right.stopped', s1_right.tStopRefresh)
    neutral.addData('s1_left.started', s1_left.tStartRefresh)
    neutral.addData('s1_left.stopped', s1_left.tStopRefresh)
    neutral.addData('bg_s1.started', bg_s1.tStartRefresh)
    neutral.addData('bg_s1.stopped', bg_s1.tStopRefresh)
    # check responses
    if stage_1.keys in ['', [], None]:  # No response was made
        stage_1.keys = None
    neutral.addData('stage_1.keys',stage_1.keys)
    if stage_1.keys != None:  # we had a response
        neutral.addData('stage_1.rt', stage_1.rt)
    neutral.addData('stage_1.started', stage_1.tStartRefresh)
    neutral.addData('stage_1.stopped', stage_1.tStopRefresh)
    #if no response, set times to 0
    if not stage_1.keys:
        continueRoutine=false
        t2=0
        t3=0
        t4=0
        t5=0
        
    #stage 1 choice
    stage1_choice=0
    if stage_1.keys=="left":
        stage1_choice=stage1_left
    if stage_1.keys=="right":
        stage1_choice=stage1_right
     
    psychoJS.experiment.addData('stage1_choice',stage1_choice)
    # the Routine "stage1" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "post_stage1"-------
    continueRoutine = True
    # update component parameters for each repeat
    # keep track of which components have finished
    post_stage1Components = [s1_right_post, s1_left_post, bg_s1_post]
    for thisComponent in post_stage1Components:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    post_stage1Clock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "post_stage1"-------
    while continueRoutine:
        # get current time
        t = post_stage1Clock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=post_stage1Clock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *s1_right_post* updates
        if s1_right_post.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            s1_right_post.frameNStart = frameN  # exact frame index
            s1_right_post.tStart = t  # local t and not account for scr refresh
            s1_right_post.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(s1_right_post, 'tStartRefresh')  # time at next scr refresh
            s1_right_post.setAutoDraw(True)
        if s1_right_post.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > s1_right_post.tStartRefresh + t2-frameTolerance:
                # keep track of stop time/frame for later
                s1_right_post.tStop = t  # not accounting for scr refresh
                s1_right_post.frameNStop = frameN  # exact frame index
                win.timeOnFlip(s1_right_post, 'tStopRefresh')  # time at next scr refresh
                s1_right_post.setAutoDraw(False)
        
        # *s1_left_post* updates
        if s1_left_post.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            s1_left_post.frameNStart = frameN  # exact frame index
            s1_left_post.tStart = t  # local t and not account for scr refresh
            s1_left_post.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(s1_left_post, 'tStartRefresh')  # time at next scr refresh
            s1_left_post.setAutoDraw(True)
        if s1_left_post.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > s1_left_post.tStartRefresh + t2-frameTolerance:
                # keep track of stop time/frame for later
                s1_left_post.tStop = t  # not accounting for scr refresh
                s1_left_post.frameNStop = frameN  # exact frame index
                win.timeOnFlip(s1_left_post, 'tStopRefresh')  # time at next scr refresh
                s1_left_post.setAutoDraw(False)
        
        # *bg_s1_post* updates
        if bg_s1_post.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            bg_s1_post.frameNStart = frameN  # exact frame index
            bg_s1_post.tStart = t  # local t and not account for scr refresh
            bg_s1_post.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(bg_s1_post, 'tStartRefresh')  # time at next scr refresh
            bg_s1_post.setAutoDraw(True)
        if bg_s1_post.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > bg_s1_post.tStartRefresh + t2-frameTolerance:
                # keep track of stop time/frame for later
                bg_s1_post.tStop = t  # not accounting for scr refresh
                bg_s1_post.frameNStop = frameN  # exact frame index
                win.timeOnFlip(bg_s1_post, 'tStopRefresh')  # time at next scr refresh
                bg_s1_post.setAutoDraw(False)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in post_stage1Components:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "post_stage1"-------
    for thisComponent in post_stage1Components:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    neutral.addData('s1_right_post.started', s1_right_post.tStartRefresh)
    neutral.addData('s1_right_post.stopped', s1_right_post.tStopRefresh)
    neutral.addData('s1_left_post.started', s1_left_post.tStartRefresh)
    neutral.addData('s1_left_post.stopped', s1_left_post.tStopRefresh)
    neutral.addData('bg_s1_post.started', bg_s1_post.tStartRefresh)
    neutral.addData('bg_s1_post.stopped', bg_s1_post.tStopRefresh)
    # the Routine "post_stage1" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "stage2"-------
    continueRoutine = True
    # update component parameters for each repeat
    if not stage_1.keys: #no stage 1 response
        s2.setImage('jpg/empty.jpg');
        bg_s2.setImage('jpg/empty.jpg');
        bg_post_s2.setImage('jpg/empty.jpg');
        bg_reward.setImage('jpg/empty.jpg');
        prev_s2.setImage('jpg/empty.jpg');
        continueRoutine = false
    else:
        #stage 2 images
        if stage1_choice == 1 or stage1_choice == 3:
            stage2_choice_name = 'jpg/s2/fractal_stage2_after_s1_13'
            reward_locator = '13'
            s2.setImage('jpg/s2/fractal_stage2_after_s1_13.png');
            bg_s2.setImage('jpg/s2/bg_1.jpg');
            bg_post_s2.setImage('jpg/s2/bg_1.jpg');
            bg_reward.setImage('jpg/s2/bg_1.jpg');
            prev_s2.setImage('jpg/s2/fractal_stage2_after_s1_13.png');
        if stage1_choice == 2 or stage1_choice == 4:
            stage2_choice_name = 'jpg/s2/fractal_stage2_after_s1_24'
            reward_locator = '24'
            s2.setImage('jpg/s2/fractal_stage2_after_s1_24.png');
            bg_s2.setImage('jpg/s2/bg_2.jpg');
            bg_post_s2.setImage('jpg/s2/bg_2.jpg');
            bg_reward.setImage('jpg/s2/bg_2.jpg');
            prev_s2.setImage('jpg/s2/fractal_stage2_after_s1_24.png');
    
    #set times if no stage2 responses
    
    
    stage_2.keys = []
    stage_2.rt = []
    _stage_2_allKeys = []
    # keep track of which components have finished
    stage2Components = [bg_s2, prev_s1, s2, stage_2]
    for thisComponent in stage2Components:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    stage2Clock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "stage2"-------
    while continueRoutine:
        # get current time
        t = stage2Clock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=stage2Clock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *bg_s2* updates
        if bg_s2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            bg_s2.frameNStart = frameN  # exact frame index
            bg_s2.tStart = t  # local t and not account for scr refresh
            bg_s2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(bg_s2, 'tStartRefresh')  # time at next scr refresh
            bg_s2.setAutoDraw(True)
        if bg_s2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > bg_s2.tStartRefresh + t3-frameTolerance:
                # keep track of stop time/frame for later
                bg_s2.tStop = t  # not accounting for scr refresh
                bg_s2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(bg_s2, 'tStopRefresh')  # time at next scr refresh
                bg_s2.setAutoDraw(False)
        
        # *prev_s1* updates
        if prev_s1.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            prev_s1.frameNStart = frameN  # exact frame index
            prev_s1.tStart = t  # local t and not account for scr refresh
            prev_s1.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(prev_s1, 'tStartRefresh')  # time at next scr refresh
            prev_s1.setAutoDraw(True)
        if prev_s1.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > prev_s1.tStartRefresh + t3-frameTolerance:
                # keep track of stop time/frame for later
                prev_s1.tStop = t  # not accounting for scr refresh
                prev_s1.frameNStop = frameN  # exact frame index
                win.timeOnFlip(prev_s1, 'tStopRefresh')  # time at next scr refresh
                prev_s1.setAutoDraw(False)
        
        # *s2* updates
        if s2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            s2.frameNStart = frameN  # exact frame index
            s2.tStart = t  # local t and not account for scr refresh
            s2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(s2, 'tStartRefresh')  # time at next scr refresh
            s2.setAutoDraw(True)
        if s2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > s2.tStartRefresh + t3-frameTolerance:
                # keep track of stop time/frame for later
                s2.tStop = t  # not accounting for scr refresh
                s2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(s2, 'tStopRefresh')  # time at next scr refresh
                s2.setAutoDraw(False)
        
        # *stage_2* updates
        waitOnFlip = False
        if stage_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            stage_2.frameNStart = frameN  # exact frame index
            stage_2.tStart = t  # local t and not account for scr refresh
            stage_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(stage_2, 'tStartRefresh')  # time at next scr refresh
            stage_2.status = STARTED
            # keyboard checking is just starting
            waitOnFlip = True
            win.callOnFlip(stage_2.clock.reset)  # t=0 on next screen flip
            win.callOnFlip(stage_2.clearEvents, eventType='keyboard')  # clear events on next screen flip
        if stage_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > stage_2.tStartRefresh + t3-frameTolerance:
                # keep track of stop time/frame for later
                stage_2.tStop = t  # not accounting for scr refresh
                stage_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(stage_2, 'tStopRefresh')  # time at next scr refresh
                stage_2.status = FINISHED
        if stage_2.status == STARTED and not waitOnFlip:
            theseKeys = stage_2.getKeys(keyList=['space'], waitRelease=False)
            _stage_2_allKeys.extend(theseKeys)
            if len(_stage_2_allKeys):
                stage_2.keys = _stage_2_allKeys[0].name  # just the first key pressed
                stage_2.rt = _stage_2_allKeys[0].rt
                # a response ends the routine
                continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in stage2Components:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "stage2"-------
    for thisComponent in stage2Components:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    neutral.addData('bg_s2.started', bg_s2.tStartRefresh)
    neutral.addData('bg_s2.stopped', bg_s2.tStopRefresh)
    neutral.addData('prev_s1.started', prev_s1.tStartRefresh)
    neutral.addData('prev_s1.stopped', prev_s1.tStopRefresh)
    neutral.addData('s2.started', s2.tStartRefresh)
    neutral.addData('s2.stopped', s2.tStopRefresh)
    if not stage_2.keys: 
        continueRoutine=false
        t4=0
        t5=0
    # check responses
    if stage_2.keys in ['', [], None]:  # No response was made
        stage_2.keys = None
    neutral.addData('stage_2.keys',stage_2.keys)
    if stage_2.keys != None:  # we had a response
        neutral.addData('stage_2.rt', stage_2.rt)
    neutral.addData('stage_2.started', stage_2.tStartRefresh)
    neutral.addData('stage_2.stopped', stage_2.tStopRefresh)
    # the Routine "stage2" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "post_stage2"-------
    continueRoutine = True
    # update component parameters for each repeat
    if not stage_1.keys:
        continueRoutine = false
    elif not stage_2.keys:
        s2_post.setImage("jpg/empty.jpg")
        continueRoutine = false
    elif stage_2.keys == 'space':
        s2_post.setImage(stage2_choice_name+"_act.png");
    # keep track of which components have finished
    post_stage2Components = [bg_post_s2, prev_s1_again, s2_post]
    for thisComponent in post_stage2Components:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    post_stage2Clock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "post_stage2"-------
    while continueRoutine:
        # get current time
        t = post_stage2Clock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=post_stage2Clock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *bg_post_s2* updates
        if bg_post_s2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            bg_post_s2.frameNStart = frameN  # exact frame index
            bg_post_s2.tStart = t  # local t and not account for scr refresh
            bg_post_s2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(bg_post_s2, 'tStartRefresh')  # time at next scr refresh
            bg_post_s2.setAutoDraw(True)
        if bg_post_s2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > bg_post_s2.tStartRefresh + t4-frameTolerance:
                # keep track of stop time/frame for later
                bg_post_s2.tStop = t  # not accounting for scr refresh
                bg_post_s2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(bg_post_s2, 'tStopRefresh')  # time at next scr refresh
                bg_post_s2.setAutoDraw(False)
        
        # *prev_s1_again* updates
        if prev_s1_again.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            prev_s1_again.frameNStart = frameN  # exact frame index
            prev_s1_again.tStart = t  # local t and not account for scr refresh
            prev_s1_again.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(prev_s1_again, 'tStartRefresh')  # time at next scr refresh
            prev_s1_again.setAutoDraw(True)
        if prev_s1_again.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > prev_s1_again.tStartRefresh + t4-frameTolerance:
                # keep track of stop time/frame for later
                prev_s1_again.tStop = t  # not accounting for scr refresh
                prev_s1_again.frameNStop = frameN  # exact frame index
                win.timeOnFlip(prev_s1_again, 'tStopRefresh')  # time at next scr refresh
                prev_s1_again.setAutoDraw(False)
        
        # *s2_post* updates
        if s2_post.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            s2_post.frameNStart = frameN  # exact frame index
            s2_post.tStart = t  # local t and not account for scr refresh
            s2_post.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(s2_post, 'tStartRefresh')  # time at next scr refresh
            s2_post.setAutoDraw(True)
        if s2_post.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > s2_post.tStartRefresh + t4-frameTolerance:
                # keep track of stop time/frame for later
                s2_post.tStop = t  # not accounting for scr refresh
                s2_post.frameNStop = frameN  # exact frame index
                win.timeOnFlip(s2_post, 'tStopRefresh')  # time at next scr refresh
                s2_post.setAutoDraw(False)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in post_stage2Components:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "post_stage2"-------
    for thisComponent in post_stage2Components:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    neutral.addData('bg_post_s2.started', bg_post_s2.tStartRefresh)
    neutral.addData('bg_post_s2.stopped', bg_post_s2.tStopRefresh)
    neutral.addData('prev_s1_again.started', prev_s1_again.tStartRefresh)
    neutral.addData('prev_s1_again.stopped', prev_s1_again.tStopRefresh)
    neutral.addData('s2_post.started', s2_post.tStartRefresh)
    neutral.addData('s2_post.stopped', s2_post.tStopRefresh)
    # the Routine "post_stage2" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "reward"-------
    continueRoutine = True
    # update component parameters for each repeat
    
    if not stage_1.keys:
        continueRoutine = false
        reward_img.setImage('jpg/empty.jpg')
        reward_color=util.Color([0,0,0]);
        disp_amount=''
    elif not stage_2.keys:
        reward_img.setImage('jpg/empty.jpg')
        reward_color=util.Color([0,0,0]);
        disp_amount=''
    else:
        reward_amount = prob_rew[reward_locator]
        disp_amount = Math.abs(reward_amount)
        psychoJS.experiment.addData('reward',reward_amount)
        #reward_amount_str = str(Math.abs(reward_amount))
        if reward_amount<0:
            reward_amount_str='n'
        #    reward_color='#DE1D14'
            reward_color=util.Color([222/127.5-1, 29/127.5-1, 20/127.5-1]);
            reward_img.setImage('jpg/reward/coin_neutral_'+reward_amount_str+'.jpg')
        #    reward_text.color=reward_color
        #    reward_amount=Math.abs(reward_amount)
        if reward_amount>0:
            reward_amount_str='p'
        #    reward_color='#2ED91C'
            reward_color=util.Color([46/127.5-1, 217/127.5-1, 28/127.5-1]);
            reward_img.setImage('jpg/reward/coin_neutral_'+reward_amount_str+'.jpg')
        #    reward_text.color=reward_color
        #    reward_text.color=[46, 217, 28]
        #    reward_amount=Math.abs(reward_amount)
        if reward_amount==0:
            reward_amount_str='0'
            reward_color=util.Color([255/127.5-1, 255/127.5-1, 255/127.5-1]);
        #    reward_text.color=reward_color
            disp_amount=''
            reward_img.setImage('jpg/reward/coin_neutral_'+reward_amount_str+'.jpg')
    
    
        #reward_img.setImage('jpg/reward/reward_'+str(reward_amount)+'.jpg')
        
    #reward_text.color=reward_color;
    
    #prob_rew['13']=Math.round(max(min(prob_rew['13']+sigma*randn_bm(),5),-4))
    #prob_rew['24']=Math.round(max(min(prob_rew['24']+sigma*randn_bm(),5),-4))
    #
    #re13 = prob_rew['13']+Math.round(randn_bm())*sigma
    
    
    
    
    reward_text.setColor('white', colorSpace='rgb')
    reward_text.setText(disp_amount)
    reward_text.color=reward_color;
    if not stage_1.keys:
        s1_left_post.setImage("jpg/empty.jpg")
        s1_right_post.setImage("jpg/empty.jpg")
    # keep track of which components have finished
    rewardComponents = [bg_reward, reward_img, reward_text, prev_s2]
    for thisComponent in rewardComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    rewardClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "reward"-------
    while continueRoutine:
        # get current time
        t = rewardClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=rewardClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *bg_reward* updates
        if bg_reward.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            bg_reward.frameNStart = frameN  # exact frame index
            bg_reward.tStart = t  # local t and not account for scr refresh
            bg_reward.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(bg_reward, 'tStartRefresh')  # time at next scr refresh
            bg_reward.setAutoDraw(True)
        if bg_reward.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > bg_reward.tStartRefresh + t5-frameTolerance:
                # keep track of stop time/frame for later
                bg_reward.tStop = t  # not accounting for scr refresh
                bg_reward.frameNStop = frameN  # exact frame index
                win.timeOnFlip(bg_reward, 'tStopRefresh')  # time at next scr refresh
                bg_reward.setAutoDraw(False)
        
        # *reward_img* updates
        if reward_img.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            reward_img.frameNStart = frameN  # exact frame index
            reward_img.tStart = t  # local t and not account for scr refresh
            reward_img.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(reward_img, 'tStartRefresh')  # time at next scr refresh
            reward_img.setAutoDraw(True)
        if reward_img.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > reward_img.tStartRefresh + t5-frameTolerance:
                # keep track of stop time/frame for later
                reward_img.tStop = t  # not accounting for scr refresh
                reward_img.frameNStop = frameN  # exact frame index
                win.timeOnFlip(reward_img, 'tStopRefresh')  # time at next scr refresh
                reward_img.setAutoDraw(False)
        
        # *reward_text* updates
        if reward_text.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            reward_text.frameNStart = frameN  # exact frame index
            reward_text.tStart = t  # local t and not account for scr refresh
            reward_text.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(reward_text, 'tStartRefresh')  # time at next scr refresh
            reward_text.setAutoDraw(True)
        if reward_text.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > reward_text.tStartRefresh + t5-frameTolerance:
                # keep track of stop time/frame for later
                reward_text.tStop = t  # not accounting for scr refresh
                reward_text.frameNStop = frameN  # exact frame index
                win.timeOnFlip(reward_text, 'tStopRefresh')  # time at next scr refresh
                reward_text.setAutoDraw(False)
        
        # *prev_s2* updates
        if prev_s2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            prev_s2.frameNStart = frameN  # exact frame index
            prev_s2.tStart = t  # local t and not account for scr refresh
            prev_s2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(prev_s2, 'tStartRefresh')  # time at next scr refresh
            prev_s2.setAutoDraw(True)
        if prev_s2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > prev_s2.tStartRefresh + t5-frameTolerance:
                # keep track of stop time/frame for later
                prev_s2.tStop = t  # not accounting for scr refresh
                prev_s2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(prev_s2, 'tStopRefresh')  # time at next scr refresh
                prev_s2.setAutoDraw(False)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in rewardComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "reward"-------
    for thisComponent in rewardComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    neutral.addData('bg_reward.started', bg_reward.tStartRefresh)
    neutral.addData('bg_reward.stopped', bg_reward.tStopRefresh)
    neutral.addData('reward_img.started', reward_img.tStartRefresh)
    neutral.addData('reward_img.stopped', reward_img.tStopRefresh)
    neutral.addData('reward_text.started', reward_text.tStartRefresh)
    neutral.addData('reward_text.stopped', reward_text.tStopRefresh)
    neutral.addData('prev_s2.started', prev_s2.tStartRefresh)
    neutral.addData('prev_s2.stopped', prev_s2.tStopRefresh)
    t1=1.5
    t2=0.25
    t3=1.5
    t4=0.25
    t5=1
    
    # the Routine "reward" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 15 repeats of 'neutral'


# ------Prepare to start Routine "new_cond"-------
continueRoutine = True
# update component parameters for each repeat
key_resp.keys = []
key_resp.rt = []
_key_resp_allKeys = []
# keep track of which components have finished
new_condComponents = [text, key_resp]
for thisComponent in new_condComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
new_condClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1

# -------Run Routine "new_cond"-------
while continueRoutine:
    # get current time
    t = new_condClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=new_condClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *text* updates
    if text.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        text.frameNStart = frameN  # exact frame index
        text.tStart = t  # local t and not account for scr refresh
        text.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(text, 'tStartRefresh')  # time at next scr refresh
        text.setAutoDraw(True)
    
    # *key_resp* updates
    waitOnFlip = False
    if key_resp.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        key_resp.frameNStart = frameN  # exact frame index
        key_resp.tStart = t  # local t and not account for scr refresh
        key_resp.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(key_resp, 'tStartRefresh')  # time at next scr refresh
        key_resp.status = STARTED
        # keyboard checking is just starting
        waitOnFlip = True
        win.callOnFlip(key_resp.clock.reset)  # t=0 on next screen flip
        win.callOnFlip(key_resp.clearEvents, eventType='keyboard')  # clear events on next screen flip
    if key_resp.status == STARTED and not waitOnFlip:
        theseKeys = key_resp.getKeys(keyList=['c'], waitRelease=False)
        _key_resp_allKeys.extend(theseKeys)
        if len(_key_resp_allKeys):
            key_resp.keys = _key_resp_allKeys[-1].name  # just the last key pressed
            key_resp.rt = _key_resp_allKeys[-1].rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in new_condComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "new_cond"-------
for thisComponent in new_condComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
thisExp.addData('text.started', text.tStartRefresh)
thisExp.addData('text.stopped', text.tStopRefresh)
# the Routine "new_cond" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "initialise_tr"-------
continueRoutine = True
routineTimer.add(1.000000)
# update component parameters for each repeat
t1=1.5
t2=0.25
t3=1.5
t4=0.25
t5=1

# keep track of which components have finished
initialise_trComponents = [text_6]
for thisComponent in initialise_trComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
initialise_trClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1

# -------Run Routine "initialise_tr"-------
while continueRoutine and routineTimer.getTime() > 0:
    # get current time
    t = initialise_trClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=initialise_trClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *text_6* updates
    if text_6.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        text_6.frameNStart = frameN  # exact frame index
        text_6.tStart = t  # local t and not account for scr refresh
        text_6.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(text_6, 'tStartRefresh')  # time at next scr refresh
        text_6.setAutoDraw(True)
    if text_6.status == STARTED:
        # is it time to stop? (based on global clock, using actual start)
        if tThisFlipGlobal > text_6.tStartRefresh + 1-frameTolerance:
            # keep track of stop time/frame for later
            text_6.tStop = t  # not accounting for scr refresh
            text_6.frameNStop = frameN  # exact frame index
            win.timeOnFlip(text_6, 'tStopRefresh')  # time at next scr refresh
            text_6.setAutoDraw(False)
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in initialise_trComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "initialise_tr"-------
for thisComponent in initialise_trComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
thisExp.addData('text_6.started', text_6.tStartRefresh)
thisExp.addData('text_6.stopped', text_6.tStopRefresh)

# set up handler to look after randomisation of conditions etc
triggering = data.TrialHandler(nReps=6, method='sequential', 
    extraInfo=expInfo, originPath=-1,
    trialList=[None],
    seed=None, name='triggering')
thisExp.addLoop(triggering)  # add the loop to the experiment
thisTriggering = triggering.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisTriggering.rgb)
if thisTriggering != None:
    for paramName in thisTriggering:
        exec('{} = thisTriggering[paramName]'.format(paramName))

for thisTriggering in triggering:
    currentLoop = triggering
    # abbreviate parameter names if possible (e.g. rgb = thisTriggering.rgb)
    if thisTriggering != None:
        for paramName in thisTriggering:
            exec('{} = thisTriggering[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "wait_tr"-------
    continueRoutine = True
    routineTimer.add(0.250000)
    # update component parameters for each repeat
    # keep track of which components have finished
    wait_trComponents = [wait_tr_bg]
    for thisComponent in wait_trComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    wait_trClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "wait_tr"-------
    while continueRoutine and routineTimer.getTime() > 0:
        # get current time
        t = wait_trClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=wait_trClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *wait_tr_bg* updates
        if wait_tr_bg.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            wait_tr_bg.frameNStart = frameN  # exact frame index
            wait_tr_bg.tStart = t  # local t and not account for scr refresh
            wait_tr_bg.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(wait_tr_bg, 'tStartRefresh')  # time at next scr refresh
            wait_tr_bg.setAutoDraw(True)
        if wait_tr_bg.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > wait_tr_bg.tStartRefresh + 0.25-frameTolerance:
                # keep track of stop time/frame for later
                wait_tr_bg.tStop = t  # not accounting for scr refresh
                wait_tr_bg.frameNStop = frameN  # exact frame index
                win.timeOnFlip(wait_tr_bg, 'tStopRefresh')  # time at next scr refresh
                wait_tr_bg.setAutoDraw(False)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in wait_trComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "wait_tr"-------
    for thisComponent in wait_trComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    triggering.addData('wait_tr_bg.started', wait_tr_bg.tStartRefresh)
    triggering.addData('wait_tr_bg.stopped', wait_tr_bg.tStopRefresh)
    
    # ------Prepare to start Routine "stage1_tr"-------
    continueRoutine = True
    # update component parameters for each repeat
    stage1_state = Math.floor(Math.random()*2)+1
    stage1_left = Math.floor(Math.random()*2)+1 + 2 * (stage1_state - 1)
    
    stage1_right = 0;
    
    if stage1_left == 1: 
        stage1_right = 2
    if stage1_left == 2:
        stage1_right = 1
    if stage1_left == 3:
        stage1_right = 4
    if stage1_left == 4:
        stage1_right = 3
        
    
    stage_1_2.keys = []
    stage_1_2.rt = []
    _stage_1_2_allKeys = []
    # keep track of which components have finished
    stage1_trComponents = [s1_right_2, s1_left_2, bg_s1_2, stage_1_2]
    for thisComponent in stage1_trComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    stage1_trClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "stage1_tr"-------
    while continueRoutine:
        # get current time
        t = stage1_trClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=stage1_trClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *s1_right_2* updates
        if s1_right_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            s1_right_2.frameNStart = frameN  # exact frame index
            s1_right_2.tStart = t  # local t and not account for scr refresh
            s1_right_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(s1_right_2, 'tStartRefresh')  # time at next scr refresh
            s1_right_2.setAutoDraw(True)
        if s1_right_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > s1_right_2.tStartRefresh + t1-frameTolerance:
                # keep track of stop time/frame for later
                s1_right_2.tStop = t  # not accounting for scr refresh
                s1_right_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(s1_right_2, 'tStopRefresh')  # time at next scr refresh
                s1_right_2.setAutoDraw(False)
        
        # *s1_left_2* updates
        if s1_left_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            s1_left_2.frameNStart = frameN  # exact frame index
            s1_left_2.tStart = t  # local t and not account for scr refresh
            s1_left_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(s1_left_2, 'tStartRefresh')  # time at next scr refresh
            s1_left_2.setAutoDraw(True)
        if s1_left_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > s1_left_2.tStartRefresh + t1-frameTolerance:
                # keep track of stop time/frame for later
                s1_left_2.tStop = t  # not accounting for scr refresh
                s1_left_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(s1_left_2, 'tStopRefresh')  # time at next scr refresh
                s1_left_2.setAutoDraw(False)
        
        # *bg_s1_2* updates
        if bg_s1_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            bg_s1_2.frameNStart = frameN  # exact frame index
            bg_s1_2.tStart = t  # local t and not account for scr refresh
            bg_s1_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(bg_s1_2, 'tStartRefresh')  # time at next scr refresh
            bg_s1_2.setAutoDraw(True)
        if bg_s1_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > bg_s1_2.tStartRefresh + t1-frameTolerance:
                # keep track of stop time/frame for later
                bg_s1_2.tStop = t  # not accounting for scr refresh
                bg_s1_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(bg_s1_2, 'tStopRefresh')  # time at next scr refresh
                bg_s1_2.setAutoDraw(False)
        
        # *stage_1_2* updates
        waitOnFlip = False
        if stage_1_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            stage_1_2.frameNStart = frameN  # exact frame index
            stage_1_2.tStart = t  # local t and not account for scr refresh
            stage_1_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(stage_1_2, 'tStartRefresh')  # time at next scr refresh
            stage_1_2.status = STARTED
            # keyboard checking is just starting
            waitOnFlip = True
            win.callOnFlip(stage_1_2.clock.reset)  # t=0 on next screen flip
            win.callOnFlip(stage_1_2.clearEvents, eventType='keyboard')  # clear events on next screen flip
        if stage_1_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > stage_1_2.tStartRefresh + t1-frameTolerance:
                # keep track of stop time/frame for later
                stage_1_2.tStop = t  # not accounting for scr refresh
                stage_1_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(stage_1_2, 'tStopRefresh')  # time at next scr refresh
                stage_1_2.status = FINISHED
        if stage_1_2.status == STARTED and not waitOnFlip:
            theseKeys = stage_1_2.getKeys(keyList=['left', 'right'], waitRelease=False)
            _stage_1_2_allKeys.extend(theseKeys)
            if len(_stage_1_2_allKeys):
                stage_1_2.keys = _stage_1_2_allKeys[0].name  # just the first key pressed
                stage_1_2.rt = _stage_1_2_allKeys[0].rt
                # a response ends the routine
                continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in stage1_trComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "stage1_tr"-------
    for thisComponent in stage1_trComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    triggering.addData('s1_right_2.started', s1_right_2.tStartRefresh)
    triggering.addData('s1_right_2.stopped', s1_right_2.tStopRefresh)
    triggering.addData('s1_left_2.started', s1_left_2.tStartRefresh)
    triggering.addData('s1_left_2.stopped', s1_left_2.tStopRefresh)
    triggering.addData('bg_s1_2.started', bg_s1_2.tStartRefresh)
    triggering.addData('bg_s1_2.stopped', bg_s1_2.tStopRefresh)
    # check responses
    if stage_1_2.keys in ['', [], None]:  # No response was made
        stage_1_2.keys = None
    triggering.addData('stage_1_2.keys',stage_1_2.keys)
    if stage_1_2.keys != None:  # we had a response
        triggering.addData('stage_1_2.rt', stage_1_2.rt)
    triggering.addData('stage_1_2.started', stage_1_2.tStartRefresh)
    triggering.addData('stage_1_2.stopped', stage_1_2.tStopRefresh)
    if not stage_1_2.keys:
        continueRoutine=false
        t2=0
        t3=0
        t4=0
        t5=0
    
    stage1_choice=0
    if stage_1_2.keys=="left":
        stage1_choice=stage1_left
    if stage_1_2.keys=="right":
        stage1_choice=stage1_right
    
    psychoJS.experiment.addData('stage1_choice',stage1_choice)
    # the Routine "stage1_tr" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "post_stage1_tr"-------
    continueRoutine = True
    # update component parameters for each repeat
    # keep track of which components have finished
    post_stage1_trComponents = [s1_right_post_2, s1_left_post_2, bg_s1_post_2]
    for thisComponent in post_stage1_trComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    post_stage1_trClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "post_stage1_tr"-------
    while continueRoutine:
        # get current time
        t = post_stage1_trClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=post_stage1_trClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *s1_right_post_2* updates
        if s1_right_post_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            s1_right_post_2.frameNStart = frameN  # exact frame index
            s1_right_post_2.tStart = t  # local t and not account for scr refresh
            s1_right_post_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(s1_right_post_2, 'tStartRefresh')  # time at next scr refresh
            s1_right_post_2.setAutoDraw(True)
        if s1_right_post_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > s1_right_post_2.tStartRefresh + t2-frameTolerance:
                # keep track of stop time/frame for later
                s1_right_post_2.tStop = t  # not accounting for scr refresh
                s1_right_post_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(s1_right_post_2, 'tStopRefresh')  # time at next scr refresh
                s1_right_post_2.setAutoDraw(False)
        
        # *s1_left_post_2* updates
        if s1_left_post_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            s1_left_post_2.frameNStart = frameN  # exact frame index
            s1_left_post_2.tStart = t  # local t and not account for scr refresh
            s1_left_post_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(s1_left_post_2, 'tStartRefresh')  # time at next scr refresh
            s1_left_post_2.setAutoDraw(True)
        if s1_left_post_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > s1_left_post_2.tStartRefresh + t2-frameTolerance:
                # keep track of stop time/frame for later
                s1_left_post_2.tStop = t  # not accounting for scr refresh
                s1_left_post_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(s1_left_post_2, 'tStopRefresh')  # time at next scr refresh
                s1_left_post_2.setAutoDraw(False)
        
        # *bg_s1_post_2* updates
        if bg_s1_post_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            bg_s1_post_2.frameNStart = frameN  # exact frame index
            bg_s1_post_2.tStart = t  # local t and not account for scr refresh
            bg_s1_post_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(bg_s1_post_2, 'tStartRefresh')  # time at next scr refresh
            bg_s1_post_2.setAutoDraw(True)
        if bg_s1_post_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > bg_s1_post_2.tStartRefresh + t2-frameTolerance:
                # keep track of stop time/frame for later
                bg_s1_post_2.tStop = t  # not accounting for scr refresh
                bg_s1_post_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(bg_s1_post_2, 'tStopRefresh')  # time at next scr refresh
                bg_s1_post_2.setAutoDraw(False)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in post_stage1_trComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "post_stage1_tr"-------
    for thisComponent in post_stage1_trComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    triggering.addData('s1_right_post_2.started', s1_right_post_2.tStartRefresh)
    triggering.addData('s1_right_post_2.stopped', s1_right_post_2.tStopRefresh)
    triggering.addData('s1_left_post_2.started', s1_left_post_2.tStartRefresh)
    triggering.addData('s1_left_post_2.stopped', s1_left_post_2.tStopRefresh)
    triggering.addData('bg_s1_post_2.started', bg_s1_post_2.tStartRefresh)
    triggering.addData('bg_s1_post_2.stopped', bg_s1_post_2.tStopRefresh)
    # the Routine "post_stage1_tr" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "stage2_tr"-------
    continueRoutine = True
    # update component parameters for each repeat
    if not stage_2_2.keys: #no stage 1 response
        s2_2.setImage('jpg/empty.jpg');
        bg_s2_2.setImage('jpg/empty.jpg');
        bg_post_s2_2.setImage('jpg/empty.jpg');
        bg_reward_2.setImage('jpg/empty.jpg');
        prev_s2_2.setImage('jpg/empty.jpg');
        continueRoutine = false
    else:
        if stage1_choice == 1 or stage1_choice == 3:
            stage2_choice_name = 'jpg/s2/fractal_stage2_after_s1_13'
            reward_locator = '13'
            s2_2.setImage('jpg/s2/fractal_stage2_after_s1_13.png');
            bg_s2_2.setImage('jpg/s2/bg_1.jpg');
            bg_post_s2_2.setImage('jpg/s2/bg_1.jpg');
            bg_reward_2.setImage('jpg/s2/bg_1.jpg');
            prev_s2_2.setImage('jpg/s2/fractal_stage2_after_s1_13.png');
        if stage1_choice == 2 or stage1_choice == 4:
            stage2_choice_name = 'jpg/s2/fractal_stage2_after_s1_24'
            reward_locator = '24'
            s2_2.setImage('jpg/s2/fractal_stage2_after_s1_24.png');
            bg_s2_2.setImage('jpg/s2/bg_2.jpg');
            bg_post_s2_2.setImage('jpg/s2/bg_2.jpg');
            bg_reward_2.setImage('jpg/s2/bg_2.jpg');
            prev_s2_2.setImage('jpg/s2/fractal_stage2_after_s1_24.png');
        
    
    stage_2_2.keys = []
    stage_2_2.rt = []
    _stage_2_2_allKeys = []
    # keep track of which components have finished
    stage2_trComponents = [bg_s2_2, prev_s1_2, s2_2, stage_2_2]
    for thisComponent in stage2_trComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    stage2_trClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "stage2_tr"-------
    while continueRoutine:
        # get current time
        t = stage2_trClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=stage2_trClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *bg_s2_2* updates
        if bg_s2_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            bg_s2_2.frameNStart = frameN  # exact frame index
            bg_s2_2.tStart = t  # local t and not account for scr refresh
            bg_s2_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(bg_s2_2, 'tStartRefresh')  # time at next scr refresh
            bg_s2_2.setAutoDraw(True)
        if bg_s2_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > bg_s2_2.tStartRefresh + t3-frameTolerance:
                # keep track of stop time/frame for later
                bg_s2_2.tStop = t  # not accounting for scr refresh
                bg_s2_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(bg_s2_2, 'tStopRefresh')  # time at next scr refresh
                bg_s2_2.setAutoDraw(False)
        
        # *prev_s1_2* updates
        if prev_s1_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            prev_s1_2.frameNStart = frameN  # exact frame index
            prev_s1_2.tStart = t  # local t and not account for scr refresh
            prev_s1_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(prev_s1_2, 'tStartRefresh')  # time at next scr refresh
            prev_s1_2.setAutoDraw(True)
        if prev_s1_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > prev_s1_2.tStartRefresh + t3-frameTolerance:
                # keep track of stop time/frame for later
                prev_s1_2.tStop = t  # not accounting for scr refresh
                prev_s1_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(prev_s1_2, 'tStopRefresh')  # time at next scr refresh
                prev_s1_2.setAutoDraw(False)
        
        # *s2_2* updates
        if s2_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            s2_2.frameNStart = frameN  # exact frame index
            s2_2.tStart = t  # local t and not account for scr refresh
            s2_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(s2_2, 'tStartRefresh')  # time at next scr refresh
            s2_2.setAutoDraw(True)
        if s2_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > s2_2.tStartRefresh + t3-frameTolerance:
                # keep track of stop time/frame for later
                s2_2.tStop = t  # not accounting for scr refresh
                s2_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(s2_2, 'tStopRefresh')  # time at next scr refresh
                s2_2.setAutoDraw(False)
        
        # *stage_2_2* updates
        waitOnFlip = False
        if stage_2_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            stage_2_2.frameNStart = frameN  # exact frame index
            stage_2_2.tStart = t  # local t and not account for scr refresh
            stage_2_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(stage_2_2, 'tStartRefresh')  # time at next scr refresh
            stage_2_2.status = STARTED
            # keyboard checking is just starting
            waitOnFlip = True
            win.callOnFlip(stage_2_2.clock.reset)  # t=0 on next screen flip
            win.callOnFlip(stage_2_2.clearEvents, eventType='keyboard')  # clear events on next screen flip
        if stage_2_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > stage_2_2.tStartRefresh + t3-frameTolerance:
                # keep track of stop time/frame for later
                stage_2_2.tStop = t  # not accounting for scr refresh
                stage_2_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(stage_2_2, 'tStopRefresh')  # time at next scr refresh
                stage_2_2.status = FINISHED
        if stage_2_2.status == STARTED and not waitOnFlip:
            theseKeys = stage_2_2.getKeys(keyList=['space'], waitRelease=False)
            _stage_2_2_allKeys.extend(theseKeys)
            if len(_stage_2_2_allKeys):
                stage_2_2.keys = _stage_2_2_allKeys[0].name  # just the first key pressed
                stage_2_2.rt = _stage_2_2_allKeys[0].rt
                # a response ends the routine
                continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in stage2_trComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "stage2_tr"-------
    for thisComponent in stage2_trComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    triggering.addData('bg_s2_2.started', bg_s2_2.tStartRefresh)
    triggering.addData('bg_s2_2.stopped', bg_s2_2.tStopRefresh)
    triggering.addData('prev_s1_2.started', prev_s1_2.tStartRefresh)
    triggering.addData('prev_s1_2.stopped', prev_s1_2.tStopRefresh)
    triggering.addData('s2_2.started', s2_2.tStartRefresh)
    triggering.addData('s2_2.stopped', s2_2.tStopRefresh)
    if not stage_2_2.keys: 
        continueRoutine=false
        t4=0
        t5=0
    # check responses
    if stage_2_2.keys in ['', [], None]:  # No response was made
        stage_2_2.keys = None
    triggering.addData('stage_2_2.keys',stage_2_2.keys)
    if stage_2_2.keys != None:  # we had a response
        triggering.addData('stage_2_2.rt', stage_2_2.rt)
    triggering.addData('stage_2_2.started', stage_2_2.tStartRefresh)
    triggering.addData('stage_2_2.stopped', stage_2_2.tStopRefresh)
    # the Routine "stage2_tr" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "post_stage2_tr"-------
    continueRoutine = True
    # update component parameters for each repeat
    if not stage_1_2.keys:
        continueRoutine = false
    if not stage_2_2.keys:
        s2_post_2.setImage("jpg/empty.jpg")
        continueRoutine = false
    if stage_2_2.keys == 'space':
        s2_post_2.setImage(stage2_choice_name+"_act.png");
    # keep track of which components have finished
    post_stage2_trComponents = [bg_post_s2_2, prev_s1_again_2, s2_post_2]
    for thisComponent in post_stage2_trComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    post_stage2_trClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "post_stage2_tr"-------
    while continueRoutine:
        # get current time
        t = post_stage2_trClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=post_stage2_trClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *bg_post_s2_2* updates
        if bg_post_s2_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            bg_post_s2_2.frameNStart = frameN  # exact frame index
            bg_post_s2_2.tStart = t  # local t and not account for scr refresh
            bg_post_s2_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(bg_post_s2_2, 'tStartRefresh')  # time at next scr refresh
            bg_post_s2_2.setAutoDraw(True)
        if bg_post_s2_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > bg_post_s2_2.tStartRefresh + t4-frameTolerance:
                # keep track of stop time/frame for later
                bg_post_s2_2.tStop = t  # not accounting for scr refresh
                bg_post_s2_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(bg_post_s2_2, 'tStopRefresh')  # time at next scr refresh
                bg_post_s2_2.setAutoDraw(False)
        
        # *prev_s1_again_2* updates
        if prev_s1_again_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            prev_s1_again_2.frameNStart = frameN  # exact frame index
            prev_s1_again_2.tStart = t  # local t and not account for scr refresh
            prev_s1_again_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(prev_s1_again_2, 'tStartRefresh')  # time at next scr refresh
            prev_s1_again_2.setAutoDraw(True)
        if prev_s1_again_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > prev_s1_again_2.tStartRefresh + t4-frameTolerance:
                # keep track of stop time/frame for later
                prev_s1_again_2.tStop = t  # not accounting for scr refresh
                prev_s1_again_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(prev_s1_again_2, 'tStopRefresh')  # time at next scr refresh
                prev_s1_again_2.setAutoDraw(False)
        
        # *s2_post_2* updates
        if s2_post_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            s2_post_2.frameNStart = frameN  # exact frame index
            s2_post_2.tStart = t  # local t and not account for scr refresh
            s2_post_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(s2_post_2, 'tStartRefresh')  # time at next scr refresh
            s2_post_2.setAutoDraw(True)
        if s2_post_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > s2_post_2.tStartRefresh + t4-frameTolerance:
                # keep track of stop time/frame for later
                s2_post_2.tStop = t  # not accounting for scr refresh
                s2_post_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(s2_post_2, 'tStopRefresh')  # time at next scr refresh
                s2_post_2.setAutoDraw(False)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in post_stage2_trComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "post_stage2_tr"-------
    for thisComponent in post_stage2_trComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    triggering.addData('bg_post_s2_2.started', bg_post_s2_2.tStartRefresh)
    triggering.addData('bg_post_s2_2.stopped', bg_post_s2_2.tStopRefresh)
    triggering.addData('prev_s1_again_2.started', prev_s1_again_2.tStartRefresh)
    triggering.addData('prev_s1_again_2.stopped', prev_s1_again_2.tStopRefresh)
    triggering.addData('s2_post_2.started', s2_post_2.tStartRefresh)
    triggering.addData('s2_post_2.stopped', s2_post_2.tStopRefresh)
    # the Routine "post_stage2_tr" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "reward_tr"-------
    continueRoutine = True
    # update component parameters for each repeat
    if not stage_1_2.keys:
        continueRoutine = false
        reward_img_2.setImage('jpg/empty.jpg')
        reward_color=util.Color([0,0,0]);
        disp_amount=''
    elif not stage_2_2.keys:
        reward_img_2.setImage('jpg/empty.jpg')
        reward_color=util.Color([0,0,0]);
        disp_amount=''
    else:
        reward_amount = prob_rew[reward_locator]
        disp_amount = Math.abs(reward_amount)
        psychoJS.experiment.addData('reward',reward_amount)
        #reward_amount_str = str(Math.abs(reward_amount))
        if reward_amount<0:
            reward_amount_str='n'
        #    reward_color='#DE1D14'
            reward_color=util.Color([222/127.5-1, 29/127.5-1, 20/127.5-1]);
            reward_img_2.setImage('jpg/reward/coin_neutral_'+reward_amount_str+'.jpg')
        #    reward_text.color=reward_color
        #    reward_amount=Math.abs(reward_amount)
        if reward_amount>0:
            reward_amount_str='p'
        #    reward_color='#2ED91C'
            reward_color=util.Color([46/127.5-1, 217/127.5-1, 28/127.5-1]);
            reward_img_2.setImage('jpg/reward/coin_trigger.jpg')
        #    reward_text.color=reward_color
        #    reward_text.color=[46, 217, 28]
        #    reward_amount=Math.abs(reward_amount)
        if reward_amount==0:
            reward_amount_str='0'
            reward_color=util.Color([255/127.5-1, 255/127.5-1, 255/127.5-1]);
            reward_img_2.setImage('jpg/reward/coin_neutral_'+reward_amount_str+'.jpg')
        #    reward_text.color=reward_color
            disp_amount=''
    
    
    
    #
    reward_text_2.setColor('white', colorSpace='rgb')
    reward_text_2.setText(disp_amount)
    reward_text_2.color=reward_color;
    # keep track of which components have finished
    reward_trComponents = [bg_reward_2, reward_img_2, reward_text_2, prev_s2_2]
    for thisComponent in reward_trComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    reward_trClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "reward_tr"-------
    while continueRoutine:
        # get current time
        t = reward_trClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=reward_trClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *bg_reward_2* updates
        if bg_reward_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            bg_reward_2.frameNStart = frameN  # exact frame index
            bg_reward_2.tStart = t  # local t and not account for scr refresh
            bg_reward_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(bg_reward_2, 'tStartRefresh')  # time at next scr refresh
            bg_reward_2.setAutoDraw(True)
        if bg_reward_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > bg_reward_2.tStartRefresh + t5-frameTolerance:
                # keep track of stop time/frame for later
                bg_reward_2.tStop = t  # not accounting for scr refresh
                bg_reward_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(bg_reward_2, 'tStopRefresh')  # time at next scr refresh
                bg_reward_2.setAutoDraw(False)
        
        # *reward_img_2* updates
        if reward_img_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            reward_img_2.frameNStart = frameN  # exact frame index
            reward_img_2.tStart = t  # local t and not account for scr refresh
            reward_img_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(reward_img_2, 'tStartRefresh')  # time at next scr refresh
            reward_img_2.setAutoDraw(True)
        if reward_img_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > reward_img_2.tStartRefresh + t5-frameTolerance:
                # keep track of stop time/frame for later
                reward_img_2.tStop = t  # not accounting for scr refresh
                reward_img_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(reward_img_2, 'tStopRefresh')  # time at next scr refresh
                reward_img_2.setAutoDraw(False)
        
        # *reward_text_2* updates
        if reward_text_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            reward_text_2.frameNStart = frameN  # exact frame index
            reward_text_2.tStart = t  # local t and not account for scr refresh
            reward_text_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(reward_text_2, 'tStartRefresh')  # time at next scr refresh
            reward_text_2.setAutoDraw(True)
        if reward_text_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > reward_text_2.tStartRefresh + t5-frameTolerance:
                # keep track of stop time/frame for later
                reward_text_2.tStop = t  # not accounting for scr refresh
                reward_text_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(reward_text_2, 'tStopRefresh')  # time at next scr refresh
                reward_text_2.setAutoDraw(False)
        
        # *prev_s2_2* updates
        if prev_s2_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            prev_s2_2.frameNStart = frameN  # exact frame index
            prev_s2_2.tStart = t  # local t and not account for scr refresh
            prev_s2_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(prev_s2_2, 'tStartRefresh')  # time at next scr refresh
            prev_s2_2.setAutoDraw(True)
        if prev_s2_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > prev_s2_2.tStartRefresh + t5-frameTolerance:
                # keep track of stop time/frame for later
                prev_s2_2.tStop = t  # not accounting for scr refresh
                prev_s2_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(prev_s2_2, 'tStopRefresh')  # time at next scr refresh
                prev_s2_2.setAutoDraw(False)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in reward_trComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "reward_tr"-------
    for thisComponent in reward_trComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    triggering.addData('bg_reward_2.started', bg_reward_2.tStartRefresh)
    triggering.addData('bg_reward_2.stopped', bg_reward_2.tStopRefresh)
    triggering.addData('reward_img_2.started', reward_img_2.tStartRefresh)
    triggering.addData('reward_img_2.stopped', reward_img_2.tStopRefresh)
    triggering.addData('reward_text_2.started', reward_text_2.tStartRefresh)
    triggering.addData('reward_text_2.stopped', reward_text_2.tStopRefresh)
    triggering.addData('prev_s2_2.started', prev_s2_2.tStartRefresh)
    triggering.addData('prev_s2_2.stopped', prev_s2_2.tStopRefresh)
    t1=1.5
    t2=0.25
    t3=1.5
    t4=0.25
    t5=1
    # the Routine "reward_tr" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 6 repeats of 'triggering'


# ------Prepare to start Routine "unique_code"-------
continueRoutine = True
# update component parameters for each repeat
text_3.setText("Here is some self-help websites.....\n\nOn the next page you will see a thank-you message. Please click 'OK' to be redicrect back to Prolific. Otherwise, we will not be able to compensate you.\n\nOnce you are ready to finish the experiment, press 'c'. \n\n")
key_resp_2.keys = []
key_resp_2.rt = []
_key_resp_2_allKeys = []
# keep track of which components have finished
unique_codeComponents = [text_3, key_resp_2]
for thisComponent in unique_codeComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
unique_codeClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1

# -------Run Routine "unique_code"-------
while continueRoutine:
    # get current time
    t = unique_codeClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=unique_codeClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *text_3* updates
    if text_3.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        text_3.frameNStart = frameN  # exact frame index
        text_3.tStart = t  # local t and not account for scr refresh
        text_3.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(text_3, 'tStartRefresh')  # time at next scr refresh
        text_3.setAutoDraw(True)
    
    # *key_resp_2* updates
    waitOnFlip = False
    if key_resp_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        key_resp_2.frameNStart = frameN  # exact frame index
        key_resp_2.tStart = t  # local t and not account for scr refresh
        key_resp_2.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(key_resp_2, 'tStartRefresh')  # time at next scr refresh
        key_resp_2.status = STARTED
        # keyboard checking is just starting
        waitOnFlip = True
        win.callOnFlip(key_resp_2.clock.reset)  # t=0 on next screen flip
        win.callOnFlip(key_resp_2.clearEvents, eventType='keyboard')  # clear events on next screen flip
    if key_resp_2.status == STARTED and not waitOnFlip:
        theseKeys = key_resp_2.getKeys(keyList=['c'], waitRelease=False)
        _key_resp_2_allKeys.extend(theseKeys)
        if len(_key_resp_2_allKeys):
            key_resp_2.keys = _key_resp_2_allKeys[-1].name  # just the last key pressed
            key_resp_2.rt = _key_resp_2_allKeys[-1].rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in unique_codeComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "unique_code"-------
for thisComponent in unique_codeComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
thisExp.addData('text_3.started', text_3.tStartRefresh)
thisExp.addData('text_3.stopped', text_3.tStopRefresh)
# the Routine "unique_code" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# Flip one final time so any remaining win.callOnFlip() 
# and win.timeOnFlip() tasks get executed before quitting
win.flip()

# these shouldn't be strictly necessary (should auto-save)
thisExp.saveAsWideText(filename+'.csv')
thisExp.saveAsPickle(filename)
logging.flush()
# make sure everything is closed down
thisExp.abort()  # or data files will save again on exit
win.close()
core.quit()
