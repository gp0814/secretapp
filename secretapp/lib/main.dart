import 'package:flutter/material.dart';

void main() {
  runApp(SecretApp());
}

class SecretApp extends StatelessWidget {
  const SecretApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Secret App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.blueAccent),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Navigate to the home page after the splash screen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SecretHomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 182, 193), // Light pink
                Color.fromARGB(255, 255, 240, 245), // Lavender blush
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Animated heart
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: const Icon(
                      Icons.favorite,
                      size: 150,
                      color: Colors.red,
                    ),
                  );
                },
              ),
              // Smaller floating hearts
              const Positioned(
                top: 100,
                left: 50,
                child: Icon(Icons.favorite, size: 50, color: Colors.pinkAccent),
              ),
              const Positioned(
                bottom: 150,
                right: 50,
                child: Icon(Icons.favorite, size: 70, color: Colors.deepOrange),
              ),
              const Positioned(
                top: 200,
                right: 80,
                child: Icon(Icons.favorite, size: 40, color: Colors.redAccent),
              ),
              const Positioned(
                bottom: 80,
                left: 80,
                child: Icon(Icons.favorite, size: 60, color: Colors.pink),
              ),
              // Circular progress indicator
              const Positioned(
                bottom: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecretHomePage extends StatefulWidget {
  const SecretHomePage({super.key});

  @override
  _SecretHomePageState createState() => _SecretHomePageState();
}

class _SecretHomePageState extends State<SecretHomePage> {
  int _step = 0;
  int _noClicks = 0;
  DateTime? _selectedDate;

  void _nextStep() {
    setState(() {
      _step++;
    });
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _nextStep();
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("It's a Date!"),
          content:
              const Text("Looking forward to our lovely coffee time together ☕❤️"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Can't wait!"),
            ),
          ],
        ),
      );
    }
  }

  void _handleNoClick(BuildContext context) {
    if (_noClicks < 3) {
      final messages = [
        "Are you sure? 💔",
        "Come on, don't say no! 😢",
        "You're breaking my heart! 😭",
        "I'm gonna cry! 😭"
      ];
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Please reconsider!"),
          content: Text(messages[_noClicks]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Okay"),
            ),
          ],
        ),
      );
      setState(() {
        _noClicks++;
      });
    } else {
      setState(() {
        _noClicks++;
      });
    }
  }

  void _showLovelyMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("A Lovely Message"),
        content: const Text(
            "Thank you for choosing this date! It's going to be wonderful! ❤️"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Yay!"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 173, 216, 230),
                  Color.fromARGB(255, 224, 255, 255)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 139).withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (_step) {
      case 0:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite, color: Colors.blue, size: 50),
            const SizedBox(height: 20),
            const Text(
              'Click here to know a secret',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nextStep,
              child: const Text('Next'),
            ),
          ],
        );
      case 1:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock, color: Colors.blue, size: 50),
            const SizedBox(height: 20),
            const Text(
              'Will you tell anyone?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nextStep,
              child: const Text('No I won\'t :)'),
            ),
          ],
        );
      // Remaining cases unchanged...
      case 2:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite_border, color: Colors.blue, size: 50),
            const SizedBox(height: 20),
            const Text(
              'Promise?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nextStep,
              child: const Text('Promise!'),
            ),
          ],
        );
      case 3:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite, color: Colors.blue, size: 50),
            const SizedBox(height: 20),
            const Text(
              'Okay, I trust you',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nextStep,
              child: const Text('Click here to unlock secret'),
            ),
          ],
        );
      case 4:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.coffee, color: Colors.blue, size: 50),
            const SizedBox(height: 20),
            const Text(
              'I know the perfect spot for coffee ☕ Wanna join?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _nextStep,
                  child: const Text('Yes, of course!'),
                ),
                const SizedBox(width: 10),
                if (_noClicks < 3)
                  ElevatedButton(
                    onPressed: () => _handleNoClick(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text('No'),
                  ),
              ],
            ),
          ],
        );
      case 5:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today, color: Colors.blue, size: 50),
            const SizedBox(height: 20),
            const Text(
              'Select Date ☕',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Pick a date'),
            ),
          ],
        );
      case 6:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cake, color: Colors.blue, size: 50),
            const SizedBox(height: 20),
            const Text(
              'It\'s a Date!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (_selectedDate != null)
              ElevatedButton(
                onPressed: () => _showLovelyMessage(context),
                child: Text('❤️❤️❤️ ${_selectedDate!.toLocal()}'.split(' ')[0]),
              )
            else
              const Text(
                'No date selected',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
          ],
        );
      default:
        return const Text(
          'Unexpected step',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        );
    }
  }
}
