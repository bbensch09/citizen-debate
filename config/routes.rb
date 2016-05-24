Rails.application.routes.draw do

  resources :topic_tags
  mount Ckeditor::Engine => '/ckeditor'

  get '/taxes-should-be-raised-on-Americans-who-earn-at-least-250k' => 'debates#launch'
  get 'BingSiteAuth.xml' => 'about#BingSiteAuth'
  resources :closing_statements
  resources :opening_statements
  resources :comments, only: [:new, :create]
  resources :civility_votes
  resources :debate_votes
  resources :messages
  resources :rounds do
    member do
      post :start_first_round
    end
  end
  resources :verdicts
  resources :debates do
    member do
      post :accept_challenge
      get :share_times_with_opponent
      get :schedule
      get :notify_followers
      get :skip_to_results
      get :share_challenge
    end
  end
  resources :available_times do
    member do
      post :confirm
    end
  end

  resources :debaters
  resources :judges
  resources :profiles do
    member do
      post :verify
    end
  end
  resources :topics
  resources :topic_votes do
    member do
      post :upvote
      post :follow
      post :unfollow
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get 'comments' => 'comments#new'
  get '/admin_index' => 'profiles#admin_index'
  get '/admin_users' => 'profiles#admin_users'
  get '/early_adopter_program' => 'welcome#early_adopter_program'
  get '/debate_format' => 'about#debate_format'
  get '/reputation' => 'about#reputation'
  get '/faqs' => 'about#faqs'
  get '/about_us' => 'about#about_us'
  get '/register-to-vote' => 'about#register_to_vote'
  get '/privacy_policy' =>'about#privacy_policy'
  get '/terms_of_service' =>'about#terms_of_service'
  # HACKY SHIT
  get '/test' => 'profiles#test_page'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  end
