# frozen_string_literal: true

require 'inss_calculator'

class ProponentsController < ApplicationController
  before_action :set_proponent, only: %i[show edit update destroy]

  # GET /proponents or /proponents.json
  def index
    @proponents = Proponent.page(params[:page]).per(5)
  end

  # GET /proponents/1 or /proponents/1.json
  def show; end

  # GET /proponents/new
  def new
    @proponent = Proponent.new
    @proponent.build_address
  end

  # GET /proponents/1/edit
  def edit; end

  # POST /proponents or /proponents.json
  def create
    @proponent = Proponent.new(proponent_params)
    @proponent.inss_discount = INSSCalculator.calculate_inss_discount(@proponent.salary)

    respond_to do |format|
      if @proponent.save
        format.html { redirect_to proponent_url(@proponent), notice: 'Proponent was successfully created.' }
        format.json { render :show, status: :created, location: @proponent }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @proponent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proponents/1 or /proponents/1.json
  def update
    @proponent.attributes = proponent_params
    @proponent.inss_discount = INSSCalculator.calculate_inss_discount(@proponent.salary)

    respond_to do |format|
      if @proponent.save
        format.html { redirect_to proponent_url(@proponent), notice: 'Proponent was successfully updated.' }
        format.json { render :show, status: :ok, location: @proponent }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @proponent.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_salary
    proponent = Proponent.find(params[:id])
    new_salary = params[:salary]

    UpdateSalaryJob.perform_later(proponent.id, new_salary)

    redirect_to proponents_path, notice: 'Salary update is being processed.'
  end

  # DELETE /proponents/1 or /proponents/1.json
  def destroy
    @proponent.destroy

    respond_to do |format|
      format.html { redirect_to proponents_url, notice: 'Proponent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def calculate_inss
    salary = params[:salary].to_f
    inss_discount = INSSCalculator.calculate_inss_discount(salary)

    render json: { inss_discount: }
  end

  def report
    @salary_ranges = Proponent.salary_ranges
  end

  def salary_report
    data = Proponent.salary_ranges.transform_values(&:count)

    render json: data
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def proponent_params
    params.require(:proponent).permit(:name, :cpf, :birth_date, :salary, :personal_contact, :reference_contact,
                                      address_attributes: %i[id street number neighborhood city state zip_code _destroy])
  end
end
