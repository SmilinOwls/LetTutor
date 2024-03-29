import 'package:flutter/material.dart';
import 'package:lettutor/models/schedule/schedule.dart';
import 'package:lettutor/models/user/user.dart';
import 'package:lettutor/providers/auth/auth_provider.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:lettutor/services/user_service.dart';
import 'package:lettutor/utils/time_helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorBookingConfirmDialog extends StatefulWidget {
  const TutorBookingConfirmDialog({super.key, required this.schedule});

  final Schedule schedule;

  @override
  State<TutorBookingConfirmDialog> createState() =>
      _TutorBookingConfirmDialogState();
}

class _TutorBookingConfirmDialogState extends State<TutorBookingConfirmDialog> {
  final TextEditingController _requestTextEditingController =
      TextEditingController();
  late AppLocalizations local;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    local = AppLocalizations.of(context);
  }

  void _tutorBookingHandle() async {
    await BookingService.bookClass(
      scheduleDetailIds: [widget.schedule.scheduleDetails?[0].id ?? ''],
      note: _requestTextEditingController.text,
      onSuccess: () {
        _updateUserInfo();
      },
      onError: (message) {
        Navigator.pop(context, false);
      },
    );
  }

  void _updateUserInfo() async {
    await UserService.getUserInfo(
      onSuccess: (User user) {
        context.read<AuthProvider>().setUser(user);
        Navigator.pop(context, true);
      },
      onError: (message) {
        Navigator.pop(context, false);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _requestTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().getUser();
    final balance = user?.walletInfo?.amount ?? '0';

    return AlertDialog(
      title: Column(
        children: <Widget>[
          Text(
            local.tutorBooking,
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 6,
          ),
          const Divider(height: 1),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                local.bookingTime,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 6),
              Text(
                '${TimeHelper.convertTimeStampToHour(widget.schedule.startTimestamp ?? 0)}'
                '-'
                '${TimeHelper.convertTimeStampToHour(widget.schedule.endTimestamp ?? 0)}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue[700],
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                TimeHelper.convertTimeStampToDate(
                    widget.schedule.startTimestamp!),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    local.balance,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        local.balanceDescription((int.parse(balance) / 100000).round()),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    local.price,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    local.priceDescription(1),
                    style: const TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                local.note,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 120,
                child: TextField(
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  controller: _requestTextEditingController,
                  onChanged: (value) {},
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.all(12),
                    hintText: local.noteForTutor,
                    hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
              fixedSize: const Size(120, 38),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              side: BorderSide(width: 1.5, color: Colors.blue[700]!)),
          child: Text(
            local.cancel,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blue[700],
            ),
          ),
        ),
        TextButton.icon(
          icon: const Icon(
            Icons.keyboard_double_arrow_right,
            color: Colors.white,
          ),
          onPressed: balance == '0'
              ? null
              : () {
                  _tutorBookingHandle();
                },
          style: TextButton.styleFrom(
            fixedSize: const Size(120, 38),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.blue[700],
            disabledBackgroundColor: Colors.grey[500],
            disabledForegroundColor: Colors.grey[300],
          ),
          label: Text(
            local.book,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
