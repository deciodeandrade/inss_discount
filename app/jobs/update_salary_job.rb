# frozen_string_literal: true

class UpdateSalaryJob < ApplicationJob
  queue_as :default

  def perform(proponent_id, new_salary)
    proponent = Proponent.find(proponent_id)
    proponent.update(salary: new_salary)

    proponent.update(inss_discount: calculate_inss_discount(new_salary))
  end

  private

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
