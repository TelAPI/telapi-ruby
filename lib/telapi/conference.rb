module Telapi
  # Wraps TelAPI Conference functionality
  class Conference < Resource
    class << self

      # Returns a resource collection containing Telapi::Conference objects
      # See http://www.telapi.com/docs/api/rest/conferences/list/
      #
      # Optional params is a hash containing:
      # +MemberID+:: string
      # +Muted+:: true or false
      # +Deafed+:: true or false
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def list(optional_params = {})
        response = Network.get(['Conferences'], optional_params)
        ResourceCollection.new(response, 'conferences', self)
      end

      # Returns a Telapi::Conference object given its name
      # See http://www.telapi.com/docs/api/rest/conferences/view/
      #
      # Required params:
      # +conference_name+:: conference name
      #
      # Optional params is a hash containing:
      # +MemberID+:: string
      # +Muted+:: true or (false)
      # +Deafed+:: true or (false)
      def get(conference_name, optional_params = {})
        response = Network.get(['Conferences', conference_name], optional_params)
        Conference.new(response)
      end

      # Mute a member of a conference call, returning a Telapi::Conference object
      # See http://www.telapi.com/docs/api/rest/conferences/mute/
      #
      # Required params:
      # +conference_name+:: conference name
      # +member_id+:: string
      def mute_member(conference_name, member_id)
        opts = { :MemberID => member_id }
        response = Network.post(['Conferences', conference_name, 'Mute'], opts)
        Conference.new(response)
      end

      # Unmute a member of a conference call, returning a Telapi::Conference object
      # See http://www.telapi.com/docs/api/rest/conferences/unmute/
      #
      # Required params:
      # +conference_name+:: conference name
      # +member_id+:: string
      def unmute_member(conference_name, member_id)
        opts = { :MemberID => member_id }
        response = Network.post(['Conferences', conference_name, 'UnMute'], opts)
        Conference.new(response)
      end

      # Deaf audio for a specific member of a conference call, returning a Telapi::Conference object
      # See http://www.telapi.com/docs/api/rest/conferences/deaf/
      #
      # Required params:
      # +conference_name+:: conference name
      # +member_id+:: string
      def deaf_member(conference_name, member_id)
        opts = { :MemberID => member_id }
        response = Network.post(['Conferences', conference_name, 'Deaf'], opts)
        Conference.new(response)
      end

      # Restore audio for a specific member of a conference call, returning a Telapi::Conference object
      # See http://www.telapi.com/docs/api/rest/conferences/undeaf/
      #
      # Required params:
      # +conference_name+:: conference name
      # +member_id+:: string
      def undeaf_member(conference_name, member_id)
        opts = { :MemberID => member_id }
        response = Network.post(['Conferences', conference_name, 'UnDeaf'], opts)
        Conference.new(response)
      end

      # Hangup a specific member of a conference call, returning a Telapi::Conference object
      # See http://www.telapi.com/docs/api/rest/conferences/hangup/
      #
      # Required params:
      # +conference_name+:: conference name
      # +member_id+:: string
      def hangup_member(conference_name, member_id)
        opts = { :MemberID => member_id }
        response = Network.post(['Conferences', conference_name, 'Hangup'], opts)
        Conference.new(response)
      end

      # Remove a specific member of a conference call, returning a Telapi::Conference object
      # See http://www.telapi.com/docs/api/rest/conferences/kick/
      #
      # Required params:
      # +conference_name+:: conference name
      # +member_id+:: string
      def kick_member(conference_name, member_id)
        opts = { :MemberID => member_id }
        response = Network.post(['Conferences', conference_name, 'Kick'], opts)
        Conference.new(response)
      end

      # Send message that will be read in an audible voice to conference members, returning a Telapi::Conference object
      # See http://www.telapi.com/docs/api/rest/conferences/speak-text/
      #
      # Required params:
      # +conference_name+:: conference name
      # +member_id+:: string
      # +text+:: string
      def speak_text(conference_name, member_id, text)
        opts = { :MemberID => member_id, :Text => text }
        response = Network.post(['Conferences', conference_name, 'Say'], opts)
        Conference.new(response)
      end

      # Play pre-recorded sound from a file to conference members, returning a Telapi::Conference object
      # See http://www.telapi.com/docs/api/rest/conferences/play-audio/
      #
      # Required params:
      # +conference_name+:: conference name
      # +member_id+:: string
      # +sound_url+:: valid URL
      def play_audio(conference_name, member_id, sound_url)
        opts = { :MemberID => member_id, :Url => sound_url }
        response = Network.post(['Conferences', conference_name, 'Play'], opts)
        Conference.new(response)
      end

      # Record conference, returning a Telapi::Conference object
      # See http://www.telapi.com/docs/api/rest/conferences/start-recording/
      #
      # Required params:
      # +conference_name+:: conference name
      def start_recording(conference_name)
        response = Network.post(['Conferences', conference_name, 'RecordStart'])
        Conference.new(response)
      end

      # End recording of conference, returning a Telapi::Conference object
      # See http://www.telapi.com/docs/api/rest/conferences/stop-recording/
      #
      # Required params:
      # +conference_name+:: conference name
      def stop_recording(conference_name)
        response = Network.post(['Conferences', conference_name, 'RecordStop'])
        Conference.new(response)
      end

    end

    # See ::mute_member
    def mute_member(member_id)
      self.class.mute_member(self.name, member_id)
    end

    # See ::unmute_member
    def unmute_member(member_id)
      self.class.unmute_member(self.name, member_id)
    end

    # See ::deaf_member
    def deaf_member(member_id)
      self.class.deaf_member(self.name, member_id)
    end

    # See ::undeaf_member
    def undeaf_member(member_id)
      self.class.undeaf_member(self.name, member_id)
    end

    # See ::hangup_member
    def hangup_member(member_id)
      self.class.hangup_member(self.name, member_id)
    end

    # See ::kick_member
    def kick_member(member_id)
      self.class.kick_member(self.name, member_id)
    end

    # See ::speak_text
    def speak_text(member_id, text)
      self.class.speak_text(self.name, member_id, text)
    end

    # See ::play_audio
    def play_audio(member_id, sound_url)
      self.class.play_audio(self.name, member_id, sound_url)
    end

    # See ::start_recording
    def start_recording
      self.class.start_recording(self.name)
    end

    # See ::stop_recording
    def stop_recording
      self.class.stop_recording(self.name)
    end

  end
end