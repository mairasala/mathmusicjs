window.App=_.extend({},window.App,
  #this class will be instantiated several times so its better to use prototype
  #it simple plays a specific frequency with a sine wave oscilator
  Note: (()->
    NoteClass = (frequency,context) ->
      @frequency = frequency
      @context= context
      @osc= null
      @gain=null
  
    # we create an oscilator with a specific gain and plug it to the audio context
    NoteClass.prototype.start=->
      @osc= @context.createOscillator()
      @osc.type = 'sine'
      @osc.frequency.value= @frequency
  
      @gain= @context.createGain()
      @gain.gain.value= 0.03
  
      @osc.connect(@gain)
      @gain.connect(@context.destination)
  
      @osc.start(0)
  
    NoteClass.prototype.stop=->
      @osc.stop()
  
    NoteClass)()
)
