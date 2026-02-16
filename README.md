# Broadcast Console

A web-based broadcast playout management console built with Ruby on Rails. This application provides comprehensive tools for managing broadcast channels, scheduling video content, monitoring playout servers, and controlling broadcast operations.

## Features

- **Channel Management** - Create and manage broadcast channels
- **Video Library** - Upload and organize video content
- **Schedule Management** - Plan and schedule video playout
- **Server Monitoring** - Monitor and control playout servers
- **Event Management** - Track and manage broadcast events
- **User Management** - Multi-user support with authentication
- **Command Control** - Execute and monitor broadcast commands
- **License Management** - Track and manage broadcast licenses
- **Background Processing** - Asynchronous job processing with Sidekiq
- **FFmpeg Integration** - Video processing capabilities

## Technology Stack

- **Ruby** 3.2.3
- **Rails** 7.1.4+
- **Database** PostgreSQL (production), SQLite3 (development)
- **Background Jobs** Sidekiq with Redis
- **Frontend** Turbo, Stimulus, Importmap
- **Video Processing** FFmpeg
- **Web Server** Puma
- **Reverse Proxy** Caddy

## Prerequisites

- Ruby 3.2.3
- PostgreSQL 13+ (for production)
- Redis (for Sidekiq background jobs)
- FFmpeg (for video processing)
- Docker and Docker Compose (for containerized deployment)

## Installation

### Local Development

1. Clone the repository:
```bash
git clone https://github.com/stukenov/broadcast-console.git
cd broadcast-console
```

2. Install dependencies:
```bash
bundle install
```

3. Set up environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

4. Create and migrate the database:
```bash
rails db:create
rails db:migrate
```

5. Start the development server:
```bash
rails server
```

The application will be available at `http://localhost:3000`

### Docker Deployment

1. Clone the repository:
```bash
git clone https://github.com/stukenov/broadcast-console.git
cd broadcast-console
```

2. Configure environment variables in `docker-compose.yml`

3. Build and start the containers:
```bash
docker-compose up -d
```

The application will be available through Caddy reverse proxy on port 80/443.

## Configuration

### Environment Variables

Copy `.env.example` to `.env` and configure:

- `RAILS_ENV` - Rails environment (development/production)
- `DATABASE_URL` - Database connection string
- `REDIS_URL` - Redis connection string
- `SECRET_KEY_BASE` - Rails secret key (generate with `rails secret`)

### Database Setup

For production with PostgreSQL:
```bash
RAILS_ENV=production rails db:create db:migrate
```

For development with SQLite:
```bash
rails db:migrate
```

## Background Jobs

The application uses Sidekiq for background job processing. Make sure Redis is running, then start Sidekiq:

```bash
bundle exec sidekiq
```

Sidekiq Scheduler is configured for periodic tasks like scheduled video playback.

## Docker Services

The `docker-compose.yml` includes:

- **rails** - Rails application server
- **db** - PostgreSQL database
- **redis** - Redis for Sidekiq (add if needed)
- **ffmpeg** - FFmpeg service for video processing
- **ffprobe** - FFprobe service for video analysis
- **caddy** - Reverse proxy and web server

## Testing

Run the test suite:

```bash
# RSpec tests
bundle exec rspec

# Minitest
rails test
```

## Project Structure

```
broadcast-console/
├── app/              # Application code (controllers, models, views, jobs)
├── config/           # Configuration files
├── db/               # Database migrations and schema
├── test/             # Test files
├── spec/             # RSpec test files
├── public/           # Static files
├── storage/          # Active Storage files
├── log/              # Application logs
├── tmp/              # Temporary files
├── Dockerfile        # Docker configuration
├── docker-compose.yml # Docker Compose configuration
└── Caddyfile         # Caddy reverse proxy configuration
```

## API Controllers

Based on the test structure, the application includes:

- `ChannelsController` - Broadcast channel management
- `VideosController` - Video content management
- `SchedulesController` - Playout scheduling
- `ServersController` - Server monitoring and control
- `EventsController` - Event management
- `CommandsController` - Broadcast command execution
- `LicencesController` - License management
- `UsersController` - User management
- `ConsoleController` - Main console interface
- `AdaptoController` - Integration adapter

## Development

To contribute to this project:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For issues, questions, or contributions, please open an issue on GitHub.

## Author

Developed by [@stukenov](https://github.com/stukenov)
