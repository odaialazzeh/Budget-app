class GroupPaymentsController < ApplicationController
  before_action :set_group_payment, only: %i[show edit update destroy]

  # GET /group_payments or /group_payments.json
  def index
    @group_payments = GroupPayment.all
  end

  # GET /group_payments/1 or /group_payments/1.json
  def show; end

  # GET /group_payments/new
  def new
    @group_payment = GroupPayment.new
  end

  # GET /group_payments/1/edit
  def edit; end

  # POST /group_payments or /group_payments.json
  def create
    @group_payment = GroupPayment.new(group_payment_params)

    respond_to do |format|
      if @group_payment.save
        format.html { redirect_to group_payment_url(@group_payment), notice: 'Group payment was successfully created.' }
        format.json { render :show, status: :created, location: @group_payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_payments/1 or /group_payments/1.json
  def update
    respond_to do |format|
      if @group_payment.update(group_payment_params)
        format.html { redirect_to group_payment_url(@group_payment), notice: 'Group payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_payments/1 or /group_payments/1.json
  def destroy
    @group_payment.destroy

    respond_to do |format|
      format.html { redirect_to group_payments_url, notice: 'Group payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group_payment
    @group_payment = GroupPayment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_payment_params
    params.fetch(:group_payment, {})
  end
end
