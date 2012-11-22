module IronMotion
  class Code
    attr_reader :id
    attr_reader :project_id
    attr_reader :name
    attr_reader :runtime
    attr_reader :latest_checksum
    attr_reader :rev
    attr_reader :latest_history_id
    attr_reader :latest_change
    attr_reader :created_at
    attr_reader :updated_at
    attr_reader :uri

    def initialize(params={})
      @id                = params["id"]
      @project_id        = params["project_id"]
      @name              = params["name"]
      @runtime           = params["runtime"]
      @latest_checksum   = params["latest_checksum"]
      @rev               = params["rev"]
      @latest_history_id = params["latest_history_id"]
      @latest_change     = params["latest_change"]
      @created_at        = params["created_at"]
      @updated_at        = params["updated_at"]
      @url               = "#{IronMotion::Protocol.codes_uri(@project_id)}/#{id}"
    end

    def self.all(project_id, &block)
      uri = IronMotion::Protocol.codes_uri(project_id)
      IronMotion.client.get(uri) do |results|
        block.call parse_results(results)
      end
    end

    def self.get(id, project_id, &block)
      uri = "#{IronMotion::Protocol.codes_uri(project_id)}/#{id}"
      IronMotion.client.get(uri) do |results|
        block.call parse_results(results)
      end
    end

    def revisions(&block)
      uri = "#{@url}/#{IronMotion::Protocol::CODE_REVISIONS_PATH}"
      IronMotion.client.get(uri) do |results|
        block.call IronMotion::Code::Revision.parse_results(results)
      end
    end

    class Revision
      attr_reader :id
      attr_reader :code_id
      attr_reader :project_id
      attr_reader :rev
      attr_reader :runtime
      attr_reader :name
      attr_reader :filename

      def initialize(params={})
        @id         = params["id"]
        @code_id    = params["code_id"]
        @project_id = params["project_id"]
        @rev        = params["rev"]
        @runtime    = params["runtime"]
        @name       = params["name"]
        @filename   = params["filename"]
      end

      private

      def self.parse_results(results)
        results[IronMotion::Protocol::CODE_REVISIONS_KEY].map {|r| new(r)}
      end
    end

    private

    def self.parse_results(results)
      key = IronMotion::Protocol::CODES_KEY
      if results.has_key?(key)
        results[key].map do |r|
          new(r)
        end
      else
        new(results)
      end
    end

  end
end