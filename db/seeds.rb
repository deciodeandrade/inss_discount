Proponent.destroy_all

proponents_data = [
  {
    name: "Maria Silva",
    cpf: "12345678901",
    birth_date: "1990-05-15",
    salary: 1500.00,
    inss_discount: 119.32,
    personal_contact: "11987654321",
    reference_contact: "11912345678"
  },
  {
    name: "João Santos",
    cpf: "23456789012",
    birth_date: "1985-03-22",
    salary: 2500.00,
    inss_discount: 221.64,
    personal_contact: "11876543210",
    reference_contact: "11887654321"
  },
  {
    name: "Ana Pereira",
    cpf: "34567890123",
    birth_date: "1992-07-10",
    salary: 3000.00,
    inss_discount: 281.64,
    personal_contact: "11765432100",
    reference_contact: "11776543210"
  },
  {
    name: "Carlos Oliveira",
    cpf: "45678901234",
    birth_date: "1988-11-30",
    salary: 4500.00,
    inss_discount: 488.95,
    personal_contact: "11654321009",
    reference_contact: "11665432100"
  },
  {
    name: "Juliana Costa",
    cpf: "56789012345",
    birth_date: "1995-09-01",
    salary: 5000.00,
    inss_discount: 558.95,
    personal_contact: "11543210987",
    reference_contact: "11554321098"
  },
  {
    name: "Roberto Almeida",
    cpf: "67890123456",
    birth_date: "1978-12-15",
    salary: 6000.00,
    inss_discount: 698.95,
    personal_contact: "11432109876",
    reference_contact: "11443210987"
  },
  {
    name: "Fernanda Lima",
    cpf: "78901234567",
    birth_date: "1980-04-20",
    salary: 3500.00,
    inss_discount: 348.95,
    personal_contact: "11321098765",
    reference_contact: "11332109876"
  },
  {
    name: "Lucas Martins",
    cpf: "89012345678",
    birth_date: "1991-06-11",
    salary: 2800.00,
    inss_discount: 257.64,
    personal_contact: "11210987654",
    reference_contact: "11221098765"
  },
  {
    name: "Patricia Rocha",
    cpf: "90123456789",
    birth_date: "1983-02-25",
    salary: 3200.00,
    inss_discount: 306.95,
    personal_contact: "11109876543",
    reference_contact: "11110987654"
  },
  {
    name: "Gabriel Ferreira",
    cpf: "01234567890",
    birth_date: "1994-08-05",
    salary: 4000.00,
    inss_discount: 418.95,
    personal_contact: "11098765432",
    reference_contact: "11009876543"
  }
]

proponents_data.each do |data|
  proponent = Proponent.create!(data)

  Address.create!(
    proponent: proponent,
    street: "Rua #{proponent.name.split.first}",
    number: rand(1..100).to_s,
    neighborhood: "Bairro #{proponent.name.split.last}",
    city: "Cidade Exemplo",
    state: "SP",
    zip_code: "12345-678"
  )
end

puts "Created 10 realistic proponents with addresses and INSS discounts."
