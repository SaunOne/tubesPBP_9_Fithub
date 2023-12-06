// FutureBuilder<List<Trainer>>(
//         future: TrainerClient().showAllTrainers(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator(); // Tampilkan indikator loading jika masih menunggu data
//           } else if (snapshot.hasError) {
//             print(snapshot);
//             return Text('Error: ${snapshot.error}');
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Text('Tidak ada data.');
//           } else {
//             List<Trainer> trainerList = snapshot.data!;
//             return ListView.builder(
//               itemCount: trainerList.length,
              
//               itemBuilder: (context, index) {
//                 Trainer trainer = trainerList[index];
//                 return ;
//               },
//             );
//           }
//         },
//       ),