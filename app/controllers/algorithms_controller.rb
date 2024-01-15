class AlgorithmsController < ApplicationController
  def index
    begin
      histories = History.all
      render json: { histories: histories }, status: :ok
    rescue => e
      e.class.name == "ActiveRecord::RecordNotFound" ? status = :not_found : status = :internal_server_error
      render json: { data: [], error: e.message }, status: status
    end
  end

  def show
    begin
      history = History.find(params[:id])
      render json: { history: history }, status: :ok
    rescue => e
      e.class.name == "ActiveRecord::RecordNotFound" ? status = :not_found : status = :internal_server_error
      render json: { data: [], error: e.message }, status: status
    end
  end

  def create
    begin
      lines = params[:board].split("\n")
      board = []
      lines.each do |value|
        board.push(value.split(""))
      end

      record = History.new(board: board.to_json)
      response = MazeSolver.new(board).resolve
      record.board_path = response[1].to_json
      record.answer = response[0] ? 'Yes' : 'No'
      record.save!

      maze = { result: response[0] ? 'Yes' : 'No', board: response[1] }

      render json: { data: maze }, status: :created
    rescue => e
      e.class.name == "ActiveRecord::RecordNotFound" ? status = :not_found : status = :internal_server_error
      render json: { data: [], error: e.message }, status: status
    end
  end
end