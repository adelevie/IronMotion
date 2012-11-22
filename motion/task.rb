module IronMotion
  class Task
    attr_reader :id
    attr_reader :project_id
    attr_reader :code_id
    attr_reader :code
    attr_reader :code_history_id
    attr_reader :status
    attr_reader :code_name
    attr_reader :code_rev
    attr_reader :start_time
    attr_reader :end_time
    attr_reader :duration
    attr_reader :timeout
    attr_reader :updated_at
    attr_reader :created_at
    attr_reader :run_times
    attr_reader :percent
    attr_reader :payload

    def initialize(params={})
      @id              = params["id"]
      @project_id      = params["project_id"]
      @code_id         = params["code_id"]
      @code_history_id = params["code_history_id"]
      @status          = params["status"]
      @code_name       = params["code_name"]
      @code_rev        = params["code_rev"]
      @start_time      = params["start_time"]
      @end_time        = params["end_time"]
      @duration        = params["duration"]
      @timeout         = params["timeout"]
      @updated_at      = params["updated_at"]
      @created_at      = params["created_at"]
      @run_times       = params["run_times"]
      @percent         = params["percent"]
      @payload         = params["payload"]
      @url             = "#{IronMotion::Protocol.tasks_uri(project_id)}/#{@id}"
    end

    def self.all(project_id, options, &block)
      default_options = {
        :per_page => 100,
        :from_time => (Time.now - 24.hours).timeIntervalSince1970
      }
      default_options.merge!(options) if options
      opts = default_options
      query_string = IronMotion::Helper.hash_to_query_string(opts)
      uri = IronMotion::Protocol.tasks_uri(project_id) + query_string
      IronMotion.client.get(uri) do |results|
        block.call parse_results(results)
      end
    end

    def self.get(id, project_id, &block)
      uri = "#{IronMotion::Protocol.tasks_uri(project_id)}/#{id}"
      IronMotion.client.get(uri) do |results|
        block.call parse_results(results)
      end
    end

    def setCode(code)
      @code = code
    end

    #TODO: make sure this works
    def log(&block)
      uri = "#{@url}/#{IronMotion::Protocol::TASK_LOG_PATH}"
      options = {
        :headers => {"Content-Type" => "text/plain"}
      }
      IronMotion.client.get(uri, options) do |results|
        block.call(results)
      end
    end

    private

    def self.parse_results(results)
      key = IronMotion::Protocol::TASKS_KEY
      if results.has_key?(key)
        results[key].map {|r| new(r)}
      else
        new(results)
      end
    end

  end
end