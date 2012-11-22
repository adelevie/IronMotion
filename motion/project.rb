module IronMotion
  class Project
    include EM::Eventable

    attr_reader :id
    attr_reader :name
    attr_reader :codes
    attr_reader :tasks

    def initialize(id)
      @id = id
      @name = "dokket"
    end

    def getCodes(&block)
      IronMotion::Code.all(@id) do |codes|
        @codes = codes
        block.call(codes)
      end
    end

    def getTasks(options=nil, &block)
      @tasks = IronMotion::Task.all(@id, options) do |tasks|
        @tasks = tasks
        block.call(tasks)
      end
    end

    def joinTasksAndCodes
      raise IronMotionError, "@codes not loaded" if @codes.nil?
      raise IronMotionError, "@tasks not loaded" if @tasks.nil?
      @tasks.map do |task|
        task.setCode @codes.select {|c| c.id == task.code_id}.first
      end

      @tasks
    end

    #def self.all
    #  [IronMotion::Project.new("509c557b7e4b7117f2002bf6")]
    #end
  end
end