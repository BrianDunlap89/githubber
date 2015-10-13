module Githubber
  class Issues
    include HTTParty
    base_uri "https://api.github.com"

    def initialize(auth_token)
      @auth = {
        "Authorization" => "token #{auth_token}",
        "User-Agent"    => "HTTParty"
      }
    end

    def comment(owner, repo, iss_num)
      puts "Please enter your comment: "
      comment = { "body": gets.chomp }
      Issues.post("/repos/#{owner}/#{repo}/issues/#{iss_num}/comments",
                   :headers => @auth, :body => comment.to_json)
    end

    def list_issues(owner, repo, options={})
      Issues.get("/repos/#{owner}/#{repo}/issues", 
                  :headers => @auth, :body => options.to_json)
    end

    def close_issue(owner, repo, iss_num)
      closed = { "state": "closed" }
      Issues.patch("/repos/#{owner}/#{repo}/issues/#{iss_num}", 
                    :headers => @auth, :body => closed.to_json)
    end
  end
end
