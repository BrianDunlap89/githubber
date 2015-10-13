module Githubber
  class PullRequests
    include HTTParty
    base_uri "https://api.github.com"

    def initialize(auth_token)
      @auth = {
          "Authorization" => "token #{auth_token}",
          "User-Agent"    => "HTTParty"
      }
    end

    def get_pull_request(owner, repo, number)
      PullRequests.get("/repos/#{owner}/#{repo}/pulls/#{number}", :headers => @auth )
    end

    def create_pull_request(owner, title, repo, head, base, body=nil)
      base = { "title": title, "head": head, "base": base, "body": body }
      PullRequests.post("/repos/#{owner}/#{repo}/pulls", :headers => @auth, :body => base.to_json   )
    end

    def is_pull_request_merged(owner, repo, number)
      PullRequests.get("/repos/#{owner}/#{repo}/pulls/#{number}/merge", :headers => @auth )
    end

  end
end


