window.App=_.extend({},window.App,
  bpms:750

  #create audio context and event listeners
  init:->
    @context= new AudioContext
    if @context
      $(document).on('keydown',  (evt)=> @startMusic(evt.keyCode))
      $(document).on('keyup',  (evt)=> @stopMusic())

  #call back for key down. sets the tone or scale type and start the tempo
  startMusic:(keyCode)->
    unless @tempo || _.isEmpty(@keyboard.setTone(String.fromCharCode(keyCode)))
      @createNote()

  #we create a new random quarter note from the available notes on our current scale
  createNote:->
    @note.stop() if @note
    availableNotes = @keyboard.scales[@keyboard.scale]
    toneInterval = availableNotes[Math.floor Math.random() * availableNotes.length]
    @note = new App.Note @keyboard.frequency(toneInterval), @context
    @setTempo()
    @note.start()

  #stops the music
  stopMusic:->
    if @tempo
      @note.stop()
      clearInterval(@tempo)
      delete @tempo
  
  #set the tempo
  setTempo:->
    callback= =>@createNote()
    @tempo= setTimeout(callback,@bpms)
)
$(window).load ->
  App.init()

