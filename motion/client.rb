module IronMotion
  class Client
    def initialize(params={})
      @host        = IronMotion::Protocol::HOST
      @oauth_token = params[:oauth_token]
      @headers     = {}
      @headers.merge!({"Authorization" => "OAuth #{@oauth_token}"})
      @headers.merge!({"Accept" => "appplication/json"})
      @headers.merge!({"Accept-Encoding" => "gzip/deflate"})
      @headers.merge!({"Content-Type" => "application/json"})
    end

    def request(uri, method = :get, options = nil, &block)
      opts = {}
      opts[:headers] = @headers
      opts.merge!(options) if options

      case method
      when :get
        BW::HTTP.get(uri, opts) do |response|
          if response.ok?
            string = response.body.to_str
            json = BW::JSON.parse(string)
            block.call(json)
         # elsif response.status_code == 400
         #   raise IronMotionError, "Invalid authentication: The OAuth token is either not provided or invalid."
         # elsif response.status_code == 404
         #   raise IronMotionError, "Invalid endpoint: The resource, project, or endpoint being requested doesn’t exist."
         # elsif response.status_code == 405
         #   raise IronMotionError, "Invalid HTTP method: A GET, POST, DELETE, or PUT was sent to an endpoint that doesn’t support that particular verb."
         # elsif response.status_code == 406
         #   raise IronMotionError, "Invalid request: Required fields are missing."
          else
            raise IronMotionError, "#{response.status_code}: #{response.body.to_str}"
          end
        end
      end
    end

    def get(uri, options = nil, &block)
      request(uri, :get, options, &block)
    end

  end

  @@client = nil

  def IronMotion.init(params)
    @@client = IronMotion::Client.new(params)
  end

  def IronMotion.client
    raise IronMotionError, "API Not Initialized" unless @@client
    @@client
  end

end