class Api::V1::ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:like]
  def like
    render json: {name: "kk", age: 18, id: params[:id]}
  end
end
