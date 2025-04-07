import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import '../../controllers/theme/theme_controller.dart';
import '../components/draggable_bottom_sheet.dart';
import '../components/text/ctext.dart';

class SheetChooseContact extends StatefulWidget {
  final Function(Contact) onTap;

  SheetChooseContact({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SheetChooseContact> createState() => _SheetChooseContactState();
}

class _SheetChooseContactState extends State<SheetChooseContact> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      setState(() => _contacts = contacts);
    }
  }

  final ThemeController _theme = Get.find(tag: 'ThemeController');

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      snap: true,
      initialChildSize: 0.85,
      minChildSize: 0.85,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            color: _theme.pureWhite.value,
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DraggableBottomSheet(),
                CText(
                  "Pilih Kontak",
                  color: _theme.pureBlack.value,
                ),
                _body(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _body() {
    if (_permissionDenied) return Center(child: Text('Permission denied'));
    if (_contacts == null) return Center(child: CircularProgressIndicator());
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _contacts!.length,
      separatorBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: _theme.line.value,
            ),
            SizedBox(
              height: 8,
            ),
          ],
        );
      },
      itemBuilder: (BuildContext context, int i) {
        var _data = _contacts![i];
        return GestureDetector(
          onTap: () {
            widget.onTap(_data);
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _theme.success[3],
                ),
                child: Center(
                  child: CText(
                    _data.displayName.substring(0, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _theme.pureWhite.value,
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      _data.displayName,
                      fontSize: 16,
                      overflow: TextOverflow.visible,
                      lineHeight: 1.4,
                      color: _theme.pureBlack.value,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CText(
                      _data.phones.isNotEmpty
                          ? _data.phones.first.number
                              .replaceAll("+62 ", "0")
                              .replaceAll("-", "")
                          : _data,
                      fontSize: 12,
                      overflow: TextOverflow.visible,
                      color: _theme.pureBlack.value,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
