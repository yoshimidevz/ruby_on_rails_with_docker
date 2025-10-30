# Sistema de Quiz - Ruby on Rails com Docker

## 📋 Visão Geral

Sistema completo de quiz desenvolvido em Ruby on Rails com Docker, incluindo autenticação, controle de acesso baseado em roles, interface moderna com TailwindCSS e sistema de e-mails.

## 🚀 Funcionalidades Implementadas

### ✅ Autenticação e Autorização
- **Devise** para autenticação de usuários
- **Pundit** para controle de acesso baseado em policies
- **3 Roles**: Admin, Moderator, Student
- Sistema de permissões granular

### ✅ Sistema de Quiz
- Criação e gerenciamento de quizzes
- Perguntas de múltipla escolha e verdadeiro/falso
- Sistema de pontuação configurável
- Status de quiz: Draft, Published, Closed
- Interface para fazer quizzes
- Resultados detalhados com correção

### ✅ Interface Moderna
- **TailwindCSS** para estilização
- Design responsivo e moderno
- Componentes reutilizáveis
- Experiência de usuário otimizada

### ✅ Sistema de E-mails
- **Letter Opener** para desenvolvimento
- E-mails de boas-vindas automáticos
- Interface web para visualizar e-mails

### ✅ Estrutura Completa
- Migrations para todas as tabelas
- Models com validações robustas
- Controllers com autorização
- Views com TailwindCSS
- Seeds com dados de exemplo

## 🗄️ Estrutura do Banco de Dados

### Tabelas Principais
- **admins**: Usuários do sistema com roles
- **quizzes**: Questionários criados
- **questions**: Perguntas dos quizzes
- **options**: Opções de resposta
- **answers**: Respostas dos usuários

### Relacionamentos
- Admin → Quizzes (1:N)
- Quiz → Questions (1:N)
- Question → Options (1:N)
- Admin → Answers (1:N)
- Question → Answers (1:N)

## 👥 Roles e Permissões

### Admin
- ✅ Criar, editar e excluir quizzes
- ✅ Gerenciar perguntas e opções
- ✅ Visualizar todos os quizzes
- ✅ Ver resultados de todos os usuários
- ✅ Publicar/fechar quizzes

### Moderator
- ✅ Criar e editar próprios quizzes
- ✅ Gerenciar perguntas dos próprios quizzes
- ✅ Visualizar todos os quizzes
- ✅ Ver resultados dos próprios quizzes

### Student
- ✅ Visualizar quizzes publicados
- ✅ Fazer quizzes disponíveis
- ✅ Ver próprios resultados
- ❌ Não pode criar/editar quizzes

## 🛠️ Como Executar

### 1. Iniciar Docker
```bash
# Na pasta raiz do projeto
docker-compose up -d db
```

### 2. Executar Migrations
```bash
cd meu_app
rails db:migrate
```

### 3. Popular com Dados de Exemplo
```bash
rails db:seed
```

### 4. Iniciar Servidor
```bash
# Com Docker
docker-compose up

# Ou localmente
rails server
```

### 5. Acessar Aplicação
- **URL**: http://localhost:3000
- **E-mails**: http://localhost:3000/letter_opener

## 👤 Usuários de Teste

### Admin
- **Email**: admin@quiz.com
- **Senha**: password123
- **Permissões**: Total controle do sistema

### Moderator
- **Email**: moderator@quiz.com
- **Senha**: password123
- **Permissões**: Criar e gerenciar próprios quizzes

### Student
- **Email**: student@quiz.com
- **Senha**: password123
- **Permissões**: Fazer quizzes e ver resultados

## 📊 Dados de Exemplo

O sistema inclui:
- 3 usuários com diferentes roles
- 3 quizzes de exemplo (Ruby on Rails, JavaScript, Banco de Dados)
- 5 perguntas com opções de resposta
- Sistema de pontuação configurado

## 🎯 Fluxo de Uso

### Para Administradores/Moderadores
1. Fazer login
2. Criar novo quiz
3. Adicionar perguntas e opções
4. Publicar quiz
5. Acompanhar resultados

### Para Estudantes
1. Fazer login
2. Visualizar quizzes disponíveis
3. Fazer quiz
4. Ver resultado detalhado
5. Refazer quiz se necessário

## 🔧 Tecnologias Utilizadas

- **Ruby on Rails 8.0.2**
- **PostgreSQL** (via Docker)
- **Devise** (autenticação)
- **Pundit** (autorização)
- **TailwindCSS** (interface)
- **Letter Opener** (e-mails de desenvolvimento)
- **Docker & Docker Compose**

## 📁 Estrutura de Arquivos

```
meu_app/
├── app/
│   ├── controllers/
│   │   ├── quizzes_controller.rb
│   │   ├── questions_controller.rb
│   │   └── answers_controller.rb
│   ├── models/
│   │   ├── quiz.rb
│   │   ├── question.rb
│   │   ├── option.rb
│   │   └── answer.rb
│   ├── policies/
│   │   ├── quiz_policy.rb
│   │   ├── question_policy.rb
│   │   └── answer_policy.rb
│   └── views/
│       └── quizzes/
│           ├── index.html.erb
│           ├── new.html.erb
│           ├── take_quiz.html.erb
│           └── results.html.erb
├── db/
│   ├── migrate/
│   └── seeds.rb
└── config/
    └── routes.rb
```

## 🚀 Próximos Passos

- [ ] Implementar sistema de notificações
- [ ] Adicionar relatórios de performance
- [ ] Implementar categorias de quiz
- [ ] Adicionar sistema de tempo limite
- [ ] Implementar ranking de usuários
- [ ] Adicionar exportação de resultados

## 📝 Notas Importantes

- O sistema está configurado para desenvolvimento
- E-mails são simulados com Letter Opener
- Todas as validações estão implementadas
- Interface totalmente responsiva
- Código seguindo boas práticas do Rails

---

**Desenvolvido com ❤️ usando Ruby on Rails e Docker**




