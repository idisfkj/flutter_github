import 'package:flutter/material.dart';
import 'package:flutter_github/ui/base/base_state.dart';

abstract class BasePage<S extends BaseState>
    extends StatefulWidget {
  const BasePage();

  @override
  S createState() {
    return createBaseState();
  }

  S createBaseState();
}
