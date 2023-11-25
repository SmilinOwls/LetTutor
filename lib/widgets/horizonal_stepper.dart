import 'package:flutter/material.dart';

class HorizontalStepper extends StatefulWidget {
  const HorizontalStepper({super.key, required this.steps});

  final Map<String, Widget> steps;

  @override
  State<HorizontalStepper> createState() => _HorizontalStepperState();
}

class _HorizontalStepperState extends State<HorizontalStepper> {
  int currentStep = 0;

  StepState _getStepState(int index) {
    if (currentStep > index) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      steps: List<Step>.generate(
        widget.steps.length,
        (int index) {
          return Step(
            isActive: currentStep >= index,
            label: Text(
              widget.steps.keys.elementAt(index),
              style: const TextStyle(fontSize: 12),
            ),
            state: _getStepState(index),
            title: const Text(''),
            content: widget.steps.values.elementAt(index),
          );
        },
      ),
      currentStep: currentStep,
      onStepTapped: (step) => setState(() => currentStep = step),
      onStepContinue: () {
        if (currentStep < widget.steps.length - 1) {
          setState(() => currentStep += 1);
        }
      },
      onStepCancel:
          currentStep == 0 ? null : () => setState(() => currentStep -= 1),
    );
  }
}
