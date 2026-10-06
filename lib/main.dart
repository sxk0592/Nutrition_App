import 'package:flutter/material.dart';

void main() {
  runApp(const NutriScanApp());
}

class NutriScanApp extends StatelessWidget {
  const NutriScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriScan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8F7),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    ScanPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: pages[selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// HOME PAGE
// --------------------------------------------------

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          const Text(
            'Good afternoon 👋',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'Your Nutrition',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          // CALORIE CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF2E7D32),
                  Color(0xFF66BB6A),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 8),

                const Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '1,240',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 6),
                    Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text(
                        '/ 2,000 kcal',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const LinearProgressIndicator(
                    value: 0.62,
                    minHeight: 10,
                    backgroundColor: Colors.white24,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  '760 calories remaining',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Macronutrients',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const Row(
            children: [
              Expanded(
                child: MacroCard(
                  title: 'Protein',
                  amount: '72g',
                  icon: Icons.fitness_center,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: MacroCard(
                  title: 'Carbs',
                  amount: '145g',
                  icon: Icons.bakery_dining,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: MacroCard(
                  title: 'Fat',
                  amount: '48g',
                  icon: Icons.water_drop_outlined,
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            height: 58,
            child: FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ScannerChoicePage(),
                  ),
                );
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text(
                'Scan Food',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            'Today\'s Food',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const FoodItem(
            name: 'Greek Yogurt',
            description: '1 serving',
            calories: '120 kcal',
            icon: Icons.breakfast_dining,
          ),

          const FoodItem(
            name: 'Chicken & Rice',
            description: 'Lunch',
            calories: '520 kcal',
            icon: Icons.lunch_dining,
          ),

          const FoodItem(
            name: 'Protein Bar',
            description: '1 bar',
            calories: '210 kcal',
            icon: Icons.cookie_outlined,
          ),
        ],
      ),
    );
  }
}

class MacroCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;

  const MacroCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.green,
          ),
          const SizedBox(height: 10),
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// SCAN PAGE
// --------------------------------------------------

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScannerChoicePage(
      showBackButton: false,
    );
  }
}

class ScannerChoicePage extends StatelessWidget {
  final bool showBackButton;

  const ScannerChoicePage({
    super.key,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showBackButton
          ? AppBar(
              title: const Text('Scan Food'),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!showBackButton) ...[
              const SizedBox(height: 12),
              const Text(
                'Scan Food',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],

            const SizedBox(height: 10),

            const Text(
              'Choose how you would like to identify your food.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            ScanOptionCard(
              icon: Icons.qr_code_scanner,
              title: 'Scan Barcode',
              description:
                  'Scan packaged food to find nutrition information.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BarcodePlaceholderPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            ScanOptionCard(
              icon: Icons.camera_alt_outlined,
              title: 'AI Food Scanner',
              description:
                  'Take a picture and let AI identify the food.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AIPlaceholderPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            ScanOptionCard(
              icon: Icons.edit_note,
              title: 'Enter Manually',
              description:
                  'Search or manually enter food nutrition information.',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class ScanOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const ScanOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: Colors.green.shade700,
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------------------------------
// FAKE BARCODE SCREEN
// --------------------------------------------------

class BarcodePlaceholderPage extends StatelessWidget {
  const BarcodePlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Barcode Scanner'),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                    size: 150,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Place barcode inside the frame',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FoodResultPage(),
                    ),
                  );
                },
                child: const Text(
                  'Simulate Successful Scan',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// AI CAMERA PLACEHOLDER
// --------------------------------------------------

class AIPlaceholderPage extends StatelessWidget {
  const AIPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Food Recognition'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Camera Preview',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FoodResultPage(
                        foodName: 'Grilled Chicken & Rice',
                        calories: '540',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.auto_awesome),
                label: const Text(
                  'Analyze Food with AI',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------
// RESULT PAGE
// --------------------------------------------------

class FoodResultPage extends StatelessWidget {
  final String foodName;
  final String calories;

  const FoodResultPage({
    super.key,
    this.foodName = 'Greek Yogurt',
    this.calories = '120',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Result'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                Icons.restaurant,
                color: Colors.green.shade600,
                size: 90,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              foodName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Estimated serving: 1 serving',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    '$calories kcal',
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Divider(),

                  const SizedBox(height: 15),

                  const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                    children: [
                      NutritionValue(
                        title: 'Protein',
                        value: '18g',
                      ),
                      NutritionValue(
                        title: 'Carbs',
                        value: '14g',
                      ),
                      NutritionValue(
                        title: 'Fat',
                        value: '4g',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Nutrition information may be estimated. Verify serving size for better accuracy.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '$foodName added to today\'s food.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  'Add to Today',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NutritionValue extends StatelessWidget {
  final String title;
  final String value;

  const NutritionValue({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

// --------------------------------------------------
// HISTORY
// --------------------------------------------------

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),

          Text(
            'Food History',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 6),

          Text(
            'Sunday, September 27',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          SizedBox(height: 25),

          FoodItem(
            name: 'Greek Yogurt',
            description: 'Breakfast • 8:20 AM',
            calories: '120 kcal',
            icon: Icons.breakfast_dining,
          ),

          FoodItem(
            name: 'Chicken & Rice',
            description: 'Lunch • 12:45 PM',
            calories: '520 kcal',
            icon: Icons.lunch_dining,
          ),

          FoodItem(
            name: 'Protein Bar',
            description: 'Snack • 3:10 PM',
            calories: '210 kcal',
            icon: Icons.cookie_outlined,
          ),
        ],
      ),
    );
  }
}

class FoodItem extends StatelessWidget {
  final String name;
  final String description;
  final String calories;
  final IconData icon;

  const FoodItem({
    super.key,
    required this.name,
    required this.description,
    required this.calories,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: Colors.green,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Text(
            calories,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// PROFILE
// --------------------------------------------------

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),

          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green.shade100,
              child: Icon(
                Icons.person,
                size: 55,
                color: Colors.green.shade700,
              ),
            ),
          ),

          const SizedBox(height: 35),

          const ListTile(
            leading: Icon(Icons.flag_outlined),
            title: Text('Daily Calorie Goal'),
            trailing: Text('2,000 kcal'),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.monitor_weight_outlined),
            title: Text('Weight'),
            trailing: Text('Set weight'),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Settings'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
