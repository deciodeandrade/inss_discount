# frozen_string_literal: true

class UpdateSalaryJob < ApplicationJob
  queue_as :default

  def perform(proponent_id, new_salary)
    proponent = Proponent.find(proponent_id)
    proponent.update(salary: new_salary)

    proponent.update(inss_discount: INSSCalculator.calculate_inss_discount(new_salary))
  end
end
