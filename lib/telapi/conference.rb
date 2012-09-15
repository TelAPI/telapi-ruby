module Telapi
  # Wraps TelAPI Conference functionality
  class Conference < Resource
    class << self

      # Returns a resource collection containing Telapi::Conference objects
      # See http://www.telapi.com/docs/api/rest/conferences/list/
      #
      # Optional params is a hash containing:
      # +FriendlyName+:: string
      # +Status+:: init, in-progress, or completed
      # +DateCreate+:: date in the following format: YYYY-MM-DD
      # +DateUpdated+:: date in the following format: YYYY-MM-DD
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
      # +conference_sid+:: conference identifier
      def get(conference_sid)
        response = Network.get(['Conferences', conference_sid])
        Conference.new(response)
      end

      # Returns a resource collection containing Telapi::Participant objects
      # See http://www.telapi.com/docs/api/rest/conferences/list-participants/
      # Required params:
      # +conference_sid+:: conference identifier
      #
      # Optional params:
      # +Muted+:: true or (false)
      # +Deaf+:: true or (false)
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def participants(conference_sid, optional_params = {})
        response = Network.get(['Conferences', conference_sid, 'Participants'], optional_params)
        ResourceCollection.new(response, 'participants', Participant)
      end

      # Returns a Telapi::Participant object
      # See http://www.telapi.com/docs/api/rest/conferences/view-participant/
      # Required params:
      # +conference_sid+:: conference identifier
      # +call_sid+:: call identifier
      def participant(conference_sid, call_sid)
        response = Network.get(['Conferences', conference_sid, 'Participants', call_sid])
        Participant.new(response)
      end

    end

    # See ::participants
    def participants(optional_params = {})
      self.class.participants(self.sid, optional_params)
    end

    # See ::participant
    # Required params:
    # +call_sid+:: call (participant) identifier
    def participant(call_sid)
      self.class.participant(self.sid, call_sid)
    end

  end
end