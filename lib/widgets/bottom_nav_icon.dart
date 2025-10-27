import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:dcs_polman_kkn/config/size_config.dart';

class BottomNavBtn extends StatelessWidget {
  BottomNavBtn({
    super.key,
    required this.icon,
    required this.label,
    this.index,
    required this.currentIndex,
    required this.onPressed,
    this.isPopupButton = false,
    this.popupType,
    this.activePopupType,
  });

  final IconData icon;
  final String label;
  final int? index;
  final int currentIndex;
  final Function(int) onPressed;
  final bool isPopupButton;
  final String? popupType;
  final String? activePopupType;

  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    AppSizes().initSizes(context);
    final bool isActive = currentIndex == index ||
        (isPopupButton && popupType == activePopupType);

    return Container(
      key: _key,
      child: InkWell(
        onTap: () {
          if (isPopupButton) {
            if (popupType == 'user') {
              _showPopupAboveButtonUser(context);
            }
            else if (popupType == 'document') {
              _showPopupAboveButtonDocument(context);
            }
          } else {
            onPressed(index!);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
          height: isActive
              ? AppSizes.blockSizeHorizontal * 16
              : AppSizes.blockSizeHorizontal * 15,
          width: isActive
              ? AppSizes.blockSizeHorizontal * 18
              : AppSizes.blockSizeHorizontal * 15,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? const Color(0xFF13A79B) : Colors.white,
                size: AppSizes.blockSizeHorizontal * 7,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isActive
                    ? Column(
                  children: [
                    SizedBox(height: AppSizes.blockSizeVertikal * 0.3),
                    Text(
                      label,
                      style: TextStyle(
                        color: const Color(0xFF13A79B),
                        fontSize: AppSizes.blockSizeHorizontal * 3.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: AppSizes.blockSizeVertikal * 0.3,
                      ),
                      height: AppSizes.blockSizeVertikal * 0.4,
                      width: AppSizes.blockSizeHorizontal * 10,
                      decoration: BoxDecoration(
                        color: const Color(0xFF13A79B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPopupAboveButtonUser(BuildContext context) {
    final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx - 25,
        offset.dy - size.height * 3.2,
        offset.dx + size.width,
        offset.dy,
      ),
      items: [
        PopupMenuItem(
          child: _popupItem(Icons.person_outline, 'Users'),
          onTap: () => onPressed(3),
        ),
        PopupMenuItem(
          child: _popupItem(Icons.admin_panel_settings_outlined, 'Roles'),
          onTap: () => onPressed(4),
        ),
        PopupMenuItem(
          child: _popupItem(Icons.verified_user_outlined, 'Permission'),
          onTap: () => onPressed(5),
        ),
      ],
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  void _showPopupAboveButtonDocument(BuildContext context) {
    final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx - 25,
        offset.dy - size.height * 4.5,
        offset.dx + size.width,
        offset.dy,
      ),
      items: [
        PopupMenuItem(
          child: _popupItem(Icons.sell_outlined, 'Kategori'),
          onTap: () => onPressed(6),
        ),
        PopupMenuItem(
          child: _popupItem(Icons.edit_document, 'Dokumen'),
          onTap: () => onPressed(0),
        ),
        PopupMenuItem(
          child: _popupItem(Icons.folder_open_outlined, 'My Dokumen'),
          onTap: () => onPressed(1),
        ),
        PopupMenuItem(
          child: _popupItem(Icons.verified_outlined, 'Pengesahan'),
          onTap: () => onPressed(9),
        ),
        PopupMenuItem(
          child: _popupItem(Icons.history, 'Riwayat'),
          onTap: () => onPressed(10),
        ),
      ],
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Widget _popupItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF13A79B)),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF13A79B),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
