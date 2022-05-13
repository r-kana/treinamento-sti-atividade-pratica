module UsersHelper
  def pretty_cpf cpf
    cpf.insert(3, '.').insert(7, '.').insert(11, '-')
  end
end
