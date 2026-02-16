Rails.application.routes.draw do
  root 'console#index'

  get 'chats', to: 'chats#index', as: 'chats'

  get 'users', to: 'users#index', as: 'users'
  get 'users/new', to: 'users#new', as: 'new_user'
  post 'users', to: 'users#create', as: 'create_user'
  delete 'users/:id', to: 'users#destroy', as: 'destroy_user'
  get 'users/:id', to: 'users#show', as: 'user'
  get 'users/:id/edit', to: 'users#edit', as: 'edit_user'
  patch 'users/:id', to: 'users#update', as: 'update_user'

  scope "/adapto" do
    get "/servers/:servername/commands", to: "servers#adapto_commands"
    post "/servers/:servername/commands/:id/status", to: "servers#adapto_commands_status"
    post "/servers/register", to: "servers#register"
    get "/videos/:id/download", to: "videos#download", as: "download_video"
  end

  scope "/console" do
    get "/", to: "console#index", as: "console"
    get "/management", to: "console#management", as: "management"

    get "/channels", to: "channels#index", as: "channels"
    get "/channels/new", to: "channels#new", as: "new_channel"
    post "/channels", to: "channels#create", as: "create_channel"
    get "/channels/:id", to: "channels#show", as: "channel"
    delete "/channels/:id", to: "channels#destroy", as: "destroy_channel"
    get "/channels/:id/edit", to: "channels#edit", as: "edit_channel"
    patch "/channels/:id", to: "channels#update", as: "update_channel"

    get "/events", to: "events#index", as: "channels_events"
    get "/channels/:channel_id/events", to: "events#channel_index", as: "channel_events"
    get "/channels/:channel_id/events/new", to: "events#new", as: "new_channel_event"
    post "/channels/:channel_id/events", to: "events#create", as: "create_channel_event"
    get "/channels/:channel_id/events/generate", to: "events#generate", as: "generate_channel_events"
    post "/channels/:channel_id/events/generate", to: "events#generate_events", as: "generate_channel_events_post"
    delete "/channels/:channel_id/events/:id", to: "events#destroy", as: "destroy_channel_event"
    get "/channels/:channel_id/events/:id", to: "events#show", as: "channel_event"
    get "/channels/:channel_id/events/:id/edit", to: "events#edit", as: "edit_channel_event"
    patch "/channels/:channel_id/events/:id", to: "events#update", as: "update_channel_event"

    get "/schedules", to: "schedules#index", as: "schedules"
    get "/channels/:channel_id/schedules", to: "schedules#channel_index", as: "channel_schedules"
    get "/channels/:channel_id/schedules/:date", to: "schedules#channel_index_by_date", as: "channel_schedules_by_date"
    get "/channels/:channel_id/schedules/:date/new", to: "schedules#new", as: "new_channel_schedule"
    post "/channels/:channel_id/schedules/:date", to: "schedules#create", as: "create_channel_schedule"
    delete "/channels/:channel_id/schedules/:date/:id", to: "schedules#destroy", as: "destroy_channel_schedule"
    get "/channels/:channel_id/schedules/:date/:id", to: "schedules#show", as: "channel_schedule"
    get "/channels/:channel_id/schedules/:date/:id/edit", to: "schedules#edit", as: "edit_channel_schedule"
    patch "/channels/:channel_id/schedules/:date/:id", to: "schedules#update", as: "update_channel_schedule"

    get "/videos", to: "videos#index", as: "videos"
    get "/videos/new", to: "videos#new", as: "new_video"
    post "/videos", to: "videos#create", as: "create_video"
    get "/videos/:id", to: "videos#show", as: "video"
    delete "/videos/:id", to: "videos#destroy", as: "destroy_video"
    get "/videos/:id/edit", to: "videos#edit", as: "edit_video"
    patch "/videos/:id", to: "videos#update", as: "update_video"
    get "/videos/:id/play", to: "videos#play", as: "play_video"

    get "/servers", to: "servers#index", as: "servers"
    get "/servers/:id", to: "servers#show", as: "server"
    delete "/servers/:id", to: "servers#destroy", as: "destroy_server"
    get "/servers/:id/edit", to: "servers#edit", as: "edit_server"
    patch "/servers/:id", to: "servers#update", as: "update_server"
    get "/servers/:id/commands", to: "servers#commands", as: "server_commands"
    
    get "/commands", to: "commands#index", as: "commands"
    get "/commands/new", to: "commands#new", as: "new_command"
    post "/commands", to: "commands#create", as: "create_command"
    get "/commands/:id", to: "commands#show", as: "command"
    delete "/commands/:id", to: "commands#destroy", as: "destroy_command"

    get "/licences", to: "licences#index", as: "licences"
    get "/licences/:id", to: "licences#show", as: "licence"
    get "/licences/:id/edit", to: "licences#edit", as: "edit_licence"
    delete "/licences/:id", to: "licences#destroy", as: "destroy_licence"
    patch "/licences/:id", to: "licences#update", as: "update_licence"
    post "/licences/generate", to: "licences#generate", as: "generate_licence"
  end

  # Добавление маршрутов для авторизации
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
