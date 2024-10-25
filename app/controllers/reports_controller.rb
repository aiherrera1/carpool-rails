# frozen_string_literal: true

# Controller for model Review
class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update delete]
  before_action :authenticate_user!

  def new
    @report = Report.new
    session[:to_user_id] = params[:to_user_id]
  end

  def create
    @report = Report.new(report_params)
    @report.update(to_user_id: session[:to_user_id], from_user_id: current_user.id)
    if @report.save
      flash[:alert] = 'Your report was succesfully sent'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit; end

  def update; end

  def delete; end

  def index
    @reports = Report.group(:to_user_id).count
    @list = []
    @reports.each do |report|
      user_id = report[0]
      count = report[1]
      @list.push([user_id, count])
    end
    @list = @list.sort_by { |count| count[1] }.reverse
  end

  def ban_user
    @user = User.find(params[:id])
    @user.update(banned: true)
    @user.driver.carpools.destroy_all
    redirect_to reports_path
  end

  def unban_user
    @user = User.find(params[:id])
    @user.update(banned: false)
    redirect_to reports_path
  end

  private

  def set_report
    @report = Report.find_by(id: params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def report_params
    params.require(:report).permit(:comment)
  end
end
