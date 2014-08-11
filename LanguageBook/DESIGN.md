DESIGN:

* Except for audio, each media represents part(s) of things that can be rendered onto the screen.
* Medias may contains child medias.
* Each media has an assocated interval that specifies the range of time where it is relevant when
  the audio is playing.
* Parent media must _always_ have interval that covers all its children's intervals.
* Image medias may contain image regions as child (meta-)medias.
* Text medias may contains words as child medias as well as rendering data (fonts, colors, etc.)
* Word medias may contains a bounding rectangle, which is utilized for hit-testing a single word.
* Each word is correlated to a subtitle (timing) data related to its parent Text.
* A Book contains many pages.
* A page is the root media element.

* Audio is handled orthogonally to all the medias
* Audio is pooled, there maybe multiple audio files involved at any given time.
* One audio controller should cover a single audio file.
* An audio controller provies continuous updates of its current playhead location.
* Audio controller preloads and caches audio data file as necessary.
* Mixer contains multiple audio controller and has an extended audio controller interface.
* Mixer provide the ability to juggle states between multiple audio and/or audio sections.

-- play-through

* When "playing", the audio is the first to play.
* Current audio location playhead from the mixer is used to highlight and/or dehighlight media
  elements as the audio progress.

-- single-tapping

* Word and image boundary region is used to identify the thing that was tapped.
* Audio region is derived from the tapped thing.
* Mixer plays a part part of the audio region.
* Highlighting/dehighlighting happens the same as when playing-through.
