module IronMotion
  module Protocol
    HOST                = "worker-aws-us-east-1.iron.io"
    VERSION             = 2
    BASE_URI            = "https://#{HOST}/#{VERSION}"
    CODES_PATH          = "codes"
    CODES_KEY           = "codes"
    CODE_REVISIONS_PATH = "revisions"
    CODE_REVISIONS_KEY  = "revisions"
    PROJECTS_PATH       = "projects"
    TASKS_PATH          = "tasks"
    TASKS_KEY           = "tasks"
    TASK_LOG_PATH       = "log"
    TASK_LOG_KEY        = "log"

    def Protocol.project_uri(project_id)
      "#{BASE_URI}/#{PROJECTS_PATH}/#{project_id}"
    end

    def Protocol.codes_uri(project_id)
      "#{Protocol.project_uri(project_id)}/#{CODES_PATH}"
    end

    def Protocol.tasks_uri(project_id)
      "#{Protocol.project_uri(project_id)}/#{TASKS_PATH}"
    end
  end
end