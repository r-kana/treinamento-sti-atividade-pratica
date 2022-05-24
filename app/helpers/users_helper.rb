module UsersHelper
  def pretty_iduff iduff
    iduff.insert(3, '.').insert(7, '.').insert(11, '-')
  end
end
