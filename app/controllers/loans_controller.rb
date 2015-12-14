class LoansController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: Loan.all
  end

  def show
    render json: Loan.find(params[:id])
  end

  def create
    loan = Loan.new(loan_params)
    loan.save ? (render json: loan) :
      (render json: {errors: loan.errors.full_messages}, status: :unprocessable_entity)
  end

  private

  def loan_params
    params.require(:loan).permit(:funded_amount)
  end
end
