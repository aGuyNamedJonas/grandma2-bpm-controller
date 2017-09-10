# grandma2-bpmcontroller
Plugin for GrandMA2 (onPC) which will help you beat match your GrandMA2 show to for example a DJ set.  
The trick here is that this plugin gives you fine grained control over a Speed Master:  
* Set speed master to a certain BPM
* Increase / Decrease speed master by BPM (=beats per minute) increments (+0.1 BPM / -0.1 BPM / +1 BPM / etc.)
* Temporarily slow down / speed up Speed Master (configurable)

## Getting started
Getting started with this plugin is easy, just follow these simple steps:  
1. Add speed master called "Master BPM" to your show
* Make sure the max speed of "Master BPM" is 225 BPM (default)
* [Download this project as a ZIP file](https://github.com/aGuyNamedJonas/grandma2-bpm-controller/archive/master.zip)
* Copy the contents of zip file to the `importexport` show folder  
(Usually `C:\ProgramData\MA Lighting Technologies\grandma\gma2_V_3.3.2\importexport`)
* Import the **bpmController** plugin into GrandMA2:  
`Import "bpmController" At Plugin 2`
* Import the example macros into GrandMA2:  
`Import "bpmControllerMacros" At Macro 1`

That's it - happy beat-matching! :)

## bpmController Plugin Reference
The `bpmController` plugin is controlled by setting the variables `$cmd`, `$bpm`, and `$duration`.  
In your macros use `SetVar` to set these variables, and then call the plugin by using the command `Go Plugin "bpmController"`.  

**Important**: The `bpmController` plugin only works when a speed master with the name `Master BPM` is setup and has a max. BPM of `225` (should be the default value when using a previously unused speed master)  

**Operation 'setBpm'**  
Sets the `Master BPM` speed fader to the speed passed in through `$bpm`  
*Variables*:  
* `$cmd`: `setBpm`
* `$bpm`: BPM which to set the speed master `Master BPM` to (needs to be between 0 and 255)

**Operation 'incBpm' / 'decBpm'**  
Increases / decreases the speed of `Master BPM` by the amount of BPMs passed in through `$bpm`
*Variables*:  
* `$cmd`: `incBpm` / `decBpm`
* `$bpm`: BPM by which to increase / decrease the speed of `Master BPM`

**Operation 'pitchUp' / 'pitchDown'**  
Temporarily increases / decreases the speed of `Master BPM` to enable matching the playback of GrandMA2 with a track / set.  
This is a standard technique used by DJs to make sure two tracks with (ideally) the same speed are beat-aligned ()"pitch bending")  
*Variables*:  
* `$cmd`: `pitchUp` / `pitchDown`
* `$bpm`: Amount of BPM to pitch up / pitch down by temporarily
* `$duration`: Time in seconds after which the speed of `Master BPM` will be reset to its previous level
