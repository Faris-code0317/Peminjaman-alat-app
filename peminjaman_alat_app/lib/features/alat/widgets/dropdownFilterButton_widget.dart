import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

import 'package:peminjaman_alat_app/features/alat/controller/alat_controller.dart';

class filterAlatByKategori_widget extends StatelessWidget {
  const filterAlatByKategori_widget({
    super.key,
    required this.multiValueListenable,
  });

  final ValueNotifier<List<String>> multiValueListenable;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final alatController = Get.find<AlatController>();
      final kategoriList = alatController.kategoriList;
      final items = ['All', ...kategoriList.map((k) => k.namaKategori)];
      return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              Icon(
                Icons.filter_alt,
                color: AppColors.bgWhite,
              ),
              Flexible(
                child: Text(
                  "Pilih kategori",
                  style: TextStyle(
                    color: AppColors.bgWhite,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
              )
            ],
          ),
          items: items.map((item) {
            return DropdownItem(
              value: item,
              height: 40,
              closeOnTap: false,
              child: ValueListenableBuilder<List<String>>(
                valueListenable: multiValueListenable,
                builder: (context, multiValue, _) {
                  final isSelected = multiValue.contains(item);
                  return Container(
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        if (isSelected)
                          const Icon(
                            Icons.check_box_outlined,
                            color: AppColors.green1,
                          )
                        else
                          const Icon(
                            Icons.check_box_outline_blank,
                            color: AppColors.green1,
                          ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.green1
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }).toList(),
          multiValueListenable: multiValueListenable,
          onChanged: (value) {
            final multiValue = multiValueListenable.value;
            final isSelected = multiValue.contains(value);
            if (value == 'All') {
              if (isSelected) {
                multiValueListenable.value = [];
                alatController.selectedKategori.clear();
              } else {
                multiValueListenable.value = List.from(items);
                alatController.selectedKategori.assignAll(items.where((i) => i != 'All'));
              }
            } else {
              if (isSelected) {
                multiValueListenable.value = [...multiValue]..remove(value);
                alatController.selectedKategori.remove(value);
              } else {
                multiValueListenable.value = [...multiValue, value!];
                alatController.selectedKategori.add(value!);
              }
            }
          },
          selectedItemBuilder: (context) {
            return items.map(
              (item) {
                return ValueListenableBuilder<List<String>>(
                    valueListenable: multiValueListenable,
                    builder: (context, multiValue, _) {
                      return Container(
                        alignment: AlignmentDirectional.center,
                        child: Row(
                          children: [
                           Icon(
                              Icons.filter_alt,
                              color: AppColors.bgWhite,
                            ),
                            SizedBox(width: 2),
                            Flexible(
                              child: Text(
                                multiValue
                                    .where((item) => item != 'All')
                                    .join(', '),
                                style: const TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.bgWhite
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ).toList();
          },
          buttonStyleData: ButtonStyleData(
            padding: const EdgeInsets.only(left: 16, right: 8),
            height: 45,
            width: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.green1,
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.zero,
          ),
        ),
      );
    });
  }
}