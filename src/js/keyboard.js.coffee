window.App=_.extend({},window.App,
  #ths object will manage the key correspondance and frequency generation
  keyboard:
    scale:'Major'
    scales:
      Major:[0,2,4,5,7,9,11]
      Minor:[0,2,3,5,7,8,10]
      MajorPentatonic:[0,2,4,7,9]
      MinorPentatonic:[0,3,5,7,10]
    keys:['A','W','S','E','D','F','T','G','Y','H','U','J'] #use this keys to change the tone of the scale 
    notes:['Do','Do#','Re','Re#','Mi','Fa','Fa#','Sol','Sol#','La','La#','Si']
    LA:
      frequency:440
      key:'H'

    #from A4 frequency (440) we can calculate all musical notes frequencies
    #from the distance they have from A4
    frequency:(interval)->
      semitoneIndex=(@toneIndex+interval)%@keys.length
      console.log("#{@notes[semitoneIndex]}")
      dist= semitoneIndex - _.indexOf(@keys,@LA.key)
      @LA.frequency*Math.pow(Math.pow(2,(dist+1)), 1/12)

    #sets the type or tone of the scale
    #use the keyboard keys set in @keys for tones and SPACE to switch the scale type
    setTone:(tone)->
      if tone is ' '
        scale_types=_.keys(@scales)
        @scale = scale_types[(_.indexOf(scale_types, @scale)+1)%scale_types.length]
        console.log("type of scale #{@scale}")
      else if _.contains(@keys, tone)
        @toneIndex=_.indexOf(@keys, tone)
        includedNotes= _.map @scales[@scale],(val)=>
          @notes[(@toneIndex+val)%@keys.length]
        console.log("escale of #{@notes[@toneIndex]} #{@scale} includes #{includedNotes.join(', ')}")
        tone
)
