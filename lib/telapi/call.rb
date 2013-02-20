module Telapi
  # Wraps TelAPI Call functionality
  class Call < Resource
    class << self

      # Returns a resource collection containing Telapi::Call objects
      # See http://www.telapi.com/docs/api/rest/calls/list/
      #
      # Optional params is a hash containing:
      # +To+:: phone number, e.g. 7325551234
      # +From+:: phone number, e.g. 7325551234
      # +Status+:: ringing, in-progress, queued, busy, no-answer, or failed
      # +StartTime+:: date in the following format: YYYY-MM-DD
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      # +DisableFaxDirections+:: true or (false)
      def list(optional_params = {})
        response = Network.get(['Calls'], optional_params)
        ResourceCollection.new(response, 'calls', self)
      end

      # Returns a Telapi::Call object given its id
      # See http://www.telapi.com/docs/api/rest/calls/view/
      def get(id)
        response = Network.get(['Calls', id])
        Call.new(response)
      end

      # Creates a call, returning a Telapi::Call object
      # See http://www.telapi.com/docs/api/rest/calls/make/
      #
      # Required params:
      # +to+:: phone number, e.g. 7325551234
      # +from+:: phone number, e.g. 7325551234
      # +url+:: valid url
      #
      # Optional params is a hash containing:
      # +ForwardedFrom+:: phone number, e.g. 7325551234
      # +Method+:: (POST) or GET
      # +FallbackUrl+:: valid URL
      # +FallbackMethod+:: (POST) or GET
      # +StatusCallback+:: valid URL
      # +StatusCallbackMethod+:: (POST) or GET
      # +SendDigits+:: 0-9, #, or *
      # +Timeout+:: integer greater than or equal to 0 (default: 60)
      # +HideCallerId+:: true or (false)
      # +StraightToVoicemail+:: true or (false)
      # +IfMachine+:: redirect, hangup,  or (continue)
      # +IfMachineUrl+:: valid URL
      # +IfMachineMethod+:: (POST) or GET
      def make(to, from, url, optional_params = {})
        opts = { :To => to, :From => from, :Url => url }.merge(optional_params)
        response = Network.post(['Calls'], opts)
        Call.new(response)
      end

      # Interrupts a call, returning a Telapi::Call object
      # See http://www.telapi.com/docs/api/rest/calls/interrupt/
      #
      # Required params:
      # +id+:: call id
      # +url+:: valid url
      # +method+:: (POST) or GET
      # +status+:: canceled or (completed)
      def interrupt(id, url, method = 'POST', status = 'completed')
        opts = { :Url => url, :Method => method, :Status => status }
        response = Network.post(['Calls', id], opts)
        Call.new(response)
      end

      # Hangs up a call, returning a Telapi::Call object
      # See http://www.telapi.com/docs/api/rest/calls/hangup/
      #
      # Required params:
      # +id+:: call id
      # +status+:: completed
      def hangup(id, status = 'completed')
        opts = { :Status => status }
        response = Network.post(['Calls', id], opts)
        Call.new(response)
      end

      # Sends touch tones during call, returning a Telapi::Call object
      # See http://www.telapi.com/docs/api/rest/calls/send-digits/
      #
      # Required params:
      # +id+:: call id
      # +play_dtmf+:: 0-9, W, or w
      # +play_dtmf_leg+:: aleg or bleg
      def send_digits(id, play_dtmf, play_dtmf_leg = 'aleg')
        opts = { :PlayDtmf => play_dtmf, :PlayDtmfLeg => play_dtmf_leg }
        response = Network.post(['Calls', id], opts)
        Call.new(response)
      end

      # Play audio file during call, returning a Telapi::Call object
      # See http://www.telapi.com/docs/api/rest/calls/play-audio/
      #
      # Required params:
      # +id+:: call id
      # +sound_url+:: valid URL
      #
      # Optional params is a hash containing:
      # +Length+:: integer greater than or equal to 0
      # +Legs+:: aleg, bleg, or (both)
      # +Loop+:: true or (false)
      # +Mix+::  true or (false)
      def play_audio(id, sound_url, optional_params = {})
        opts = { :Sounds => sound_url }.merge(optional_params)
        response = Network.post(['Calls', id, 'Play'], opts)
        Call.new(response)
      end

      # Change caller's voice via speed and pitch of audio, returning a Telapi::Call object
      # See http://www.telapi.com/docs/api/rest/calls/voice-effects/
      #
      # Required params:
      # +id+:: call id
      #
      # Optional params is a hash containing:
      # +AudioDirection+:: in or (out)
      # +Pitch+:: value between -1 and 1, including 0
      # +PitchSemiTones+:: value between -14 and 14, including 0
      # +PitchOctaves+:: value between -1 and 1, including 0
      # +Rate+:: value between -1 and 1, including 0
      def voice_effect(id, optional_params = {})
        response = Network.post(['Calls', id, 'Effect'], optional_params)
        Call.new(response)
      end

      # Initiate or end a call recording, returning a Telapi::Call object
      # See http://www.telapi.com/docs/api/rest/calls/record/
      #
      # Required params:
      # +id+:: call id
      # +record+:: (true) or false
      #
      # Optional params is a hash containing:
      # +TimeLimit+:: integer greater than or equal to 0
      # +CallbackUrl+:: valid URL
      def record(id, record = true, optional_params = {})
        opts = { :Record => record }.merge(optional_params)
        response = Network.post(['Calls', id, 'Recordings'], opts)
        Call.new(response)
      end

      # Returns a resource collection containing Telapi::Recording objects
      # See http://www.telapi.com/docs/api/rest/recordings/list/
      #
      # Required params:
      # +id+:: call id
      #
      # Optional params is a hash containing:
      # +DateCreated+:: date in the following format: YYYY-MM-DD
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def recordings(id, optional_params = {})
        response = Network.get(['Calls', id, 'Recordings'], optional_params)
        ResourceCollection.new(response, 'recordings', Recording)
      end

      # Returns a resource collection containing Telapi::Notification objects
      # See http://www.telapi.com/docs/api/rest/notifications/list/
      #
      # Required params:
      # +id+:: call id
      #
      # Optional params is a hash containing:
      # +Log+:: 0 (error), 1 (warning), or 2 (info)
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def notifications(id, optional_params = {})
        response = Network.get(['Calls', id, 'Notifications'], optional_params)
        ResourceCollection.new(response, 'notifications', Notification)
      end
    end

    # See ::interrupt
    def interrupt(url, method = 'POST', status = 'completed')
      self.class.interrupt(self.sid, url, method, status)
    end

    # See ::hangup
    def hangup(status = 'completed')
      self.class.hangup(self.sid, status)
    end

    # See ::send_digits
    def send_digits(play_dtmf, play_dtmf_leg = 'aleg')
      self.class.send_digits(self.sid, play_dtmf, play_dtmf_leg)
    end

    # See ::play_audio
    def play_audio(sound_url, optional_params = {})
      self.class.play_audio(self.sid, sound_url, optional_params)
    end

    # See ::voice_effect
    def voice_effect(optional_params = {})
      self.class.voice_effect(self.sid, optional_params)
    end

    # See ::record
    def record(record = true, optional_params = {})
      self.class.record(self.sid, record, optional_params)
    end

    # See ::recordings
    def recordings(optional_params = {})
      self.class.recordings(self.sid, optional_params)
    end

    # See ::notifications
    def notifications(optional_params = {})
      self.class.notifications(self.sid, optional_params)
    end

  end
end
