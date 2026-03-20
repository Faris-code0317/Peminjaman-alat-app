import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';
import 'package:peminjaman_alat_app/core/utils/dateFormatter_helper.dart';
import 'package:peminjaman_alat_app/core/utils/helpers.dart';

import 'package:peminjaman_alat_app/features/status/controller/status_controller.dart';
import 'package:peminjaman_alat_app/features/status/model/statusAlat_model.dart';
import 'package:peminjaman_alat_app/features/status/model/statusDetail_model.dart';
import 'package:peminjaman_alat_app/features/status/model/status_model.dart';

import 'package:peminjaman_alat_app/features/status/widget/ajukanPengembalian_button.dart';

class StatusListWidget extends StatelessWidget {
  StatusListWidget({super.key});

  // final StatusController controller = Get.find();
  final controller = Get.find<StatusController>();

  Color getStatusColor(String status) {
    switch (status) {
      case "menunggu":
        return AppColors.warning;
      case "dipinjam":
        return AppColors.success;
      case "pengembalian":
        return AppColors.link;
      case "dikembalikan":
        return AppColors.green1;
      case "ditolak":
        return AppColors.error;
      default:
        return AppColors.grey1;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "menunggu":
        return Icons.access_time;
      case "dipinjam":
        return Icons.check_circle_outline;
      case "pengembalian":
        return Icons.change_circle_outlined;
      case "dikembalikan":
        return Icons.swap_vertical_circle_outlined;
      case "ditolak":
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      itemCount: controller.statusList.length,
      itemBuilder: (context, index) {

        final data = controller.statusList[index];

        if (data.detail.isEmpty) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(15),
            child: const Text("Detail alat tidak tersedia"),
          );
        }

        final detail = data.detail.first;
        final alat = detail.alat;

        return InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {

                return DraggableScrollableSheet(
                  initialChildSize: 0.45,
                  minChildSize: 0.35,
                  maxChildSize: 0.85,
                  expand: false,

                  builder: (context, scrollController) {

                    return _detailAlat(scrollController, alat, detail, data);
                  },
                );
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.bgWhite,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
          
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: getImageUrl(alat.gambar),
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,

                        placeholder: (context, url) => Container(
                          width: 70,
                          height: 70,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(strokeWidth: 2),
                        ),

                        errorWidget: (context, url, error) => Container(
                          width: 70,
                          height: 70,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        ),
                      )
                    ),
          
                    const SizedBox(width: 15),
          
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
          
                          Text(
                            alat.namaAlat,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
          
                          const SizedBox(height: 4),
          
                          Text(
                            alat.kategori.namaKategori,
                            style: TextStyle(
                              color: AppColors.grey1,
                              fontSize: 13,
                            ),
                          ),
          
                          const SizedBox(height: 4),
          
                          Text(
                            "Jumlah: ${detail.jumlah}",
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
          
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: getStatusColor(data.status).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
          
                          Icon(
                            getStatusIcon(data.status),
                            size: 14,
                            color: getStatusColor(data.status),
                          ),
          
                          const SizedBox(width: 5),
          
                          Text(
                            data.status.capitalizeFirst!,
                            style: TextStyle(
                              color: getStatusColor(data.status),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (data.status == "dipinjam") ...[
                  const SizedBox(height: 15),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black1.withOpacity(0.15),
                          blurRadius: 10,
                          offset: Offset(0, 4)
                        )
                      ]
                    ),
                    child: ajukanPengembalianButton(controller: controller, data: data)
                  ),
                ],

                if (data.status == "dikembalikan" && data.tanggalKembali != null) ...[
                  const SizedBox(height: 15),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.green1.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [

                        const Icon(
                          Icons.done_outline,
                          color: AppColors.green1,
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Text(
                            "Peminjaman selesai pada tanggal ${DateFormatter.dateTime("${data.tanggalKembali}")}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.green1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
          
                if (data.status == "ditolak" && data.alasanDitolak != null) ...[
                  const SizedBox(height: 12),
          
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
          
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: AppColors.error,
                          size: 18,
                        ),
          
                        const SizedBox(width: 8),
          
                        Expanded(
                          child: Text(
                            data.alasanDitolak!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Container _detailAlat(ScrollController scrollController, AlatStatusModel alat, DetailModel detail, StatusModel data) {
    return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.bgWhite,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),

          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: getImageUrl(alat.gambar),
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,

                    placeholder: (context, url) => Container(
                      width: 70,
                      height: 70,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    ),

                    errorWidget: (context, url, error) => Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported),
                    ),
                  )
                ),

                const SizedBox(height: 15),

                Text(
                  alat.namaAlat,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  alat.kategori.namaKategori,
                  style: TextStyle(
                    color: AppColors.grey1,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Jumlah"),
                    Text(detail.jumlah.toString()),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tanggal Pengajuan"),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: AppColors.warning,),
                        SizedBox(width: 6),
                        Text(
                          DateFormatter.dateTimeFull(data.tanggalPinjam),
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.warning,
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                if (data.status != "menunggu") ...[
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Tanggal Disetujui Peminjaman"),
                          if(data.tanggalDisetujui == null) ...[
                            Text(
                              "Pengajuan ditolak petugas",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.error
                              ),
                            )
                          ]else ...[
                            Row(
                              children: [
                              Icon(Icons.check_circle_outline, size: 16, color: AppColors.success,),
                              SizedBox(width: 6),
                            Text(
                              DateFormatter.dateTimeFull("${data.tanggalDisetujui}"),
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        )
                      ],
                    ],
                  ),
                ],

                if(data.status == "pengembalian" || data.status == "dikembalikan" && data.tanggalPengajuanPengembalian != null) ...[
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Tanggal Pengajuan Kembali"),

                       Row(
                         children: [
                          Icon(Icons.change_circle_outlined, size: 16, color: AppColors.link,),
                          SizedBox(width: 6),
                          Text(
                            DateFormatter.dateTimeFull("${data.tanggalPengajuanPengembalian}"),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.link,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],

                if(data.status == "dikembalikan" && data.tanggalKembali != null) ...[
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Tanggal Dikembalikan"),
                      
                       Row(
                         children: [
                          Icon(getStatusIcon(data.status), size: 16, color: AppColors.green1,),
                          SizedBox(width: 6),
                          Text(
                            DateFormatter.dateTimeFull("${data.tanggalKembali}"),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.green1,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    const Text("Status"),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: getStatusColor(data.status).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [

                          Icon(
                            getStatusIcon(data.status),
                            size: 14,
                            color: getStatusColor(data.status),
                          ),

                          const SizedBox(width: 5),

                          Text(
                            data.status.capitalizeFirst!,
                            style: TextStyle(
                              color: getStatusColor(data.status),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (data.status == "dikembalikan" && data.tanggalKembali != null) ...[
                  const SizedBox(height: 15),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.green1.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [

                        const Icon(
                          Icons.done_outline,
                          color: AppColors.green1,
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Text(
                            "Peminjaman selesai pada tanggal ${DateFormatter.dateTime("${data.tanggalKembali}")}",
                            style: const TextStyle(
                              color: AppColors.green1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                if (data.status == "ditolak" && data.alasanDitolak != null) ...[
                  const SizedBox(height: 15),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [

                        const Icon(
                          Icons.warning_amber_rounded,
                          color: AppColors.error,
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Text(
                            data.alasanDitolak!,
                            style: const TextStyle(
                              color: AppColors.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
  }
}

