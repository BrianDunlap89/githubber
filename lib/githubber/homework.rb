module Githubber
  class Homework
    include HTTParty
    base_uri "https://api.github.com"

    def initialize(auth_token)
      @auth = {
          "Authorization" => "token #{auth_token}",
          "User-Agent"    => "HTTParty"
      }
    end

    def create_issue(owner, repo, options={})
      Homework.post("/repos/#{owner}/#{repo}/issues",
                        :headers => @auth,
                        :body => options.to_json)
    end

    def get_teams(org)
      Homework.get("/orgs/#{org}/teams",
                        :headers => @auth)

    end

    def get_members(id, role=nil)
      Homework.get("/teams/#{id}/members",
                        :headers => @auth,
                        :query => role.to_json)

    end

    def get_contents(id, file_name)
      data = Homework.get("/gists/#{id}",
                            :headers => @auth)
      file = file_name
      gist_content = data["files"][file]["content"]
      puts "Your gist is
            #{gist_content}."
    end
  end
end