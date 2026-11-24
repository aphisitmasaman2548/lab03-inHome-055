// ไฟล์: my_participations_screen.dart
import 'package:flutter/material.dart';
import 'participation_model.dart'; // นำเข้าข้อมูลจำลอง

class MyParticipationsScreen extends StatelessWidget {
  const MyParticipationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Participations'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ส่วนที่ 1: Header Section (จะทำในขั้นที่ 3)
          _buildHeaderSection(),

          // ส่วนที่ 2: List Section (จะทำในขั้นที่ 4)
          _buildListSection(),
        ],
      ),
    );
  }

  // ขั้นที่ 3: ออกแบบส่วนหัวหน้าจอ (Header Section)
  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      color: Colors.blue.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ชื่อผู้ใช้: Aphisit Masaman', // นิสิตสามารถเปลี่ยนเป็นชื่อตัวเองได้
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'กิจกรรมที่ลงทะเบียนทั้งหมด: ${mockParticipations.length} รายการ',
            style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }

  // ขั้นที่ 4 & 5: การสร้างโครงสร้างรายการด้วย ListView.builder และการตรวจสอบเงื่อนไขสถานะ (Conditional UI)
  Widget _buildListSection() {
    // --- เริ่มขั้นที่ 4: โครงสร้าง ListView ---
    return Expanded(
      child: ListView.builder(
        itemCount: mockParticipations.length,
        itemBuilder: (context, index) {
          final item = mockParticipations[index];

          // --- เริ่มขั้นที่ 5: ตรวจสอบสถานะเพื่อกำหนดสีและไอคอน ---
          Color iconColor = Colors.grey;
          IconData statusIcon = Icons.help;
          Color textColor = Colors.black;

          if (item.status == 'Approved') {
            iconColor = Colors.green;
            statusIcon = Icons.check_circle;
          } else if (item.status == 'Pending') {
            iconColor = Colors.orange;
            statusIcon = Icons.access_time_filled;
          } else if (item.status == 'Rejected') {
            iconColor = Colors.red;
            statusIcon = Icons.cancel;
            textColor = Colors.grey; // ถ้าถูกปฏิเสธให้ตัวอักษรเป็นสีเทา
          }

          // นำข้อมูลและสีที่ได้มาสร้างเป็น Card และ ListTile
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Icon(statusIcon, color: iconColor, size: 40),
              title: Text(
                item.activityName,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'วันที่เข้าร่วม: ${item.participantDate}\nสถานะ: ${item.status}',
              ),
              isThreeLine: true,
              onTap: () {
                // แสดงป๊อปอัป SnackBar เมื่อกดที่รายการ
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${item.activityName}\nรายละเอียด: ${item.description}',
                    ),
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
