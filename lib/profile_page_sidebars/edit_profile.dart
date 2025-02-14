// import 'package:document_management_main/apis/ikon_service.dart';
// import 'package:flutter/material.dart';
// import '../components/custom_input.dart';
//
// class EditProfile extends StatefulWidget {
//   final String? name;
//   final String? email;
//   final String? phoneNumber;
//   final String? login;
//   final ThemeMode themeMode;
//   final ColorScheme colorScheme;
//   final Function(bool isDarkMode) onThemeChanged;
//   final Function(ColorScheme colorScheme) onColorSchemeChanged;
//   final Function(String name, String email, String phoneNumber) onProfileUpdate;
//
//   const EditProfile({
//     Key? key,
//     required this.onThemeChanged,
//     required this.onColorSchemeChanged,
//     required this.colorScheme,
//     required this.themeMode,
//     this.name,
//     this.email,
//     this.login,
//     this.phoneNumber,
//     required this.onProfileUpdate
//   }) : super(key: key);
//
//   @override
//   _EditProfileState createState() => _EditProfileState();
// }
//
// class _EditProfileState extends State<EditProfile> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController loginController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the controllers with existing values
//     nameController.text = widget.name ?? '';
//     emailController.text = widget.email ?? '';
//     phoneController.text = widget.phoneNumber ?? '';
//     loginController.text = widget.login ?? '';
//   }
//
//   // void updateUserProfile(BuildContext ctx, String name, String email, String phone) async{
//   //   showDialog(
//   //     context: context,
//   //     barrierDismissible: false, // Prevents the dialog from being dismissed by tapping outside
//   //     builder: (BuildContext context) {
//   //       return Dialog(
//   //         backgroundColor: Colors.transparent,
//   //         elevation: 0,
//   //         child: Center(
//   //           child: Container(
//   //             padding: const EdgeInsets.all(20),
//   //             decoration: BoxDecoration(
//   //               color: Colors.white,
//   //               borderRadius: BorderRadius.circular(10),
//   //             ),
//   //             child:const Row(
//   //               mainAxisSize: MainAxisSize.min,
//   //               children: [
//   //                 CircularProgressIndicator(),
//   //                 SizedBox(width: 20),
//   //                 Text(
//   //                   "Updating Profile...",
//   //                   style: TextStyle(fontSize: 16),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   //   try {
//   //     await IKonService.iKonService.updateUserProfile(name: name, password: "", phone: phone, email: email, thumbnail: null);
//   //     Navigator.of(ctx).pop();
//   //     ScaffoldMessenger.of(ctx).showSnackBar(
//   //       SnackBar(content: Text('Profile updated successfully')),
//   //     );
//   //   }catch(e){
//   //     Navigator.of(context).pop();
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('An error occurred: $e')),
//   //     );
//   //   }
//   // }
//
//   void updateUserProfile(BuildContext context, String name, String email, String phone) async {
//     // Show the loading dialog
//     showDialog(
//       context: context,
//       barrierDismissible: false, // Prevents the dialog from being dismissed by tapping outside
//       builder: (BuildContext dialogContext) { // Renamed for clarity
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           child: Center(
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(width: 20),
//                   Text(
//                     "Updating Profile...",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//
//     try {
//       // Await the API call
//       await IKonService.iKonService.updateUserProfile(
//         name: name,
//         password: "", // Ensure this is handled appropriately
//         phone: phone,
//         email: email,
//         thumbnail: null,
//       );
//
//       widget.onProfileUpdate(name, email, phone);
//       // Close the dialog using the root navigator
//       Navigator.of(context, rootNavigator: true).pop();
//
//       // Show success snackbar
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Profile updated successfully')),
//       );
//
//       // Optionally, you can navigate back or refresh the UI here
//       // Navigator.pop(context); // If you need to navigate back after successful update
//
//     } catch (e) {
//       // Close the dialog using the root navigator
//       Navigator.of(context, rootNavigator: true).pop();
//
//       // Show error snackbar
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred: $e')),
//       );
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData.from(
//         colorScheme: widget.colorScheme,
//         textTheme: ThemeData.light().textTheme,
//       ).copyWith(
//         brightness: widget.themeMode == ThemeMode.dark
//             ? Brightness.dark
//             : Brightness.light,
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Edit User Profile"),
//           backgroundColor: widget.colorScheme.primary,
//           leading: GestureDetector(
//             onTap: () => Navigator.pop(context),
//             child: const Icon(Icons.arrow_back),
//           ),
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Header with background and avatar
//             Stack(
//               children: [
//                 Container(
//                   height: 180,
//                   decoration: BoxDecoration(
//                     color: widget.colorScheme.primary,
//                     borderRadius: const BorderRadius.vertical(
//                       bottom: Radius.circular(30),
//                     ),
//                   ),
//                 ),
//                 const Align(
//                   alignment: Alignment.center,
//                   child: Column(
//                     children: [
//                       SizedBox(height: 80),
//                       CircleAvatar(
//                         radius: 70,
//                         backgroundImage: AssetImage(
//                             'assets/profile_picture.png'), // Replace with actual image asset or network URL
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Software Engineer Level 1',
//                         style: TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             // Input fields section with padding
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: ListView(
//                   children: [
//                     CustomInput(
//                       labelText: "Name",
//                       isMandatory: true,
//                       hintText: "Enter your name",
//                       controller: nameController,
//                       inputType: InputType.text,
//                     ),
//                     const SizedBox(height: 16),
//                     CustomInput(
//                       labelText: "Email",
//                       isMandatory: true,
//                       hintText: "Enter your email",
//                       controller: emailController,
//                       inputType: InputType.text,
//                     ),
//                     const SizedBox(height: 16),
//                     CustomInput(
//                       labelText: "Phone Number",
//                       isMandatory: true,
//                       hintText: "Enter your phone number",
//                       controller: phoneController,
//                       inputType: InputType.number,
//                     ),
//                     const SizedBox(height: 16),
//                     CustomInput(
//                       labelText: "Login",
//                       isMandatory: true,
//                       hintText: "Enter your login ID",
//                       controller: loginController,
//                       inputType: InputType.text,
//                     ),
//                     const SizedBox(height: 32),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: widget.colorScheme.primary,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 24.0, vertical: 12.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       onPressed: () {
//                         // Save the updated profile
//                         print("Name: ${nameController.text}");
//                         print("Email: ${emailController.text}");
//                         print("Phone: ${phoneController.text}");
//                         print("Login: ${loginController.text}");
//
//                         updateUserProfile(context, nameController.text, emailController.text, phoneController.text);
//
//                         // Handle saving to the backend or state
//                         // Navigator.pop(context); // Return to Profile screen
//                       },
//                       child: const Text(
//                         "Save",
//                         style: TextStyle(fontSize: 18,color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../apis/ikon_service.dart';
import '../components/custom_input.dart';

class EditProfile extends StatefulWidget {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? login;
  final ThemeMode themeMode;
  final ColorScheme colorScheme;
  final Function(bool isDarkMode) onThemeChanged;
  final Function(ColorScheme colorScheme) onColorSchemeChanged;
  final Function(String name, String email, String phoneNumber) onProfileUpdate;

  const EditProfile({
    Key? key,
    required this.onThemeChanged,
    required this.onColorSchemeChanged,
    required this.colorScheme,
    required this.themeMode,
    this.name,
    this.email,
    this.login,
    this.phoneNumber,
    required this.onProfileUpdate
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController loginController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name ?? '';
    emailController.text = widget.email ?? '';
    phoneController.text = widget.phoneNumber ?? '';
    loginController.text = widget.login ?? '';
  }

  void updateUserProfile(BuildContext context, String name, String email, String phone) async {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return CupertinoAlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CupertinoActivityIndicator(),
              SizedBox(width: 20),
              Text(
                "Updating Profile...",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );

    try {
      await IKonService.iKonService.updateUserProfile(
        name: name,
        password: "",
        phone: phone,
        email: email,
        thumbnail: null,
      );

      widget.onProfileUpdate(name, email, phone);
      Navigator.of(context, rootNavigator: true).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: widget.colorScheme.primary,
        brightness: widget.themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light,
      ),
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle:  Text("Edit User Profile",style: TextStyle(color: widget.colorScheme.primary,fontSize: 22),),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child:  Icon(CupertinoIcons.back, color:widget.themeMode == ThemeMode.dark? Colors.white:Colors.black,size: 28, ),  // Back button is now white
            onPressed: () => Navigator.pop(context),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with background and avatar
              Stack(
                children: [
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          widget.themeMode == ThemeMode.light
                              ? CupertinoColors.white // Light mode icon color
                              : CupertinoColors.black, // Dark mode icon color
                          widget.colorScheme.primary, // Blend into primary color at the bottom
                        ],
                      ),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(30), // Keeps the rounded bottom corners
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SizedBox(height: 80),
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(
                              'assets/profile_picture.png'), // Replace with actual image asset or network URL
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Software Engineer Level 1',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),  // Added more spacing here
              // Input fields section with padding
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),  // Added more horizontal padding
                  child: ListView(
                    children: [
                      CustomInput(
                        labelText: "Name",
                        isMandatory: true,
                        hintText: "Enter your name",
                        controller: nameController,
                        inputType: InputType.text,
                      ),
                      const SizedBox(height: 24),  // Increased spacing between input fields
                      CustomInput(
                        labelText: "Email",
                        isMandatory: true,
                        hintText: "Enter your email",
                        controller: emailController,
                        inputType: InputType.text,
                      ),
                      const SizedBox(height: 24),  // Increased spacing between input fields
                      CustomInput(
                        labelText: "Phone Number",
                        isMandatory: true,
                        hintText: "Enter your phone number",
                        controller: phoneController,
                        inputType: InputType.number,
                      ),
                      const SizedBox(height: 24),  // Increased spacing between input fields
                      CustomInput(
                        labelText: "Login",
                        isMandatory: true,
                        hintText: "Enter your login ID",
                        controller: loginController,
                        inputType: InputType.text,
                      ),
                      const SizedBox(height: 32), // Increased bottom spacing
                      CupertinoButton.filled(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        onPressed: () {
                          updateUserProfile(
                            context,
                            nameController.text,
                            emailController.text,
                            phoneController.text,
                          );
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
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
