import 'package:flutter/material.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HorizontalStepper extends StatefulWidget {
  const HorizontalStepper({
    super.key,
    required this.stepHeaders,
    required this.stepWidgets,
    required this.formKey,
  });

  final List<String> stepHeaders;
  final List<Widget> stepWidgets;
  final List<GlobalKey<FormState>?> formKey;

  @override
  State<HorizontalStepper> createState() => _HorizontalStepperState();
}

class _HorizontalStepperState extends State<HorizontalStepper> {
  int currentStep = 0;
  late AppLocalizations _local;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context);
  }

  StepState _getStepState(int index) {
    if (currentStep > index) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  void _onStepContinue() {
    if (currentStep != widget.stepWidgets.length - 1) {
      if (widget.formKey[currentStep]!.currentState!.validate()) {
        setState(() => currentStep += 1);
      }
    } else {
      Navigator.of(context).pushNamed(Routes.main);
    }
  }

  void _onStepCancel() {
    setState(() => currentStep -= 1);
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      steps: List<Step>.generate(
        widget.stepWidgets.length,
        (int index) {
          return Step(
            isActive: currentStep >= index,
            label: Text(
              widget.stepHeaders[index],
              style: const TextStyle(fontSize: 12),
            ),
            state: _getStepState(index),
            title: const Text(''),
            content: widget.stepWidgets[index],
          );
        },
      ),
      controlsBuilder: (context, details) => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          children: <Widget>[
            if (currentStep != 0 && currentStep != widget.stepWidgets.length - 1)
              Expanded(
                child: OutlinedButton(
                  onPressed: details.onStepCancel,
                  child: Text(_local.back),
                ),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text(
                  currentStep != widget.stepWidgets.length - 1
                      ? _local.next
                      : _local.backToHome,
                ),
              ),
            ),
          ],
        ),
      ),
      currentStep: currentStep,
      onStepContinue: _onStepContinue,
      onStepCancel: _onStepCancel,
    );
  }
}
