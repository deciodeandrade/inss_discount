class ProponentsController < ApplicationController
  before_action :set_proponent, only: %i[ show edit update destroy ]

  # GET /proponents or /proponents.json
  def index
    @proponents = Proponent.page(params[:page]).per(5)
  end

  # GET /proponents/1 or /proponents/1.json
  def show
  end

  # GET /proponents/new
  def new
    @proponent = Proponent.new
    @proponent.build_address
  end

  # GET /proponents/1/edit
  def edit
  end

  # POST /proponents or /proponents.json
  def create
    @proponent = Proponent.new(proponent_params)
    @proponent.inss_discount = calculate_inss_discount(@proponent.salary)

    respond_to do |format|
      if @proponent.save
        format.html { redirect_to proponent_url(@proponent), notice: "Proponent was successfully created." }
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
    @proponent.inss_discount = calculate_inss_discount(@proponent.salary)

    respond_to do |format|
      if @proponent.save
        format.html { redirect_to proponent_url(@proponent), notice: "Proponent was successfully updated." }
        format.json { render :show, status: :ok, location: @proponent }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @proponent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proponents/1 or /proponents/1.json
  def destroy
    @proponent.destroy

    respond_to do |format|
      format.html { redirect_to proponents_url, notice: "Proponent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def calculate_inss
    salary = params[:salary].to_f
    inss_discount = calculate_inss_discount(salary)
    render json: { inss_discount: inss_discount }
  end

  def report
    @salary_ranges = Proponent.salary_ranges
  end

  def salary_report
    data = Proponent.salary_ranges.map { |range, proponents| [range, proponents.count] }.to_h
  
    render json: data
  end

  private
    def set_proponent
      @proponent = Proponent.find(params[:id])
    end

    def proponent_params
      params.require(:proponent).permit(:name, :cpf, :birth_date, :salary, :personal_contact, :reference_contact, address_attributes: [:id, :street, :number, :neighborhood, :city, :state, :zip_code, :_destroy])
    end

    def calculate_inss_discount(salary)
      if salary <= 1045.00
        salary * 0.075
      elsif salary <= 2089.60
        (1045.00 * 0.075) + ((salary - 1045.00) * 0.09)
      elsif salary <= 3134.40
        (1045.00 * 0.075) + ((2089.60 - 1045.00) * 0.09) + ((salary - 2089.60) * 0.12)
      elsif salary <= 6101.06
        (1045.00 * 0.075) + ((2089.60 - 1045.00) * 0.09) + ((3134.40 - 2089.60) * 0.12) + ((salary - 3134.40) * 0.14)
      else
        (1045.00 * 0.075) + ((2089.60 - 1045.00) * 0.09) + ((3134.40 - 2089.60) * 0.12) + ((6101.06 - 3134.40) * 0.14)
      end
    end
end
