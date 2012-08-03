module Telapi
  # Wraps TelAPI Recording functionality
  class Recording < Resource
    class << self

      # Returns a resource collection containing Telapi::Recording objects
      # See http://www.telapi.com/docs/api/rest/recordings/list/
      #
      # Also, recordings can be scoped to a call, see Telapi::Call::recordings
      #
      # Optional params is a hash containing:
      # +DateCreated+:: date in the following format: YYYY-MM-DD
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def list(optional_params = {})
        response = Network.get(['Recordings'], optional_params)
        ResourceCollection.new(response, 'recordings', self)
      end

      # Returns a Telapi::Recording object given its id
      # See http://www.telapi.com/docs/api/rest/recordings/view/
      def get(id)
        response = Network.get(['Recordings', id])
        Recording.new(response)
      end

      # Transcribes a recording and returns a Telapi::Transcription object
      # See http://www.telapi.com/docs/api/rest/transcriptions/transcribe-recording/
      #
      # Required params:
      # +id+:: recording id
      #
      # Optional params is a hash containing:
      # +TranscribeCallback+:: valid URL
      # +CallbackMethod+:: (POST) or GET
      # +Quality+:: (auto), silver, gold, or platinum
      def transcribe(id, optional_params = {})
        response = Network.post(['Recordings', id, 'Transcriptions'], optional_params)
        Transcription.new(response)
      end

      # Returns a resource collection containing Telapi::Transcription objects
      # See http://www.telapi.com/docs/api/rest/transcriptions/list/
      #
      # Required params:
      # +id+:: recording id
      #
      # Optional params is a hash containing:
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def transcriptions(id, optional_params = {})
        response = Network.get(['Recordings', id, 'Transcriptions'], optional_params)
        ResourceCollection.new(response, 'transcriptions', Transcription)
      end

    end

    # See ::transcribe
    def transcribe(optional_params = {})
      self.class.transcribe(self.sid, optional_params)
    end

    # See ::transcriptions
    def transcriptions(optional_params = {})
      self.class.transcriptions(self.sid, optional_params)
    end

  end
end