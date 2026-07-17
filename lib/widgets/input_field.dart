import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? unit;
  final IconData? icon;
  final String? errorText;

  const InputField({
    super.key,
    required this.controller,
    required this.label,
    this.unit,
    this.icon,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*[.,]?\d*$')),
        ],
        style: TextStyle(
          color: cs.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
          labelStyle: TextStyle(color: cs.primary, fontSize: 14),
          prefixIcon: icon != null
              ? Icon(icon, color: cs.primary.withValues(alpha: 0.8), size: 20)
              : null,
          suffixText: unit,
          suffixStyle: TextStyle(
            color: cs.primary,
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: cs.surfaceContainerHighest,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: cs.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: cs.primary, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
