class PaymentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_payment, only: %i[show edit update destroy]

  def index
    @group_id = params[:group_id]
    @payments = Payment.all
  end

  def show
    @group = Group.find(params[:group_id])
  end

  def new
    @group_id = params[:group_id]
    @group = Group.find(@group_id)
    @payment = Payment.new
  end

  def edit
    @group = Group.find(params[:group_id])
    @payment = Payment.find(params[:id])
  end

  def create
    @payment = current_user.payments.build(payment_params)
    @group_id = params[:payment][:group_id]

    if @payment.save
      @group_payment = GroupPayment.new(group_id: @group_id, payment_id: @payment.id)

      if @group_payment.save
        redirect_to group_url(@group_id), notice: 'Payment was successfully created.'
      else
        flash[:alert] = 'Group payment couldn`t be saved'
        redirect_to new_group_payment_url(@group_id)
      end
    else
      flash[:alert] = 'Transaction couldn`t be saved, please check name and amount'
      @group_id = params[:group_id]
      redirect_to new_group_payment_url(@group_id)
    end
  end

  def update
    @group = Group.find(params[:group_id])
    @payment = Payment.find(params[:id])

    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to payment_url(@payment), notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @payment.group_payments.destroy_all
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to group_url(@group), notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:name, :amount)
  end
end
