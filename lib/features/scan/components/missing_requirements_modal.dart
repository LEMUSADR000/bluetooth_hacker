import 'package:bluetooth_hacker/global/ble_state/cubit/ble_state_cubit.dart';
import 'package:flutter/material.dart';

class MissingRequirementModal extends StatelessWidget {
  const MissingRequirementModal({
    required this.permissions,
    required this.service,
    Key? key,
  }) : super(key: key);

  final List<Permissions> permissions;
  final List<Service> service;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
