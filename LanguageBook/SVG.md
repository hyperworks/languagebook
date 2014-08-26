
# SVG-based DESIGN

* We defines our extension inside an XML namespace `lk` (for LanguageKit)
* We defines an "active" state for any SVG element as either it being selected by the user or that
  the associated audio range is being played.
* We extends SVG elements with sound specific time attributes:
  * `audio` - Specify the audio file to use, marking the element as the audio container.
  * `interval` - Associate the element with a time region on the nearest audio container.
  * `animation` - References an SVG animation element to play when the element becomes active.

# ON PLAY

When an element is selected for play:

* If the element has an associated audio data `audio="filename.mp3"`, it becomes the audio container
  element.
  * Otherwise, we traverse the DOM upwards until we find a parent element with one. That element
    becomes the audio container element instead.

* If the element has an associated audio region `interval="0.123-4.567"`, it becomes the time
  container element.
  * Otherwise, we traverse the DOM upwards until we find a parent element with one. That element
    becomes the time container element instead.

* A clip of the audio data from the audio container element spanning the time region of the time
  container element is played.
* If the audio to be played is a clip of a larger audio, fading effects should be applied before and
  after playback.

# DURING PLAY

When an audio clip is being played:

* The audio and time container elements become "active".
* Every very short set interval, the DOM is traversed downwards from the audio container element. 
  Any child element with an associated audio time region that contains the current playhead time
  becomes "active".
* Any active element whose associated audio time region no longer contains the current playhead
  time becomes "inactive".
* Play continues until the whole of the audio region associated with the current time container is
  played through.

# ACTIVATION

* When an element becomes active from an inactive state, if it has an associated animation
  reference `animation="#anim"`, that animation is played.
* When an element becomes inactive from an active state, if it has an associated animation
  reference `animation="#anim"`, that animation is played in reverse.
