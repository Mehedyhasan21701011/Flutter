import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/accountpage_controller.dart';

class AccountpageView extends StatelessWidget {
  const AccountpageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountPageController accountController = Get.put(
      AccountPageController(),
    );
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Obx(
                          () => CircleAvatar(
                            radius: isPortrait ? 30 : 25,
                            backgroundColor: Colors.blue,
                            backgroundImage:
                                accountController.photoUrl.value.isNotEmpty
                                ? NetworkImage(accountController.photoUrl.value)
                                : null,
                            child: accountController.photoUrl.value.isEmpty
                                ? Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: isPortrait ? 30 : 25,
                                  )
                                : null,
                          ),
                        ),
                        Obx(
                          () => accountController.isUploading.value
                              ? Positioned.fill(
                                  child: Container(
                                    color: Colors.black26,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () =>
                                        accountController.pickAndUploadImage(),
                                    child: CircleAvatar(
                                      radius: isPortrait ? 12 : 10,
                                      backgroundColor: Colors.blue,
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: isPortrait ? 14 : 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              accountController.userName.value,
                              style: TextStyle(
                                fontSize: isPortrait ? 20 : 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Obx(
                            () => Text(
                              accountController.userEmail.value,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: isPortrait ? 14 : 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Stats Section
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Total Savings',
                        accountController.totalSavings.value,
                        Icons.savings,
                        Colors.green,
                        isPortrait,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildStatCard(
                        'Total Parkings',
                        accountController.totalParkings.value,
                        Icons.local_parking,
                        Colors.blue,
                        isPortrait,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Menu Items
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMenuItem('Payment Methods', Icons.payment, isPortrait),
                  _buildMenuItem('Parking History', Icons.history, isPortrait),
                  _buildMenuItem('Settings', Icons.settings, isPortrait),
                  _buildMenuItem('Help & Support', Icons.help, isPortrait),
                  _buildMenuItem('About', Icons.info, isPortrait),
                  _buildMenuItem(
                    'Logout',
                    Icons.logout,
                    isPortrait,
                    isLogout: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    bool isPortrait,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: isPortrait ? 30 : 25),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: isPortrait ? 20 : 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: isPortrait ? 12 : 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    IconData icon,
    bool isPortrait, {
    bool isLogout = false,
  }) {
    final accountController = Get.find<AccountPageController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout ? Colors.red : Colors.grey[600],
          size: isPortrait ? 24 : 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: isPortrait ? 16 : 14,
            color: isLogout ? Colors.red : Colors.black87,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: isPortrait ? 16 : 14,
          color: Colors.grey[400],
        ),
        onTap: () {
          if (isLogout) {
            Get.defaultDialog(
              title: 'Logout',
              middleText: 'Are you sure you want to logout?',
              textCancel: 'Cancel',
              textConfirm: 'Logout',
              confirmTextColor: Colors.white,
              onConfirm: () {
                Get.back();
                accountController.logOut();
                Get.snackbar(
                  'Logged Out',
                  'You have been logged out successfully',
                  backgroundColor: Colors.orange,
                  colorText: Colors.white,
                );
              },
            );
          } else {
            Get.snackbar(
              title,
              'Coming soon!',
              backgroundColor: Colors.blue,
              colorText: Colors.white,
            );
          }
        },
      ),
    );
  }
}
