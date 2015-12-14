class PaymentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    loan = Loan.find(params[:loan_id])
    render json: loan.payments
  end

  def show
    render json: Payment.find(params[:id])
  end

  def create
    payment = Payment.new(payment_params)
    payment.save ? (render json: payment) :
      (render json: {errors: payment.errors.full_messages}, status: :unprocessable_entity)
  end

  private

  def payment_params
    params.require(:payment).permit(:payment_amount, :payment_date, :loan_id)
  end
end
