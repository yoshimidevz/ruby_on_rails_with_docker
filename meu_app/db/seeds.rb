# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Criar usuários com diferentes roles
admin_user = Admin.find_or_create_by!(email: 'admin@quiz.com') do |admin|
  admin.password = 'password123'
  admin.password_confirmation = 'password123'
  admin.name = 'Administrador'
  admin.role = 'admin'
end

moderator_user = Admin.find_or_create_by!(email: 'moderator@quiz.com') do |admin|
  admin.password = 'password123'
  admin.password_confirmation = 'password123'
  admin.name = 'Moderador'
  admin.role = 'moderator'
end

student_user = Admin.find_or_create_by!(email: 'student@quiz.com') do |admin|
  admin.password = 'password123'
  admin.password_confirmation = 'password123'
  admin.name = 'Estudante'
  admin.role = 'student'
end

# Criar posts existentes
Post.create!([
  { title: "Laravel para sempre em tads?", content: "This is the content of the first post." },
  { title: "Joao vai trabalhar na prefeitura", content: "This is the content of the second post." },
  { title: "giovana saiu cedo", content: "This is the content of the third post." }
])

Comment.create!([
  { content: "será??, ou RoR?", post_id: 1}
])

# Criar quizzes de exemplo
quiz1 = Quiz.find_or_create_by!(title: 'Quiz de Ruby on Rails') do |quiz|
  quiz.description = 'Teste seus conhecimentos sobre Ruby on Rails, incluindo conceitos básicos, MVC, Active Record e muito mais.'
  quiz.admin = admin_user
  quiz.status = 'published'
end

quiz2 = Quiz.find_or_create_by!(title: 'Quiz de JavaScript') do |quiz|
  quiz.description = 'Avalie seu conhecimento em JavaScript, ES6+, DOM, APIs e conceitos modernos da linguagem.'
  quiz.admin = moderator_user
  quiz.status = 'published'
end

quiz3 = Quiz.find_or_create_by!(title: 'Quiz de Banco de Dados') do |quiz|
  quiz.description = 'Conhecimentos sobre SQL, relacionamentos, normalização e otimização de consultas.'
  quiz.admin = admin_user
  quiz.status = 'draft'
end

# Criar perguntas para o Quiz 1 (Ruby on Rails)
question1 = quiz1.questions.find_or_create_by!(question_text: 'O que significa MVC no contexto do Ruby on Rails?') do |q|
  q.question_type = 'multiple_choice'
  q.points = 2
end

question1.options.find_or_create_by!(option_text: 'Model, View, Controller') do |opt|
  opt.is_correct = true
end

question1.options.find_or_create_by!(option_text: 'Model, Variable, Controller') do |opt|
  opt.is_correct = false
end

question1.options.find_or_create_by!(option_text: 'Method, View, Class') do |opt|
  opt.is_correct = false
end

question1.options.find_or_create_by!(option_text: 'Model, View, Component') do |opt|
  opt.is_correct = false
end

question2 = quiz1.questions.find_or_create_by!(question_text: 'O Active Record é um padrão de design?') do |q|
  q.question_type = 'true_false'
  q.points = 1
end

question2.options.find_or_create_by!(option_text: 'Verdadeiro') do |opt|
  opt.is_correct = true
end

question2.options.find_or_create_by!(option_text: 'Falso') do |opt|
  opt.is_correct = false
end

question3 = quiz1.questions.find_or_create_by!(question_text: 'Qual comando é usado para gerar um novo controller no Rails?') do |q|
  q.question_type = 'multiple_choice'
  q.points = 2
end

question3.options.find_or_create_by!(option_text: 'rails generate controller NomeController') do |opt|
  opt.is_correct = true
end

question3.options.find_or_create_by!(option_text: 'rails new controller NomeController') do |opt|
  opt.is_correct = false
end

question3.options.find_or_create_by!(option_text: 'rails create controller NomeController') do |opt|
  opt.is_correct = false
end

question3.options.find_or_create_by!(option_text: 'rails make controller NomeController') do |opt|
  opt.is_correct = false
end

# Criar perguntas para o Quiz 2 (JavaScript)
question4 = quiz2.questions.find_or_create_by!(question_text: 'O que é uma arrow function em JavaScript?') do |q|
  q.question_type = 'multiple_choice'
  q.points = 2
end

question4.options.find_or_create_by!(option_text: 'Uma forma mais concisa de escrever funções') do |opt|
  opt.is_correct = true
end

question4.options.find_or_create_by!(option_text: 'Uma função que retorna uma seta') do |opt|
  opt.is_correct = false
end

question4.options.find_or_create_by!(option_text: 'Uma função que só funciona com arrays') do |opt|
  opt.is_correct = false
end

question4.options.find_or_create_by!(option_text: 'Uma função que não pode ter parâmetros') do |opt|
  opt.is_correct = false
end

question5 = quiz2.questions.find_or_create_by!(question_text: 'JavaScript é uma linguagem tipada estaticamente?') do |q|
  q.question_type = 'true_false'
  q.points = 1
end

question5.options.find_or_create_by!(option_text: 'Falso') do |opt|
  opt.is_correct = true
end

question5.options.find_or_create_by!(option_text: 'Verdadeiro') do |opt|
  opt.is_correct = false
end

puts "Seeds criados com sucesso!"
puts "- 3 usuários criados (admin, moderator, student)"
puts "- 3 quizzes criados"
puts "- 5 perguntas com opções criadas"
puts "- Dados de exemplo prontos para teste"
