import 'package:flutter/material.dart';
import 'package:shopzonee/routes/routes.dart';
import 'package:shopzonee/view/newpasspage.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
  
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _checkVerificationCode() {
    
    if (_controllers.every((controller) => controller.text.isNotEmpty)) {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CreateNewPasswordPage(), 
        ),
      );
    } else {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all the fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           
              Text(
                'Verification code',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
             
              Text(
                'Please enter the verification code we sent to your email address',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 30),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: TextField(
                        controller: _controllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                        ),
                        onChanged: (value) {
                        
                          if (value.isNotEmpty && index < 3) {
                            FocusScope.of(context).nextFocus();
                          }
                         
                        },
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 30),
             
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 10) 
                      ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.newpassword);
                  },
                  child: Text(
                    'Verify',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
