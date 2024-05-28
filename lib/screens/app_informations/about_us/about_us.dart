import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Us',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome to Journey!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Journey is your ultimate travel companion, designed to make your trips more enjoyable, organized, and stress-free. Whether you are planning a solo adventure, a family vacation, or a business trip, our app has everything you need to create unforgettable travel experiences.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'At Journey, our mission is to simplify travel planning and enhance your journey from start to finish. We believe that travel should be accessible, enjoyable, and hassle-free for everyone. Our app provides comprehensive tools and resources to help you plan, organize, and manage your trips with ease.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Features',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- Easy trip planning and itinerary management\n'
                '- Real-time travel updates and notifications\n'
                '- Personalized recommendations and travel tips\n'
                '- Secure and seamless booking for flights, hotels, and activities\n'
                '- Offline access to your travel details',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Our Team',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We are a team of passionate travelers and tech enthusiasts dedicated to creating the best travel app for you. Our diverse backgrounds and shared love for exploration inspire us to continuously improve our app and provide you with the best travel experience possible.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Have questions or feedback? We would love to hear from you! Contact us at [Your Contact Email] or follow us on [Your Social Media Links].',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 32),
              Center(
                child: Text(
                  'Thank you for choosing Journey. Happy travels!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
