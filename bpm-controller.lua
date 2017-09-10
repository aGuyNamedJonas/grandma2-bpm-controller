local MASTER_BPM_MAX = 225
local pitchBpm = 0

function setMasterBpm (bpm)
  local execPos = (bpm / MASTER_BPM_MAX) * 100
  gma.cmd('Executor "Master BPM" At ' ..execPos)
end

function increaseMasterBpm (bpm)
  local execDelta = (bpm / MASTER_BPM_MAX) * 100
  gma.cmd('Executor "Master BPM" At + ' ..execDelta)
end

function decreaseMasterBpm (bpm)
  local execDelta = (bpm / MASTER_BPM_MAX) * 100
  gma.cmd('Executor "Master BPM" At - ' ..execDelta)
end

function _timerPitchUp ()
  increaseMasterBpm(pitchBpm)
end

function _timerPitchDown ()
  decreaseMasterBpm(pitchBpm)
end

function noop ()
  -- Function that does nothing, we can't leave the first field of gma.time()
  -- empty unfortunately
end

function pitchUp (bpm, duration)
  -- This is a weird bug...iteration has to be set to 2 to wait for PITCH_DURATION
  -- seconds to execute _timerPitchUp
  increaseMasterBpm(bpm)
  pitchBpm = bpm
  gma.timer(noop, duration, 2, _timerPitchDown)
end

function pitchDown (bpm, duration)
  -- This is a weird bug...iteration has to be set to 2 to wait for PITCH_DURATION
  -- seconds to execute _timePitchUp
  decreaseMasterBpm(bpm)
  pitchBpm = bpm
  gma.timer(noop, duration, 2, _timerPitchUp)
end


function bpmController ()
  local cmd = gma.show.getvar('cmd')

  gma.feedback('Executing bpmController...')
  gma.feedback('cmd: ' ..gma.show.getvar('cmd'))

  if cmd == 'setBpm' then
    local bpm = tonumber(gma.show.getvar('bpm'))
    gma.feedback('Setting Master BPM to ' ..bpm)
    setMasterBpm(bpm)
  elseif cmd == 'incBpm' then
    local bpm = tonumber(gma.show.getvar('bpm'))
    gma.feedback('Decreasing Master BPM by ' ..bpm)
    increaseMasterBpm(bpm)
  elseif cmd == 'decBpm' then
    local bpm = tonumber(gma.show.getvar('bpm'))
    gma.feedback('Decreasing Master BPM by ' ..bpm)
    decreaseMasterBpm(bpm)
  elseif cmd == 'pitchDown' then
    local duration = tonumber(gma.show.getvar('duration'))
    local bpm = tonumber(gma.show.getvar('bpm'))
    gma.feedback('Pitching down Master BPM by ' ..bpm.. ' BPM for ' ..duration.. ' sec')
    pitchDown(bpm, duration)
  elseif cmd == 'pitchUp' then
    local duration = tonumber(gma.show.getvar('duration'))
    local bpm = tonumber(gma.show.getvar('bpm'))
    gma.feedback('Pitching up Master BPM by ' ..bpm.. ' BPM for ' ..duration.. ' sec')
    pitchUp(bpm, duration)
  end
end

return bpmController;
