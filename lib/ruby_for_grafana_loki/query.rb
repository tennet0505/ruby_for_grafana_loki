module RubyForGrafanaLoki
  class Query
    attr_reader :streams_data
      def initialize(response)
          @streams_data = response['streams']
      end
    end
end