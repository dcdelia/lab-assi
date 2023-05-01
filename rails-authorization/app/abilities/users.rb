Canard::Abilities.for(:user) do
  can [:read, :create], Movie
  cannot [:destroy], Movie
end
