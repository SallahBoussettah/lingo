# 🌍 Lingo - Interactive Language Learning Platform

A modern, interactive language learning application built with Next.js, featuring gamified lessons, progress tracking, and subscription management.

## ✨ Features

- 🎯 **Interactive Lessons** - Engaging language exercises with multiple choice and assist modes
- 🏆 **Gamification** - Hearts system, points, and progress tracking
- 📚 **Structured Learning** - Organized courses, units, and lessons
- 💳 **Subscription Management** - Stripe integration for premium features
- 🔐 **Authentication** - Secure user management with Clerk
- 🎨 **Modern UI** - Beautiful, responsive design with dark/light mode
- 📱 **Mobile Friendly** - Optimized for all devices
- 🚀 **Performance** - Built with Next.js 14 and optimized for speed

## 🛠️ Tech Stack

- **Frontend**: Next.js 14, React 18, TypeScript
- **Styling**: Tailwind CSS, Framer Motion
- **Database**: PostgreSQL with Drizzle ORM
- **Authentication**: Clerk
- **Payments**: Stripe
- **UI Components**: Radix UI, Lucide Icons
- **State Management**: Zustand
- **Deployment**: Oracle Cloud, PM2, Nginx

## 🚀 Quick Start

### Prerequisites

- Node.js 18+ 
- PostgreSQL database
- Clerk account
- Stripe account (for payments)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/SalahBoussetah/lingo.git
   cd lingo
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Environment Setup**
   ```bash
   cp .env.example .env
   ```   
   Up
date `.env` with your credentials:
   ```env
   # Clerk Authentication
   NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY="your_clerk_publishable_key"
   CLERK_SECRET_KEY="your_clerk_secret_key"
   
   # Database
   DATABASE_URL="postgresql://username:password@localhost:5432/lingo"
   
   # Stripe
   STRIPE_API_KEY="your_stripe_secret_key"
   STRIPE_WEBHOOK_SECRET="your_stripe_webhook_secret"
   
   # App URL
   NEXT_PUBLIC_APP_URL="http://localhost:3000"
   ```

4. **Database Setup**
   ```bash
   # Push database schema
   npm run db:push
   
   # Seed with sample data
   npm run db:seed
   ```

5. **Start Development Server**
   ```bash
   npm run dev
   ```

   Open [http://localhost:3000](http://localhost:3000) in your browser.

## 📁 Project Structure

```
lingo/
├── app/                    # Next.js app directory
├── components/            # Reusable UI components
│   ├── landing/          # Landing page components
│   ├── motion/           # Animation components
│   └── ui/               # Base UI components
├── config/               # Configuration files
├── db/                   # Database schema and utilities
├── lib/                  # Utility functions
├── public/               # Static assets
├── scripts/              # Database scripts
├── store/                # State management
├── types/                # TypeScript type definitions
├── drizzle.config.ts     # Drizzle ORM configuration
└── middleware.ts         # Next.js middleware
```

## 🗄️ Database Schema

The application uses PostgreSQL with the following main entities:

- **Courses** - Language courses (Spanish, French, etc.)
- **Units** - Course sections (Unit 1, Unit 2, etc.)
- **Lessons** - Individual lessons within units
- **Challenges** - Questions/exercises within lessons
- **Challenge Options** - Multiple choice answers
- **User Progress** - User learning progress and stats
- **User Subscription** - Stripe subscription management

## 🎮 Available Scripts

```bash
# Development
npm run dev              # Start development server
npm run build           # Build for production
npm run start           # Start production server
npm run lint            # Run ESLint

# Database
npm run db:studio       # Open Drizzle Studio
npm run db:push         # Push schema to database
npm run db:seed         # Seed database with sample data
npm run db:prod         # Add production data
npm run db:reset        # Reset database
```

## 🚀 Production Deployment

For detailed production deployment instructions, see [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md).

### Quick Production Setup

1. **Server Requirements**
   - Ubuntu/CentOS VPS
   - Node.js 18+
   - PostgreSQL
   - PM2 process manager

2. **Deploy**
   ```bash
   # Clone and setup
   git clone https://github.com/SalahBoussetah/lingo.git
   cd lingo
   npm install
   
   # Configure environment
   cp .env.production .env
   # Edit .env with your production values
   
   # Database setup
   npm run db:push
   npm run db:seed
   
   # Build and start
   npm run build
   pm2 start ecosystem.config.js
   ```

## 🔧 Configuration

### Clerk Authentication

1. Create a Clerk application at [clerk.com](https://clerk.com)
2. Get your publishable and secret keys
3. Configure allowed redirect URLs

### Stripe Integration

1. Create a Stripe account at [stripe.com](https://stripe.com)
2. Get your API keys (test/live)
3. Set up webhook endpoints
4. Configure subscription products

### Database

The app supports PostgreSQL. For production, we recommend:
- Oracle Cloud Database
- Neon PostgreSQL
- Supabase
- AWS RDS

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Salah Boussetah**
- GitHub: [@SalahBoussetah](https://github.com/SalahBoussetah)
- Twitter: [@SalahBoussetah](https://twitter.com/SalahBoussetah)

## 🙏 Acknowledgments

- Built with [Next.js](https://nextjs.org/)
- UI components from [Radix UI](https://www.radix-ui.com/)
- Icons from [Lucide](https://lucide.dev/)
- Animations with [Framer Motion](https://www.framer.com/motion/)

## 🐛 Issues & Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/SalahBoussetah/lingo/issues) page
2. Create a new issue with detailed information
3. For deployment issues, refer to [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)

---

⭐ If you found this project helpful, please give it a star on GitHub!