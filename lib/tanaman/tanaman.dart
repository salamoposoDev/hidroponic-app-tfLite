import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidroponik_app2/data/plant_data.dart';
import 'package:hidroponik_app2/tanaman/widgets/plant_card.dart';

class PlantTab extends StatelessWidget {
  const PlantTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 70.h,
        title: Text(
          'Tanaman',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.h,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search plant',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 14),
              // All Feature section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Feature',
                    style: TextStyle(
                      fontSize: 20.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(color: Colors.green, fontSize: 16.h),
                    ),
                  ),
                ],
              ),
              GridView.builder(
                itemCount: plantData.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 20.h,
                  mainAxisExtent: 200.h,
                ),
                itemBuilder: (context, index) {
                  return PlantCard(
                    onTap: () {
                      showDetail(
                        context,
                        plantData[index]['name'].toString(),
                        plantData[index]['desc'].toString(),
                      );
                    },
                    name: plantData[index]['name'].toString(),
                    description: plantData[index]['desc'].toString(),
                    imageUrl: plantData[index]['image'].toString(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showDetail(BuildContext context, String name, String desc) {
    return showModalBottomSheet(
      context: context,
      builder: (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 20.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                Text(desc, textAlign: TextAlign.justify),
              ],
            ),
          ),
        );
      },
    );
  }

  //   void _showAddPlantModal(BuildContext context) {
  //     showModalBottomSheet(
  //       context: context,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
  //       ),
  //       builder: (BuildContext context) {
  //         return Padding(
  //           padding: const EdgeInsets.all(18.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Center(
  //                 child: Text(
  //                   'Tambah Tanaman',
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               SizedBox(height: 24),
  //               Text('Jenis tanaman', style: TextStyle(fontSize: 14)),
  //               SizedBox(height: 8),
  //               DropdownButtonFormField<String>(
  //                 items: [
  //                   DropdownMenuItem(child: Text('Pakcoy'), value: 'Pakcoy'),
  //                   DropdownMenuItem(child: Text('Selada'), value: 'Selada'),
  //                   DropdownMenuItem(child: Text('Bayam'), value: 'Bayam'),
  //                   DropdownMenuItem(child: Text('Kangkung'), value: 'Kangkung'),
  //                 ],
  //                 onChanged: (value) {},
  //                 decoration: InputDecoration(
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 16),
  //               Text('Usia tanaman', style: TextStyle(fontSize: 14)),
  //               SizedBox(height: 8),
  //               DropdownButtonFormField<String>(
  //                 items: [
  //                   DropdownMenuItem(
  //                     child: Text('Pembibitan'),
  //                     value: 'Pembibitan',
  //                   ),
  //                   DropdownMenuItem(child: Text('Muda'), value: 'Muda'),
  //                   DropdownMenuItem(child: Text('Dewasa'), value: 'Dewasa'),
  //                 ],
  //                 onChanged: (value) {},
  //                 decoration: InputDecoration(
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 20),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor:
  //                           Colors.green, // Mengubah warna tombol menjadi hijau
  //                     ),
  //                     child: Text('Simpan'),
  //                   ),
  //                   OutlinedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.red,
  //                     ), // Mengubah warna tombol menjadi hijau
  //                     child: Text(
  //                       'Cancel',
  //                       style: TextStyle(color: Colors.white),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     );
  //   }
}
