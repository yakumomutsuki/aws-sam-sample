class App
    def initialize(event, context)
        @event = event
        @context = context
    end

    def execute
        {
            statusCode: 200,
            body: {
              message: "Sample2",
              # location: response.body
              event: @event,
              context: @context
            }.to_json
        }
    end
end