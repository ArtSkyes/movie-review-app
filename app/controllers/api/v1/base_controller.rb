class Api::V1::BaseController < ApplicationController
  def self.common_responses
    returns code: 200, desc: "Ok"
    returns code: 201, desc: "Created"
    returns code: 204, desc: "No Content"
    returns code: 400, desc: "Bad Request"
    returns code: 401, desc: "Unauthorized"
    returns code: 404, desc: "Not Found"
    returns code: 500, desc: "Internal Server Error"
  end
end
