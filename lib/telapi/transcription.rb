module Telapi
  # Wraps TelAPI Transcription functionality
  class Transcription < Resource
    class << self

      # Returns a resource collection containing Telapi::Transcription objects
      # See http://www.telapi.com/docs/api/rest/transcriptions/list/
      #
      # Also, Transcriptions can be scoped to a recording, see Telapi::Recording::transcriptions
      #
      # Optional params is a hash containing:
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def list(optional_params = {})
        response = Network.get(['Transcriptions'], optional_params)
        ResourceCollection.new(response, 'transcriptions', self)
      end

      # Returns a Telapi::Transcription object given its id
      # See http://www.telapi.com/docs/api/rest/transcriptions/view/
      def get(id)
        response = Network.get(['Transcriptions', id])
        Transcription.new(response)
      end

      # Transcribes any audio url, returning a Telapi::Transcription object
      # See http://www.telapi.com/docs/api/rest/transcriptions/transcribe-audio-url/
      #
      # Required params:
      # +audio_url+:: valid url
      #
      # Optional params is a hash containing:
      # +TranscribeCallback+:: valid URL
      # +CallbackMethod+:: (POST) or GET
      # +Quality+:: (auto), silver, gold, or platinum
      def transcribe_audio(audio_url, optional_params = {})
        opts = { :AudioUrl => audio_url }.merge(optional_params)
        response = Network.post(['Transcriptions'], opts)
        Transcription.new(response)
      end

    end
  end
end