class GroupsController < ApplicationController
  load_and_authorize_resource
  before_action :set_group, only: %i[show edit update destroy]

  def index
    @user = current_user
    @groups = Group.where(user_id: @user.id).includes(:group_payments)
    @total_user_amount = @groups.flat_map(&:payments).sum(&:amount)
    render :index, locals: { total_user_amount: @total_user_amount }
  end

  def show
    @group = Group.find(params[:id])
    @payments = @group.payments.order(created_at: :desc)
  end

  def new
    @group = Group.new
  end

  def edit; end

  def create
    @group = current_user.groups.build(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to group_url(@group), notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    payments = []
    group_payments = @group.group_payments.all
    group_payments.each do |e|
      payment = Payment.find_by(id: e.payment_id)
      payments.push(payment)
    end

    group_payments.destroy_all
    payments.each(&:destroy)
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
