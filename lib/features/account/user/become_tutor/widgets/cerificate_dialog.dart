import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/utils/file_picker.dart';
import 'package:lettutor/widgets/drop_down/drop_down.dart';
import 'package:lettutor/widgets/text/error_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CerificateDialog extends StatefulWidget {
  const CerificateDialog({super.key, required this.certificates});

  final List<Map<String, dynamic>> certificates;

  @override
  State<CerificateDialog> createState() => _CerificateDialogState();
}

class _CerificateDialogState extends State<CerificateDialog> {
  final TextEditingController _certificateTypeTextEditingController =
      TextEditingController();
  PlatformFile? _certificateFile;
  String? errorText;
  late AppLocalizations _local;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context);
  }

  void _onCertificateTypeSelected() async {
    PlatformFile? fileData = await pickFile();
    setState(() {
      _certificateFile = fileData;
    });
  }

  void _onCertificateSaved() {
    if (_certificateTypeTextEditingController.text.isEmpty) {
      setState(() {
        errorText = _local.emptyCertificateTypeError;
      });
      return;
    } else if (_certificateFile == null) {
      setState(() {
        errorText = _local.emptyCertificateFileError;
      });
      return;
    } else if (widget.certificates
        .where((certificate) =>
            certificate['certificateFile'].name == _certificateFile?.name &&
            certificate['certificateFile'].size == _certificateFile?.size &&
            certificate['certificateFile'].identifier ==
                _certificateFile?.identifier)
        .isNotEmpty) {
      setState(() {
        errorText = _local.duplicateCertificateTypeError;
      });
      return;
    }

    final Map<String, dynamic> certificate = {
      'certificateType': _certificateTypeTextEditingController.text,
      'certificateFile': _certificateFile,
    };

    Navigator.of(context).pop(certificate);
  }

  @override
  void dispose() {
    super.dispose();
    _certificateTypeTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(
        _local.addCertificate,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      titlePadding: const EdgeInsets.only(
        top: 12,
        left: 24,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Divider(height: 1),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  DropDownField(
                    controller: _certificateTypeTextEditingController,
                    list: certificateLevels,
                    validator: _local.certificateTypeInputValidator,
                    hintText: _local.certificateTypeInputHint,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextButton.icon(
                          onPressed: _onCertificateTypeSelected,
                          icon: const Icon(
                            Icons.upload_file,
                            color: Colors.grey,
                          ),
                          label: Text(
                            _local.clickToUpload,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          _certificateFile?.name ?? '',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (errorText != null)
                    ErrorText(
                      text: errorText!,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
          ],
        ),
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: Text(
            _local.cancel,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _onCertificateSaved();
          },
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: Text(
            _local.save,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
