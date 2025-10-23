import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seed/core/constants/app_strings.dart';
import 'package:seed/core/widgets/staggered_list_animation.dart';
import 'package:seed/presentation/home/widgets/home_section_title.dart';
import 'package:seed/presentation/home/widgets/recommending_card.dart';

class RecommendingCardsSection extends StatelessWidget {
  const RecommendingCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RecommendingCard> recommendingCards = [
      RecommendingCard(
        title: 'Jobs',
        company: 'Company',
        salary: '3-6 months/\$1,500',
        description:
            'We are a growing startup building a fitness & nutrition mobile app that provides personalized workout plans and nutrition guidance. We are looking for a React Native app, and we need a skilled backend developer to build and implement the server-side systems that power it.',
        icon: Icons.business,
        requirements: [
          'Strong experience with Node.js (Express/NestJS) or Python (Django/FastAPI).',
          'Proficiency with PostgreSQL and writing optimized SQL queries.',
          'Proficiency with PostgreSQL and writing optimized SQL queries.',
          'Familiarity with Redis for caching.',
          'Experience with JWT authentication and API security best practices.',
          'Hands-on with Docker and cloud platforms (AWS/GCP).',
          'Good communication skills and ability to work in a distributed team.',
        ],
      ),
      RecommendingCard(
        title: 'Learning',
        company: 'Online Course',
        salary: 'Backend Development',
        description:
            'This course is designed for students, self-learners, professionals, and anyone who want to master backend development and build scalable backend systems. You will learn about database design, code, and deploy scalable backend systems.',
        icon: Icons.school,
        requirements: [
          'Backend Fundamentals: HTTP, REST APIs, authentication & authorization.',
          'Database Design: Relational and NoSQL databases.',
          'API Development: Node.js, Express, NestJS, Python, Django, FastAPI.',
          'Security: JWT, OAuth, rate limiting, API security best practices.',
          'Deployment: Docker, Kubernetes, AWS, GCP, and more.',
          'Scalability: Load balancing, caching, and database optimization.',
          'Testing: Unit testing, integration testing, and end-to-end testing.',
        ],
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        StaggeredListAnimation(
          index: 0,
          child: HomeSectionTitle(
            title: AppStrings.recommending,
            subtitle: AppStrings.cards,
          ),
        ),
        ...recommendingCards.asMap().entries.map((entry) {
          return StaggeredListAnimation(
            index: entry.key + 1,
            child: entry.value,
          );
        }),
      ],
    );
  }
}
