Rails.application.routes.draw do
  scope :azure, :path => '/azure' do
    get :locations, :controller =>:hosts
  end
end
