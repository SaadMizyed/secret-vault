import 'package:flutter/material.dart';

void main() {
  runApp(const SecretVaultApp());
}

class SecretVaultApp extends StatelessWidget {
  const SecretVaultApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'خزنة سرية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0f172a),
      ),
      home: const PinScreen(),
    );
  }
}

// ================= שاشة إدخال رمز المرور =================
class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final TextEditingController _pinController = TextEditingController();
  final String correctPin = "1234"; // رمز المرور الافتراضي للخزنة
  String errorMessage = "";

  void _verifyPin() {
    if (_pinController.text == correctPin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const VaultHomeScreen()),
      );
    } else {
      setState(() {
        errorMessage = "رمز المرور غير صحيح! حاول مرة أخرى.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 80, color: Colors.blueAccent),
                const SizedBox(height: 20),
                const Text(
                  "أدخل رمز المرور لفتح الخزنة",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _pinController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  maxLength: 4,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF1e293b),
                    hintText: "أدخل 4 أرقام",
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (errorMessage.isNotEmpty)
                  Text(errorMessage, style: const TextStyle(color: Colors.redAccent)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _verifyPin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("فتح الخزنة", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= الشاشة الرئيسية للخزنة =================
class VaultHomeScreen extends StatefulWidget {
  const VaultHomeScreen({Key? key}) : super(key: key);

  @override
  State<VaultHomeScreen> createState() => _VaultHomeScreenState();
}

class _VaultHomeScreenState extends State<VaultHomeScreen> {
  // قائمة وهمية للملفات والصور المخزنة
  final List<Map<String, String>> _vaultItems = [
    {"name": "صورة الهوية الشخصية.png", "type": "صورة"},
    {"name": "عقد الإيجار السري.pdf", "type": "ملف"},
    {"name": "كلمات المرور المهمة.txt", "type": "مستند"},
  ];

  // دالة محاكاة لإضافة ملف جديد للخزنة
  void _addItem() {
    setState(() {
      int newId = _vaultItems.length + 1;
      _vaultItems.add({"name": "ملف سري جديد_$newId.dat", "type": "ملف"});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("خزنتي السرية المحمية", style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: const Color(0xFF1e293b),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.lock, color: Colors.blueAccent),
            onPressed: () {
              // العودة لشاشة قفل الخزنة
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PinScreen()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _vaultItems.length,
          itemBuilder: (context, index) {
            final item = _vaultItems[index];
            return Card(
              color: const Color(0xFF1e293b),
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(
                  item['type'] == 'صورة' ? Icons.image : Icons.insert_drive_file,
                  color: Colors.blueAccent,
                ),
                title: Text(
                  item['name']!, 
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "النوع: ${item['type']}", 
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: const Icon(Icons.security, color: Colors.greenAccent),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
