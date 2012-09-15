module Telapi
  # A Participant is always generated via Conferences but
  # this class also provides some convenience methods to access
  # them directly, thereby reducing API calls.
  class Participant < Resource
    class << self
      # Convenient alternative to Conference::participants
      def list(conference_sid, optional_params = {})
        Conference.participants(conference_sid, optional_params)
      end

      # Convenient alternative to Conference::participant
      def get(conference_sid, call_sid)
        Conference.participant(conference_sid, call_sid)
      end
    end

    # Deaf a participant of a conference call, returning a Telapi::Participant object
    # See http://www.telapi.com/docs/api/rest/conferences/deaf-or-mute/
    def deaf
      response = Network.post(['Conferences', self.conference_sid, 'Participant', self.call_sid], { :Deaf => true })
      Participant.new(response)
    end

    # Undeaf a participant of a conference call, returning a Telapi::Participant object
    # See http://www.telapi.com/docs/api/rest/conferences/deaf-or-mute/
    def undeaf
      response = Network.post(['Conferences', self.conference_sid, 'Participant', self.call_sid], { :Deaf => false })
      Participant.new(response)
    end

    # Mute a participant of a conference call, returning a Telapi::Participant object
    # See http://www.telapi.com/docs/api/rest/conferences/deaf-or-mute/
    def mute
      response = Network.post(['Conferences', self.conference_sid, 'Participant', self.call_sid], { :Muted => true })
      Participant.new(response)
    end

    # Unmute a participant of a conference call, returning a Telapi::Participant object
    # See http://www.telapi.com/docs/api/rest/conferences/deaf-or-mute/
    def unmute
      response = Network.post(['Conferences', self.conference_sid, 'Participant', self.call_sid], { :Muted => false })
      Participant.new(response)
    end

    # Hangup a participant of a conference call, returning a Telapi::Participant object
    # See http://www.telapi.com/docs/api/rest/conferences/hangup-participant/
    def hangup
      response = Network.delete(['Conferences', self.conference_sid, 'Participant', self.call_sid])
      Participant.new(response)
    end

    # Play pre-recorded sound from a file to conference members, returning a Telapi::Participant object
    # See http://www.telapi.com/docs/api/rest/conferences/play-audio/
    #
    # Required params:
    # +sound_url+:: URL containing an audio file
    def play_audio(sound_url = 'http://www.telapi.com/audio.mp3')
      response = Network.post(['Conferences', self.conference_sid, 'Participant', self.call_sid], { :AudioUrl => sound_url })
      Participant.new(response)
    end

  end
end