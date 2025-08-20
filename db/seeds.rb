# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Iniciando seed do banco de dados..."

# Limpar dados existentes (opcional - descomente se quiser limpar tudo)
# puts "🧹 Limpando dados existentes..."
# Appointment.destroy_all
# Client.destroy_all
# Procedure.destroy_all
# User.destroy_all

# Criar usuário principal se não existir
puts "👤 Criando usuário principal..."
user = User.find_or_create_by!(id: 1) do |u|
  u.email = "admin@clinica.com"
  u.password = "123456"
  u.password_confirmation = "123456"
  u.name = "Administrador da Clínica"
  u.role = "admin"
end

puts "✅ Usuário criado: #{user.email} (ID: #{user.id})"

# Criar procedimentos se não existirem
puts "🏥 Criando procedimentos..."
procedures = [
  {
    name: "Consulta de Rotina",
    description: "Avaliação médica geral e preventiva",
    price: 150.00
  },
  {
    name: "Exame de Sangue",
    description: "Análise laboratorial completa",
    price: 89.90
  },
  {
    name: "Eletrocardiograma",
    description: "Exame do coração",
    price: 120.00
  },
  {
    name: "Ultrassom Abdominal",
    description: "Exame de imagem do abdômen",
    price: 200.00
  },
  {
    name: "Fisioterapia",
    description: "Sessão de fisioterapia",
    price: 80.00
  },
  {
    name: "Dermatologia",
    description: "Consulta especializada em pele",
    price: 180.00
  },
  {
    name: "Oftalmologia",
    description: "Consulta especializada em olhos",
    price: 160.00
  },
  {
    name: "Cardiologia",
    description: "Consulta especializada em coração",
    price: 220.00
  }
]

procedures.each do |proc_data|
  Procedure.find_or_create_by!(name: proc_data[:name]) do |p|
    p.description = proc_data[:description]
    p.price = proc_data[:price]
  end
end

puts "✅ #{Procedure.count} procedimentos criados"

# Criar 100 clientes
puts "👥 Criando 100 clientes..."
100.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.unique.email(name: "#{first_name}.#{last_name}")
  phone = Faker::PhoneNumber.cell_phone_in_e164

  Client.find_or_create_by!(email: email) do |c|
    c.first_name = first_name
    c.last_name = last_name
    c.phone = phone
  end
end

puts "✅ #{Client.count} clientes criados"

# Criar 100 agendamentos vinculados ao usuário 1
puts "📅 Criando 100 agendamentos..."
100.times do |i|
  # Selecionar cliente e procedimento aleatórios
  client = Client.offset(rand(Client.count)).first
  procedure = Procedure.offset(rand(Procedure.count)).first

  # Gerar data/hora aleatória nos próximos 6 meses
  scheduled_at = Time.current + rand(6.months) + rand(8..18).hours + rand(0..59).minutes

  # Status aleatório
  statuses = [ "agendado", "confirmado", "em_andamento", "concluído", "cancelado" ]
  status = statuses.sample

  # Notas aleatórias (opcional)
  notes = case status
  when "cancelado"
    [ "Paciente solicitou cancelamento", "Horário não disponível", "Paciente não compareceu" ].sample
  when "concluído"
    [ "Procedimento realizado com sucesso", "Paciente liberado", "Aguardando resultado" ].sample
  else
    [ "", "Lembrar de confirmar", "Paciente solicitou horário específico" ].sample
  end

  Appointment.find_or_create_by!(
    client: client,
    procedure: procedure,
    user: user,
    scheduled_at: scheduled_at
  ) do |a|
    a.status = status
    a.notes = notes
  end
end

puts "✅ #{Appointment.count} agendamentos criados"

puts "🎉 Seed concluído com sucesso!"
puts "📊 Resumo:"
puts "   - Usuários: #{User.count}"
puts "   - Clientes: #{Client.count}"
puts "   - Procedimentos: #{Procedure.count}"
puts "   - Agendamentos: #{Appointment.count}"
puts ""
puts "🔑 Credenciais de acesso:"
puts "   Email: admin@clinica.com"
puts "   Senha: 123456"
puts ""
puts "💡 Execute 'bin/rails db:seed' para executar novamente"
