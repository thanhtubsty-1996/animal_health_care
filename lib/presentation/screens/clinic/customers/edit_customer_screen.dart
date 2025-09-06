import 'package:flutter/material.dart';

class EditCustomerScreen extends StatelessWidget {
  final String? customerId;

  const EditCustomerScreen({super.key, this.customerId});

  @override
  Widget build(BuildContext context) {
    final isEditing = customerId != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Chỉnh sửa Khách hàng' : 'Thêm Khách hàng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Tên khách hàng'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Số điện thoại'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Địa chỉ'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement save logic
              },
              child: const Text('Lưu'),
            )
          ],
        ),
      ),
    );
  }
}
